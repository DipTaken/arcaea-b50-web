# Codebase Audit — Bugs, Tailwind Refactor, Code Quality

A full sweep of the repo covering three things: repeated Tailwind class combinations worth
extracting, actual bugs, and amateur code/CSS that should be written better.

This is the **reference document** — findings with reasoning. For an actionable checklist with
learning notes, see [report_todo.md](report_todo.md). For the running project list, see
[todo.txt](todo.txt).

Everything here was verified by reading the file. The load-bearing claims — the `line-clamp`
conflict, the rating math, the dead proxy — were verified by running code or grepping the generated
CSS, not by inference.

**Headline:** two silent-wrong-output bugs (`getShinyPureCount` is wrong on roughly half of all real
scores; `line-clamp-2` has never once clamped), one silent-data-loss bug (`addScore` discards its
insert error), and a session-refresh proxy that is a pure passthrough. The Tailwind duplication is
real but secondary — and the right fix for most of it is shared *components*, not shared strings.

---

## 1. Correctness bugs

### 1.1 `getShinyPureCount` is wrong ~51% of the time — `utils/rating.ts:25-29`

```ts
const noteScore = Math.floor(2 * (score / 10000000) * noteCount)
const shiny = score - (noteScore * 5000000) / noteCount
return Math.round(shiny)
```

The game computes `score = floor(units * 5_000_000 / noteCount) + shiny`, where a far is worth 1
unit and a pure 2. This subtracts the **unfloored** term, so the result is
`shiny − frac(units·5e6/N)`, and `Math.round` only rescues it when that fraction is under 0.5.

Brute-forced the round trip over realistic note counts (777/903/1024/1148/1281/1600, 3000 cases):
**1466 exact, 1532 off by one, 2 wildly wrong.**

| noteCount | play | true shiny | displayed |
|---|---|---|---|
| 777 | 774 pure / 1 far / 2 lost, score 9,968,374 | 550 | **549** |
| 1024 | 1023 pure / 1 far, score 9,995,117 | 0 | **4883** |

The second class comes from a separate defect: `Math.floor` on line 26 undershoots `noteScore` by 1
when `shiny` is very small, and the error then multiplies out.

Surfaces at `app/scores/ScoreInfo.tsx:35` ("Shiny Pures: …").

**Fix** — stay in integer arithmetic; float division is what causes the residual edge cases:

```ts
export function getShinyPureCount(score: number, noteCount: number): number {
    if (!noteCount) return 0
    // A far is worth 1 unit, a pure 2, so a chart holds 2 * noteCount units and each unit is
    // worth 5,000,000 / noteCount points. The game floors that base total, then adds one point
    // per shiny pure:   score = floor(units * 5_000_000 / noteCount) + shiny
    // So recover `units` as the largest u with floor(u * 5e6 / noteCount) <= score, which is
    // u * 5e6 < (score + 1) * noteCount. Multiplying through keeps every term an integer.
    const units = Math.min(Math.ceil(((score + 1) * noteCount) / 5000000) - 1, 2 * noteCount)
    return score - Math.floor((units * 5000000) / noteCount)
}
```

Verified **exact for every noteCount 50–2236** — 0 mismatches in 87,480 randomized cases, including
zero-shiny, one-shiny, and full-PM extremes. Above ~2237 notes the shiny count is genuinely
underdetermined by the score alone (the same physical fact `MAX_NOTES_SAFE_PM_THRESHOLD` already
encodes), and the `Math.min` clamp keeps the result in range there.

> **Note on `getPmRating`:** `rating.ts:36` already reads `MAX - ${noteCount - shiny}`, which is
> correct. It was displaying wrong distances because `getShinyPureCount` fed it a wrong `shiny` —
> fixing the above fixes both. The old "getPmRating reports the wrong distance" entry was pointing
> one level too high.

### 1.2 `line-clamp-2` has never worked — `app/scores/ScoreCard.tsx:46`, `app/browse/BrowseCard.tsx:44`

```tsx
<div className={`flex flex-col justify-center line-clamp-2 w-3/4 h-full p-2 ${getTextSize(...)}`}>
```

`line-clamp-2` sets `display: -webkit-box`; `flex` sets `display: flex`. Both are utilities in the
same layer, so **stylesheet emit order decides, not attribute order**. Verified against the built
CSS:

```
.next/dev/static/chunks/app_globals_0yg4wg8.css
361:  .line-clamp-2 {
372:  .flex {          ← wins
```

Long titles are hard-cut by the inherited `overflow: hidden` at `h-10` instead of wrapping to two
lines. Worth internalizing: **two utilities that set the same CSS property can never coexist on one
element**, and the failure is completely invisible in review.

**Fix:** move the clamp to an inner element. §2.3's `CardBottomBar` does this once for both cards.

### 1.3 The proxy never refreshes the session — `utils/supabase/middleware.ts:15-36`

```ts
const supabase = createServerClient(supabaseUrl!, supabaseKey!, { cookies: {...} })
// ...
return supabaseResponse
```

`supabase` is constructed and never used — ESLint already flags it as unused, and *that warning is
the bug*. The `setAll` callback only fires during a token refresh, and a refresh only happens when
something asks for the session. Nothing does. So `setAll` never runs, the `supabaseResponse`
reassignment on line 25 is dead, and `proxy.ts` is a passthrough.

Compounding it, `utils/supabase/server.ts:19` swallows cookie-write failures in a `try/catch` whose
own comment reads *"This can be ignored if you have middleware refreshing user sessions"* — which is
exactly what isn't happening. A refreshed token computed inside a Server Component gets discarded.

**Failure:** log in, wait out the 1h access token, reload `/scores` → NavBar flips to "Sign in" and
the grid empties.

**Fix:** call `await supabase.auth.getUser()` before returning `supabaseResponse`. That forces
`createClient` to become `async`, so `proxy.ts` must `await` it. Also line 24 destructures `options`
and then drops it — `request.cookies.set(name, value)` loses the cookie attributes. While in there,
rename `createClient` → `updateSession`; a function returning a `NextResponse` shouldn't be called
`createClient`.

### 1.4 `addScore` discards its insert error — `app/scores/actions.ts:55-62`

```ts
await supabase.from('scores').insert({ chart_id: chartId, user_id: userId, score, pure, far, lost })
revalidatePath('/scores')
```

No `{ error }` destructure — every other Supabase call in the file checks its error, this one
doesn't. `AddScoreButton.tsx:35` sees `result?.error === undefined`, treats it as success, and closes
the modal.

**Failure:** an RLS/GRANT rejection (`42501`), a FK violation, or a NOT NULL violation → the modal
closes cheerfully, the page revalidates, and the score simply isn't there. Silent data loss, zero
feedback.

**Fix:** `const { error } = await supabase.from('scores').insert(...)` and
`if (error) return { error: error.message }` **before** `revalidatePath`.

### 1.5 Unguarded `.toFixed` crashes the whole grid — `app/scores/ScoreCard.tsx:50`

```tsx
{score.charts?.chart_constant.toFixed(1)}
```

The `?.` short-circuits on `charts`, not on `chart_constant`. Every other consumer guards it —
`BrowseCard.tsx:45` uses `chart_constant?.toFixed(1)`, `SongInfo.tsx:27` uses a ternary,
`search.ts:34` uses `?? 0`, and `search.ts:82` literally comments *"some charts may not have a cc"*.

TypeScript can't catch it because `utils/types.ts:7` declares `chart_constant: number`
(non-nullable) **and** the query returns `any` anyway (§4.1).

**Failure:** one logged score on a constant-less chart → `TypeError` thrown during render of a
client component, taking down all of `/scores`, not just that card.

**Fix:** `chart_constant?.toFixed(1)`. `CardBottomBar` in §2.3 makes this uniform across both cards.

Same class of bug at `rating.ts:54` — `getB50Rating` uses `.charts.chart_constant` with no optional
chaining while `app/scores/page.tsx:28` uses `?.`.

### 1.6 Cancelling Google login reports success — `app/auth/callback/route.ts:9,32`

```ts
if (code) { /* ...exchange... */ }
return NextResponse.redirect(`${origin}/browse`)
```

When the provider returns `?error=access_denied&error_description=…` there is no `code`, the whole
block is skipped, and control falls through to the **success** redirect. The `error` /
`error_description` params are never read.

**Failure:** click Cancel on the Google consent screen → land on `/browse`, still signed out, with
no indication anything happened.

**Fix:** read `searchParams.get('error')` and redirect to `/auth/auth-code-error` (which needs to
stop being an empty `<div>` — §5.3). Treat "no code and no error" as a failure too, not a success.

**Deployment landmine in the same file:** `origin` comes from `new URL(request.url)`, which behind a
proxy is the *internal* origin. Supabase's own template reads `x-forwarded-host` for exactly this
reason. This will redirect to `localhost` the moment the app is deployed — worth fixing now.

### 1.7 NaN passes every validation gate — `app/scores/actions.ts:13-48`

`Number('abc')` is `NaN`, and `NaN < 0 || NaN > maxScore` is `false` — so **all four** range checks
pass. Server actions are public HTTP endpoints, so the client-side `required` / `type="number"` is
not a defense.

`NaN` then JSON-serializes to `null` on the wire, producing a NOT NULL violation on `score` that
§1.4 currently swallows.

**Fix:** `if (!Number.isFinite(score)) return { error: 'Invalid score' }`, and have
`parseOptionalNumber` return `null` for non-finite input.

Two smaller holes in the same block:

- Line 46 only cross-checks pure+far+lost when **all three** are non-null, and only rejects
  `> note_count`. A partial `{pure, far}` submission is never checked, and an impossible sub-total
  is accepted.
- Line 50 calls `getGuestId()` *before* the `getUser()` check on line 51, so it mints and refreshes
  a `guest_id` cookie for logged-in users who never browsed as guests. Move it after, and only call
  it when `user` is null.

### 1.8 `handleSubmit` has no `try/catch` — `app/scores/AddScoreButton.tsx:31-40`

Validation errors are returned properly now, but a *thrown* rejection (network failure, RLS 401,
`revalidatePath` error) rejects the form action and line 39's `dialogRef.current?.close()` never
runs — reproducing the "frozen backdrop, no message" symptom that was already fixed once, just for a
different error class.

**Fix:** wrap in `try/catch`, set `errorMessage` in the `catch`.

### 1.9 Stale-closure state update — `app/browse/BrowseSearch.tsx:137`

```tsx
onClick={() => setVisibleCount(visibleCount + CARDS_PER_PAGE)}
```

Two fast clicks on "Load More" batch into a single +100. Use the updater form:
`setVisibleCount(c => c + CARDS_PER_PAGE)`.

### 1.10 Enter in the chart search submits the form — `app/scores/ChartSearch.tsx:30-36`

The search box lives inside `<form action={handleSubmit}>`. Once a chart is picked the submit button
is enabled, so implicit form submission fires: type a score, go back to refine the search, press
Enter → the score submits mid-edit.

**Fix:** `onKeyDown={(e) => { if (e.key === 'Enter') e.preventDefault() }}` on the input.

### 1.11 Smaller correctness issues

| Issue | Location | Note |
|---|---|---|
| Descending sort reverses tie groups | `utils/search.ts:57` | `.reverse()` instead of negating the comparator — two charts with equal constants swap order between asc/desc. The `default` branch also reverses title order without having sorted. |
| Unknown levels pass `<` / `<=` | `utils/search.ts:18-19` | `indexOf` → `-1` compares less than every real level. Guard `chartIndex >= 0`. |
| `chartInfoElement` renders the wrong chart | `app/scores/AddScoreButton.tsx:58-69` | Reads `defaultChart` while the inputs read `selectedChart`. Masked today because the only `showSongInfo` call sites never change selection — latent the moment a `ChartSearch` is added there. |
| Locale-dependent filename | `utils/jacket.ts:3` | `toLocaleLowerCase()` with no locale uses the process default. Use `toLowerCase()` for a storage key. |
| Dead condition | `utils/rating.ts:2` | `isPM(...) \|\| noteCount < 2237` — `isPM` already returns `true` for `noteCount < 2237` when score ≥ 10M. Also inlines `2237` even though the named constant sits 38 lines below. |
| Stale modal after revalidation | `app/scores/ScoreGrid.tsx:9,26` | `selectedScore` holds the pre-update object after `revalidatePath`, so an open modal shows stale data. |

---

## 2. Tailwind de-duplication — shared components

**Approach: shared React components, plus `@theme` tokens for the four chrome colors.**

The rationale worth keeping in mind: in a React app the duplication is *markup plus classes
together*. `ScoreCard.tsx:45-52` and `BrowseCard.tsx:41-46` don't just repeat a class string, they
repeat a `<div>` inside a `<div>`. A shared string dedupes ~30% of that; a component dedupes 100% —
and only the component can carry the structural `line-clamp` fix from §1.2.

A second reason to prefer components over exported strings: appending to a shared class string
doesn't determine precedence, emit order does. `BASE + "px-2"` where `BASE` contains `p-6` fails
silently. A `variant: 'a' | 'b'` prop makes that bug **unrepresentable**.

**Do not add `clsx` or `tailwind-merge`.** `tailwind-merge` exists to repair conflicts created by
merging class strings from props; the components below deliberately expose **no `className` escape
hatch**, so there is nothing to repair. Reaching for it later is a signal that a component is taking
`className` when it should be taking a `variant`.

### 2.0 One correction to a common assumption

`--foreground` in `app/globals.css:5` is **not** dead scaffolding.
`body { color: var(--foreground) }` is the only thing giving every `<h1>` its color, and the
`prefers-color-scheme` block is what makes that `#ededed` instead of near-black `#171717` on an
always-dark gradient. Deleting those blindly turns every heading nearly invisible.

Only `--background`, `--color-background`, and `--color-foreground` are genuinely unreferenced.

### 2.1 `globals.css` — collapse four color homes into one

Colors currently live in four unrelated places: dead CSS vars, a hardcoded gradient in
`layout.tsx`, a Tailwind class string smuggled through `utils/style.ts`, and hex in
`getDifficultyColor`/`getGradeColor`.

```css
@import "tailwindcss";

/* `inline` because next/font defines --font-exo on <html>, not :root — the value must be
   substituted into --default-font-family, not merely referenced. */
@theme inline {
    --font-sans: var(--font-exo);
    --font-mono: var(--font-exo);
}

/* The app palette. Every token here is consumed by a utility, so plain @theme is enough —
   Tailwind v4 tree-shakes theme vars that no utility references. */
@theme {
    --color-foreground: #ededed;
    --color-card:       #16222d;
    --color-page-start: #0f1014;
    --color-page-end:   #191621;
}

@utility no-spinner { /* unchanged */ }
```

Delete: `:root { --background / --foreground }`, the `@media (prefers-color-scheme: dark)` block,
`--color-background`, and the unlayered `body { … }` rule. Then `app/layout.tsx:22`:

```tsx
<body className="min-h-full flex flex-col text-foreground bg-linear-to-r from-page-start to-page-end">
```

This leaves `globals.css` with **zero unlayered CSS**, retiring the specificity hazard that already
bit once. Preflight already applies `--font-sans` via `--default-font-family`, so the `body` font
rule is redundant — verify the font still renders as Exo after deleting it.

**Verify this step by flipping the OS to light mode.** Nothing should change. That's the proof the
`prefers-color-scheme` block was a landmine rather than a feature.

Then replace `${bgColor}` with `bg-card` at `ScoreCard.tsx:12,18` and `BrowseCard.tsx:14,25`, and
delete `utils/style.ts:52`.

### 2.2 Keep the difficulty/grade palettes as hex + inline `style`

It's tempting to make these `@theme` tokens too, with a lookup of static class names
(`{ FTR: 'border-ftr', … }`). The JIT scanner *would* see those. **It's still the wrong call here**,
for three reasons:

1. **You'd need one table per CSS property.** The difficulty color is used as a border on the card,
   a border on the badge, a background on the bottom bar, a background on a modal badge, *and* a
   gradient stop at 70% alpha (`BrowseCard.tsx:32`). That last one can't be a utility at all, so
   you'd end up running both mechanisms side by side — strictly more confusing than either alone.
2. **It multiplies the edit surface.** Adding a 6th difficulty today is one `case`. After, it's a
   `@theme` line plus three table entries, and missing one fails silently (no border, not a crash).
3. **It buys nothing once `<Card accent={…}>` exists.** The color gets computed once per card and
   passed down. There's no repetition left to remove.

The rule: *a color belongs in CSS when CSS consumes it as a utility; it belongs in TS when TS
computes which one applies.* `bg-card` is a class → CSS. `getDifficultyColor(difficulty)` is a
runtime lookup → TS. Two homes, each with a reason, down from four.

### 2.3 `app/components/Card.tsx` — three named exports

```tsx
export function Card({ accent, jacketUrl, onClick, children }: {
    accent: string          // difficulty color; drives the border
    jacketUrl?: string      // BrowseCard only; ScoreCard omits it
    onClick?: () => void
    children: React.ReactNode
})

export function CardBadge({ accent, wide = false, children }: {
    accent: string
    wide?: boolean          // ScoreCard 40px (rank) vs BrowseCard 80px ("FTR 11+")
    children: React.ReactNode
})

export function CardBottomBar({ accent, title, constant }: {
    accent: string
    title: string | null | undefined
    constant: number | null | undefined   // note the `?.` — fixes §1.5 for both cards
})
```

Shell classes (identical between the two cards today except `z-10` / `bg-cover bg-center`):

```
relative flex w-[200px] h-[150px] flex-col justify-between rounded-md border-2 bg-card
bg-cover bg-center cursor-pointer transition-transform duration-200 ease-in-out hover:scale-105
```

`CardBottomBar` is where §1.2 gets fixed — `line-clamp-2` moves onto an inner `<span>` so it stops
fighting `flex`:

```tsx
<div style={{ backgroundColor: accent }} className="absolute z-10 bottom-0 left-0 h-10 w-full">
    <div className="flex h-full w-3/4 flex-col justify-center p-2">
        <span className={`line-clamp-2 ${getTextSize(title ?? '')}`}>{title}</span>
    </div>
    <div className="absolute bottom-0 right-1 text-right">{constant?.toFixed(1)}</div>
</div>
```

**Call sites:** `ScoreCard.tsx` (3 `getDifficultyColor` calls collapse to one local `const accent`),
`BrowseCard.tsx` (4 → 1). The gradient overlay and the sort-dependent info line stay inline in
`BrowseCard` — they appear once.

**Two things to eyeball after this step:** dropping `z-10` from the `<li>` means it no longer forms
a stacking context (which is already how `BrowseCard` behaves) — check the corner badges. And the
`right-0` on `ScoreCard.tsx:37` is a no-op today (the `<img>` is statically positioned) — drop it.

### 2.4 The other four components

| Component | Replaces | Call sites |
|---|---|---|
| `app/components/CardGrid.tsx` | the byte-identical grid `<ul>` | `ScoreGrid.tsx:19`, `BrowseSearch.tsx:128` |
| `app/components/Panel.tsx` | `flex flex-col gap-4 p-10 justify-center items-center rounded-lg bg-gray-800 border-2 border-gray-400 w-full max-w-5xl` | `ScoreModal.tsx:15`, `BrowseModal.tsx:15` |
| `app/components/PageShell.tsx` | page shell + `text-3xl font-bold` ×4 + `text-xl font-light` ×3 | all four `page.tsx` files |
| `app/components/Button.tsx` | 6 near-identical buttons | see below |

`PageShell` takes `{ title, subtitle?, children }` and renders `<main>` rather than `<div>` — an
a11y win (§5.2) that changes no layout, since `<body>` is already `flex flex-col`. **Decision:** the
four current gaps are `gap-10 / gap-4 / gap-5 / gap-10`. Normalizing to `gap-6` is probably right;
if the difference is deliberate, add a `gap` prop — but a knob on four call sites tends to drift.

`Panel` deliberately does **not** absorb `AddScoreButton.tsx:91`'s form — that string differs
(`gap-y-7`, no `items-center`) and appears once. Don't add a polymorphic `as` prop to chase it.

`Button` takes `variant: 'default' | 'primary' | 'danger'` and `size: 'sm' | 'md' | 'lg' | 'fill'`
with two lookup objects, spreading `React.ComponentProps<'button'>`. `fill` isn't a padding size —
it's the named case "sized by my parent", which is what the submit/cancel buttons
(`AddScoreButton.tsx:160,167`) actually are (`flex-1 h-full` in an `h-15` row). Naming it is what
removes the need for a `className` escape hatch.

**Not converted** — each is a one-off, and forcing them in means a variant used once:
`LoginButton.tsx:24` (no background, `font-light` — different species),
`ProfileButton.tsx:29,38`, and `BrowseSearch.tsx:71`'s sort-direction toggle (visually a form
control — it belongs with the `<select>`s, §2.6).

**Visual deltas to approve when converting:** the modal Add Score loses 12px of horizontal padding
(`px-15` → `lg` = `px-12`); the top-level one loses 24px (`px-12` → `md` = `px-6`); "Load More"
gains `border-gray-400` where it currently inherits `currentColor`, and its hover goes gray-600 →
gray-700. Adjust the lookup tables to taste.

### 2.5 Kill the three class props on `AddScoreButton`

`AddScoreButton.tsx:22` takes `sizeClasses`, `textClasses`, and `borderClasses`, with no merge
handling — and both modals pass the identical trio. Line 79 even hardcodes `text-white` *and* takes
it as the `textClasses` default, so it's emitted twice.

Replace all three with `size?: 'md' | 'lg'`. The compiler then becomes the checklist: TS will error
at `ScoreModal.tsx:22`, `BrowseModal.tsx:22`, and `app/scores/page.tsx:39`.

Same idea applies to `Modal`'s `width` string prop (`Modal.tsx:9`), though with only two distinct
values it's borderline.

### 2.6 Local dedup — zero visual change

These stay inside their own file; they don't earn a shared module.

- **`JudgementInput`**, local to `AddScoreButton.tsx` — collapses lines 116-145 (three inputs with
  an identical class string *and* identical `type`/`min`/`max`/`disabled`/`onChange` props) to three
  lines.
- **`InfoRow`**, local to `SongInfo.tsx` —
  `({ label, children }) => <p><span className="font-bold">{label}: </span>{children}</p>`.
  Turns lines 12-58 (47 lines, 9 copy-pasted blocks) into ~11.
  ⚠️ Keep `||`, not `??` — `chart.note_count ? … : 'Unknown'` currently renders `Unknown` for `0`,
  and `??` would render a literal `0`.
- **`controlClasses`**, a local const in `BrowseSearch.tsx` —
  `"rounded-md border-2 border-gray-400 bg-gray-800 py-3 text-center text-white"`, applied at
  lines 57, 71, 80, 91, 115 as `` `${controlClasses} px-6` `` etc. This is the safe use of a shared
  string: *extend it only with utilities that set properties the base doesn't set.*
- **`ScoreInfo.tsx:6`** — drop the load-bearing trailing space on `flexClasses` and switch from `+`
  to a template literal, so a formatter can't silently break it.

### 2.7 The conflicting-padding rewrites

`p-6 py-3` (and the `p-5`/`p-2` variants) at `BrowseSearch.tsx:57,71,80,91,115` and `px-50 p-4` at
`app/scores/page.tsx:46` render correctly **only** because Tailwind emits `.p-*` before `.px-*`
before `.py-*`. Rewrite to `px-N py-3` / `px-50 py-4`.

These are exact-equivalent rewrites — zero visual change — but the result is true by construction
instead of by accident. Same lesson as §1.2.

### 2.8 Cosmetic noise found while cataloging

**Template literals with nothing to interpolate:** `app/scores/page.tsx:40`,
`AddScoreButton.tsx:91,111,160,167`, `ImportFromBrowserButton.tsx:32`.

**Dead classes:** `scrollbar-thin scrollbar-thumb-gray-400 scrollbar-track-gray-700` at
`ChartSearch.tsx:41` — `tailwind-scrollbar` isn't installed and there's no `@plugin` in globals.css.

**No-op utilities:** `right-0`/`z-0` without positioning (`ScoreCard.tsx:37`),
`items-center justify-end` on a non-flex div (`ImportFromBrowserButton.tsx:37`), `justify-end` on a
`<p>` (`ScoreInfo.tsx:36`), `rounded-lg` on a transparent wrapper (`BrowseSearch.tsx:44`).

**Inline styles that are plain utilities:** `ChartSearch.tsx:50-53` → `cursor-pointer` +
`font-bold`/`font-normal`.

**Whitespace in class strings** (double/trailing spaces): `SongInfo:21,68`, `ScoreCard:37`,
`scores/page:37`, `AddScoreButton:59`, `BrowseSearch:56,57,71,80,91,115`.

**`ChartSearch`'s dropdown is positioned against a distant ancestor:** its wrapper `<div>` (line 21)
isn't `relative`, so `absolute left-10 right-10` (line 41) resolves against the `<dialog>` — and
those offsets are hand-tuned to cancel the `p-10` on `AddScoreButton`'s form. Add `relative` to the
wrapper and use `left-0 right-0 top-full`.

---

## 3. Responsive layout

### 3.1 The grid

Current: `grid grid-cols-[repeat(5,230px)] gap-y-10 w-fit justify-items-center mx-auto` — a hard
1150px box that overflows below ~1150px viewport. There are **zero breakpoint prefixes anywhere in
`app/`**.

The current horizontal gutter isn't a `gap` at all: it's the 30px left over from a 230px track
holding a `w-[200px]` card, centered by `justify-items-center`. Two magic numbers encoding one gap.

Replacement for `CardGrid`:

```
mx-auto grid w-full max-w-6xl grid-cols-[repeat(auto-fit,200px)] justify-center gap-x-[30px] gap-y-10 px-4
```

**Pixel-identical on desktop:** `max-w-6xl` = 72rem = 1152px, minus `px-4` (2×16px) = 1120px content
box. Five 200px tracks + four 30px gaps = 1120px exactly. `justify-center` has nothing to
distribute. Only the 15px of dead outer slack is lost.

**Collapses cleanly:** using `200n + 30(n−1) + 32`, columns drop at 1152 / 922 / 692 / 462 / 232px.
A 375px iPhone gets one centered column and no horizontal scrollbar.

`auto-fit` not `auto-fill` (with fixed tracks, `auto-fill` keeps empty tracks and shoves a partial
last row off-center). `justify-items-center` is dropped — it existed only because the track was
wider than the card.

### 3.2 Required companion change — this breaks without it

`w-full` resolves against the parent's content box, and both grid wrappers are shrink-to-fit
(`items-center` ancestors). Under an indefinite available size, a percentage width is treated as
`auto` and `auto-fit` behaves like `auto-fill` — the grid blows out to one track per card.

**Add `w-full` to both wrappers:** `ScoreGrid.tsx:17` and `BrowseSearch.tsx:43`.

### 3.3 Toolbar and PTT row

`BrowseSearch.tsx:54`'s `flex … gap-6 h-20` control bar still overflows on mobile → `flex-wrap` +
`h-auto`.

`app/scores/page.tsx:46`'s `px-50` is 200px of horizontal padding, hand-tuned to roughly line the
PTT badge up with the grid at exactly one viewport width. Re-anchor it to the same container as the
grid so it tracks at every width:

```tsx
<div className="mx-auto flex w-full max-w-6xl items-start gap-4 px-4 py-4">
```

---

## 4. Data model, types, and component dedup

### 4.1 Every Supabase result is `any` — the root cause of several findings above

The clients are never parameterized with a generated `Database` type, so
`supabase.from('scores').select('*, charts(*)')` returns `any`. Consequences:

- `app/scores/page.tsx:26-31`'s sort type-checks **vacuously** — `a` and `b` are `any` — and the
  `any[]` is handed to `<ScoreGrid scores={ScoreWithChart[]}>` with no cast and no validation.
- `utils/types.ts` is a hand-written parallel schema that can drift silently, and already has: it
  declares `chart_constant: number` while the code guards it as nullable in three different ways
  (§1.5), and declares `charts: Chart` non-null while ~20 call sites write `score.charts?.…`.
  Either the type is wrong or all that optional chaining is dead code.

**Fix:** `npx supabase gen types typescript --project-id <id> > utils/database.types.ts`, then
`createClient<Database>(...)` in all three client factories. This single change closes §1.5, the
`ScoreWithChart` ambiguity, and makes the `any` in §4.4 impossible.

### 4.2 B50 double-counts repeat plays — `app/scores/page.tsx:26-31`

`addScore` always `insert`s (never upserts), and `ImportFromBrowser` deliberately preserves
`created_at` so multiple rows per chart coexist. Nothing dedupes by `chart_id` before
`.slice(0, 50)`.

**Failure:** log three plays of Testify → all three occupy B50 slots #1/#2/#3, push three legitimate
charts out, and `getB50Rating` weights the best one at 2× *and* counts the other two. Displayed PTT
is inflated and the grid shows visual duplicates.

**Fix:** group by `chart_id`, keep the max `getPlayRating`, then sort and slice. A `Map` keyed on
`chart_id` is the straightforward version.

### 4.3 `user_id` can be `null` on a first visit — `app/scores/page.tsx:14-23`

`getGuestIdReadOnly()` returns `null` when the cookie is absent, and the cookie is only minted by
`getGuestId()` inside `addScore`. So a brand-new visitor sends `.eq('user_id', null)` →
`user_id=eq.null` against a `uuid` column, which Postgres rejects.

Because **none of the three page queries destructure `error`** (`app/scores/page.tsx:18,19`,
`app/browse/page.tsx:9`), the failure is indistinguishable from "no scores" — it renders as an empty
grid and `PTT: 0.00`.

**Fix:** skip the query entirely when `!userId`, and destructure + surface `error` on all three.

### 4.4 `ImportFromBrowser` — `app/scores/ImportFromBrowser.ts:46-56`

```ts
.upsert(duplicatedScores, { onConflict: 'user_id,chart_id,created_at', ignoreDuplicates: true })
```

The documented schema has `id` as the only key. Postgres requires a matching unique constraint for
`ON CONFLICT` — **verify `(user_id, chart_id, created_at)` actually exists in the live DB.** If it
doesn't, *every* import fails with `42P10`, surfaced to the user as that raw string.

Also line 56: `(data as any[]).length` is the repo's **only ESLint error** and pure noise —
`data?.length ?? 0`. Line 36's unused `id` destructure needs an eslint-disable comment or a rename
to `_id`.

### 4.5 Component dedup

| Duplication | Files | Extraction |
|---|---|---|
| `useState<T\|null>` + `useRef<HTMLDialogElement>` + `useEffect(showModal)` | `ScoreGrid.tsx:9-14`, `BrowseSearch.tsx:19-25` | one `useDialogSelection<T>()` hook |
| `ScoreModal` ≈ `BrowseModal` | `app/scores/ScoreModal.tsx`, `app/browse/BrowseModal.tsx` | same 30 lines; `ScoreModal` only adds `<ScoreInfo>`. Even the comments are copy-pasted. |
| Inline Supabase clients | `LoginButton.tsx:6-9`, `app/auth/callback/route.ts:11-23` | import `utils/supabase/client.ts` / `server.ts` — `ProfileButton` already does it right |
| Difficulty list in **3** places | `style.ts:2-17`, `search.ts:102-116`, `BrowseSearch.tsx:118-122` | the `<option>` values 1-5 are hardcoded to match `getDifficultyValue` |
| Level list in **2** places | `search.ts:7`, `BrowseSearch.tsx:93-110` | export `levelOrder`, then `levelOrder.map()` |
| Sort keys in **3** places | `BrowseSearch.tsx:59-67`, `search.ts:29-56`, `search.ts:80-97` | all stringly typed (`string \| null`), so a typo silently falls to `default` — make it a union |

Also: `rating.ts:50` hand-writes `{ score: number, charts: { chart_constant: number } }[]` where
`ScoreWithChart[]` exists. Its body is a 1-indexed loop with the `getPlayRating` line duplicated in
both branches, divided by a magic `60` (which is `2 × 10 + (50 − 10)`). A `reduce` with named
constants is ~4 lines.

`10000000` is hardcoded in five places (`rating.ts:2,14,26,44`, `actions.ts:31`,
`AddScoreButton.tsx:28`). `MAX_NOTES_SAFE_PM_THRESHOLD` shows the pattern — `MAX_BASE_SCORE`
deserves the same.

---

## 5. Polish and config

### 5.1 Lint baseline

`npx eslint .` is currently **1 error / 7 warnings**:

- 1 error — `ImportFromBrowser.ts:56` `as any[]` (§4.4)
- 4 warnings — `no-img-element` on `ProfileButton:31`, `SongInfo:63`, `AddScoreButton:60`,
  `ScoreCard:35`. `next.config.ts` has no `images.remotePatterns` for the Supabase storage host,
  which is what blocks migrating to `next/image`.
- 3 warnings — unused `id` (`ImportFromBrowser:36`), unused `supabase` and `options`
  (`middleware.ts:15,24`). The latter two disappear when §1.3 is fixed.

So: fixing §4.4 and §1.3 takes this to **0 errors / 4 warnings**, all of them the `<img>` migration.

### 5.2 Accessibility

- **Clickable `<li>`s with no keyboard path** — `ScoreCard.tsx:12`, `BrowseCard.tsx:13`,
  `ChartSearch.tsx:43`. No `role`, no `tabIndex`, no `onKeyDown`. Keyboard and screen-reader users
  cannot open a single card. Wrap the content in a real `<button>` — `Card` from §2.3 fixes both
  grids at once.
- **No form labels anywhere** — `AddScoreButton.tsx:102-145`, `ChartSearch.tsx:30`, and all five
  `<select>`s in `BrowseSearch` are placeholder-only. The sort-direction button renders only
  `↑`/`↓` with no accessible name.
- **`ProfileButton` menu** — lines 28-43 lack `aria-expanded`/`aria-haspopup`, and the menu closes
  only by clicking the toggle again (no outside-click, no Escape).
- **No `<main>` landmark** — `layout.tsx:23` puts `{children}` directly in `<body>`. `PageShell`
  (§2.4) fixes this. Note that `min-h-full flex flex-col` on `<body>` is currently inert because no
  child has `flex-1`.
- **alt text** — `"Song jacket"` / `"Song Jacket"` (inconsistent casing) on every card;
  `SongInfo.tsx:65` gets it right with `alt={chart.title}`.

### 5.3 Other

- **Uncontrolled selects show the wrong active sort** — `BrowseSearch.tsx:14,57` seeds `sortOption`
  to `'chartConstant'`, but the `<select>` has no `value` prop, so it displays "Sort by…" while the
  grid is already sorted by constant. All five selects are uncontrolled. Line 82 also ships a
  **duplicate `eq` option** (one `hidden`, one not) to fake a placeholder — `value` + a real
  placeholder removes the hack.
- **`/auth/auth-code-error` is an empty `<div>`** — no longer an anonymous export (so
  `react/display-name` is gone), but §1.6 makes the page actually reachable, so it needs real
  content. `/leaderboard` is a heading only, but `NavBar` links to it. Both are `async` with no
  `await`.
- **5000 chart rows shipped to the browser, twice** — `app/browse/page.tsx:9` and
  `app/scores/page.tsx:18`. On `/scores` the full catalog exists only to power `ChartSearch`'s
  autocomplete. Worse, `BrowseSearch.tsx:39` re-runs `filterCharts` + `sortCharts` (a
  `.slice().sort().reverse()` over 5000 rows) on **every render** — every keystroke, every "Load
  More" click. `useMemo` is the cheap fix; server-side search/pagination the real one.
- **`display: contents` divs as a form-reset hack** — `AddScoreButton.tsx:97-100`. Two nested
  layout-invisible wrappers whose only job is to hold a `key`, plus a `resetKey` counter.
  `formRef.current?.reset()` or a `key` on the `<form>` removes all of it.
- **Context with a silent no-op default** — `AddScoreButton.tsx:10` defaults to `() => {}`, so using
  `ChartSearch` outside a provider silently does nothing. Throw instead, and move the context to its
  own module (it's currently exported from a component file).
- **Five `!` env assertions, no validation** — `client.ts:8-9`, `server.ts:9-10`,
  `middleware.ts:16-17`, `LoginButton.tsx:7-8`, `callback/route.ts:12-13`. One startup assertion
  beats five cryptic runtime crashes.
- **Naming/formatting** — `ImportFromBrowser` is a PascalCase server action (reads like a component)
  living in its own file next to camelCase `addScore` in `actions.ts`. Indentation is 4 spaces
  everywhere except `app/scores/page.tsx` (2, and inconsistent within itself). Semicolons appear in
  `utils/supabase/*` and nowhere else. **There's no Prettier config or `format` script** — adding
  one settles all of it mechanically.
- **`tsconfig.json`** — `allowJs: true` (line 5) is pointless in an all-TS repo.
  `noUncheckedIndexedAccess: true` would catch the `sortedScores[i-1]` and `partsA[i]` indexing.

---

## 6. Suggested order

Each step is independently verifiable and leaves the app working.

1. **§1.1 + §1.4 + §1.5 + §1.7** — the silent-wrong-output and silent-data-loss bugs. Pure logic,
   no UI risk, highest value.
2. **§1.3** — the proxy. Isolated, and it's the one that will bite after deployment.
3. **§4.1** — generated Supabase types. Do this before the component work; it collapses several
   type findings and turns the stringly-typed unions into compile-time checks.
4. **§2.1 + §2.2** — `globals.css` tokens and `bg-card`. Small, and everything below builds on it.
5. **§3** — the responsive grid (with the `w-full` companion fix). One class change, biggest
   visible payoff.
6. **§2.3 + §2.4 + §2.5** — the component extractions. §1.2's `line-clamp` fix rides along in
   `CardBottomBar`.
7. **§2.6 + §2.7 + §2.8** — local dedup and the no-op/conflict cleanups. Should move zero pixels;
   if something moves, that's a real emit-order dependency.
8. **§4.2 + §4.3 + §4.5** — B50 dedup, null-guard the queries, extract the shared dialog hook.
9. **§5** — a11y, config, Prettier.

---

## 7. Verification

**Per step:** `npm run build` catches both TS and Tailwind errors. `npx eslint .` should go from
1 error / 7 warnings to 0 errors / 4 warnings after §4.4 + §1.3.

**§1.1 (rating math)** — the highest-value check, and it needs no UI. A scratch script that builds a
score from known pure/far/lost/shiny values and asserts the round trip:

```js
const score = Math.floor((2 * pure + far) * 5000000 / noteCount) + shiny
assert(getShinyPureCount(score, noteCount) === shiny)
```

Sweep `noteCount` 50–2236 with shiny at 0, 1, and `pure`. That's the exact harness used above; it
should report **0 mismatches**. The Testify reference case (cc 12.0, score 9,438,838 → Play Rating
delta −0.2039) must still hold — `getScoreModifier`/`getPlayRating` are untouched by this fix.

**§1.2 (line-clamp)** — find a chart with a title over 26 characters on `/browse`. Before: one line,
hard-cut. After: two lines.

**§1.3 (proxy)** — in Supabase's dashboard set the JWT expiry to ~60s, log in, wait it out, then
reload `/scores`. NavBar should stay signed in and the grid should stay populated.

**§1.4 (insert error)** — temporarily `REVOKE INSERT ON public.scores FROM anon`, submit a score.
An error message should appear in the modal, not a cheerful close. Re-grant afterward.

**§1.6 (OAuth)** — click Sign in, then Cancel on the Google consent screen. Should land on
`/auth/auth-code-error` with a real message, not `/browse`.

**§2.1 (theme tokens)** — flip the OS between light and dark mode. Nothing should change.

**§3 (responsive)** — DevTools device toolbar. At ≥1152px screenshot-diff the grid against `main`
(should be pixel-identical). At 375px: one centered column, no horizontal scrollbar. Check `/scores`
and `/browse` both.

**§4.2 (B50 dedup)** — log the same chart three times with different scores. It should occupy one
grid slot showing the best score, and PTT should not jump.

**§4.3 (null user)** — clear cookies entirely, then load `/scores` as a brand-new visitor. Should
render an empty grid with no server error in the terminal.

**§5.2 (a11y)** — Tab through `/browse`: every card should be focusable and Enter should open its
modal. Run Lighthouse's accessibility audit before and after for a number to compare.

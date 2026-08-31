# Audit Backlog

Actionable checklist from [report.md](report.md). Each item has the fix, the concrete failure it
causes, and — the actual point of this file — the **concept** behind it, so the same bug class is
recognizable next time.

Ordered by priority. Items already tracked in [todo.txt](todo.txt) are marked `→ todo.txt` and not
duplicated there.

---

## Tier 1 — Silently wrong output or data loss

### [DONE] 1.1 Fix `getShinyPureCount` — `utils/rating.ts:25-29`

```ts
export function getShinyPureCount(score: number, noteCount: number): number {
    if (!noteCount) return 0
    const units = Math.min(Math.ceil(((score + 1) * noteCount) / 5000000) - 1, 2 * noteCount)
    return score - Math.floor((units * 5000000) / noteCount)
}
```

**Why it matters:** verified wrong on **1532 of 3000** realistic scores — usually off by one, and
badly wrong when shiny is 0 (a 1024-note chart with 0 shiny pures currently displays **4883**).
Fixing this also fixes `getPmRating`, which was displaying wrong "MAX − n" distances for the same
reason.

**Concept — inverting a lossy formula.** The game *floors* an intermediate value, so the forward
computation destroys information. The original code inverted the formula as if no floor were there
and then tried to patch it up with `Math.round`, which works only when the discarded fraction
happens to be under 0.5. The general move when inverting something with a floor in it: don't
approximate and round — *solve for the integer that satisfies the original relation*. Here that's
"the largest `units` where `floor(units * 5e6 / N) <= score`", which rearranges to
`units * 5e6 < (score + 1) * N`. Multiplying through to clear the division keeps every term an
integer, which is also why the fix has no float edge cases.

Worth noting the boundary is real, not sloppiness: above ~2237 notes the shiny count genuinely can't
be recovered from the score alone, because the per-unit point value drops below 1 point per shiny.
That's the same fact `MAX_NOTES_SAFE_PM_THRESHOLD` already encodes.

---

### [DONE] 1.2 Move `line-clamp-2` off the flex container — `ScoreCard.tsx:46`, `BrowseCard.tsx:44`

Put the clamp on an inner `<span>`; leave `flex flex-col justify-center` on the wrapper.
Handled for free by `CardBottomBar` in item 2.3.

**Why it matters:** long chart titles have never wrapped to two lines. They're hard-cut by the
inherited `overflow: hidden`.

**Concept — two utilities, one property.** `line-clamp-2` sets `display: -webkit-box`; `flex` sets
`display: flex`. They can't both win. Crucially, **the order you write them in the `className` does
nothing** — CSS resolves same-specificity conflicts by position in the *stylesheet*, and Tailwind
decides that order when it generates the file. Verified here:

```
.next/dev/static/chunks/app_globals_0yg4wg8.css
361:  .line-clamp-2 {
372:  .flex {          ← later in the file, so it wins
```

This is the single most useful Tailwind lesson in the audit, and it has a sibling in item 2.7
(`p-6 py-3`). Rule of thumb: if two utilities in one `className` touch the same CSS property, one of
them is dead — and you can't tell which by reading the JSX. The fix is always structural (move one
to a different element) or to stop writing the conflict.

---

### [x] 1.4 Check the insert error in `addScore` — `app/scores/actions.ts:55-62`

```ts
const { error } = await supabase.from('scores').insert({ ... })
if (error) return { error: error.message }
revalidatePath('/scores')
```

**Why it matters:** an RLS rejection, FK violation, or NOT NULL violation currently closes the modal
as if it worked. The score is just gone. Every other Supabase call in this file checks its error —
this one was missed.

**Concept — errors that arrive as return values, not exceptions.** `supabase-js` does not throw on a
database error; it resolves with `{ data, error }`. So `await` succeeding tells you *nothing* about
whether the write happened. Any client with this shape (Supabase, Go-style tuples, Rust's `Result`)
moves the burden onto you: unchecked, the failure is indistinguishable from success. Grep for
`await supabase` and confirm every one destructures `error`.

---

### [ ] 1.5 Guard `chart_constant` — `app/scores/ScoreCard.tsx:50`

`score.charts?.chart_constant.toFixed(1)` → `score.charts?.chart_constant?.toFixed(1)`
Also `utils/rating.ts:54`, which uses `.charts.chart_constant` with no guard at all.

**Why it matters:** one logged score on a chart with a null constant throws a `TypeError` during
render, taking down the entire `/scores` page — not just that one card.

**Concept — `?.` guards exactly one link in the chain.** `a?.b.c` means "if `a` is null, stop;
otherwise evaluate `a.b.c` normally". It says nothing about `b`. If `b` can also be null you need
`a?.b?.c`. The reason TypeScript didn't catch this: `utils/types.ts:7` declares
`chart_constant: number` (non-nullable), and the query returns `any` anyway (item 4.1). So this is
really a symptom — the hand-written type disagrees with reality in three other places too. A crash
in a client component's render is not contained to that component; React unmounts the whole tree.

---

### [ ] 1.7 Reject `NaN` in `addScore` — `app/scores/actions.ts:13-48`

`if (!Number.isFinite(score)) return { error: 'Invalid score' }`, and have `parseOptionalNumber`
return `null` for non-finite input.

**Why it matters:** `Number('abc')` is `NaN`, and **all four** range checks let it through.

**Concept — `NaN` fails every comparison, including the ones meant to reject it.**
`NaN < 0` is `false`. `NaN > max` is `false`. `NaN === NaN` is `false`. So a bounds check written as
`x < min || x > max` accepts `NaN` silently. Always establish that a number *is* a number
(`Number.isFinite`) before comparing it.

Second concept, more important: **a Server Action is a public HTTP endpoint.** The `required` and
`type="number"` on the form are UX, not validation — anyone can POST to the action directly. Client
validation improves the experience; server validation is the only thing that protects the database.

While here: line 46 only cross-checks pure+far+lost when all three are present, and line 50 mints a
guest cookie for logged-in users because it runs before the `getUser()` check.

---

### [x] 1.3 Make the proxy actually refresh the session — `utils/supabase/middleware.ts` → todo.txt

Done: `await supabase.auth.getUser()` now runs before the `return supabaseResponse`, `createClient`
is `async`, and `proxy()` returns its promise (Next awaits a promise-returning proxy, so no `await`
was needed at the call site). The unused-`supabase` warning is gone.

Two leftovers, neither behavioral: the `createClient` → `updateSession` rename is still not done, and
this item originally claimed line 24 "loses the cookie attributes" by dropping `options` — that was
wrong. The *response* set on line 28 passes `options`, and that is the one the browser sees; the
request-side jar only needs name/value so downstream server code reads the fresh token. Dropping the
unused binding, as the current code does, is correct and matches Supabase's own snippet.

**Still unverified at runtime:** shorten the JWT expiry in the dashboard, idle past it, reload.

**Why it matters:** sessions expire instead of rolling over. Log in, wait an hour, reload — signed
out.

**Concept — an unused-variable warning is sometimes a *logic* warning.** ESLint says
`'supabase' is assigned a value but never used`, which reads like lint noise. It isn't: the client's
only job was to trigger a token refresh, the refresh only fires when something asks for the session,
and nothing asks. The lint rule found a real behavioral bug. Treat "constructed but never used" on
anything with side effects as suspicious rather than cosmetic.

---

## Tier 2 — Wrong behavior, contained

### [x] 1.6 Handle OAuth failure — `app/auth/callback/route.ts`

Read `searchParams.get('error')` and redirect to `/auth/auth-code-error`. Treat "no code and no
error" as a failure too.

**Why it matters:** cancelling the Google consent screen lands the user on `/browse`, still signed
out, with no explanation.

**Concept — an `if` with no `else` has a default branch whether you wrote one or not.** The code
reads "if there's a code, exchange it", then falls through to the success redirect. The unhandled
path silently inherits the happy-path outcome. When a function has exactly one success exit, check
that every way of *not* succeeding routes somewhere else.

**Also in this file, and important before deploying:** `origin` comes from `new URL(request.url)`,
which behind a proxy is the internal origin, not the public one. This will redirect to `localhost`
in production. Supabase's own template reads the `x-forwarded-host` header for this reason.

---

### [DONE] 4.2 Dedupe B50 by chart — `app/scores/page.tsx:26-31`

Group by `chart_id`, keep the highest `getPlayRating`, then sort and slice to 50.

**Why it matters:** `addScore` always inserts a new row, so three plays of the same chart take three
B50 slots, push out three real charts, and inflate PTT (the best one gets the 2× weight *and* the
other two still count).

**Concept — "top N rows" and "top N *things*" are different queries.** The sort is correct; what's
missing is that the input isn't one row per chart. Whenever you sort-then-slice, ask what the unit
of the list is supposed to be, and whether the data guarantees one row per unit. It usually doesn't.

---

### [~] 4.3 Guard `user_id` and check query errors — `app/scores/page.tsx`, `app/browse/page.tsx:9`

**Guard: done.** The scores query is now conditional on `user` and yields `{ data: [] }` otherwise, so
no invalid uuid ever reaches the filter. (The anon-auth migration made the original null case
unreachable anyway — a writer always has a real `auth.uid()` now.)

**Error checks: still open**, and now more urgent than when this was written. Neither query on
`/scores` nor the one on `/browse` destructures `error`. Once Step 3's RLS policies exist, a wrong
policy returns null rows, `?? []` turns that into an empty array, and the page renders an empty B50
with no error anywhere. You would be debugging a policy through a UI that insists nothing is wrong.

**Why it mattered originally:** a brand-new visitor had no `guest_id` cookie, so `userId` was `null`
and the query sent `user_id=eq.null` against a `uuid` column, which Postgres rejects.

**Concept — a discarded error turns a bug into a feature request.** `const { data } = await …`
throws away the only signal that something went wrong, and the empty-state UI then renders a
plausible lie. The class of bug is "failure that is indistinguishable from a legitimate empty
result" — the two cases need to be distinguishable before you can debug anything.

---

### [ ] 1.8 Wrap `handleSubmit` in `try/catch` — `app/scores/AddScoreButton.tsx:31-40`

**Why it matters:** validation errors are returned properly now, but a *thrown* rejection (network
failure, RLS 401) still skips `dialogRef.current?.close()` — the frozen-backdrop symptom, back for a
different reason.

**Concept — returned errors and thrown errors are two separate channels, and you need both.**
Handling `result.error` covers the failures the action anticipated. It does nothing for the ones it
didn't. Any `await` that must be followed by cleanup wants `try/catch` or `try/finally`.

---

### [ ] 1.9 Use the updater form — `app/browse/BrowseSearch.tsx:137`

`setVisibleCount(visibleCount + CARDS_PER_PAGE)` → `setVisibleCount(c => c + CARDS_PER_PAGE)`

**Why it matters:** two fast clicks on "Load More" produce one +100 instead of +200.

**Concept — a closure captures the value, not the variable.** `visibleCount` inside that arrow
function is whatever it was *when this render ran*. Two clicks before React re-renders both compute
from the same stale number, and the second overwrites the first. The updater form `c => c + 1`
receives the latest queued value instead. Rule: **if the new state is derived from the old state,
use the updater form.** If it's a fresh value (`setSearch(e.target.value)`), direct is fine.

---

### [ ] 1.10 Stop Enter from submitting mid-edit — `app/scores/ChartSearch.tsx:30-36`

`onKeyDown={(e) => { if (e.key === 'Enter') e.preventDefault() }}`

**Concept — implicit form submission.** A `<form>` with a submit button submits when Enter is
pressed in *any* text input inside it. This is browser behavior you get for free and usually want —
until the form contains a search box that isn't meant to submit anything.

---

### [ ] 1.11 The smaller ones

- [ ] `utils/search.ts:57` — descending sort uses `.reverse()` instead of negating the comparator,
  so equal-constant charts swap order between asc and desc. The `default` branch reverses without
  having sorted at all.
  **Concept:** reversing a sorted array is not the same as sorting descending — it also reverses
  ties, breaking *stability*. Negate the comparator instead.
- [ ] `utils/search.ts:18-19` — a `chart.level` not in `levelOrder` yields `indexOf` → `-1`, which
  passes every `lt`/`le` comparison. Guard `chartIndex >= 0`.
  **Concept:** `indexOf` returns `-1` for "absent", and `-1` is a perfectly valid number that
  silently participates in arithmetic. Sentinel values that share a type with real values are a
  recurring trap (`indexOf`, `parseInt` → `NaN`, `find` → `undefined`).
- [ ] `app/scores/AddScoreButton.tsx:58-69` — `chartInfoElement` renders `defaultChart` while the
  form inputs read `selectedChart`. Harmless today, wrong the moment a `ChartSearch` is added to
  that call site.
- [ ] `utils/jacket.ts:3` — `toLocaleLowerCase()` → `toLowerCase()`. Locale-aware casing for a
  storage key is non-deterministic by construction (the Turkish dotless-ı is the classic example).
- [ ] `utils/rating.ts:2` — `isPM(...) || noteCount < 2237` can never change the result; `isPM`
  already handles that case. Also inlines `2237` when the named constant is 38 lines below.
- [ ] `app/scores/ScoreGrid.tsx:9,26` — after `revalidatePath`, an open modal keeps rendering the
  pre-update score object.
  **Concept:** state holding a *copy* of a prop goes stale when the prop refreshes. Store the id and
  look the object up from the current list.

---

## Tier 3 — Tailwind de-duplication

Approach: **shared React components + `@theme` tokens.** No `clsx`, no `tailwind-merge` — see
report §2 for why.

### [DONE]] 2.1 `@theme` tokens in `globals.css`, then `bg-card`

Add `--color-foreground`, `--color-card`, `--color-page-start`, `--color-page-end`. Delete the
`:root` vars, the `prefers-color-scheme` block, and the unlayered `body` rule. Update
`layout.tsx:22`. Then replace `${bgColor}` with `bg-card` in both cards and delete `style.ts:52`.

> ⚠️ `--foreground` is **not** dead. `body { color: var(--foreground) }` is the only thing coloring
> every `<h1>`, and the media query is what makes it light instead of near-black. Move the value
> into the `@theme` token and put `text-foreground` on `<body>` — don't just delete.

**Concept — one home per fact.** Colors currently live in four places: CSS vars, a hardcoded
gradient in `layout.tsx`, a Tailwind class string exported from a `.ts` file, and hex in
`style.ts`. Consolidating isn't about tidiness, it's about there being exactly one place to change a
color. The `@theme` block earns it because Tailwind turns each token into a real utility
(`bg-card`, `from-page-start`) that the JIT scanner can see.

**Concept — unlayered CSS beats utilities regardless of specificity.** The old
`body { background: … }` rule was already removed for this reason. Anything outside `@layer` sits in
a higher cascade layer than Tailwind's generated utilities, so a plain CSS rule silently wins over
any `bg-*` class. After this step `globals.css` has zero unlayered CSS and the hazard is gone.

**Verify by flipping the OS to light mode.** Nothing should change — that's the proof the media
query was a landmine, not a feature.

---

### [DONE] 2.2 Leave the difficulty/grade palettes alone

Keep them as hex in `utils/style.ts`, applied via inline `style={{}}`. Don't convert to `@theme` +
static class lookups.

**Concept — where a value lives depends on who consumes it.** A color belongs in CSS when CSS
consumes it as a utility; it belongs in TS when TS computes *which one* applies. `bg-card` is
always the same class → CSS. `getDifficultyColor(chart.difficulty)` is a runtime branch over 5
values used as 4 different CSS properties plus a gradient stop → TS. Converting would mean one
lookup table per property (`DIFFICULTY_BORDER`, `DIFFICULTY_BG`, …) *and* keeping inline styles for
the gradient anyway — both mechanisms at once, which is worse than either.

The related rule you already know: Tailwind's scanner only sees complete literal strings, so
`` bg-[${color}] `` never generates CSS. That's *why* inline `style` is correct for dynamic colors.

---

### [DONE] 2.3 Extract `Card` / `CardBadge` / `CardBottomBar` → `app/components/Card.tsx`

Rewrite `ScoreCard.tsx` and `BrowseCard.tsx` around them. Carries the item 1.2 and 1.5 fixes.

**Why components rather than exported class strings:** in React the duplication is *markup plus
classes together* — the two cards repeat a `<div>` inside a `<div>`, not just a string. A shared
constant dedupes ~30% of it and can't carry the structural `line-clamp` fix at all.

**Concept — extraction changes what's possible, not just what's shorter.** Once
`getDifficultyColor` is called once per card and passed down as `accent`, the repetition it was
causing (3-4 calls per file, each with its own `?? ""`) disappears without needing a lookup table.
Good extractions tend to dissolve neighboring problems like this; if an extraction only saves
keystrokes, it's probably not the right seam.

**After this step, eyeball:** the corner badges (the `<li>` no longer creates a stacking context
once `z-10` is dropped) and long titles (now genuinely clamping to two lines).

---

### [DONE] 2.4 Extract `CardGrid`, `Panel`, `PageShell`, `Button` → `app/components/`

| Component | Replaces | Call sites |
|---|---|---|
| `CardGrid` | the byte-identical grid `<ul>` | `ScoreGrid.tsx:19`, `BrowseSearch.tsx:128` |
| `Panel` | the modal content panel | `ScoreModal.tsx:15`, `BrowseModal.tsx:15` |
| `PageShell` | page wrapper + `text-3xl font-bold` ×4 + `text-xl font-light` ×3 | all four `page.tsx` |
| `Button` | 6 near-identical buttons | see report §2.4 |

`PageShell` renders `<main>` instead of `<div>` — free a11y win, no layout change. Decide whether
the four different gaps (10/4/5/10) are deliberate; normalizing to `gap-6` is probably right.

**Concept — know when *not* to extract.** `Panel` deliberately skips `AddScoreButton.tsx:91`'s form,
which is one character different and appears once. Adding a polymorphic `as` prop to capture it
would make the component harder to read than the duplication it removes. Two occurrences is the
usual threshold; one occurrence that *looks* similar is a coincidence, not a pattern.

`Button`'s `size: 'fill'` is worth noticing: it isn't a padding value, it's the named case "sized by
my parent" (`flex-1 h-full`). Naming that case is what lets `Button` avoid a `className` escape
hatch entirely.

---

### [DONE] 2.5 Replace `AddScoreButton`'s three class props with a `size` union — `AddScoreButton.tsx:22`

Delete `sizeClasses` / `textClasses` / `borderClasses`, add `size?: 'md' | 'lg'`. The compiler will
point at every call site (`ScoreModal.tsx:22`, `BrowseModal.tsx:22`, `app/scores/page.tsx:39`).

**Concept — make invalid states unrepresentable.** `sizeClasses="p-6"` passed to a base containing
`p-2` compiles fine and renders wrong, with no warning anywhere. `size="lg"` cannot express that
conflict at all — the mistake stops existing rather than being caught. This is the deeper reason to
prefer variant props over `className` props, and it's also why `tailwind-merge` isn't needed here:
there's nothing to merge.

Note line 79 currently hardcodes `text-white` *and* takes it as the `textClasses` default, so it's
emitted twice — a small illustration of the same problem.

---

### [DONE] 2.6 Local dedup — zero visual change

- [ ] `JudgementInput` local to `AddScoreButton.tsx` — collapses lines 116-145 to three lines.
  Dedupes the repeated *props* (`type`, `min`, `max`, `disabled`, `onChange`) as much as the classes.
- [ ] `InfoRow` local to `SongInfo.tsx` — 47 lines of 9 copy-pasted blocks → ~11.
  ⚠️ Keep `||`, not `??`: `note_count ? … : 'Unknown'` renders `Unknown` for `0` today, and `??`
  would render a literal `0`.
- [ ] `controlClasses` const in `BrowseSearch.tsx` for the five toolbar controls.
- [ ] `ScoreInfo.tsx:6` — drop the load-bearing trailing space, use a template literal not `+`.

**Concept — a shared class string is safe only under a rule.** Extend it *only* with utilities that
set properties the base doesn't set. `controlClasses + " px-6"` is fine because the base has no
horizontal padding; `controlClasses + " p-6"` would not be. This is exactly the constraint that
components make unnecessary, which is why the string version stays scoped to one file.

**Concept — never let whitespace be load-bearing.** `ScoreInfo`'s `flexClasses` ends in a space so
`+ "justify-start"` doesn't glue two class names together. Any formatter, or anyone tidying the
file, silently breaks it. Template literals with explicit `${}` boundaries can't have this failure.

---

### [DONE] 2.7 Fix the conflicting padding pairs

`p-6 py-3` → `px-6 py-3` at `BrowseSearch.tsx:57,71,80,91,115`; `px-50 p-4` → `px-50 py-4` at
`app/scores/page.tsx:46`.

**Why it matters:** these render correctly *only* because Tailwind emits `.p-*` before `.px-*`
before `.py-*`. Zero visual change — but afterwards it's true by construction instead of by luck.

**Concept:** same as item 1.2. Two utilities touching one property means one is dead. `p-6` sets all
four sides, `py-3` overrides two of them — so the effective value was always `px-6 py-3`, just
written in a way that depends on Tailwind's internal ordering staying the same forever.

---

### [DONE] 2.8 Cosmetic cleanup

- [DONE] Template literals with no `${}` — `app/scores/page.tsx:40`, `AddScoreButton.tsx:91,111,160,167`,
  `ImportFromBrowserButton.tsx:32`
- [CLASSES ARE NOT DEAD] Dead `scrollbar-*` classes at `ChartSearch.tsx:41` — the plugin isn't installed
- [DONE] No-op utilities: `right-0`/`z-0` without positioning (`ScoreCard.tsx:37`),
  `items-center justify-end` on a non-flex div (`ImportFromBrowserButton.tsx:37`), `justify-end` on
  a `<p>` (`ScoreInfo.tsx:36`), `rounded-lg` on a transparent wrapper (`BrowseSearch.tsx:44`)
- [DONE] `ChartSearch.tsx:50-53` — inline `fontWeight`/`cursor` → `font-bold`/`font-normal` +
  `cursor-pointer`
- [DONE] `ChartSearch.tsx:21,41` — the dropdown's wrapper isn't `relative`, so `absolute left-10
  right-10` resolves against the `<dialog>` and the offsets are hand-tuned to cancel the form's
  `p-10`. Add `relative` to the wrapper, use `left-0 right-0 top-full`.
- [DONE] Stray double/trailing spaces in class strings — `SongInfo:21,68`, `ScoreCard:37`,
  `scores/page:37`, `AddScoreButton:59`, `BrowseSearch:56,57,71,80,91,115`

**Concept — positioning is relative to the nearest *positioned* ancestor.** `absolute` looks up the
tree for the closest element with `position` other than `static` (in Tailwind: `relative`,
`absolute`, `fixed`, `sticky`). Forget the `relative` and it silently keeps walking — often all the
way to the viewport or, here, to the `<dialog>`. The tell is magic offsets that happen to match some
distant ancestor's padding. Same reason `right-0` on `ScoreCard.tsx:37` does nothing: that `<img>`
is `static`, so inset properties don't apply to it at all.

---

## Tier 4 — Responsive layout

### [DONE] 3.1 + 3.2 Make the grid responsive

In `CardGrid`:

```
mx-auto grid w-full max-w-6xl grid-cols-[repeat(auto-fit,200px)] justify-center gap-x-[30px] gap-y-10 px-4
```

**Required companion:** add `w-full` to both grid wrappers (`ScoreGrid.tsx:17`,
`BrowseSearch.tsx:43`). Without it the grid blows out — see the concept below.

**Why it matters:** the app currently has **zero** breakpoint prefixes anywhere and the grid is a
hard 1150px. Any phone or tablet scrolls sideways.

**Concept — `auto-fit` needs a definite container width.** `w-full` is `width: 100%`, and a
percentage resolves against the parent's content box. Both wrappers are shrink-to-fit (they sit
under `items-center` ancestors), so their width comes *from* their children — a circular dependency
the spec resolves by treating the percentage as `auto`. Under an indefinite width, `auto-fit`
behaves like `auto-fill` and lays out one track per card. This is the same "the parent is sized from
the children, so `w-full` is meaningless" trap that made `w-full max-w-5xl` inert inside the
`<dialog>`.

**Concept — the current gutter isn't a gap.** `repeat(5, 230px)` with `w-[200px]` cards and
`justify-items-center` produces 30px between cards as *leftover track space* — two magic numbers
encoding one gap. Making it a real `gap-x-[30px]` with 200px tracks is what lets the column count
change without the spacing changing. The math works out exactly: `max-w-6xl` (1152px) − `px-4`
(32px) = 1120px = 5×200 + 4×30, so desktop is pixel-identical.

### [DONE] 3.3 Toolbar and PTT row

- [DONE ] `BrowseSearch.tsx:54` — add `flex-wrap`, drop `h-20` for `h-auto`
- [DONE ] `app/scores/page.tsx:46` — replace the hand-tuned `px-50` with
  `mx-auto flex w-full max-w-6xl items-start gap-4 px-4 py-4` so the PTT badge tracks the grid's
  left edge at every width, not just at 1150px

---

## Tier 5 — Types, dedup, polish

### [ ] 4.1 Generate Supabase types → todo.txt

`npx supabase gen types typescript --project-id <id> > utils/database.types.ts`, then
`createClient<Database>(...)` in all three factories.

**Why it matters:** this is the root cause behind item 1.5 and the `types.ts` drift. Right now
`app/scores/page.tsx:26-31`'s sort type-checks *vacuously* — `a` and `b` are `any` — and the result
is handed to a `ScoreWithChart[]` prop with no cast and no complaint.

**Concept — `any` doesn't fail loudly, it disables checking silently.** A hand-written type
(`utils/types.ts`) that mirrors a database is a second source of truth, and the two drift without
anything noticing: `chart_constant: number` is declared non-nullable while three separate call sites
defend against it being null, and `charts: Chart` is declared non-null while ~20 call sites write
`score.charts?.…`. Either the type is wrong or all that optional chaining is dead code — and today
there's no way to tell which. Generated types make the database the single source of truth.

### [~] 4.4 Verify the import's unique constraint — `app/scores/ImportFromBrowser.ts:46`

**Answered: it exists.** The `db pull` baseline shows
`CONSTRAINT "unique_user_score" UNIQUE (user_id, chart_id, created_at)` on `public.scores`, so the
`ON CONFLICT` had a real constraint behind it and never risked `42P10`.

Worth noting what it does *not* do: because `created_at` is part of the key, two plays of the same
chart a microsecond apart are distinct rows. It guards the import against re-running; it does nothing
about known bug 9 (B50 double-counting repeat plays).

Moot in practice for now — `ImportFromBrowser` reads a `guest_id` cookie nothing sets any more, so the
action is inert until Step 4 rewires it. The two sub-items below are still live, since the file
still contains the repo's only ESLint error.

- [ ] Also line 56: `(data as any[]).length` → `data?.length ?? 0` (the repo's only ESLint error)
- [ ] Also line 36: the unused `id` destructure needs an eslint-disable or a rename to `_id`

### [ ] 4.5 Component and constant dedup

- [ ] Extract `useDialogSelection<T>()` — `ScoreGrid.tsx:9-14` and `BrowseSearch.tsx:19-25` are the
  same hook trio (`useState` + `useRef` + `useEffect(showModal)`)
- [ ] `ScoreModal` and `BrowseModal` are the same 30 lines; `ScoreModal` only adds `<ScoreInfo>`
- [ ] Inline Supabase clients in `LoginButton.tsx:6-9` and `app/auth/callback/route.ts:11-23`
  → use `utils/supabase/` → todo.txt
- [ ] Difficulty list lives in **3** places (`style.ts:2-17`, `search.ts:102-116`,
  `BrowseSearch.tsx:118-122` — where the `<option value>`s 1-5 are hardcoded to match
  `getDifficultyValue`)
- [ ] Level list lives in **2** (`search.ts:7` vs 17 hand-written `<option>`s at
  `BrowseSearch.tsx:93-110`) — export `levelOrder` and `.map()` it
- [ ] Sort keys live in **3** (`BrowseSearch.tsx:59-67`, `search.ts:29-56`, `search.ts:80-97`), all
  typed `string | null` so a typo silently falls through to `default` — make it a union type
- [ ] `rating.ts:50` — hand-written param type where `ScoreWithChart[]` exists; 1-indexed loop with
  the body duplicated across both branches; magic `60` (really `2×10 + (50−10)`)
- [ ] `MAX_BASE_SCORE` — `10000000` is inlined in 5 places

**Concept — a list that exists in two places will disagree.** The `<option value="3">FTR</option>`
in `BrowseSearch` is coupled to `getDifficultyValue` returning `3` for `"FTR"`, with nothing
enforcing it. Deriving the options from the array (`levelOrder.map(...)`) makes the coupling
structural instead of a convention someone has to remember.

### [ ] 5.2 Accessibility

- [ ] Clickable `<li>`s with no keyboard path — `ScoreCard.tsx:12`, `BrowseCard.tsx:13`,
  `ChartSearch.tsx:43`. Wrap the content in a real `<button>` (item 2.3 fixes both grids at once)
- [ ] No labels on any form input — `AddScoreButton.tsx:102-145`, `ChartSearch.tsx:30`, all five
  `<select>`s in `BrowseSearch`. The `↑`/`↓` sort button has no accessible name at all
- [ ] `ProfileButton.tsx:28-43` — no `aria-expanded`/`aria-haspopup`, no outside-click or Escape
- [ ] No `<main>` landmark (`PageShell` fixes this). Note `min-h-full flex flex-col` on `<body>` is
  currently inert — no child has `flex-1`
- [ ] `alt="Song jacket"` / `"Song Jacket"` on every card; `SongInfo.tsx:65` does it right with
  `alt={chart.title}`

**Concept — `onClick` on a non-interactive element is invisible to keyboards.** A `<div>` or `<li>`
isn't focusable, doesn't fire on Enter/Space, and isn't announced as actionable. `role="button"` +
`tabIndex={0}` + `onKeyDown` reimplements what `<button>` gives you for free, badly. Reach for the
semantic element first and restyle it; reach for ARIA only when no element fits.

**Concept — a placeholder is not a label.** It disappears on focus, isn't read reliably by screen
readers, and leaves the field unidentifiable once the user starts typing.

### [ ] 5.3 Polish

- [ ] `BrowseSearch` — all five `<select>`s are uncontrolled (no `value` prop), so the sort dropdown
  shows "Sort by…" while the grid is already sorted by chart constant. Line 82 ships a duplicate
  `eq` option to fake a placeholder; `value` + a real placeholder removes the hack
  **Concept:** an uncontrolled input keeps its own copy of the truth. With `useState` *and* DOM
  state, they can disagree — and here they do from first paint.
- [ ] `/auth/auth-code-error` is an empty `<div>`; item 1.6 makes it reachable
- [ ] `useMemo` the filter+sort in `BrowseSearch.tsx:39` — it re-runs
  `.slice().sort().reverse()` over 5000 rows on **every render**, including every keystroke
- [ ] Both pages ship all ~1800 charts to the browser; `/scores` does it only for the autocomplete
- [ ] `AddScoreButton.tsx:97-100` — two `display: contents` wrappers plus a `resetKey` counter, all
  to force a remount. `formRef.current?.reset()` or a `key` on the `<form>` replaces the lot
- [ ] `AddScoreButton.tsx:10` — the context defaults to `() => {}`, so using `ChartSearch` outside a
  provider silently does nothing. Throw instead, and move the context to its own module
  **Concept:** a default that silently no-ops converts a wiring mistake into a "why isn't this
  working" session. Fail loudly at the boundary.
- [ ] Five `!` env assertions across `client.ts`, `server.ts`, `middleware.ts`, `LoginButton.tsx`,
  `callback/route.ts` — one startup check beats five cryptic runtime crashes
- [ ] Add Prettier + a `format` script. Indentation is 4 spaces except `app/scores/page.tsx` (2, and
  inconsistent with itself); semicolons appear in `utils/supabase/*` and nowhere else
- [ ] `next.config.ts` — add `images.remotePatterns` for the Supabase storage host, which is what
  blocks moving the four `<img>` tags to `next/image` (4 of the 7 lint warnings)
- [ ] `tsconfig.json` — drop `allowJs`; consider `noUncheckedIndexedAccess`

---

## Lint baseline

`npx eslint .` today: **1 error, 7 warnings.**

| | |
|---|---|
| 1 error | `ImportFromBrowser.ts:56` `as any[]` |
| 4 warnings | `no-img-element` — `ProfileButton:31`, `SongInfo:63`, `AddScoreButton:60`, `ScoreCard:35` |
| 3 warnings | unused `id` (`ImportFromBrowser:36`), unused `supabase` + `options` (`middleware.ts:15,24`) |

Fixing items 4.4 and 1.3 takes this to **0 errors / 4 warnings**, all of them the `next/image`
migration.

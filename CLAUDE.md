@AGENTS.md

# Arcaea Score Viewer — Project Context

Personal project + learning exercise (first time with TypeScript, Next.js, Supabase/SQL). Built incrementally with heavy explanation at each step — prioritize understanding over speed when helping on this project.

## Docs

| File | Contents |
|---|---|
| `docs/todo.txt` | The running project list — features, deploy blockers, stage planning. |
| `docs/report.md` | Full codebase audit: bugs (with failure scenarios and fixes), the Tailwind de-duplication plan, responsive layout, code quality. |
| `docs/report_todo.md` | The audit as an actionable checklist, each item with a concept note explaining the underlying bug class. |
| `docs/anon_auth_migration.md` | Staged plan for replacing the `guest_id` cookie with Supabase `signInAnonymously()` — the blocker on UPDATE/DELETE policies. |

## Stack

- **Frontend/Backend:** Next.js 16 (App Router, TypeScript, Tailwind CSS v4)
- **Database/Auth/Storage:** Supabase (Postgres + Google OAuth + Storage)
- **OCR (Stage 2, not started):** Python service, likely using `arcaea-offline-ocr` (PyPI) or a custom pipeline
- **Package manager:** npm
- **Font:** `Exo` via `next/font/google`, wired to `--font-sans`/`--font-mono` in `globals.css`

Env vars (in `.env.local`, gitignored): `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`.
`.env.example` holds the same two keys with empty values. Note `.gitignore`'s `.env*` rule would otherwise
swallow it, so there is an explicit `!.env.example` negation below it — without that the template is never
committed and the second-contributor workflow silently breaks.
Note the key is named `PUBLISHABLE_KEY`, not the older `ANON_KEY` convention — the same string is used by the browser, server, and proxy clients.

## Routes

| Route | Purpose |
|---|---|
| `/` | Landing page. Shows a welcome line if logged in, otherwise a `<LoginButton>` prompt. |
| `/scores` | The B50 view — top 50 scores by Play Rating, plus Add Score / Import buttons. |
| `/browse` | Full chart catalog with search, sort, and level/difficulty filters. |
| `/leaderboard` | Stub — heading only, no content yet. |
| `/auth/callback` | OAuth code-exchange route handler; redirects to `/browse` on success — **and also on provider-side failure**, see known bug 6. |
| `/auth/auth-code-error` | Stub — renders an empty `<div>`. |

`NavBar` is rendered globally from `app/layout.tsx`, so it appears on every route.

## Auth (Stage 3 — mostly done)

Google OAuth via Supabase is **implemented and working**:

- `LoginButton` calls `signInWithOAuth({ provider: 'google' })` with `redirectTo: ${origin}/auth/callback`.
- `app/auth/callback/route.ts` exchanges the `code` param for a session, then redirects to `/browse`.
- `ProfileButton` shows the Google avatar + a click-to-open Sign Out menu, and calls `router.refresh()` after sign-out.
- `NavBar` picks `ProfileButton` vs `LoginButton` off `supabase.auth.getUser()`.

**Anonymous → account model** (the `guest_id` cookie is gone; `utils/guest.ts` is deleted). Steps 0–2 of
`docs/anon_auth_migration.md` are done, so there is now exactly one kind of identity: a real row in
`auth.users`, reached through a Supabase-signed JWT. `user_id` on a score is always an `auth.uid()`.

- **`utils/auth.ts` → `getOrCreateUser(supabase)`** returns a discriminated `{ user, error }`: it calls
  `getUser()` and only calls `signInAnonymously()` when there is no user. Anonymous users are created
  **lazily, on the actual write** — `addScore` calls it *after* all validation passes, so a rejected
  submission never mints a permanent `auth.users` row.
- **Only Server Actions and Route Handlers may call it.** `utils/supabase/server.ts:17-23` swallows
  cookie-write failures in a `try/catch`, so calling it from a Server Component would silently create a
  user, fail to persist the session, and repeat on every render. Read paths (`/scores/page.tsx`,
  `NavBar`, `/`) use plain `getUser()` and treat `!user` as "no scores yet".
- **`getUser()` reports "no session" as an `AuthSessionMissingError`, not as `{ user: null, error: null }`.**
  Every branch must test `user`, never `error` — testing `error` sends every first-time visitor down the
  failure path. `getOrCreateUser` deliberately discards that error.
- **`user.is_anonymous` is the "really logged in" test.** `NavBar.tsx:28` and `app/page.tsx:17` use
  `user && !user.is_anonymous`; bare `user` used to mean "signed in with Google" and now doesn't. This is
  not cosmetic: an anonymous user handed a Sign Out button loses their identity **irreversibly** — the
  `auth.users` row survives with no credential to sign back in with, and every score under that uid is
  orphaned. An anonymous user gets *Sign in with Google*, never *Sign Out*.
- **`ImportFromBrowser` is dead code for now.** It still reads a `guest_id` cookie that nothing sets any
  more, so it can only ever report "nothing to import". Its button has been removed from `/scores`; the
  action and `ImportFromBrowserButton.tsx` still exist. Step 4 of the migration either rewires it to read
  `prev_anon_id` or drops it, depending on how `linkIdentity()` goes.

Still outstanding: UPDATE/DELETE policies (Step 3), which additionally need the `anon` grants extended to
`authenticated` — an anonymous **user** carries `role: authenticated`, so the current
`GRANT ... TO anon` stops covering them.

## Database schema (Supabase/Postgres)

### `charts`
| column | type | notes |
|---|---|---|
| id | int8 | PK, identity/auto-increment |
| title | text | unicode display title |
| song_id | text | Arcaea's internal Latin-only slug; drives jacket lookup |
| difficulty | text | "PST", "PRS", "FTR", "ETR", "BYD" |
| level | text | e.g. "11", "11+" — text because of the "+" suffix |
| chart_constant | float4 | precise difficulty value |
| note_count | int4 | |
| artist | text | |
| bpm | text | text, not numeric — some charts have ranges |
| length | text | "m:ss" format, parsed by `getLengthValue` |
| version | text | dotted game version, compared by `compareVersions` |
| chart_designer | text | nullable |
| jacket_designer | text | nullable |
| jacket_override | bool | true when this difficulty has its own alt jacket art |

`charts` is populated **manually / via SQL** — there is no in-app "add chart" flow, so every column above is filled in by hand.

The `utils/style.ts` and `utils/search.ts` difficulty maps cover all five difficulties including PST/PRS, so the earlier "only FTR/BYD/ETR are tracked" constraint no longer holds in code.

### `scores`
| column | type | notes |
|---|---|---|
| id | int8 | PK, identity/auto-increment |
| chart_id | int8 | FK → charts.id, ON DELETE/UPDATE: No Action (Restrict) |
| user_id | uuid | either a Supabase `auth.uid()` or a guest UUID — the column does not distinguish |
| score | int8 | required |
| pure | int4 | **nullable** — optional field |
| far | int4 | **nullable** — optional field |
| lost | int4 | **nullable** — optional field |
| created_at | timestamptz | default `now()` |

**Design principle:** store raw facts only. Grade, Play Rating, Play Potential, and PM-distance are all *calculated*, never stored — see `utils/rating.ts`. This avoids stale derived data if the formula or a chart_constant is ever corrected.

### Storage
Public bucket `jackets`, holding `{song_id}.jpg` and `{song_id}_{difficulty}.jpg` (lowercased difficulty) for alt art. Resolved by `utils/jacket.ts`.

### RLS / Grants
Both tables have RLS enabled (project-wide "automatic RLS on new tables" was on at project creation; "automatically expose new tables" was off).

- `charts`: SELECT policy (`using (true)`) + `GRANT SELECT ON public.charts TO anon;`
- `scores`: SELECT + INSERT policies (`using/with check (true)`) + `GRANT SELECT, INSERT ON public.scores TO anon;`
- **No UPDATE/DELETE policies yet** — deliberately deferred until the guest identity is trustworthy (see Auth above).
- Note: RLS policies and table-level GRANTs are separate and both required — a missing GRANT throws error `42501` even with a correct RLS policy.

## File map

```
app/
├── layout.tsx                 — root layout; loads Exo, renders <NavBar> above {children}.
│                                 <body> carries the page-wide background (bg-linear-to-r from-[#0f1014] to-[#191621]).
│                                 globals.css's old plain-CSS `body { background: ... }` rule was removed — it lived outside
│                                 any Tailwind @layer, so as unlayered CSS it always beat the bg-* utility class regardless
│                                 of specificity (Tailwind's own utilities are generated inside @layer utilities).
├── page.tsx                   — landing page. Server component; greets by email prefix or shows <LoginButton>.
├── globals.css                — Tailwind v4 @import + @theme inline block mapping the Exo font vars.
├── auth/
│   ├── callback/route.ts      — GET handler; exchangeCodeForSession(code) → redirect to /browse (or /auth/auth-code-error).
│   │                             Builds its own createServerClient inline rather than reusing utils/supabase/server.ts.
│   └── auth-code-error/page.tsx — STUB, renders an empty div. Named export, so no lint error — but the
│                                 page is user-reachable on a failed code exchange and shows nothing.
├── components/
│   ├── NavBar.tsx             — server component; 3-column grid (logo / links / profile). Calls getUser() to pick
│   │                             ProfileButton vs LoginButton.
│   ├── LoginButton.tsx        — client; Google OAuth sign-in. Constructs createBrowserClient inline instead of
│   │                             using utils/supabase/client.ts.
│   ├── ProfileButton.tsx      — client; avatar button + useState-toggled Sign Out dropdown.
│   ├── Modal.tsx              — shared <dialog> wrapper. Takes a ref, children, and an optional onClose. Backdrop
│   │                             dimmed/blurred via the `backdrop:` variant. Centered with `m-auto` (Preflight zeroes
│   │                             the margin:auto a modal <dialog> gets by default). Click-outside closes via
│   │                             `e.target === e.currentTarget` — a ::backdrop click targets the <dialog> itself,
│   │                             while content clicks merely bubble. `onClose` is wired to the native `close` event,
│   │                             so it fires on Esc too — required for any parent driving the modal from state.
│   │                             Takes a `width` prop (default `w-[min(60vw,60rem)]`) because a <dialog> otherwise
│   │                             keeps the UA stylesheet's `width: fit-content` and shrink-wraps its own content —
│   │                             which made `w-full max-w-5xl` on the children inert and every modal a different size.
│   └── SongInfo.tsx           — shared 2-column chart detail panel (jacket + all metadata). Used by BrowseModal.
├── scores/
│   ├── page.tsx               — B50 view. Server component. Renders AddScoreButton + <ScoreGrid>.
│   │                             charts is fetched unconditionally; the scores query (nested `charts(*)` join)
│   │                             runs only when getUser() returns a user, otherwise `{ data: [] }`. Ordering is
│   │                             deliberate: a session-less visitor still needs charts, because AddScoreButton
│   │                             is what mints their anonymous user. B50 selection lives in rating.ts.
│   │                             ImportFromBrowserButton was removed from here — see the Auth section.
│   ├── ScoreGrid.tsx          — client; owns `selectedScore` state + the single shared dialog ref, maps ScoreCards,
│   │                             renders one <ScoreModal>. Exists so page.tsx can stay a server component.
│   ├── ScoreCard.tsx          — one B50 grid cell: rank badge, grade + Play Rating, jacket, difficulty-colored
│   │                             border/title bar. Owns no modal — calls `onSelect(score)` on click.
│   ├── ScoreModal.tsx         — the one shared score-detail modal. Takes `score: ScoreWithChart | null`; contents are
│   │                             guarded on it, so they unmount when nothing is open (and the null check narrows the
│   │                             type, so no placeholder chart is needed). Renders SongInfo + ScoreInfo + AddScoreButton.
│   ├── ScoreInfo.tsx          — score-detail panel: score + PM distance, Play Rating, colored grade, pure/far/lost,
│   │                             shiny pure count, and the created_at timestamp.
│   ├── AddScoreButton.tsx     — client; button + <Modal> wrapping the add-score form. Styling is customizable per
│   │                             call site via `sizeClasses`/`textClasses`/`borderClasses` props (these REPLACE rather
│   │                             than append, which avoids Tailwind conflicts — two same-property utilities in one
│   │                             class attribute are resolved by stylesheet order, not attribute order).
│   │                             Both modals pass the identical trio; docs/report.md §2.5 argues for collapsing
│   │                             all three into one `size` union, which makes the conflict unrepresentable.
│   │                             Exposes SelectedChartContext so ChartSearch can push the picked chart up.
│   ├── ChartSearch.tsx        — client; searchable chart picker used inside AddScoreButton's form.
│   ├── actions.ts             — `addScore` server action. Validates chart existence + score range server-side and
│   │                             returns `{ error }` rather than throwing, resolves user?.id ?? guestId, inserts.
│   │                             Calls revalidatePath('/scores'). NOTE: the insert's own error is not checked.
│   ├── ImportFromBrowser.ts   — `ImportFromBrowser` server action; copies guest scores onto the logged-in account.
│   └── ImportFromBrowserButton.tsx — client; useTransition + inline result message.
├── browse/
│   ├── page.tsx               — fetches all charts (~1800), renders <BrowseSearch>.
│   ├── BrowseSearch.tsx       — client; owns search/sort/filter state, `selectedChart`, and the shared dialog ref.
│   │                             Renders the control bar, the capped card grid, a Load More button, and one
│   │                             <BrowseModal>. Grid is capped at CARDS_PER_PAGE (100) and extended on demand.
│   │                             The cap resets on any filter/sort change via the "adjust state during render"
│   │                             pattern (compare a `filterKey` string against previous state) rather than an
│   │                             effect — react-hooks/set-state-in-effect rejects the effect version, and the
│   │                             render-phase reset avoids painting the stale count or a second commit.
│   ├── BrowseCard.tsx         — client; chart card with the jacket as a CSS background-image, difficulty gradient
│   │                             overlay, and a sort-dependent info line. Owns no modal — calls `onSelect(chart)`.
│   └── BrowseModal.tsx        — the one shared chart-detail modal. Takes `chart: Chart | null`, contents guarded on
│                                 it. <SongInfo> + a scaled-up <AddScoreButton defaultChart={chart}>.
└── leaderboard/page.tsx       — STUB, heading only.

utils/
├── supabase/
│   ├── client.ts              — browser Supabase client
│   ├── server.ts              — server Supabase client (takes a cookieStore param)
│   └── middleware.ts          — used by proxy.ts. Awaits getUser() before returning, which is what makes the
│                                 setAll cookie callback fire and the session roll over. NOTE: filename still says
│                                 "middleware" even though the Next.js file convention moved to proxy, and the
│                                 export is still named createClient even though it returns a NextResponse.
├── auth.ts                    — `getOrCreateUser(supabase)` → `{ user, error }` discriminated union.
│                                 getUser(), then signInAnonymously() only if there is no user.
│                                 SERVER ACTIONS / ROUTE HANDLERS ONLY — see the Auth section.
│                                 (Replaced utils/guest.ts, which is deleted.)
├── jacket.ts                  — `getJacketUrl(songId, difficulty, jacketOverride)` → Supabase Storage public URL.
│                                 Picks `{song_id}_{difficulty}.jpg` when jacket_override is true, else `{song_id}.jpg`.
├── rating.ts                  — grade / Play Rating / PM math. See below.
├── search.ts                  — `filterCharts`, `sortCharts`, `getSortDisplayValue` + comparison/coercion helpers.
├── style.ts                   — `getDifficultyColor` / `getGradeColor` → hex strings, applied via inline `style`
│                                 (Tailwind's JIT scanner only sees complete literal class strings, so a template
│                                 class like `bg-[${color}]` never generates CSS). `getTextSize(title)` → a static
│                                 Tailwind class bucketed by title length, so interpolating THAT onto className is fine.
│                                 Also exports the shared `bgColor` constant.
└── types.ts                   — `Chart` (mirrors the charts table), `Score` (mirrors scores), and
                                  `ScoreWithChart = Score & { charts: Chart }` for the joined query result.
                                  Hand-written, NOT generated — so it can and does disagree with the DB.

proxy.ts                       — root proxy (Next.js 16's rename of middleware.ts). Delegates to
                                  utils/supabase/middleware.ts. Matcher skips _next/static, _next/image, favicon, images.

docs/
├── todo.txt                   — the running project list (feature backlog, deploy blockers)
├── report.md                  — full codebase audit: bugs, Tailwind de-duplication, code quality
└── report_todo.md             — the audit as an actionable checklist, with a concept note per item
```

### The shared-modal pattern (both grids)

`/browse` and `/scores` both used to render one `<Modal>` **per card** — and because each card's modal
also contained an `<AddScoreButton>` (which renders a second `<Modal>` with a full form), a 1799-chart
browse page mounted ~3,600 `<dialog>` elements and ~1,800 forms when at most one can ever be open.

Both now use the same shape, and new grids should copy it:

- The **list container** (`BrowseSearch` / `ScoreGrid`) owns `selected*` state plus a single `dialogRef`.
- A `useEffect` on the selection calls `showModal()` once the newly selected item has rendered into the modal.
- The **card** owns no dialog. It takes an `onSelect` callback and calls it on click.
- The **modal** takes a nullable item and guards its contents on it (`{item && ...}`), so the subtree
  unmounts when nothing is open — which also narrows the type, so no placeholder object is needed.
- `onClose` resets the selection to null. This is load-bearing: Esc closes a `<dialog>` natively without
  going through the click handler, and without the reset the state would desync and the same card
  couldn't be reopened.
- `AddScoreButton` is keyed on the chart id, because it seeds `useState(defaultChart)` on mount only —
  a changed `defaultChart` prop does not update that state.

### Next.js 16: `middleware.ts` is now `proxy.ts`

Next 16 deprecated the `middleware.js` file convention and renamed it to `proxy.js` — same functionality, new file and export names (`node_modules/next/dist/docs/01-app/03-api-reference/03-file-conventions/middleware.md`). This repo has already migrated: the root file is `proxy.ts` exporting `proxy()`. Only the helper it delegates to, `utils/supabase/middleware.ts`, still carries the old name.

## `utils/rating.ts`

`getScoreModifier` / `getPlayRating` are verified against real Sheets data: Testify (chart_constant 12.0, score 9,438,838) → Play Rating delta -0.2039, Play Potential 11.7961, matching the original Google Sheets exactly.

- `getGrade(score, noteCount, pure, far, lost)` → "PM" | "EX+" | "EX" | "AA" | "A" | "B" | "C" | "D". Returns a bare `"PM"` (no "MAX-n" suffix) so it fits the small ScoreCard cell.
- `getScoreModifier(score)` → the delta added to chart_constant.
- `getPlayRating(score, chartConstant)` → `max(modifier + constant, 0)`.
- `getShinyPureCount(score, noteCount)` → count of shiny (max-value) pure notes, derived from the score. **Currently wrong — see bug 2 below.**
- `getPmRating(score, noteCount, far, lost)` → "MAX" / "MAX - n" / "N/A". The formula here is correct; it displays wrong distances only because `getShinyPureCount` feeds it a wrong `shiny`.
- `isPM(...)` (private) → guarded by `MAX_NOTES_SAFE_PM_THRESHOLD = 2237`; below that note count, score ≥ 10M is only reachable via a true PM, so far/lost aren't needed. The same threshold is the point above which `getShinyPureCount` becomes genuinely undecidable: at >2237 notes each unit is worth <1 point, so shiny can't be recovered from the score alone.

Naming note (unresolved, cosmetic): `getPlayRating`/`getScoreModifier` don't match the Sheets' own column labels ("Play Rating" = delta alone, "Play Potential" = constant + delta).

## Known bugs / rough edges

Live issues in the current tree, verified — not speculation. Full reasoning, failure scenarios, and
fixes are in `docs/report.md`; `docs/report_todo.md` is the same list as a checklist. Keep this
section to the headline and a pointer rather than restating the analysis.

1. ~~**The proxy never refreshes the session.**~~ **FIXED** — `utils/supabase/middleware.ts` now awaits `supabase.auth.getUser()` before returning the `supabaseResponse` that `setAll` reassigns, `createClient` is `async`, and `proxy()` returns its promise. Numbering below is left alone so existing references to "bug N" still resolve. Not yet verified against a real expiring token (shorten the JWT expiry, idle past it, reload). Cosmetic leftover: `createClient` returns a `NextResponse`, so `updateSession` would be the honest name.
2. **`getShinyPureCount` is wrong on ~half of all real scores.** `utils/rating.ts:25-29` subtracts an *unfloored* term where the game floors it, so the result is `shiny − frac(...)` patched up with `Math.round` — which only works when that fraction is under 0.5. Measured: 1532 of 3000 realistic scores off by one, plus a worse failure mode when `shiny` is 0 (a 1024-note chart with 0 shiny displays 4883). This is also why `getPmRating` shows wrong "MAX − n" distances. `docs/report.md` §1.1 has a verified integer-arithmetic replacement.
3. **`line-clamp-2` has never clamped.** `ScoreCard.tsx:46` and `BrowseCard.tsx:44` put `line-clamp-2` and `flex` on the same element. Both set `display`, and Tailwind emits `.flex` later in the stylesheet, so it wins — class-attribute order is irrelevant. Long titles are hard-cut instead of wrapping. The fix is structural: move the clamp to an inner element.
4. ~~**`addScore` discards its insert error.**~~ **FIXED** — the insert now destructures `{ error: insertError }` and returns it before `revalidatePath`. This matters more than it looks: Step 3's RLS policies will make `42501` a routine result, and it used to surface as a modal that closed reporting success.
5. **`ScoreCard.tsx:50` can crash the whole grid.** `score.charts?.chart_constant.toFixed(1)` — the `?.` guards `charts`, not `chart_constant`. Every other consumer guards the constant (`BrowseCard.tsx:45`, `SongInfo.tsx:27`, `search.ts:34,82`). One score on a constant-less chart throws during render and takes down all of `/scores`.
6. **Cancelling Google login reports success.** `app/auth/callback/route.ts` skips its `if (code)` block when the provider returns `?error=...` and falls through to the `/browse` success redirect. The `error` params are never read. Same file: `origin` comes from `new URL(request.url)`, which is the internal origin behind a proxy — this will redirect to `localhost` once deployed.
7. **`NaN` passes every validation gate in `addScore`.** `Number('abc')` is `NaN`, and `NaN < 0 || NaN > max` is `false`, so all four range checks accept it. Server actions are public HTTP endpoints, so the form's `required` isn't a defense.
8. **Unknown levels slip through `<`/`<=` filters.** In `filterCharts`, a `chart.level` not present in `levelOrder` yields `indexOf` → `-1`, which passes `lt`/`le` comparisons against any real level.
9. **B50 double-counts repeat plays.** `addScore` always inserts, so multiple rows per chart coexist and nothing dedupes by `chart_id` before `.slice(0, 50)`. Three plays of one chart take three slots and inflate PTT.
10. **Half fixed.** `/scores` no longer queries with a null `user_id` — the scores query is now conditional on `user` and yields `{ data: [] }` otherwise, so the invalid-uuid filter is unreachable. Still open: neither remaining query on that page destructures `error`, so a rejected query still renders as an empty B50. Sharper under Step 3, where a wrong policy returns null and looks exactly like "you have no scores".
11. **Inline Supabase clients.** `app/auth/callback/route.ts` and `LoginButton.tsx` construct their own clients instead of importing `utils/supabase/server.ts` / `client.ts`.
12. **`/auth/auth-code-error` and `/leaderboard` are empty stubs.** Neither is an ESLint error any more (both are named exports), but bug 6 makes the former user-reachable.

Lint baseline: `npx eslint .` is **1 error / 6 warnings**. The error is `ImportFromBrowser.ts:56`'s `as any[]`. Four warnings are `no-img-element` (blocked on adding `images.remotePatterns` to `next.config.ts`); the other two are unused vars — `id` in `ImportFromBrowser.ts:36` and `getPlayRating` in `ScoreCard.tsx:3`.

## Not yet built

**Stage 1 is done.** The homepage grid, ScoreCard, browse page, rating math, and — new — real jacket art are all complete. Jackets resolve through `utils/jacket.ts` against the public `jackets` bucket using `song_id` + `jacket_override`.

- **Stage 2 (OCR)** — not started. Candidate library: `arcaea-offline-ocr` on PyPI (KNN + SIFT-based, extracts score/pure/far/lost/song_id from a screenshot). It uses the same internal `song_id` system already adopted here for jackets.
- **Stage 3** — Google login is done. Still outstanding: public deployment, and real RLS policies for UPDATE/DELETE (blocked on replacing the guest cookie with `signInAnonymously()`).
- **Leaderboard** — route exists, no implementation.
- **Score detail modal** — built. Clicking a ScoreCard opens `ScoreModal` → `SongInfo` + `ScoreInfo`. Still missing from the original plan: play/import history (there is no history table — each play is just another `scores` row).
- **Input validation** — done on both sides. `actions.ts` returns `{ error }` instead of throwing, and `AddScoreButton` surfaces it and disables submit until a chart is picked. Remaining gaps: `NaN` (bug 7), the unchecked insert error (bug 4), and no `try/catch` around `handleSubmit` for *thrown* rejections.
- **Typed Supabase queries.** `ScoreWithChart` types the components, but the query itself still returns `any` (no generated database types), so a narrowed `select()` would not be caught at compile time. This is the root cause of bug 5 and of `utils/types.ts` disagreeing with the code in several places (`chart_constant` is declared non-nullable while three call sites guard it; `charts` is declared non-null while ~20 call sites write `charts?.`). `supabase gen types typescript` + `createClient<Database>` would close that gap.
- **Responsive layout** — there are zero breakpoint prefixes anywhere in `app/`, and both card grids are a hard `repeat(5,230px)` = 1150px, so every page scrolls sideways on a phone. `docs/report.md` §3 has a drop-in replacement that's pixel-identical on desktop.

## Working style notes

- User is learning — prefers being walked through concepts and writing code themselves over being handed finished files, especially for new concepts (Server Actions, useState, useRef, destructuring, RLS, etc.)
- User is a Waterloo CS student, comfortable with general programming/CS concepts, genuinely new to this specific web stack
- **CSS/Tailwind specifically: user had never done CSS before this project.** For new-to-them CSS concepts, explain thoroughly with illustrative (non-literal) examples rather than inserting large code blocks directly — let the user write the real implementation and review it after. Small mechanical fixes (typos, misplaced tags, dead/invalid classes, one-line corrections to code the user already wrote) are fine to edit directly. Once a concept is understood, the user wants direct, concrete answers (real class names, real prop names) rather than re-explaining from scratch each time.
- A friend (also Waterloo CS, also plays Arcaea) may join as a second contributor — repo should assume a `.env.example` + shared Supabase project workflow, not a single-owner setup

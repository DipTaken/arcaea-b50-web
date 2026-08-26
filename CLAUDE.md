@AGENTS.md

# Arcaea Score Viewer — Project Context

Personal project + learning exercise (first time with TypeScript, Next.js, Supabase/SQL). Built incrementally with heavy explanation at each step — prioritize understanding over speed when helping on this project.

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
| `/auth/callback` | OAuth code-exchange route handler; redirects to `/browse` on success. |
| `/auth/auth-code-error` | Stub — renders an empty `<div>`. |

`NavBar` is rendered globally from `app/layout.tsx`, so it appears on every route.

## Auth (Stage 3 — mostly done)

Google OAuth via Supabase is **implemented and working**:

- `LoginButton` calls `signInWithOAuth({ provider: 'google' })` with `redirectTo: ${origin}/auth/callback`.
- `app/auth/callback/route.ts` exchanges the `code` param for a session, then redirects to `/browse`.
- `ProfileButton` shows the Google avatar + a click-to-open Sign Out menu, and calls `router.refresh()` after sign-out.
- `NavBar` picks `ProfileButton` vs `LoginButton` off `supabase.auth.getUser()`.

**Guest → account model.** Both identities coexist:
- Guest users get a UUID in an `httpOnly` `guest_id` cookie (`utils/guest.ts`), refreshed on write (~1yr maxAge).
- Every read/write resolves identity the same way: `const userId = user?.id ?? guestId`. A logged-in user's real `auth.uid()` wins; otherwise the guest cookie is used.
- `ImportFromBrowser` (server action) copies all rows with `user_id = guestId` to `user_id = user.id`. It **duplicates** rather than moves — the guest rows are left behind, so re-importing will create duplicates.

The guest UUID is still **not** cryptographically tied to auth — it's a self-issued cookie value. Before adding UPDATE/DELETE policies on `scores`, this needs replacing with Supabase anonymous auth (`signInAnonymously()`) so RLS can trust `auth.uid()`.

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
│   └── auth-code-error/page.tsx — STUB, renders an empty div. Also an anonymous default export.
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
│   │                             NOTE: sets no width, so the dialog inherits the UA stylesheet's `width: fit-content`
│   │                             and shrink-wraps its content. See the bug note below.
│   └── SongInfo.tsx           — shared 2-column chart detail panel (jacket + all metadata). Used by BrowseModal.
├── scores/
│   ├── page.tsx               — B50 view. Server component. Fetches charts + scores (nested `charts(*)` join), sorts
│   │                             by Play Rating, slices to top 50. Renders AddScoreButton + ImportFromBrowserButton
│   │                             + <ScoreGrid>.
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
│   │                             Exposes SelectedChartContext so ChartSearch can push the picked chart up.
│   ├── ChartSearch.tsx        — client; searchable chart picker used inside AddScoreButton's form.
│   ├── actions.ts             — `addScore` server action. Validates chart existence + score range server-side,
│   │                             resolves user?.id ?? guestId, inserts. Calls revalidatePath('/').
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
│   └── middleware.ts          — used by proxy.ts. NOTE: filename still says "middleware" even though the Next.js
│                                 file convention moved to proxy. See the bug note below — it never calls getUser(),
│                                 so it does not currently refresh anything.
├── guest.ts                   — `getGuestId()` (Server Action use, sets/refreshes the cookie) +
│                                 `getGuestIdReadOnly()` (Server Components, read-only)
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

proxy.ts                       — root proxy (Next.js 16's rename of middleware.ts). Delegates to
                                  utils/supabase/middleware.ts. Matcher skips _next/static, _next/image, favicon, images.

alt/                           — experimental/abandoned design variants, NOT wired into the app
├── app/ScoreCardNew.tsx       — alternate ScoreCard layout
└── utils/style copy.ts        — matching alt copy of style.ts used only by ScoreCardNew.tsx
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
- `getShinyPureCount(score, noteCount)` → count of shiny (max-value) pure notes, derived from the score.
- `getPmRating(score, noteCount, far, lost)` → "MAX" / "MAX - n" / "N/A". **See the bug note below.**
- `isPM(...)` (private) → guarded by `MAX_NOTES_SAFE_PM_THRESHOLD = 2237`; below that note count, score ≥ 10M is only reachable via a true PM, so far/lost aren't needed.

Naming note (unresolved, cosmetic): `getPlayRating`/`getScoreModifier` don't match the Sheets' own column labels ("Play Rating" = delta alone, "Play Potential" = constant + delta).

## Known bugs / rough edges

These are live issues in the current tree, not speculation:

1. **The proxy never refreshes the session.** `utils/supabase/middleware.ts` builds a `createServerClient` into a local `supabase` variable, then returns `supabaseResponse` without ever calling `await supabase.auth.getUser()`. The `setAll` cookie callback only fires during a token refresh, and a refresh only happens when something asks for the session — so `supabase` is dead code and the proxy is a passthrough. Sessions will expire instead of rolling over. Supabase's documented pattern calls `getUser()` before returning the response (which also means `createClient` has to become `async`).
2. **`getPmRating` reports the wrong distance.** It returns `MAX - ${shiny}` where `shiny` is the count of shiny pures, but "MAX - n" means *n notes short of max*. It should be `MAX - ${noteCount - shiny}`. On a 1000-note chart one note off max currently prints "MAX - 999" instead of "MAX - 1".
3. **Stale `revalidatePath('/')`.** Both `addScore` and `ImportFromBrowser` revalidate `/`, but the score grid moved to `/scores`. Adding or importing a score does not invalidate the page that displays it.
4. **`ImportFromBrowser` duplicates on re-run.** It inserts copies without clearing or flagging the guest rows, so clicking Import twice doubles the scores.
5. **A failed `addScore` leaves the modal (and backdrop) stuck open.** `AddScoreButton.handleSubmit` is `await addScore(formData)` followed by `dialogRef.current?.close()`. `addScore` *throws* on "Chart not found" and on an out-of-range score, so the `close()` line is simply never reached — the dialog stays open, the backdrop stays up, and no error is shown to the user. Easiest trigger: on `/scores`, submit the top-level Add Score form without picking a chart. `ChartSearch`'s hidden input is `value={selectedId ?? ''}`, so an unpicked chart sends `''` → `Number('')` → `0` → the `.eq('id', 0).single()` lookup fails → throw. The score field is `required`; the chart selection is not. Fix is to return an error object from the action instead of throwing (and surface it), or at minimum `try/finally` the close.
6. **Every modal is a different size.** `Modal` sets no width, so the `<dialog>` keeps the UA stylesheet's `width: fit-content` (Preflight resets margin/padding/border, not width) and shrink-wraps its own content. The `w-full max-w-5xl` on the *children* is inert — `w-full` is 100% of a parent that is itself sized from those children, so intrinsic content width wins. `SongInfo`'s `grid-cols-[1fr_2fr]` with a 256px jacket is much wider than the add-score form's stack of inputs, hence the mismatch. Fix by putting a definite width on the `<dialog>` in `Modal.tsx`. Related: `ScoreModal`/`BrowseModal` pass two children to the dialog, which is not a flex container, so the Add Score button sits in its own full-width block below the card.
7. **Unknown levels slip through `<`/`<=` filters.** In `filterCharts`, a `chart.level` not present in `levelOrder` yields `indexOf` → `-1`, which passes `lt`/`le` comparisons against any real level.
8. **`/auth/auth-code-error` and `/leaderboard` are empty stubs.** The former is an anonymous default export, which is also the repo's only ESLint *error* (`react/display-name`).
9. **Inline Supabase clients.** `app/auth/callback/route.ts` and `LoginButton.tsx` construct their own clients instead of importing `utils/supabase/server.ts` / `client.ts`.
10. **`getJacketUrl` builds a Supabase client per call.** Harmless in the browser (`createBrowserClient` returns a cached singleton once `isBrowser()` is true), but during SSR that check fails and every call constructs a fresh client. The public URL is a deterministic string, so the client isn't needed at all.

## Not yet built

**Stage 1 is done.** The homepage grid, ScoreCard, browse page, rating math, and — new — real jacket art are all complete. Jackets resolve through `utils/jacket.ts` against the public `jackets` bucket using `song_id` + `jacket_override`.

- **Stage 2 (OCR)** — not started. Candidate library: `arcaea-offline-ocr` on PyPI (KNN + SIFT-based, extracts score/pure/far/lost/song_id from a screenshot). It uses the same internal `song_id` system already adopted here for jackets.
- **Stage 3** — Google login is done. Still outstanding: public deployment, and real RLS policies for UPDATE/DELETE (blocked on replacing the guest cookie with `signInAnonymously()`).
- **Leaderboard** — route exists, no implementation.
- **Score detail modal** — built. Clicking a ScoreCard opens `ScoreModal` → `SongInfo` + `ScoreInfo`. Still missing from the original plan: play/import history (there is no history table — each play is just another `scores` row).
- Client-side input validation on the add-score form. Server-side range/existence checks exist in `actions.ts`, but they `throw` rather than returning errors — see bug 5. Nothing requires a chart to be selected before submitting.
- **Typed Supabase queries.** `ScoreWithChart` types the components, but the query itself still returns `any` (no generated database types), so a narrowed `select()` would not be caught at compile time. `supabase gen types typescript` + `createClient<Database>` would close that gap.

## Working style notes

- User is learning — prefers being walked through concepts and writing code themselves over being handed finished files, especially for new concepts (Server Actions, useState, useRef, destructuring, RLS, etc.)
- User is a Waterloo CS student, comfortable with general programming/CS concepts, genuinely new to this specific web stack
- **CSS/Tailwind specifically: user had never done CSS before this project.** For new-to-them CSS concepts, explain thoroughly with illustrative (non-literal) examples rather than inserting large code blocks directly — let the user write the real implementation and review it after. Small mechanical fixes (typos, misplaced tags, dead/invalid classes, one-line corrections to code the user already wrote) are fine to edit directly. Once a concept is understood, the user wants direct, concrete answers (real class names, real prop names) rather than re-explaining from scratch each time.
- A friend (also Waterloo CS, also plays Arcaea) may join as a second contributor — repo should assume a `.env.example` + shared Supabase project workflow, not a single-owner setup

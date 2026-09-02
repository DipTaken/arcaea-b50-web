@AGENTS.md

# Arcaea Score Viewer — Project Context

Personal project + learning exercise (first time with TypeScript, Next.js, Supabase/SQL). Prioritize
explanation over speed — see Working style at the bottom.

## Docs

| File | Contents |
|---|---|
| `docs/todo.txt` | Running project list — features, deploy blockers, stage planning. |
| `docs/report.md` | Codebase audit: bugs with failure scenarios + fixes, Tailwind dedup, responsive, quality. |
| `docs/report_todo.md` | The audit as a checklist, with a concept note per item. |
| `docs/anon_auth_migration.md` | `guest_id` cookie → `signInAnonymously()`. Steps 0–4 done. |
| `docs/gotchas.md` | One-line reference of traps hit on this project — TS narrowing, React controlled/uncontrolled, Next 16 API changes, Supabase auth/RLS/CLI, Tailwind. Check here first when something behaves impossibly. |
| `docs/hours_log.md` | Per-contributor hours table. |

## Stack

Next.js 16.3.2 (App Router) · React 19.2 · TypeScript · Tailwind v4 · Supabase (Postgres + Google
OAuth + Storage) · npm. Font `Exo` via `next/font/google` → `--font-exo`, mapped to
`--font-sans`/`--font-mono`. One runtime dependency beyond the framework: **`papaparse`** (+
`@types/papaparse`), for CSV/TSV parsing — see `parseCsv.ts`.

Env vars (`.env.local`, gitignored): `NEXT_PUBLIC_SUPABASE_URL`,
`NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` — one string used by browser, server, and proxy clients
(`PUBLISHABLE_KEY`, not the older `ANON_KEY` name). `.env.example` holds both, empty. `.gitignore`'s
`.env*` would swallow it, so there is an explicit `!.env.example` negation — without it the
second-contributor workflow silently breaks.

Stage 2 (OCR) is not started. Candidate: `arcaea-offline-ocr` on PyPI (KNN + SIFT; already speaks the
same `song_id` system used for jackets).

## Routes

| Route | Purpose |
|---|---|
| `/` | Landing. Welcome line if signed in, else `<LoginButton>`, plus a hand-maintained `<Panel>` changelog (newest first — the comment in the file notes the order is wrong). |
| `/scores` | B50 view — best score per chart, top 50 by Play Rating, plus the B50 number. |
| `/browse` | Chart catalog: search, sort, level/difficulty filters, Load More. |
| `/leaderboard` | Stub — `PageShell` heading only. |
| `/auth/callback` | OAuth code exchange. Guard clauses in order: `error`/`error_code`, then missing `code`, then failed exchange — each returns early, so `/scores` is only reachable on success. `identity_already_exists` → `/auth/link?error=account_exists`. `redirectTo(path)` is the one place the base URL is built, from `x-forwarded-host`/`-proto` with an `origin` fallback. |
| `/auth/auth-code-error` | Catch-all failure page (heading + Go Home). |
| `/auth/link` | Anonymous-only sign-in fork. Guards `!user → /`, `!is_anonymous → /scores`; shows the score count and two paths: `<LinkButton>` (keeps scores) and `<LoginButton>` (loses them). |

`NavBar` and `Footer` render globally from `app/layout.tsx`.

## Auth

Google OAuth + anonymous auth are both live. There is exactly one kind of identity — a real
`auth.users` row behind a Supabase JWT — so `scores.user_id` is always an `auth.uid()`.
`utils/guest.ts` and `ImportFromBrowser` are deleted.

- **`utils/auth.ts` → `getOrCreateUser(supabase)`** returns a discriminated `{ user, error }`:
  `getUser()`, then `signInAnonymously()` only if there is no user. Anonymous users are minted
  **lazily on the write** — `addScore` calls it *after* validation, so a rejected submission never
  creates a permanent row.
- **Server Actions and Route Handlers only.** `utils/supabase/server.ts` swallows cookie-write
  failures in a `try/catch`, so from a Server Component this would create a user, fail to persist the
  session, and repeat every render. Read paths (`/scores`, `NavBar`, `/`) use plain `getUser()` and
  treat `!user` as "no scores yet".
- **`getUser()` reports "no session" as an `AuthSessionMissingError`**, not `{ user: null, error: null }`.
  Branch on `user`, never on `error` — testing `error` sends every first-time visitor down the
  failure path.
- **`user.is_anonymous` is the "really signed in" test.** `NavBar` branches three ways:
  `ProfileButton` (real user) / "Sign in" link to `/auth/link` (anonymous) / `LoginButton` (no user).
  This is not cosmetic — an anonymous user handed Sign Out loses their identity **irreversibly**: the
  `auth.users` row survives with no credential, and every score under that uid is orphaned.
- **No merge on upgrade.** Step 4 chose link-or-lose, not identity merging. RLS had already made a
  copy impossible: `scores_select_own` filters `where user_id = <other uid>` to zero rows.

## Database schema (Supabase/Postgres)

### `charts`
`id` int8 PK · `title` text (unicode display) · `song_id` text (Arcaea's Latin slug; drives jacket
lookup) · `difficulty` text (PST/PRS/FTR/ETR/BYD) · `level` text (text because of the `+` suffix) ·
`chart_constant` float4 · `note_count` int4 · `artist` text · `bpm` text (ranges exist) · `length`
text `m:ss` · `version` text (dotted) · `chart_designer` / `jacket_designer` text nullable ·
`jacket_override` bool.

Populated manually / via SQL — there is no in-app "add chart" flow.

### `scores`
`id` int8 PK · `chart_id` int8 FK → charts.id (No Action) · `user_id` uuid **NOT NULL, no default**
(it used to default to `gen_random_uuid()`, so an insert omitting it got a random owner instead of an
error — walking straight past `WITH CHECK`) · `score` int8 · `pure`/`far`/`lost` int4 nullable ·
`clear_status` text NOT NULL · `created_at` timestamptz default `now()`.

Constraint `unique_user_score UNIQUE (user_id, chart_id, created_at)`. It does *not* dedupe repeat
plays — `created_at` is in the key. B50 dedupes in code instead (`getB50FromScores`).

**Design principle:** store raw facts only. Grade, Play Rating, PM-distance are all calculated in
`utils/rating.ts`, never stored, so a corrected formula or chart_constant can't leave stale data.

### Storage
Public bucket `jackets`: `{song_id}.jpg`, plus `{song_id}_{difficulty}.jpg` (lowercased) when
`jacket_override`. Resolved by `utils/jacket.ts`. A second public bucket `images` holds the hero
backdrop.

### RLS / Grants

Schema is version-controlled under `supabase/migrations/` (a `db pull` baseline plus
`add_scores_rls.sql`). **Change policies and grants by writing a migration, not in the dashboard.**
`supabase/seed.sql` is a `--data-only` dump of `charts` (1799 rows) — both the backup for the one
table that can't be regenerated and what `db reset` loads locally.

Both tables have RLS on, via a `rls_auto_enable` event trigger installed by the project's automatic-RLS setting.

- `charts` — `charts_select_all`, `for select to anon, authenticated using (true)`; `GRANT SELECT` to
  both. `anon` matters: `/browse` and the chart picker run with no session.
- `scores` — four ownership policies (`scores_select_own`/`_insert_own`/`_update_own`/`_delete_own`),
  each `to authenticated` with `(select auth.uid()) = user_id`; `GRANT SELECT, INSERT, UPDATE,
  DELETE` to `authenticated` only. `anon` deliberately has no grant — an anonymous *user* carries
  `role: authenticated`; `anon` means no JWT at all.

Learned the hard way:

- **Grants and policies are independent; a policy cannot take back a grant.** The pre-migration
  baseline granted everything including `TRUNCATE` and `DELETE` on both tables to `anon`. Nothing
  exploited it only because RLS denies commands with no matching policy — protection by absence, one
  careless `using (true)` from failing. Invisible in the dashboard; only the `db pull` output showed it.
- **`TRUNCATE` is not subject to RLS at all**, so no policy could ever have covered that grant.
- A missing GRANT is `42501` even behind a perfect policy. Grants and policies fail differently.
- Write `(select auth.uid())`, not bare `auth.uid()` — the subquery is an InitPlan evaluated once
  instead of per row, which matters on the `scores → charts(*)` join.
- **`UPDATE` needs both `USING` and `WITH CHECK`.** `USING` picks targetable rows; `WITH CHECK`
  validates the produced row. With only `USING`, a user could reassign `user_id` on the way out.
- Don't run `db pull` after your own `db push` — pull captures out-of-band changes, and re-diffing a
  schema you already described emitted a bare `DROP TABLE chartsoldold` that broke replay from
  scratch. Undone with `migration repair --status reverted <version>`.

No FK from `scores.user_id` → `auth.users(id)`; still deferred.

## File map

```
app/
├── layout.tsx           — Exo, <NavBar>, hero backdrop layer, {children}, <Footer>. <body> is
│                          `min-h-full flex flex-col bg-linear-to-r from-page-start to-page-end`.
│                          The backdrop is an absolute -z-10 div using style={{backgroundImage}} with a
│                          blur + linear-gradient mask, so it fades out down the page.
│                          globals.css's old plain-CSS `body { background }` was removed: unlayered CSS
│                          always beats a utility class, since Tailwind emits utilities in @layer.
├── globals.css          — Tailwind import, @theme inline (font vars), @theme (--color-foreground,
│                          --color-card, --color-page-start, --color-page-end), @utility no-spinner.
├── page.tsx             — landing; greets by email prefix or shows <LoginButton>.
├── auth/                — callback/route.ts, link/page.tsx, auth-code-error/page.tsx (see Routes).
├── components/          — shared, used by both feature areas:
│   ├── Button.tsx       — variant 'default'|'primary'|'danger' × size 'sm'|'md'|'lg'|'fill', each a
│   │                      Record<NonNullable<...>, string> lookup so a missing key is a type error.
│   ├── Card.tsx         — Card / CardPill / CardBottomBar. The <li> shell (200×150, difficulty
│   │                      border, optional jacket background), the top-left pill (wide=80px for
│   │                      BrowseCard, 40px for ScoreCard's rank), and the title+constant bottom bar.
│   ├── CardGrid.tsx     — `grid-cols-[repeat(auto-fit,200px)] max-w-6xl`. Responsive; both grids use it.
│   ├── PageShell.tsx    — <main> + h1 title + h2 subtitle. Every page's outer wrapper.
│   ├── Panel.tsx        — the gray bordered box used inside modals. `mx-auto max-w-5xl`: the auto
│   │                      margins are load-bearing only when the dialog is WIDER than 64rem, which
│   │                      ImportCSVButton's `w-[min(90vw,90rem)]` is — max-width caps size, never
│   │                      centers. Every other modal is ≤60rem so the cap never engages.
│   ├── Footer.tsx       — logo, GitHub link, disclaimer. `mt-auto` pins it via the flex-col body.
│   ├── Modal.tsx        — <dialog> wrapper (ref, children, onClose?, width?). Centered with `m-auto`
│   │                      (Preflight zeroes the UA's margin:auto). Click-outside closes via
│   │                      `e.target === e.currentTarget` — a ::backdrop click targets the <dialog>,
│   │                      content clicks merely bubble. onClose is on the native `close` event, so it
│   │                      fires on Esc too. `width` defaults to w-[min(60vw,60rem)] because a <dialog>
│   │                      otherwise keeps `width: fit-content` and shrink-wraps, which made
│   │                      `w-full max-w-5xl` on the children inert.
│   ├── NavBar.tsx       — server; 3-col grid, 3-way auth branch (see Auth).
│   ├── LoginButton.tsx  — client; signInWithOAuth. size 'sm'|'md'|'lg'.
│   ├── LinkButton.tsx   — client; linkIdentity — attaches Google to the CURRENT anonymous user, so
│   │                      the uid and its scores survive. /auth/link only. Discards its error.
│   ├── ProfileButton.tsx— client; avatar + useState Sign Out dropdown, router.refresh() after.
│   └── SongInfo.tsx     — 2-col chart detail panel; local InfoRow helper.
├── scores/
│   ├── page.tsx         — server. charts fetched unconditionally (a session-less visitor still needs
│   │                      them — AddScoreButton is what mints their anon user); the `*, charts(*)`
│   │                      scores query runs only when getUser() returns a user, else `{data: []}`.
│   │                      Both queries `.limit(5000)`. B50 selection + the B50 number live in rating.ts.
│   ├── ScoreGrid.tsx    — client; owns `selectedId: number | null` and the one dialogRef, derives the
│   │                      entry by `find`. Exists so page.tsx can stay a server component.
│   │                      Passes `onDeleted={() => dialogRef.current?.close()}` — closing the dialog,
│   │                      not resetting state, because Modal's onClose already maps close → selectedId
│   │                      null. `setSelectedId(null)` alone would leave the <dialog> open and empty.
│   ├── ScoreCard.tsx    — one B50 cell from a B50Entry: rank pill, grade, playRating, clear lamp,
│   │                      jacket + score, title bar. Owns no modal — calls onSelect(entry).
│   ├── ScoreModal.tsx   — Panel(SongInfo + ScoreInfo) plus an Add / Edit / Delete button bar.
│   │                      Pure pass-through for `onDeleted`: it forwards ScoreGrid's callback to
│   │                      DeleteScoreButton and does nothing with it itself.
│   ├── ScoreInfo.tsx    — score + PM distance, Play Rating, colored grade, pure/far/lost, shiny
│   │                      pures, lamp, created_at.
│   ├── ScoreForm.tsx    — client; THE form, shared by add and edit. Props are the entire variation
│   │                      surface: defaultChart, initialValues, onSubmit (the server action), onClose,
│   │                      submitLabel, showSongInfo, children. Owns selectedChart / scoreText /
│   │                      errorMessage, the setCustomValidity handler, and the local ClearInfo.
│   │                      Inputs are UNCONTROLLED (defaultValue + FormData), so initialValues seeds on
│   │                      mount only — which is why both parents key it on resetKey.
│   │                      Exposes SelectedChartContext so ChartSearch can push the picked chart up.
│   ├── AddScoreButton.tsx  — Button + Modal + <ScoreForm onSubmit={addScore}>. size 'md'|'lg'.
│   │                      Modal's onClose bumps resetKey; key={resetKey} remounts ScoreForm, resetting
│   │                      all its state including ClearInfo's.
│   ├── EditScoreButton.tsx — same shape, onSubmit={editScore}, initialValues from the score, hidden
│   │                      score_id / chart_id inputs as children.
│   ├── DeleteScoreButton.tsx — danger Button + a confirm <Modal> (no ScoreForm — delete needs no
│   │                      input). `handleDelete` awaits deleteScore(score.id), shows `{ error }` in
│   │                      local errorMessage state, and only on success closes its own dialog then
│   │                      calls `onDeleted?.()` to close the parent. Modal's onClose clears
│   │                      errorMessage — the component is keyed on the score id, so a close/reopen
│   │                      would otherwise show a stale error. The `if (!score)` guard is unreachable
│   │                      (the buttons only render when score is truthy) but required: TS can't
│   │                      narrow a prop from a JSX condition into a closure.
│   ├── ChartSearch.tsx  — client; searchable chart picker used inside ScoreForm. Gets its setter from
│   │                      ScoreForm's SelectedChartContext, so it only works inside that provider —
│   │                      elsewhere useContext returns the default no-op and picking silently does
│   │                      nothing. An onSelect prop would free it; not needed while ScoreForm is the
│   │                      only caller.
│   ├── ImportCSVButton.tsx — client; the CSV/TSV import flow. Two steps in one Modal, switched by
│   │                      `showTable`: ImportTextArea (paste box + ImportErrorList + row counts) then
│   │                      ImportPreview (PreviewTable + Import / Go back). `scores`/`errors` are
│   │                      DERIVED during render from `text` — no second useState, so the preview can't
│   │                      go stale. ~0.3ms per keystroke including the 1799-chart map, so no memo.
│   │                      `isImporting` is separate from `showTable`: one is "which screen", the other
│   │                      "request in flight". Modal's onClose resets both and clears `text`.
│   ├── parseCsv.ts      — pure module, NO 'use server' (same reason as validateScore.ts): the browser
│   │                      needs it for the live preview and the action reuses it. parseCsv wraps Papa
│   │                      with header:true + skipEmptyLines + lowercasing transformHeader, and NO
│   │                      `delimiter`, so comma and tab both auto-detect — a spreadsheet clipboard is
│   │                      TSV, which is why paste works with no export step. validateImportScores
│   │                      groups charts into a Map<key, Chart[]>, then per row COLLECTS failures and
│   │                      continues, returning { scores, errors }. Columns: song, difficulty, score,
│   │                      clear_status required; pure/far/lost/artist optional.
│   ├── validateScore.ts — pure module, NO 'use server', so the client can import it. validateScore
│   │                      (range + cross-field), parseScoreFormData, getClearStatus, and the
│   │                      CLEAR_STATUS_VALUES whitelist. NOTE: validateScore does NOT check that
│   │                      whitelist — it only compares clearStatus to "fullRecall"/"pureMemory" for the
│   │                      cross-checks — so every caller must check membership itself. parseCsv and
│   │                      importScores both do.
│   └── actions.ts       — addScore / editScore / deleteScore / importScores, all returning `{ error }`
│                          not throwing. add/edit take FormData; **deleteScore takes `scoreId: number`**
│                          and **importScores takes `ImportScore[]`** — neither has a form behind it, so
│                          there's nothing to parse.
│                          importScores re-validates from scratch: it fetches note_counts itself with
│                          one `.in('id', chartIds)` and builds the Map SERVER-SIDE. Taking that map as
│                          a parameter was tried and reverted — it let the caller supply the yardstick,
│                          so every bound check passed against forged numbers. Then one array `.insert`
│                          (atomic; a per-row loop leaves half the rows written on failure) and
│                          `{ imported: data.length }`.
│                          `parseAndValidate` is the shared front half (parse → fetch chart →
│                          getClearStatus → validateScore); it stays here because it needs the client.
│                          addScore calls getOrCreateUser AFTER validation. edit/delete make no auth
│                          call and no user_id filter — RLS owns that — and user_id is kept out of the
│                          update payload because WITH CHECK would reject changing it.
│                          Both use `.select()` + `if (!data?.length)`: a write RLS filters to zero rows
│                          succeeds with NO error, so the row count is the only signal.
├── browse/
│   ├── page.tsx         — charts ordered by title, limit 5000 → <BrowseSearch>.
│   ├── BrowseSearch.tsx — client; search/sort/filter state, selectedChart, the shared dialogRef, the
│   │                      control bar, the capped grid, Load More, one BrowseModal. Cap is
│   │                      CARDS_PER_PAGE (100). It resets on any filter change via "adjust state
│   │                      during render" (compare a filterKey against previous state), not an effect —
│   │                      react-hooks/set-state-in-effect rejects the effect version, and the
│   │                      render-phase reset avoids painting a stale count or a second commit.
│   ├── BrowseCard.tsx   — jacket as background image, difficulty gradient overlay, sort-dependent
│   │                      info line. Owns no modal.
│   └── BrowseModal.tsx  — Panel(SongInfo) + AddScoreButton keyed on chart.id.
└── leaderboard/page.tsx — STUB, heading only.

utils/
├── supabase/client.ts     — browser client.
├── supabase/server.ts     — server client, takes a cookieStore param.
├── supabase/middleware.ts — used by proxy.ts. Awaits getUser() before returning, which is what makes
│                            the setAll callback fire and the session roll over. Two stale names: the
│                            file (Next moved the convention to `proxy`) and the export `createClient`
│                            (it returns a NextResponse; `updateSession` would be honest).
├── auth.ts     — getOrCreateUser. SERVER ACTIONS / ROUTE HANDLERS ONLY — see Auth.
├── jacket.ts   — getJacketUrl(songId, difficulty, jacketOverride) → Storage public URL.
├── rating.ts   — all score math. See below.
├── search.ts   — filterCharts, sortCharts, getSortDisplayValue + comparison/coercion helpers.
├── style.ts    — getDifficultyColor / getGradeColor / getClearStatusColor → hex, applied via inline
│                 `style` (Tailwind's scanner only sees complete literal class strings, so
│                 `bg-[${color}]` never generates CSS). getTextSize(title) → a *static* class bucketed
│                 by length, so interpolating THAT is fine. Also cardHoverAnimation and
│                 heroBackdropURL. Also `scrollbarStyle` — but those are `tailwind-scrollbar` plugin
│                 classes and the plugin is NOT installed, so the constant currently emits no CSS.
└── types.ts    — Chart, Score, ScoreWithChart = Score & { charts: Chart },
                  B50Entry = { rank, score, playRating, weight: 1 | 2 }, and the import pair
                  ImportScore / RowError (moved here so actions.ts and the client can share them).
                  Hand-written, NOT generated — so it can and does disagree with the DB.

proxy.ts        — Next 16's rename of middleware.ts; delegates to utils/supabase/middleware.ts.
supabase/       — CLI project; the CLI is a devDependency, so every command is `npx supabase ...`.
                  config.toml is COMMITTED but does NOT mirror the dashboard — it shipped with
                  enable_anonymous_sign_ins = false while the live project had it on, and
                  `config push` would have silently disabled the feature. Kept in sync by hand.
                  seed.sql was dumped with `--schema public -x public.scores`; omitting --schema
                  dumps auth/storage too, including live refresh tokens. Read a dump before committing.
```

### The shared-modal pattern (both grids)

Both grids used to render one `<Modal>` per card, each containing an `<AddScoreButton>` with a second
modal — ~3,600 `<dialog>`s and ~1,800 forms on `/browse` when at most one can be open. New grids
should copy the current shape:

- The **list container** owns `selected*` state plus a single `dialogRef`.
- A `useEffect` on the selection calls `showModal()` once the item has rendered into the modal.
- The **card** owns no dialog — it takes `onSelect` and calls it on click.
- The **modal** takes a nullable item and guards on it (`{item && ...}`), so the subtree unmounts when
  nothing is open and the null check narrows the type — no placeholder object needed.
- `onClose` resets the selection to null. Load-bearing: Esc closes a `<dialog>` natively without
  going through the click handler, and without the reset the same card couldn't be reopened.
- `AddScoreButton` is keyed on the chart id, because it seeds `useState(defaultChart)` on mount only.

### Next.js 16: `middleware.ts` is now `proxy.ts`

Next 16 deprecated the `middleware.js` convention and renamed it to `proxy.js` — same functionality,
new file and export names. Already migrated: the root file is `proxy.ts` exporting `proxy()`. Only
`utils/supabase/middleware.ts` still carries the old name.

## `utils/rating.ts`

- `getGrade(score, noteCount, pure, far, lost)` → "PM"|"EX+"|"EX"|"AA"|"A"|"B"|"C"|"D". Bare `"PM"`
  with no "MAX-n" suffix, so it fits the small ScoreCard cell.
- `getClearStatus(clearStatus, 'short'|'long')` → lamp label; 'short' is the one-letter card badge.
- `getScoreModifier(score)` → the delta added to chart_constant.
- `getPlayRating(score, chartConstant, clearStatus)` → `max(modifier + clearFactor + constant, 0)`,
  where `clearFactor` is `0` on a fail and `0.2` otherwise. **The clear factor is a deliberate
  house-rule addition** — the old Sheets check (Testify, cc 12.0, score 9,438,838 → 11.7961) predates
  it and no longer matches by that 0.2.
- `getShinyPureCount(score, noteCount)` → recovers `units` in integer arithmetic
  (`score = floor(units·5e6/N) + shiny`) and clamps to `2·noteCount`. Verified exact for every
  noteCount 50–2236.
- `getPmRating(score, noteCount, far, lost)` → "MAX" / "MAX - n" / "N/A".
- `isPM(...)` — exported (validateScore imports it). Guarded by `MAX_NOTES_SAFE_PM_THRESHOLD = 2237`:
  below that, score ≥ 10M is only reachable by a true PM, so far/lost aren't needed. Above it each
  unit is worth <1 point, which is also the point where `getShinyPureCount` becomes undecidable.
- `getB50FromScores(scores)` → `B50Entry[]`. Keeps the best score per `chart_id`, sorts by play
  rating, `slice(0, 50)`, then assigns `rank` and `weight` (2 for the top 10, else 1).
- `getB50Rating(entries)` → `sum(playRating × weight) / 60`.

Naming nit (cosmetic): `getPlayRating`/`getScoreModifier` don't match the Sheets' labels ("Play
Rating" = the delta alone, "Play Potential" = constant + delta).

## Known bugs / rough edges

Verified against the current tree. Reasoning and fixes are in `docs/report.md`; keep this to the
headline. Numbering is stable, so fixed entries stay listed.

1. ~~Proxy never refreshes the session.~~ **FIXED.** Not yet verified against a real expiring token
   (shorten the JWT expiry, idle past it, reload).
2. ~~`getShinyPureCount` wrong on ~half of all scores.~~ **FIXED** — now the integer-arithmetic
   version from report §1.1. It omits that fix's `if (!noteCount) return 0` guard, so a chart with a
   null/zero `note_count` yields `NaN`.
3. ~~`line-clamp-2` never clamped.~~ **RESOLVED BY REMOVAL** — `CardBottomBar` has no clamp at all, so
   long titles now shrink via `getTextSize` and truncate at `h-10` rather than wrapping to two lines.
4. ~~`addScore` discards its insert error.~~ **FIXED.**
5. ~~Unguarded `.toFixed` crashes the grid.~~ **FIXED** — `CardBottomBar` takes `constant` as
   `number | null | undefined` and writes `constant?.toFixed(1)`.
6. ~~Cancelling Google login reports success.~~ **FIXED**, including the `forwardedProto ?? 'https'`
   fallback.
7. ~~`NaN` passes every validation gate.~~ **FIXED** — `validateScore` now opens with a loop rejecting
   any non-null `score`/`pure`/`far`/`lost` that fails `Number.isInteger` (stricter than the
   `Number.isFinite` originally planned; also catches non-integer floats). It runs before the range
   checks and covers add and edit, since both go through `parseAndValidate`. Still open: the
   pure+far+lost cross-check only fires when all three are non-null, and `deleteScore` has no
   equivalent guard on `scoreId` (RLS makes that non-urgent).
8. **Unknown levels slip through `</<=` filters.** `filterCharts` guards `levelIndex >= 0` for the
   *filter* value, but a `chart.level` missing from `levelOrder` still yields `-1`, which passes
   `lt`/`le` against any real level.
9. ~~B50 double-counts repeat plays.~~ **FIXED** — `getB50FromScores` keeps only the best score per
   `chart_id`.
10. **Query errors are invisible on `/scores`.** Neither query destructures `error`, so a denied
    policy renders as an empty B50 — indistinguishable from "you have no scores". The main debugging
    hazard now that RLS is on.
11. ~~Inline Supabase clients.~~ **FIXED.**
12. **`/leaderboard` is an empty stub.**
13. ~~`DeleteScoreButton` renders a dead button.~~ **FIXED** — real confirm modal, awaited action,
    error display, and an `onDeleted` callback that closes the parent modal. All 5 of its lint
    warnings are gone.
14. **`ScoreForm`'s heading is hardcoded `"Add Score"`**, so the edit modal is titled "Add Score".
    Only `submitLabel` varies.
15. **`heroBackdropURL` hardcodes the full project URL** (`utils/style.ts`) instead of building on
    `NEXT_PUBLIC_SUPABASE_URL` like `getJacketUrl` does — it breaks for a contributor on another
    Supabase project.
16. **A blank `clear_status` in an imported row silently becomes `clearNormal`** (`parseCsv.ts:60-63`,
    commit 41b114d). `getClearFactor` gives 0 only to exactly `"fail"` and 0.2 to everything else, so
    a genuine fail imported blank gains 0.2 play rating and inflates the B50 — and it's stored, so a
    later formula fix can't repair it. Deliberate trade for friction; the alternative is requiring the
    column. Nothing tells the user the default was applied.
17. **`importScores` rejects the whole batch on the first bad row**, with a message that names a
    `chartId` and no row number (`ImportScore` has no `rowNumber`). Low-impact — the client already
    filtered, so this only fires on tampering or a stale chart list — but the message is unactionable.
18. **`handleImport` has no `try/catch`** (`ImportCSVButton.tsx`) and reports via `alert()`. A thrown
    rejection skips `setIsImporting(false)`, leaving the button stuck on "Importing…". Same class as
    `ScoreForm.handleSubmit`; `finally` fixes it. Every other surface uses inline error state.
19. **Re-importing the same paste duplicates every row.** `unique_user_score` is
    `(user_id, chart_id, created_at)` and `created_at` defaults to `now()`, so nothing conflicts.
    `getB50FromScores` keeps the best per chart, so the B50 looks correct while `scores` doubles.
20. **`scrollbarStyle` is dead** (`utils/style.ts`) — `tailwind-scrollbar` classes with the plugin
    uninstalled. Used by the textarea, error list, and preview table.
21. **`/docs/importing-scores` 404s** — `ImportCSVButton`'s help link points at a route that
    doesn't exist.

Baselines: `npx tsc --noEmit` is clean. `npx eslint .` is **0 errors, 5 warnings** — 4
`no-img-element` (blocked on `images.remotePatterns` in `next.config.ts`) and 1 unused
`getPlayRating` in `ScoreCard.tsx`. The 5 `DeleteScoreButton.tsx` warnings and the unused `Link` in
`ProfileButton.tsx` are gone. Note `next dev` does not typecheck — a bad import surfaces as a runtime
"Element type is invalid … got: undefined", so run `tsc` rather than trusting the dev server.

## Not yet built

- **Stage 2 (OCR)** — not started.
- **Deployment** — the three `auth/callback` code blockers in `docs/anon_auth_migration.md`
  § Deployment are all fixed; what remains is the configuration checklist there.
- **RLS verification** — `docs/todo.txt` marks the three-step check done, but no result was recorded
  anywhere, so treat it as unconfirmed until someone re-runs it. The meaningful test is a private
  window seeing an *empty* `/scores` (not your scores), `/browse` still loading with no session, and
  `auth.users` not growing when the same anon user adds a second score. "I can see my own scores" is
  equally true with no policy at all.
- **Leaderboard** — route only.
- **Play/import history** — no history table; each play is just another `scores` row. Needs a schema
  decision first. CSV import made this concrete: see bug 19.
- **Import hardening** — the feature works end to end; bugs 16–21 are what's left. The most
  consequential is the silent `clearNormal` default, since it writes a fabricated fact.
- **Typed Supabase queries** — `ScoreWithChart` types the components, but the queries still return
  `any`, so a narrowed `select()` wouldn't fail at compile time. This is why `utils/types.ts`
  disagrees with the code (`chart_constant` and `charts` are declared non-nullable while ~20 call
  sites write `charts?.`). `supabase gen types typescript` + `createClient<Database>` closes it.
- **`handleSubmit` has no `try/catch`** (`ScoreForm`) — a *thrown* rejection (network drop) is
  unhandled; only returned `{ error }` is displayed.

## Working style notes

- User is learning — prefers being walked through concepts and writing the code themselves over being
  handed finished files, especially for new concepts (Server Actions, useState, useRef, RLS, …).
- Waterloo CS student: comfortable with general programming/CS, genuinely new to this web stack.
- **CSS/Tailwind: user had never written CSS before this project.** For new-to-them CSS, explain with
  illustrative (non-literal) examples and let the user write the real implementation. Small mechanical
  fixes (typos, dead classes, one-line corrections to their own code) are fine to edit directly. Once
  a concept is understood, give direct concrete answers — real class names, real prop names.
- A friend (also Waterloo CS) may join as a second contributor — assume a `.env.example` + shared
  Supabase project workflow, not a single-owner setup.

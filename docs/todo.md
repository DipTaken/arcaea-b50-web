# TODO

Single running list. Replaces `todo.txt`, `report.md`, `report_todo.md`.

**Tiers**

| | Meaning |
|---|---|
| **T0** | Destroys user data, or an open exposure on the live site. |
| **T1** | Wrong behaviour a user will hit. |
| **T2** | Visible but harmless. |
| **T3** | Debt — dedup, a11y, perf, nits. No user impact. |
| **T4** | Not built yet. |

Baselines: `npx tsc --noEmit` clean · `npx eslint .` 0 errors, 5 warnings (4 `no-img-element`, blocked on
`images.remotePatterns`; 1 unused `getPlayRating` in `ScoreCard.tsx`).

**Shipped:** deployed on Vercel. Google OAuth verified end to end (redirect back works; Supabase URL
config updated). RLS three-step check confirmed.

---

## T0 — Data loss

- [ ] **Homepage sign-in orphans an anonymous user's scores.**
      `app/page.tsx:18-24` branches two ways (`user && !user.is_anonymous` → welcome, else `<LoginButton>`),
      so an anonymous user gets `signInWithOAuth`, which replaces their session. The anon uid survives with
      no credential and every score under it is unreachable. `NavBar`'s three-way branch is the model —
      anonymous users belong on `/auth/link`.
      *Repro: incognito → add a score → homepage → Sign in.*

- [ ] **No CAPTCHA on anonymous sign-ins, and the site is public.** Bots can mint permanent `auth.users`
      rows; Supabase's only backstop is 30/hr per IP.
      **This is a form change, not a dashboard checkbox.** Supabase applies hCaptcha/Turnstile to the auth
      endpoints project-wide, and the token is produced *in the browser* by a widget and is single-use — so
      `getOrCreateUser()`, which runs server-side inside a Server Action, cannot call
      `signInAnonymously()` unaided. The widget has to render in `AddScoreButton`, its token rides along as
      a form field, and the action passes `signInAnonymously({ options: { captchaToken } })`.
      Cloudflare's always-pass / always-fail dummy sitekeys let you build the whole path before touching a
      real domain. Budget half a day.

*(See "Decided, don't revisit" for the blank-`clear_status` default.)*

## T1 — Broken

- [ ] **Formatted score doesn't reset when the chart changes.**
      `ScoreForm.tsx:114` keys the input subtree on `selectedChart?.id`, which remounts the uncontrolled
      inputs — but `scoreText` (line 41) lives in `ScoreForm` *outside* that subtree, so the grey formatted
      number on line 129 survives. Result: empty input, stale number beneath it.
      Fix at the single place the chart changes — wrap the context value on line 104 so it clears
      `scoreText` alongside `setSelectedChart`.
      *Repro: /scores → Add Score → pick a chart → type a score → switch charts.*

- [ ] **Query errors are invisible on `/scores`.** Neither query destructures `error`, so a denied policy
      renders as an empty B50 — indistinguishable from "no scores yet". Main debugging hazard now RLS is on.

- [ ] **Unknown levels slip through `<`/`<=` filters.** `filterCharts` guards `levelIndex >= 0` for the
      filter value, but a `chart.level` missing from `levelOrder` yields `-1`, which passes `lt`/`le`
      against any real level.

- [ ] **`getShinyPureCount` returns `NaN` on a null or zero `note_count`.** Missing the
      `if (!noteCount) return 0` guard. Not hypothetical — `lasteternity`'s three placeholder charts carry
      NULL note counts.

- [ ] **`getLengthValue` throws on a null `length`** (`search.ts:120-121` calls `.split(':')`), crashing
      `/browse` when sorted by length. Nine songs in the current songlist have no length. Guard the
      function or fill the values in.

- [ ] **`handleImport` has no `try/catch`** (`ImportCSVButton.tsx`) and reports via `alert()`. A thrown
      rejection skips `setIsImporting(false)`, leaving the button stuck on "Importing…". `finally` fixes it.

- [ ] **`ScoreForm.handleSubmit` has no `try/catch`.** Only a returned `{ error }` is displayed; a thrown
      rejection (network drop) is unhandled. Same class as above.

- [ ] **`importScores` rejects the whole batch on the first bad row**, with a message naming a `chartId`
      and no row number (`ImportScore` has no `rowNumber`). Only fires on tampering or a stale chart list,
      but the message is unactionable.

## T2 — Papercuts

- [ ] `/docs/importing-scores` 404s — `ImportCSVButton`'s help link points at a route that doesn't exist.

## T3 — Debt

**Duplication**
- [ ] Difficulty list lives in 3 places — `style.ts:2-19`, `search.ts:102-117`, `BrowseSearch.tsx:123-127`.
      Already drifted: `INS` exists only in `style.ts`, so Inscribed charts sort before PST and match no
      difficulty filter.
- [ ] Level list lives in 2 — `search.ts:7` vs 17 hand-written `<option>`s in `BrowseSearch.tsx`.
- [ ] Sort keys live in 3 — `BrowseSearch.tsx`, `search.ts` (sort), `search.ts` (display).
- [ ] `MAX_BASE_SCORE` — `10000000` inlined in 5 places.
- [ ] Extract `useDialogSelection<T>()` — `ScoreGrid.tsx` and `BrowseSearch.tsx` hold the same
      selection + `dialogRef` + effect.
- [ ] `ScoreModal` and `BrowseModal` are the same 30 lines; `ScoreModal` only adds `<ScoreInfo>`.

**Types**
- [ ] **Generated Supabase types** (`supabase gen types typescript` + `createClient<Database>`). Root cause
      of several items — queries still return `any`, which is why `utils/types.ts` can disagree with the DB
      (`chart_constant` / `note_count` declared non-nullable while the columns are nullable).

**Correctness nits**
- [ ] `parseAndValidate` cross-check only runs when pure, far and lost are all non-null.
- [ ] `deleteScore` has no integer guard on `scoreId` (RLS makes it non-urgent).
- [ ] `jacket.ts:3` — `toLocaleLowerCase()` → `toLowerCase()`. Locale-aware casing on an ASCII slug.
- [ ] `rating.ts:4` — `isPM(...) || noteCount < 2237` is redundant; `isPM` already covers it.
- [ ] `search.ts:57` — descending sort uses `.reverse()` rather than negating the comparator, which
      inverts ties as well.
- [ ] `ScoreCard.tsx:3` — unused `getPlayRating` import (1 of the 5 lint warnings).
- [ ] `heroBackdropURL` (`utils/style.ts:77`) hardcodes the full project URL while `getJacketUrl` builds
      on `NEXT_PUBLIC_SUPABASE_URL`. Consistency only — contributors share the one project, so this breaks
      nothing until the project itself moves.
- [ ] Rename `utils/supabase/middleware.ts` → `proxy.ts` and its `createClient` → `updateSession`
      (it returns a `NextResponse`, not a client).
- [ ] No cleanup plan for accumulated anonymous users — old, zero-score, no linked identity. Grows
      forever; worse once the CAPTCHA gap (T0) has been open a while.

**Accessibility**
- [ ] Clickable `<li>`s with no keyboard path — `ScoreCard.tsx`, `BrowseCard.tsx`.
- [ ] No labels on any form input — `ScoreForm`, `ChartSearch`, `BrowseSearch`.
- [ ] `ProfileButton` — no `aria-expanded`/`aria-haspopup`, no outside-click or Escape handling.
- [ ] `alt="Song jacket"` on every card; `SongInfo.tsx:65` does it right — copy that.

**Perf / polish**
- [ ] `BrowseSearch`'s five `<select>`s are uncontrolled, so state and UI can disagree after a reset.
- [ ] `useMemo` the filter+sort in `BrowseSearch`; it re-runs on every render.
- [ ] Both pages ship ~1800 charts to the browser.
- [ ] Five `!` env assertions across `client.ts`, `server.ts`, `middleware.ts`, `LoginButton.tsx`.
- [ ] Add Prettier + a `format` script. Indentation is 4 spaces except `app/scores/page.tsx`.
- [ ] `next.config.ts` — `images.remotePatterns` for the Supabase storage host, which unblocks the 4
      `no-img-element` warnings.
- [ ] `tsconfig.json` — drop `allowJs`; consider `noUncheckedIndexedAccess` (would have caught two bugs in
      the converter).

## T4 — Not built

- [ ] **Monthly chart update pipeline** — *in progress.*
      `scripts/json_to_csv.mts` converts songlist + cc + note_count + length JSON into a 13-column CSV;
      `supabase/scripts/update_charts{,_dry}.sql` merge it. Remaining: the `INS` rename via `song.set`, the
      warning pass, the CSV write, then the first dry run. Setup still needed: a `unique (song_id,
      difficulty)` migration on `charts` — the merge's `ON CONFLICT` requires it. Full runbook in
      `docs/CHART_UPDATE_INSTRUCTIONS.md`.
- [ ] **Leaderboard** — route + heading only.
- [ ] **Play / import history, and an import undo.** No history table; each play is just another `scores`
      row. Note re-import can't be solved with a constraint — the same score on the same chart is a
      legitimate repeat play, so there is nothing safe to dedupe on. The real gap is that a mistaken import
      can't be removed: a `batch_id` (or an `imports` table) would make one importable *and* undoable.
      Schema decision first.
- [ ] **Stage 2 (OCR)** — not started. Candidate: `arcaea-offline-ocr` on PyPI (KNN + SIFT), already speaks
      the same `song_id` system used for jackets.
- [ ] Next/prev buttons in Score/Browse modals to step through charts without closing.

---

## Decided, don't revisit

- **A blank `clear_status` on import defaults to `clearNormal`.** Deliberate: the overwhelming majority of
  plays are not fails, so defaulting costs less friction than requiring the column. A genuine fail imported
  blank gains 0.2 play rating; accepted.
- **Re-import inserts duplicates, and that stays.** The same score on the same chart is a legitimate repeat
  play, so no unique constraint can tell a duplicate import from a real one. Undo, not prevention — see T4.
- **Adding a score from inside a modal leaves the outer modal open.** `close()` only closes the inner dialog.
- **Import: no inline-editable preview cells, no per-row `ChartSearch`.** The paste is still on screen in
  step 1, and editing the table would leave the user's actual spreadsheet wrong.
- **Import: no dropdown for ambiguous charts.** The optional `artist` column covers all 6 colliding pairs.
- **No identity merge on anon → Google upgrade.** `/auth/link` offers link-or-lose. RLS had already made the
  cross-uid copy impossible, and a merge would need proof of ownership.
- **Load More is not an updater form.** Wontfix.

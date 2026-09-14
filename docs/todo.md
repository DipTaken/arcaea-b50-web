# TODO

Single running list. Completed items are deleted, not checked off — git history is the record.

**Tiers**

| | Meaning |
|---|---|
| **T0** | Destroys user data, or an open exposure on the live site. |
| **T1** | Wrong behaviour a user will hit. |
| **T2** | Visible but harmless. |
| **T3** | Debt — dedup, a11y, perf, nits. No user impact. |
| **T4** | Not built yet. |

Baselines (2026-09-13): `npx tsc --noEmit` **1 error** (ScoreGrid.tsx:28, see T1) · `npx eslint .` 0
errors, 4 warnings (all `no-img-element`, blocked on `images.remotePatterns`).

---

## T0 — Data loss

- [ ] **No CAPTCHA on anonymous sign-ins, and the site is public.** Bots can mint permanent `auth.users`
      rows; Supabase's only backstop is 30/hr per IP.
      **This is a form change, not a dashboard checkbox.** Supabase applies hCaptcha/Turnstile to the auth
      endpoints project-wide, and the token is produced *in the browser* by a widget and is single-use — so
      `getOrCreateUser()`, which runs server-side inside a Server Action, cannot call
      `signInAnonymously()` unaided. The widget has to render in `AddScoreButton`, its token rides along as
      a form field, and the action passes `signInAnonymously({ options: { captchaToken } })`.
      Cloudflare's always-pass / always-fail dummy sitekeys let you build the whole path before touching a
      real domain. Budget half a day.

## T1 — Broken

- [ ] **`getClearStatus` throws away every clear status except Pure Memory.** `validateScore.ts:79-91`.
      The first branch handles `pm === true`, so inside the `else if` `!pm` is *always* true and
      `rawClearStatus || !pm` can never be false — the third branch is dead code. Every non-PM score is
      written as `clearNormal`, whatever the user picked.
      Hits **both** write paths: the Add/Edit form (via `parseAndValidate`) and CSV import
      (`parseCsv.ts:111` calls the same function), so a CSV column reading `fail` / `clearEasy` /
      `clearHard` / `fullRecall` is validated, then discarded. A fail stored as `clearNormal` silently
      gains the 0.2 clear factor in `getPlayRating`, so the B50 number is wrong too.
      Introduced by `3996d66` — the intent (revert PM → non-PM when the score is edited down) was right,
      the condition overshot. Needs `rawClearStatus` to be honoured when it is a real user choice.
      *Repro: Add Score → any non-PM score → set Clear Status to Fail → save → the card shows a C lamp.*
      *Existing rows are already wrong; a backfill is not possible — the original status wasn't stored.*

## T2 — Papercuts

- [ ] `/docs/importing-scores` 404s — `ImportCSVButton.tsx:102` links a route that doesn't exist. Write the
      page (T4) or drop the link.

## T3 — Debt

**Duplication**
- [ ] Extract `useDialogSelection<T>()` — `ScoreGrid.tsx` and `BrowseSearch.tsx` hold the same
      selection + `dialogRef` + effect.

**Types**
- [ ] **Generated Supabase types** (`supabase gen types typescript` + `createClient<Database>`). Root cause
      of several items — queries still return `any`, which is why `utils/types.ts` can disagree with the DB
      (`chart_constant` / `note_count` / `length` declared non-nullable while the columns are nullable).
      The `?? 0` scattered through `constants.ts` and `rating.ts` is the workaround.

**Correctness nits**
- [ ] `ImportCSVButton`'s `importResult` isn't cleared by `Modal`'s `onClose` (only `showTable`, `text`,
      `isImporting` are). Close after a failed import, reopen, advance to the preview → the old error is
      still there. Same class as the bug already fixed in `DeleteScoreButton`.
- [ ] `/scores` destructures `error` from the scores query but not the charts query
      (`page.tsx:18-23`), so a failed charts fetch renders an empty chart picker with no explanation.
- [ ] Rename `utils/supabase/middleware.ts` → `proxy.ts` and its `createClient` → `updateSession`
      (it returns a `NextResponse`, not a client).

**Accessibility**
- [ ] Clickable `<li>`s with no keyboard path — the `onClick` lives on `Card.tsx:12` with no `tabIndex`,
      `role`, or key handler, so neither grid is reachable without a mouse.
- [ ] No labels on any form input — `ScoreForm` (only the `is_cleared` checkbox has one), `ChartSearch`,
      `BrowseSearch`.
- [ ] `ProfileButton` — no `aria-expanded`/`aria-haspopup`, no outside-click or Escape handling.
- [ ] Generic `alt` text on jackets — `ScoreCard.tsx:41` and `ScoreForm.tsx:92`. `SongInfo.tsx:50` does it
      right (`alt={chart.title}`); copy that.

**Perf / polish**
- [ ] `BrowseSearch`'s four `<select>`s are uncontrolled (no `value` prop), so state and UI can disagree
      after a reset. The search `<input>` is already controlled.
- [ ] `useMemo` the filter+sort in `BrowseSearch:42`; it re-runs on every render.
- [ ] Both pages ship ~1830 charts to the browser.
- [ ] Five `!` env assertions across `client.ts`, `server.ts`, `middleware.ts`.
- [ ] Add Prettier + a `format` script. Indentation is 4 spaces except `app/scores/page.tsx`.
- [ ] `next.config.ts` is empty — `images.remotePatterns` for the Supabase storage host unblocks the 4
      `no-img-element` warnings.
- [ ] `tsconfig.json` — drop `allowJs`; consider `noUncheckedIndexedAccess` (would have caught two bugs in
      the converter).

## T4 — Not built

- [ ] **Chart-update converter has no validation pass.** `docs/CHART_UPDATE_INSTRUCTIONS.md` step 2 claims
      `json_to_csv.mts` "fails on charts with a missing constant or note count that isn't a `rating: 0`
      placeholder" — it does not. It writes `?? null` and says nothing, so a truncated `cc.json` produces a
      CSV full of NULL constants that merges cleanly. Either build the check or correct the runbook.
      The rest of the pipeline is done and has shipped once (v1.1.2, Arcaea 7.0): the `INS` rename via
      `song.set`, the CSV write, the `unique (song_id, difficulty)` migration, and a full dry-run → merge.
- [ ] **`/docs/importing-scores`** — the import help page linked from `ImportCSVButton`.
- [ ] **Leaderboard** — route + heading only.
- [ ] **Play** No history table; each play is just another `scores`
      row.
- [ ] **Stage 2 (OCR)** — not started. Candidate: `arcaea-offline-ocr` on PyPI (KNN + SIFT), already speaks
      the same `song_id` system used for jackets.
- [ ] Next/prev buttons in Score/Browse modals to step through charts without closing.

---

## Decided, don't revisit

- **A blank `clear_status` on import defaults to `clearNormal`.** Deliberate: the overwhelming majority of
  plays are not fails, so defaulting costs less friction than requiring the column. A genuine fail imported
  blank gains 0.2 play rating; accepted. *(Currently moot — the T1 `getClearStatus` bug defaults
  every row, not just blank ones. Re-read this once that's fixed.)*
- **Re-import inserts duplicates, and that stays.** The same score on the same chart is a legitimate repeat
  play, so no unique constraint can tell a duplicate import from a real one. Undo, not prevention — see T4.
- **Adding a score from inside a modal leaves the outer modal open.** `close()` only closes the inner dialog.
- **Import: no inline-editable preview cells, no per-row `ChartSearch`.** The paste is still on screen in
  step 1, and editing the table would leave the user's actual spreadsheet wrong.
- **Import: no dropdown for ambiguous charts.** The optional `artist` column covers all 6 colliding pairs.
- **No identity merge on anon → Google upgrade.** `/auth/link` offers link-or-lose. RLS had already made the
  cross-uid copy impossible, and a merge would need proof of ownership.
- **Load More is not an updater form.** Wontfix.
- **Unknown `chart.level` slipping through `<`/`<=` filters is unreachable.** `filterCharts` compares
  `indexOf(chart.level)`, which is `-1` for a level outside `LEVEL_LIST` — but every one of the 1830 seed
  rows uses a level that *is* in the list (`1`–`12` plus the `+` variants). Revisit only if Arcaea ships
  a new level notation.
- **Anonymous-user cleanup is handled outside the repo.** No migration or script in-tree; if that changes,
  record where it runs.

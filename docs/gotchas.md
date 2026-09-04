# Gotchas

Things that cost time on this project. One line each. Details live in the other docs.

---

## TypeScript

- **Destructuring severs narrowing.** `const { user, error } = await fn()` then `if (error) return` leaves `user` still nullable. Keep the object whole: `if (r.error) return`, then destructure.
- **Truthiness doesn't narrow a `string` discriminant** — `''` is falsy, so the error arm survives `if (r.error)`. Use `if (r.error !== null)`. Works fine when the discriminant is an object (always truthy).
- **Every arm of a union needs every key.** `{ error: 'x' }` doesn't satisfy `{ values: null; error: string }`. Either fill in the nulls or mark them `?: undefined`.
- **`next dev` does not typecheck.** Run `npx tsc --noEmit`. A type error shows up as a runtime symptom instead.
- **`JSON.parse` returns `any`, so `readJson<T>()` is an unchecked assertion.** Types at a file boundary state what you *expect*; nothing verifies it. Runtime guards do the real validating.
- **A `Record<string, T>` index signature accepts any key.** `lengths.notes` typechecks as `T` while being `undefined` at runtime — index signatures switch off misspelling protection.
- **Input types describe the file, not what you want.** `ratingClass: number` even though you need `difficulty: string` — the rename belongs in the mapping, not the declaration.

## JavaScript

- **`flatMap` flattens arrays only.** Returning `null` inserts a `null` *element*; return `[]` to contribute nothing. Only the one-to-many level needs it — a 1→1 inner `map` stays `map`.
- **`??` doesn't catch `""`.** It falls back only on null/undefined. When a source spells "none" as an empty string, you need `||`.
- **Indexing a string with a number is legal.** A stray `?.[i]` on `"1:55"` yields `"5"`, not an error.

## Node scripts (.mts)

- **Node 24 runs `.ts`/`.mts` directly** via type stripping — no `tsx`, no `ts-node`, no build step. Only *erasable* syntax: no `enum`, `namespace`, or parameter properties.
- **ESM has no `__dirname`** — use `import.meta.dirname`. Bare relative paths resolve against `cwd`, not the script's folder.
- **`readFileSync` without an encoding returns a `Buffer`.** `JSON.parse` coerces it, so it appears to work and mangles unicode.
- **`import type` is erased entirely**, so `@/utils/types` resolves for `tsc` and is never resolved at runtime.

## React

- **`value` = controlled, `defaultValue` = uncontrolled.** Forms read via `FormData`, so use `defaultValue`. Both on one element → `value` wins silently.
- **`defaultValue` and `useState(initial)` only apply on mount.** A changed prop won't update them.
- **`key` changes remount and reset all state** — including children's. That's how `AddScoreButton` resets `ScoreForm`. `key` is consumed by React, never seen as a prop.
- **"Element type is invalid… got: undefined"** = named/default import mismatch.
- **Derive during render instead of a second `useState`.** `parseCsv(text)` recomputed each render can't go stale; a mirrored state can. Sync work has no "done" event to wait for.
- **A child needing its parent's setters means the boundary is misplaced.** Split on ownership (own state, or genuinely reusable), not on function length.
- **Hyphenated JSX attributes are never type-checked** — the `data-*`/`aria-*` escape hatch means `resize-y` as a bare attribute compiles, renders `resize-y="true"` on the DOM, and only warns at runtime. Tailwind classes belong in `className`.

## Next.js 16

- **`middleware.ts` is now `proxy.ts`.** Only `utils/supabase/middleware.ts` still carries the old name.
- **`searchParams` and `params` are Promises.** `const { error } = await searchParams`.
- **`redirect()` throws.** Never call it inside `try/catch`. Returns `never`, so it narrows — `if (!user) redirect('/')` makes `user` non-null afterward. Defaults to `replace` in Server Components. Doesn't work in event handlers; use `useRouter`.
- **`request.url` is the *internal* URL behind a proxy.** Build redirect bases from `x-forwarded-host` / `x-forwarded-proto` with an `origin` fallback. Breaks only in production.
- **Use `request.headers`, not `headers()` from `next/headers`,** when you already have the request.
- **`NextResponse` vs `Response`** — only matters when setting cookies on the response (`.cookies`). Otherwise interchangeable.
- **Server Components can't set cookies.** `utils/supabase/server.ts` swallows the failure silently, so anything that writes a session must be a Server Action or Route Handler.
- **A `'use server'` file may only export `async` functions** — enforced by SWC at build time (the message lives in `next-swc`), not by `tsc`. The directive marks every export as a public endpoint, so returns must be promises. Files with *neither* directive are shared and get bundled into whichever side imports them — that's what `validateScore.ts` and `parseCsv.ts` are.
- **A duplicate import binding fails the whole route, not just the file.** Turbopack refuses to compile it, so the page renders nothing at all — indistinguishable from a CSS mistake. When *nothing* renders, read the dev-server terminal before inspecting styles.
- **A file nothing imports is never compiled**, so `next build` passing proves nothing about it.

## Supabase — auth

- **`getUser()` reports "no session" as an `AuthSessionMissingError`,** not `{ user: null, error: null }`. Branch on `user`, never on `error`, or every first-time visitor takes the failure path.
- **Anonymous users carry `role: authenticated`,** not `anon`. The `anon` Postgres role means *no JWT at all*.
- **`user.is_anonymous` is the "really signed in" test.** Bare `user` is true for anon users too.
- **Signing out an anonymous user is irreversible** — no credential to return with, and every score under that uid is orphaned. Offer *Sign in*, never *Sign out*.
- **`linkIdentity()` needs "Allow manual linking"** on in the dashboard, and only works on a user who already has a session.
- **`unlinkIdentity()` needs ≥2 identities.** An anon user has 0, and 1 after linking — so linking is permanent.
- **The 422 (`identity_already_exists`) comes back through the callback,** not the call site: `?error=…` with no `code`. Failures *before* the redirect (manual linking off, no session) surface at the call site instead.
- **Provider error params are three separate flat keys:** `error` (coarse), `error_code` (specific — branch on this), `error_description` (log only, never render).
- **Google Cloud Console points at Supabase, not your app** (`https://<ref>.supabase.co/auth/v1/callback`). Deploying doesn't require touching it — the per-environment allowlist is Supabase → URL Configuration.

## Supabase — data

- **`supabase-js` returns `{ data, error }`; it does not throw.** A successful `await` says nothing about whether the write happened.
- **An UPDATE/DELETE that RLS filters to zero rows succeeds with no error.** Use `.select()` and check `!data?.length` — without `.select()` you get `data: null` either way.
- **Grants and policies are independent.** A policy can't take back a grant. Missing grant = `42501`; policy denial = empty result.
- **TRUNCATE is not subject to RLS at all**, so no policy can cover that grant.
- **`UPDATE` policies need both `USING` and `WITH CHECK`** — `USING` picks the rows you may target, `WITH CHECK` validates the row you produce. Without the latter a user can reassign `user_id` on the way out.
- **Write `(select auth.uid())`, not `auth.uid()`** — evaluated once as an InitPlan instead of per row.
- **A column default can bypass a policy.** `user_id uuid DEFAULT gen_random_uuid()` meant an insert that omitted the column got a random owner instead of an error — nothing for `WITH CHECK` to compare.
- **Count queries:** `.select('*', { count: 'exact', head: true })`. `count(*)` in the select string is not PostgREST syntax, and `count` is `null` unless you ask for it — so it renders as `0` rather than erroring.
- **`null <> null` is `null`, not true.** A `WHERE` treats that as "don't return this row", so `<>` silently drops exactly the comparisons where one side is empty. Use `IS DISTINCT FROM` — it also works on whole tuples.
- **`ON CONFLICT` needs a real unique index to target** — `42P10` without one. Grants and policies don't enter into it.
- **`ON CONFLICT DO UPDATE` can't touch the same row twice in one statement** — `21000` if the source table has duplicate keys. It's a data problem, not a SQL one.
- **An identity column is consumed even on conflict**, so upserts leave gaps in the id sequence. Harmless.

## Supabase CLI

- **It's a devDependency — always `npx supabase …`.** A global npm install is unsupported.
- **`supabase login` (account token) is separate from the database password.** The token lives in your user config, outside the repo.
- **`db dump --data-only` defaults to every non-system schema.** Without `--schema public` it pulls `auth.users`, `auth.sessions` and live `auth.refresh_tokens` — bearer credentials — into the file. Read any generated dump before committing it.
- **`config.toml` does not mirror the dashboard.** It shipped with `enable_anonymous_sign_ins = false` while the live project had it on; `config push` would have silently disabled the feature. Keep it in sync by hand.
- **Don't `db pull` after your own `db push`.** Pull captures changes made *outside* migrations; running it afterward re-diffs a schema you already described and emits a redundant migration. Remove one with `migration repair --status reverted <version>`.
- **`supabase/seed.sql` doubles as the `charts` backup** and as what `db reset` loads locally.
- **`db query -f file.sql --linked` runs a SQL file** through the Management API. It runs **privileged** — RLS and the `anon`/`authenticated` grants don't apply, so a mistyped `WHERE` has nothing standing in its way.
- **Temp tables don't survive between dashboard SQL-editor runs** (pooled connections), so a staging table has to be a real one you drop by hand.

## Tailwind

- **Two utilities setting the same property → stylesheet emit order decides, not `className` order.** `flex` beats `line-clamp-2`; one of them is dead and you can't tell which from the JSX. Fix structurally, or don't write the conflict.
- **The JIT scanner only sees complete literal class strings.** `bg-[${color}]` never generates CSS — use an inline `style` for dynamic values, and static class buckets for the rest.
- **`overflow` does nothing without a height constraint.** `max-h-*` creates the overflow; `overflow-y-auto` only decides how to handle it.
- **`overflow` on a `<table>` is ignored** — tables have their own layout model. Put the scroll on a wrapper div.
- **`border-radius` has no effect under `border-collapse: collapse`** (Preflight's default, `preflight.css:171`). Round the scroll wrapper instead — any non-`visible` overflow clips. Same cause: a `border` on a sticky `<th>` is owned by the table and scrolls away; use a shadow.
- **`max-w-*` caps width, it never centers.** Always `max-w-* mx-auto`. Only visible once the container is wider than the cap.
- **A flex item won't shrink below its content** (`min-height: auto`), so `flex-1` + `overflow-y-auto` silently never scrolls. Add `min-h-0`. Doesn't bite with an explicit `max-h-*`.
- **`odd:`/`even:` are `:nth-child`,** so they go on `<tr>` — on `<td>` they'd stripe columns. Cells with their own `bg-*` paint over the row.
- **`display: flex` on a `<td>` removes `display: table-cell`,** so that column stops sizing with the table. Put the flex on an inner div.

## This project

- **Anonymous users are minted lazily, on the actual write** — `addScore` calls `getOrCreateUser` *after* validation, so a rejected submission never creates a permanent row.
- **Read paths use plain `getUser()`.** Only Server Actions and Route Handlers may call `getOrCreateUser`.
- **No merge between identities.** `scores_select_own` makes reading another uid's rows impossible, so a merge would need elevated access plus proof of ownership. `/auth/link` offers link-or-sign-in instead.
- **`utils/types.ts` is hand-written and disagrees with the DB** in places. `supabase gen types typescript` is the real fix.
- **`title + difficulty` is NOT unique in `charts`.** Quon and Genesis each exist twice (different `song_id` and artist) — 6 colliding pairs. `new Map(entries)` is last-write-wins, so keying on it silently picks one and validates against the wrong `note_count`. `title + difficulty + artist` is unique across all 1799 rows; import uses `artist` only to break ties.
- **Grouping needs accumulation, not the `Map` constructor.** `new Map(xs.map(x => [k, [x]]))` looks like grouping and isn't — duplicates still overwrite. Get-or-default, push, set.
- **Six song titles contain commas** (`Love me, Love me, Love me`), one contains quotes. A naive `split(',')` corrupts them — hence papaparse.
- **Spreadsheet clipboards are TSV, not CSV.** Leaving papaparse's `delimiter` unset auto-detects both, which is what makes paste-from-Sheets work with no export step.
- **`Number(' ')` is `0`, not `NaN`** — trim before testing for blank, or whitespace cells become zeros.
- **Don't collapse `NaN` to `null` when parsing** — `null` means "absent" and `validateScore`'s integer guard deliberately skips it, so garbage would pass. Let the `NaN` through and be rejected.

## Arcaea source data (`scripts/data/`)

- **songlist's `difficulties` is packed; `cc.json` and `note_count.json` are positional.** The latter keep an explicit `null` holding an absent slot. Index by `diff.ratingClass`, never by the array position — the two agree until the first song that skips a slot, then all 109 Eternal charts are off by one. Correct on `lostcivilization`, wrong on `sayonarahatsukoi`.
- **`ratingClass`: 0 PST, 1 PRS, 2 FTR, 3 BYD, 4 ETR.** 3 and 4 are easy to swap. No song has both.
- **`rating: 0` marks a placeholder chart**, not a real one — `lasteternity`'s PST/PRS/FTR. Constants and note counts are legitimately absent and the DB stores NULL. Treat missing-with-`rating: 0` as normal, missing otherwise as an error.
- **songlist contains tombstones** — `{"id":"particlearts","deleted":true}` with no `difficulties` array at all. Unguarded, it throws.
- **Any song-level field can be overridden per difficulty** — `version` (50), `title_localized` (8), `artist` (6), `bpm` (4). These are the Beyond charts that are really a different song (`dropdead` → "overdead.", `ignotus` → "Ignotus Afterburn"). The override applies to that difficulty *only*; never hoist it to the song.
- **`jacketDesigner: ""` means none** (530 of 1833) and the DB stores NULL. `chartDesigner` too (9).
- **"Inscribed" is a display name on the Beyond slot** — still `ratingClass: 3`. Pack-wide, keyed on `song.set`.
- **`length.json` is one string per song**, not per difficulty, and omits songs not yet released. `cc.json` and `note_count.json` are keyed by `song_id`; `note_count.json` alone is wrapped in `{ "notes": … }`.

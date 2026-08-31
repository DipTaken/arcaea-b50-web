# Gotchas

Things that cost time on this project. One line each. Details live in the other docs.

---

## TypeScript

- **Destructuring severs narrowing.** `const { user, error } = await fn()` then `if (error) return` leaves `user` still nullable. Keep the object whole: `if (r.error) return`, then destructure.
- **Truthiness doesn't narrow a `string` discriminant** — `''` is falsy, so the error arm survives `if (r.error)`. Use `if (r.error !== null)`. Works fine when the discriminant is an object (always truthy).
- **Every arm of a union needs every key.** `{ error: 'x' }` doesn't satisfy `{ values: null; error: string }`. Either fill in the nulls or mark them `?: undefined`.
- **`next dev` does not typecheck.** Run `npx tsc --noEmit`. A type error shows up as a runtime symptom instead.

## React

- **Components take one props object**, not positional params. `function C(a, b)` gets the whole props object as `a`.
- **`value` = controlled, `defaultValue` = uncontrolled.** Forms read via `FormData`, so use `defaultValue`. Both on one element → `value` wins silently.
- **`defaultValue` and `useState(initial)` only apply on mount.** A changed prop won't update them.
- **`key` changes remount and reset all state** — including children's. That's how `AddScoreButton` resets `ScoreForm`. `key` is consumed by React, never seen as a prop.
- **"Element type is invalid… got: undefined"** = named/default import mismatch.

## Next.js 16

- **`middleware.ts` is now `proxy.ts`.** Only `utils/supabase/middleware.ts` still carries the old name.
- **`searchParams` and `params` are Promises.** `const { error } = await searchParams`.
- **`redirect()` throws.** Never call it inside `try/catch`. Returns `never`, so it narrows — `if (!user) redirect('/')` makes `user` non-null afterward. Defaults to `replace` in Server Components. Doesn't work in event handlers; use `useRouter`.
- **`request.url` is the *internal* URL behind a proxy.** Build redirect bases from `x-forwarded-host` / `x-forwarded-proto` with an `origin` fallback. Breaks only in production.
- **Use `request.headers`, not `headers()` from `next/headers`,** when you already have the request.
- **`NextResponse` vs `Response`** — only matters when setting cookies on the response (`.cookies`). Otherwise interchangeable.
- **Server Components can't set cookies.** `utils/supabase/server.ts` swallows the failure silently, so anything that writes a session must be a Server Action or Route Handler.

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

## Supabase CLI

- **It's a devDependency — always `npx supabase …`.** A global npm install is unsupported.
- **`supabase login` (account token) is separate from the database password.** The token lives in your user config, outside the repo.
- **`db dump --data-only` defaults to every non-system schema.** Without `--schema public` it pulls `auth.users`, `auth.sessions` and live `auth.refresh_tokens` — bearer credentials — into the file. Read any generated dump before committing it.
- **`config.toml` does not mirror the dashboard.** It shipped with `enable_anonymous_sign_ins = false` while the live project had it on; `config push` would have silently disabled the feature. Keep it in sync by hand.
- **Don't `db pull` after your own `db push`.** Pull captures changes made *outside* migrations; running it afterward re-diffs a schema you already described and emits a redundant migration. Remove one with `migration repair --status reverted <version>`.
- **`supabase/seed.sql` doubles as the `charts` backup** and as what `db reset` loads locally.

## Tailwind

- **Two utilities setting the same property → stylesheet emit order decides, not `className` order.** `flex` beats `line-clamp-2`; one of them is dead and you can't tell which from the JSX. Fix structurally, or don't write the conflict.
- **Variant props beat `className` props.** `size="lg"` can't express a conflict; `sizeClasses="p-6"` against a base `p-2` compiles and renders wrong.
- **The JIT scanner only sees complete literal class strings.** `bg-[${color}]` never generates CSS — use an inline `style` for dynamic values, and static class buckets for the rest.

## This project

- **Anonymous users are minted lazily, on the actual write** — `addScore` calls `getOrCreateUser` *after* validation, so a rejected submission never creates a permanent row.
- **Read paths use plain `getUser()`.** Only Server Actions and Route Handlers may call `getOrCreateUser`.
- **No merge between identities.** `scores_select_own` makes reading another uid's rows impossible, so a merge would need elevated access plus proof of ownership. `/auth/link` offers link-or-sign-in instead.
- **`utils/types.ts` is hand-written and disagrees with the DB** in places. `supabase gen types typescript` is the real fix.

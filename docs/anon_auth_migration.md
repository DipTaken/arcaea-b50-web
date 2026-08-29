# Migration: `guest_id` cookie → Supabase anonymous auth

Plan for replacing the self-issued guest cookie with `signInAnonymously()`. This is the blocker on
[todo.txt:68](todo.txt) and therefore on UPDATE/DELETE policies, editing scores, deleting scores, and
public deployment.

Same format as [report_todo.md](report_todo.md): each step has the change, the concrete failure it
prevents, and the **concept** behind it.

---

## The point of the whole migration

Today `user_id` is a string **the app invented** and handed to the browser in a cookie. Postgres has
no way to check it, which is exactly why every policy on `scores` is `using (true)` — the database is
trusting app code, not the request.

After `signInAnonymously()`, a guest is a real row in `auth.users` (flagged `is_anonymous: true`) and
their identity arrives as a **JWT signed by Supabase**, which Postgres verifies itself. That is what
makes `auth.uid() = user_id` meaningful, and it is the only reason UPDATE/DELETE policies can exist.

**Concept — where trust lives.** A cookie your own server mints is an *assertion*; a signed token is
*evidence*. Any authorization rule is only as strong as the weakest thing it reads. `using (true)` was
never laziness — it was an honest admission that the DB had nothing verifiable to check against. The
migration isn't an API swap, it's moving the trust boundary from the app into the database.

---

## Step 0 — Fix the proxy. Hard blocker, do this before anything else.

`utils/supabase/middleware.ts:15-36` (known bug 1). Add `await supabase.auth.getUser()` before
`return supabaseResponse`. That makes `createClient` `async`, and `proxy()` in `proxy.ts` too.

**Why it matters:** this bug is currently harmless *only because* a `guest_id` cookie has
`maxAge: 1 year` and never needs refreshing. An anon session is the opposite: an access token that
expires in ~1 hour plus a refresh token, and the refresh only fires when something calls `getUser()`
— the exact call the proxy is missing. Migrate before fixing this and **anonymous users silently lose
their identity, and their entire B50, one hour after their first visit.**

Why the proxy and not the server client: the swallowed `try/catch` in `utils/supabase/server.ts:17-23`
exists because **Server Components cannot set cookies**. When `/scores` triggers a token refresh, the
refreshed token is discarded. The proxy is the only place that runs on every request *and* can persist
cookies.

Two things to get right while writing it:

- `setAll` reassigns `supabaseResponse`. **Return that variable.** Building a fresh
  `NextResponse.next()` after the refresh drops the new cookies and produces an infinite re-auth loop.
- An async `proxy` is supported — see
  [proxy.md:31](../node_modules/next/dist/docs/01-app/03-api-reference/03-file-conventions/proxy.md#L31).
  Next 16 runs proxy on the Node runtime by default, so there are no Edge restrictions here.

**Verify before moving on:** shorten the JWT expiry in the dashboard, log in, idle past it, hit a page,
confirm you're still signed in. The ESLint "assigned but never used" warning on `supabase` should also
be gone — that warning *was* the bug.

**Concept — a latent bug is a bug whose preconditions haven't arrived yet.** Nothing about the proxy
changes in this migration. What changes is that the identity it carries goes from "expires in a year"
to "expires in an hour," and a dormant defect becomes a data-loss bug. Worth scanning for this shape
generally: code that is correct only because of an assumption made somewhere else, which the current
task is about to invalidate.

---

## Step 1 — Enable the feature

Dashboard → Authentication → Sign In / Providers → **Allow anonymous sign-ins**.

Two operational facts to know before deploying:

- Every call creates a **permanent row in `auth.users`**. They accumulate; plan on a cleanup query for
  anonymous users older than N days with no scores.
- Supabase rate-limits anonymous sign-ins per IP (30/hr by default). CAPTCHA is the recommended
  production guard, since the endpoint is a free user-row generator otherwise.

---

## Step 2 — Mint the anon user lazily, on first write

The real design decision. Two options:

| Where | Trade-off |
|---|---|
| Proxy, on every session-less request | Simple, but mints an `auth.users` row for every crawler and every bounce |
| Lazily, in the write path | Only mints when someone actually adds a score |

**Take the lazy one.** It's where `getGuestId()` already sits, for the same underlying reason: Server
Actions can write cookies, Server Components can't.

### Changes

- **New `utils/auth.ts`, exporting `getOrCreateUser()`** — replaces `utils/guest.ts` entirely. Calls
  `getUser()`; if null, calls `signInAnonymously()` and returns that user.
- **`app/scores/actions.ts:13-15`** — drops `getGuestId()`. Both branches now end at a real `user.id`,
  so `user?.id ?? guestId` collapses to just `user.id`.
- **`app/scores/page.tsx:15-17`** — drops `getGuestIdReadOnly()`. Guard on `!user` → render an empty
  B50 and skip the query entirely. This also closes **known bug 10** for free: `.eq('user_id', null)`
  is never fired again.
- **Delete `utils/guest.ts`.**

**Must-get-right:** `getOrCreateUser()` has to call `getUser()` first and only sign in when it's null.
Calling `signInAnonymously()` unconditionally mints a **brand new user on every action**, and each
score lands under a different id — a data-loss bug that looks exactly like "my scores disappeared."

**Concept — read paths and write paths have different powers.** The existing
`getGuestId()` / `getGuestIdReadOnly()` split already encodes this: only one of them can set a cookie,
because only one runs somewhere Next allows it. That constraint doesn't go away under anon auth, it
just changes shape — the write path may create an identity, the read path may only observe one. When a
framework splits an API into "the one that mutates" and "the one that doesn't," that split is usually
telling you something about where the code is allowed to run.

---

## Step 3 — RLS policies (the actual goal)

Three things that catch people out:

### 3a. Anonymous users are `authenticated`, not `anon`

The `anon` Postgres role means *no JWT at all*. An anonymous Supabase **user** carries a real JWT with
`role: authenticated`. So the current grants —

```sql
GRANT SELECT ON public.charts TO anon;
GRANT SELECT, INSERT ON public.scores TO anon;
```

— stop covering your users the moment sessions exist. Extend them to `authenticated` (adding
`UPDATE, DELETE` on `scores`). Grants and policies are independent: a missing grant is `42501` even
behind a perfect policy.

### 3b. Policies become ownership checks

Replace `using (true)` / `with check (true)` with `auth.uid() = user_id`, for all four verbs. Write it
as `(select auth.uid())` — Postgres then evaluates it once as an InitPlan instead of re-running it per
row, which matters on the joined `scores → charts(*)` query.

`charts` stays `using (true)`; the catalog is public.

### 3c. `is_anonymous` is queryable

`auth.jwt() ->> 'is_anonymous'` is readable inside a policy. That's the lever for later if the
leaderboard should only show permanent accounts.

**Do not add a FK from `scores.user_id` → `auth.users(id)` yet** — see Step 4.

**Concept — a policy is a predicate on data the DB can verify by itself.** `auth.uid()` isn't a
function call into your app; it reads a claim out of a token whose signature Postgres already checked.
That's the whole difference from the cookie. It's also why the policy can be trusted against a
*direct* PostgREST request that never touched your Next.js code — which is the actual threat model,
since the publishable key is in the browser.

---

## Step 4 — Existing rows, and the guest → Google upgrade

### Existing rows

Every score currently in `scores` has a cookie-issued UUID matching no `auth.users` row. Under the new
policy they become unreachable by anyone, including you. Pre-deploy, so just pick one:

- delete them, or
- one `UPDATE scores SET user_id = '<your real Google uid>'` to keep your own test data.

Do this **before** adding any FK to `auth.users`, or the constraint fails on creation.

### The upgrade path gets simpler

`supabase.auth.linkIdentity({ provider: 'google' })` attaches Google to the **existing anonymous
user** — same UUID, so the `scores` rows are already correct and **there is nothing to copy**.
`ImportFromBrowser` stops being needed for the normal path. Requires *manual linking* enabled in the
dashboard.

The edge case that keeps it alive: if that Google account already exists as its own user,
`linkIdentity` fails with 422. Fallback is a plain `signInWithOAuth` plus a merge — but by then the
anon session is gone and the old uid with it. So **stash the anon uid in a cookie before redirecting**.
`ImportFromBrowser` then survives nearly unchanged, reading `prev_anon_id` instead of `guest_id`.

**Concept — identity migration is a rename, not a copy, when you control the key.** The current import
copies rows because the guest UUID and the auth UUID are two unrelated namespaces. `linkIdentity`
removes the need by making them the same row in `auth.users` — the id never changes, so no score ever
moves. Reach for "can these two identities become one?" before writing data-migration code.

---

## Order of work

1. **Step 0** — proxy `getUser()` fix. Self-contained, independently verifiable, already a tracked bug.
2. **Step 1** — dashboard toggle.
3. **Step 2** — `utils/auth.ts`, rewrite the two call sites, delete `utils/guest.ts`.
4. **Step 4 (existing rows)** — clean up before policies lock them away.
5. **Step 3** — grants + policies. Verify a second browser profile can't read your scores.
6. **Step 4 (linkIdentity)** — last, and only after the rest is stable.

Then UPDATE/DELETE UI (edit + delete a score) is unblocked.

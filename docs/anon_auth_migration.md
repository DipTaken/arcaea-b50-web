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

## Step 0 — Fix the proxy. Hard blocker, do this before anything else. — **DONE (code)**

*Code landed; the runtime check at the end of this section has not been run yet.*

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

## Step 1 — Enable the feature — **DONE**

Dashboard → Authentication → Sign In / Providers → **Allow anonymous sign-ins**. On as of 2026-08-29.

**Allow manual linking** on the same screen is still **off**, and should stay off until Step 4.
`linkIdentity()` is the only thing that needs it, and leaving it off until then keeps the surface
small — the API lets any signed-in session attach an identity, so it is worth turning on next to the
code that uses it rather than months early.

Two operational facts to know before deploying:

- Every call creates a **permanent row in `auth.users`**. They accumulate; plan on a cleanup query for
  anonymous users older than N days with no scores.
- Supabase rate-limits anonymous sign-ins per IP (30/hr by default). CAPTCHA is the recommended
  production guard, since the endpoint is a free user-row generator otherwise. **Do not enable it
  yet** — it is not a pure dashboard toggle. It applies to the auth endpoints project-wide and
  requires every affected call to pass `options: { captchaToken }` from a real widget, so flipping it
  on before that widget exists breaks local sign-in. It belongs in the deploy step, not here.

---

## Step 2 — Mint the anon user lazily, on first write — **DONE**

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
- **`app/components/NavBar.tsx:28` and `app/page.tsx:17`** — both branch on bare `user`, which today
  is a safe stand-in for "signed in with Google" only because guests are `null`. After this step an
  anonymous visitor *is* a `user`, so both need `user && !user.is_anonymous`.

  **The NavBar one is the dangerous half.** It would render `ProfileButton` for an anonymous user —
  no avatar, and a working Sign Out button. Signing out of an anonymous session is **irreversible**:
  there is no credential to sign back in with, the `auth.users` row survives with nobody able to
  authenticate as it, and every score under that uid is orphaned for good. An anonymous user must be
  offered *Sign in with Google* (which becomes `linkIdentity()` in Step 4), never *Sign Out*.

  The landing page is only cosmetic by comparison: `user.email` is `undefined` on an anon user, so
  `user.email?.split('@')[0]` renders `Welcome, ` and nothing else. Note the `?.` is what makes it
  quiet — without it you'd get a crash pointing straight at the problem.

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

## Step 2.5 — Version-control the schema, *before* writing any policy — **DONE**

Done, and it paid for itself immediately — see the three corrections at the top of Step 3, none of
which were visible in the dashboard. Notes from actually doing it:

- The CLI is a **devDependency**, not a global install (`npm i -g supabase` is unsupported). Run it as
  `npx supabase ...`. Upside: the version is pinned in `package.json` for the second contributor.
- `supabase login` is a separate credential from the database password. The access token is
  account-level and lives in your user config, outside the repo.
- **`supabase db dump --data-only` defaults to every non-system schema**, not just `public`. The first
  attempt at the `charts` backup pulled `auth.users`, `auth.sessions` and 18 rows of
  `auth.refresh_tokens` — live bearer credentials — into `seed.sql`. Caught before it was staged.
  Always `--schema public`, and read a generated file before committing it.
- The backup landed at `supabase/seed.sql` on purpose: `[db.seed]` in `config.toml` points there, so
  `supabase db reset` loads the catalog into a local stack. Backup and local-dev fixture in one file.
- **`config.toml` does not reflect the dashboard.** It shipped with `enable_anonymous_sign_ins = false`
  while the live project had it on; `supabase config push` would have silently turned the feature off.
  Set it to match reality before committing.
- **Don't `db pull` after your own `db push`.** Pull is for capturing changes made outside migrations.
  Running it afterward re-diffs a schema you already described and emits a redundant migration — here,
  a bare `DROP TABLE chartsoldold` that broke replay from scratch, since the earlier migration had
  already dropped it. Removed with `supabase migration repair --status reverted <version>`.

Original notes follow.

The ordering is the entire point. Run `supabase db pull` now and your current schema becomes
migration #1; every policy in Step 3 then lands as a reviewable file. Do it afterward and you are
reverse-engineering which checkboxes you clicked in a web UI.

```
supabase init
supabase link --project-ref <ref>
supabase db pull                        # snapshot current remote schema as the baseline
supabase migration new add_scores_rls   # then write Step 3 into this file
supabase db push
```

**Why this project needs it, specifically:**

- **Step 3's policies are about to be the most security-critical code in the repo**, and they would
  otherwise exist only as dashboard state — no diff, no review, no rollback, no way to tell what prod
  actually has versus what you meant.
- **A second contributor is planned.** Without migrations, onboarding is "ask Dennis to click through
  twenty screens," which no `.env.example` can fix.
- **The symptom is already here.** Nobody knows whether the `user_id,chart_id,created_at` unique
  constraint `ImportFromBrowser`'s `onConflict` depends on is in the live DB. That uncertainty *is*
  untracked schema.

Free side effect: `supabase gen types typescript` becomes available, which is
[todo.txt:77](todo.txt) and the fix for the `any` hole that let `score.charts.chart_id` typecheck
against a shape that never existed.

**Migrations version the schema, not the data.** The ~1800 hand-entered `charts` rows are not covered
by any of this. Take a separate `pg_dump` of that table — it is the one thing in the project that
genuinely cannot be regenerated.

**Concept — if it isn't in the repo, it isn't reviewable, reversible, or reproducible.** A dashboard
click and a line of code have identical power over your data, but only one of them leaves a trace.
Anything that decides who can read or write rows belongs under the same review as the code that
depends on it.

---

## Step 3 — RLS policies (the actual goal) — **DONE (pushed; app-level verification outstanding)**

Shipped as `supabase/migrations/20260830090336_add_scores_rls.sql`. **Three of this section's own claims
turned out to be wrong**, and all three were found by reading the `db pull` baseline rather than the
dashboard — which is the strongest possible argument for having done Step 2.5 first:

- **3a was backwards.** The grants were not `SELECT` / `SELECT, INSERT`. The baseline had
  `GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE` on *both* tables to
  `anon` **and** `authenticated`. So the job was never "extend them to `authenticated`" — it was
  revoking. `anon` held DELETE and UPDATE on the entire chart catalog, and TRUNCATE besides, which no
  policy could have restrained because TRUNCATE is not subject to RLS.
- **`scores.user_id` was nullable with `DEFAULT gen_random_uuid()`.** An insert that omitted the column
  got a random owner rather than an error — a way straight past `WITH CHECK`, which has nothing to
  compare against when the column is absent. Now `NOT NULL` with no default.
- **An empty leftover `chartsoldold` table** existed, carrying its own RLS policy and grants to `anon`.
  Dropped.

Two things that went to plan: `(select auth.uid())` for the InitPlan optimisation, and `UPDATE` getting
both `USING` and `WITH CHECK` (without the latter a user could reassign a row's `user_id` on the way
out). Pre-existing guest-cookie rows were deleted rather than reassigned — in the event the DELETE
matched nothing, since every score already belonged to a real `auth.users` row.

Also settled in passing: the `unique_user_score (user_id, chart_id, created_at)` constraint that
`ImportFromBrowser`'s `onConflict` depends on **does** exist (closes report_todo 4.4).

**Still to verify in the app:** a second browser profile must not be able to read the first's scores,
and `/browse` must still load with no session (that one exercises the `anon` grant on `charts`).

**Concept — the dashboard shows you what it has a screen for.** Every one of the three corrections
above was live in the database for months and invisible in the UI. Version-controlling the schema
isn't only about review and rollback; the diff is the first time anyone actually *reads* what is
there. Original notes follow.

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

## Step 4 — Existing rows, and the guest → Google upgrade — **IN PROGRESS**

Existing rows: done, by Step 3's DELETE (it matched nothing — every score already had a real owner).

**Decision: no merge.** The fallback this section describes — `ImportFromBrowser` reading `prev_anon_id`
— cannot work any more, and Step 3 is why. It selects `where user_id = <the anon uid>` using the
*logged-in* user's session, and `scores_select_own` filters that to zero rows. A merge would need
elevated access plus proof the caller owned that anon user; without the proof it is score theft with
extra steps. So `ImportFromBrowser.ts` and `ImportFromBrowserButton.tsx` are deleted, and the
`prev_anon_id` cookie is not needed.

The flip side is reassuring: a forged `prev_anon_id` cookie would now be inert. The policy is doing
the work the cookie used to be trusted for.

**`unlinkIdentity` is unavailable here**, confirmed in the SDK's own doc comment: a user needs at least
two identities to unlink one. An anonymous user has zero, and exactly one after linking. So "permanent"
is literally true and can be stated in the UI without hedging.

**Shipped:** `/auth/link` — a Server Component, anonymous-only (guards `!user → /`,
`!is_anonymous → /scores`), showing the score count and two paths:

| Path | Call | Outcome |
|---|---|---|
| New account | `linkIdentity` | Google attaches to the existing anon user. Same uid, scores survive. |
| Existing account | `signInWithOAuth` | Signs into the other account. The anon session is replaced and its scores are unreachable for good. |

Both are irreversible, so the page names the cost of each rather than treating one as a cancel.
`NavBar` sends anonymous users here via a plain "Sign in" link — same label and styling as the
signed-out button, because from the user's side nothing is different.

**Working end to end.** Manual linking is on (dashboard + `config.toml:179`), and bug 6 is fixed in both
halves — the callback reads the error params before `code` and returns early, and builds its redirect
base from `x-forwarded-host`/`-proto` so it will survive deployment. `/auth/auth-code-error` is a real
page now that it's reachable.

Deliberately skipped: `LinkButton` doesn't check `linkIdentity`'s error. Failures there are pre-redirect
only (manual linking off, no session, network) and rare once configured; the 422 — the one that matters
— comes back through the callback instead.

Original notes follow.

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

| # | Step | Estimate |
|---|---|---|
| 1 | **Step 0** — proxy `getUser()` fix. Self-contained, independently verifiable, already a tracked bug. | 30–60 min |
| 2 | **Step 1** — dashboard toggle. | 5 min |
| 3 | **Step 2** — `utils/auth.ts`, rewrite the two call sites, delete `utils/guest.ts`. | 1–2 hrs |
| 4 | **Step 2.5** — `supabase init` / `link` / `db pull`. Baseline before any policy exists. | 1–2 hrs |
| 5 | **Step 4 (existing rows)** — clean up before policies lock them away. | 15 min |
| 6 | **Step 3** — grants + policies, as a migration. Verify a second browser profile can't read your scores. | 1–2 hrs |
| 7 | **Step 4 (linkIdentity)** — last, and only after the rest is stable. | 2–4 hrs |

**Steps 1–6 are what UPDATE/DELETE actually needs** — roughly 4–7 hours. `linkIdentity` is a separate
feature that improves the guest→Google upgrade; nothing blocks on it, and it is the least predictable
item here because it runs through `auth/callback/route.ts`, which still carries known bug 6.

Then UPDATE/DELETE UI is unblocked: Delete first (~1–2 hrs, needs no form refactor and is the cheapest
way to prove the policies work end to end), then `validateScore` + `ScoreForm` extraction and Update
(~4–6 hrs). See CLAUDE.md's notes on `AddScoreButton` for why the form has to come apart first.

---

# Deployment

Everything above is a prerequisite. This section is what remains *after* it, and it is mostly not code.

## Hard code blockers

### 1. `origin` is the internal origin behind a proxy — `app/auth/callback/route.ts:6`

```ts
const { searchParams, origin } = new URL(request.url)
```

On Vercel — or any host that terminates TLS in front of the app — this is the internal hostname, so
line 32 redirects production users somewhere they cannot reach. **Google login breaks in prod while
working perfectly in local dev**, which makes it a nasty first-deploy surprise. Read `x-forwarded-host`
(falling back to `origin` locally).

### 2. Cancelling Google login reports success — same file, line 9

The `if (code)` block is skipped when the provider returns `?error=access_denied`, and execution falls
straight through to the `/browse` success redirect. The `error` / `error_description` params are never
read. Read them and redirect to the error page.

### 3. `/auth/auth-code-error` renders an empty `<div>`

The one route that exists to explain a failure explains nothing. Blocker only because fixing #2 makes
it genuinely reachable.

## Configuration checklist (lives in no file — catches everyone)

- [ ] Production callback URL added to **Google Cloud Console** → authorized redirect URIs
- [ ] Same URL in **Supabase → Authentication → URL Configuration** — both *Site URL* and *Redirect URLs*
- [ ] `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` set in the host
- [ ] **CAPTCHA enabled on anonymous sign-ins** — a public URL means bots minting permanent
      `auth.users` rows for free, and the default limit is only 30/hr per IP.
      **This is a code change, not a checkbox.** Supabase (hCaptcha or Cloudflare Turnstile) applies
      it to the auth endpoints project-wide, and the token is produced *in the browser* by a widget
      and is single-use. So `getOrCreateUser()` — which runs server-side, inside a Server Action —
      cannot call `signInAnonymously()` unaided: the widget has to render in `AddScoreButton`, its
      token has to ride along as a form field, and the action passes it as
      `signInAnonymously({ options: { captchaToken } })`. Budget a form change, not five minutes.
      Cloudflare's dummy testing sitekey/secret pair (always-pass and always-fail variants) lets you
      build and test all of that before any real widget or domain exists.
- [ ] A cleanup plan for accumulated anonymous users (old, zero-score, no linked identity)
- [ ] `pg_dump` of `charts` taken and stored somewhere that is not the Supabase project

## Worth doing, not blocking

- `next.config.ts` is empty — adding `images.remotePatterns` for the Supabase storage domain clears the
  four `no-img-element` warnings and puts jackets through `next/image`.
- `ImportFromBrowser.ts:56`'s `as any[]` is the one remaining ESLint **error**. Harmless at runtime,
  but check whether your build runs lint before it surprises you in CI.
- `/leaderboard` is still a heading with no content, and it is in the nav on every page.

## Order

1. Fix the three `auth/callback/route.ts` issues locally (they are one file and one sitting).
2. Deploy to a preview URL **first**. The redirect bugs only manifest behind a proxy, so a preview
   deploy is the only place they can actually be tested.
3. Add the preview *and* production URLs to Google Cloud Console and Supabase before testing login.
4. Verify, in a fresh incognito window: anonymous score add → Google sign-in → scores still present →
   sign out → sign back in.
5. Promote to production.

Budget roughly half a day, most of it spent on redirect-URI round trips rather than on code.

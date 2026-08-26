# Arcaea B50 Web Viewer

Browse charts and track your best scores for the mobile rhythm game [Arcaea](https://arcaea.lowiro.com/).

Your top 50 plays are ranked by **Play Rating** (chart constant + a score-derived modifier), the same way the game computes potential. Scores are stored as raw facts — grade, rating, and PM distance are always calculated on read, never persisted, so nothing goes stale if a chart constant is corrected.

## Stack

- **Next.js 16** (App Router, TypeScript) + **Tailwind CSS v4**
- **Supabase** — Postgres, Google OAuth, and Storage for song jackets

## Routes

```
/                  Landing page — sign in, or a welcome line
/scores            B50 view — your top 50 plays, plus add/import
/browse            Chart catalog — search, sort, filter by level and difficulty
/leaderboard       Not implemented yet
```

## Getting started

Requires Node 20+ and a Supabase project.

```bash
npm install
```

Create `.env.local` in the repo root:

```
NEXT_PUBLIC_SUPABASE_URL=https://<your-project>.supabase.co
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=<your-publishable-key>
```

Then:

```bash
npm run dev
```

The app expects a Supabase project with:

- a `charts` table and a `scores` table (see **Database** below),
- RLS policies **and** matching table-level `GRANT`s for the `anon` role — both are required, and a missing GRANT throws error `42501` even when the policy is correct,
- a public Storage bucket named `jackets`,
- Google enabled as an OAuth provider, with `<origin>/auth/callback` registered as a redirect URL.

## Database

**`charts`** — the song/chart catalog. Populated manually via SQL; there is no in-app editor.
`id`, `title`, `song_id`, `difficulty`, `level`, `chart_constant`, `note_count`, `artist`, `bpm`, `length`, `version`, `chart_designer`, `jacket_designer`, `jacket_override`

`song_id` is Arcaea's internal Latin-only slug. Display titles are unicode and can't be matched against asset filenames, so jackets are looked up by `song_id` instead: `{song_id}_{difficulty}.jpg` when `jacket_override` is set, otherwise `{song_id}.jpg`.

**`scores`** — one row per submitted play.
`id`, `chart_id` → `charts.id`, `user_id`, `score`, `pure`, `far`, `lost`, `created_at`

`pure` / `far` / `lost` are optional. `user_id` holds either a Supabase `auth.uid()` or a guest UUID.

## Accounts and guests

You can add scores without signing in. Guests get a UUID in an `httpOnly` `guest_id` cookie, and every read and write resolves identity as `user?.id ?? guestId`.

After signing in with Google, **Import Guest Scores to Account** copies everything recorded on that browser onto your account. It currently duplicates rather than moves, so importing twice will double your scores.

The guest cookie is self-issued and not cryptographically tied to auth, which is why there are no UPDATE or DELETE policies on `scores` yet — editing and deleting are blocked until guests move to Supabase's anonymous auth.

## Project layout

```
app/
├── auth/          OAuth callback route handler
├── browse/        Chart catalog page, cards, filters
├── components/    NavBar, Modal, SongInfo, login/profile buttons
├── scores/        B50 page, ScoreCard, add-score form, guest import
└── leaderboard/   Stub
utils/
├── supabase/      Browser, server, and proxy clients
├── rating.ts      Grade, Play Rating, and PM math
├── search.ts      Chart filtering and sorting
├── jacket.ts      Jacket URL resolution
├── style.ts       Difficulty/grade colors, title text sizing
├── guest.ts       Guest cookie handling
└── types.ts       The Chart type
proxy.ts           Session refresh (Next 16's rename of middleware.ts)
alt/               Abandoned design experiments, not wired into the app
```

## Status

Chart browsing, score entry, the B50 grid, jacket art, and Google sign-in all work. See [todo.txt](todo.txt) for known bugs and what's next — the headline items are OCR score import from screenshots, a per-score detail view, and the leaderboard.

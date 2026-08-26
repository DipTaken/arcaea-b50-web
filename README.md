# Arcaea B50 Web Viewer

Browse charts and track your best scores for the mobile rhythm game [Arcaea](https://arcaea.lowiro.com/).

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
See [todo.txt](todo.txt)

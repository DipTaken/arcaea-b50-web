# Arcaea B50 Web Viewer

Browse charts and track your best scores for the mobile rhythm game [Arcaea](https://arcaea.lowiro.com/).

## About

A learning project — my first time with TypeScript, Next.js, Supabase, and CSS. It's built
deliberately slowly, one concept at a time, and it is **not vibecoded**: I write the code. Where AI
is involved it's used the way a tutor or a code reviewer would be — explaining a concept before I
implement it, or auditing what I've already written — not generating features for me to paste in.
The audit in [docs/report.md](docs/report.md) is an example of the latter.

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
└── types.ts       Chart, Score, and ScoreWithChart
proxy.ts           Proxy entry point (Next 16's rename of middleware.ts)
docs/              Project list and codebase audit
```

## Status

- [docs/todo.txt](docs/todo.txt) — what's built and what's next
- [docs/report.md](docs/report.md) — codebase audit: bugs, Tailwind refactor, code quality
- [docs/report_todo.md](docs/report_todo.md) — the audit as a checklist, with notes on each concept

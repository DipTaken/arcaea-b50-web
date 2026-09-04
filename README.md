# Arcaea B50 Web Viewer

Browse charts and track your best scores for the mobile rhythm game [Arcaea](https://arcaea.lowiro.com/).

## About

A learning project. My first time with TypeScript, Next.js, Supabase, and CSS. It is **not vibecoded**. I write the code myself, but AI is used as a tutor and code reviewer. AI is also used to audit what I've already written.
The tiered bug list in [docs/todo.md](docs/todo.md) is an example.

## Stack

- **Next.js 16** (App Router, TypeScript) + **Tailwind CSS v4**
- **Supabase** — Postgres, Google OAuth + anonymous auth, Storage for song jackets

## Setup

```bash
npm install
cp .env.example .env.local   # fill in both values from the Supabase dashboard
npm run dev
```

`.env.local` needs `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`

The Supabase CLI is a devDependency, so every command is `npx supabase ...`. Schema changes go
through a migration in `supabase/migrations/`, not the dashboard.

## Auth

The first write mints an anonymous Supabase user, and
`/auth/link` provides a way to link it to a Google Account.

## Routes

```
/                  Landing — sign in, or a welcome line
/scores            B50 view — best score per chart, top 50 by Play Rating
/browse            Chart catalog — search, sort, filter by level and difficulty
/auth/link         Anonymous → Google upgrade
/leaderboard       Not implemented yet
```

## Project layout

```
app/
├── auth/          OAuth callback, the link page, the error page
├── browse/        Chart catalog page, cards, filters
├── components/    Shared UI — Button, Card, CardGrid, Modal, Panel, PageShell,
│                  NavBar, Footer, SongInfo, login/link/profile buttons
├── scores/        B50 page, ScoreCard, the shared add/edit form, server actions
└── leaderboard/   Stub
utils/
├── supabase/      Browser, server, and proxy clients
├── auth.ts        getOrCreateUser — lazily mints the anonymous user
├── rating.ts      Grade, Play Rating, PM distance, B50 selection
├── search.ts      Chart filtering and sorting
├── jacket.ts      Jacket URL resolution
├── style.ts       Difficulty/grade/lamp colors, title text sizing
└── types.ts       Chart, Score, ScoreWithChart, B50Entry
proxy.ts           Proxy entry point (Next 16's rename of middleware.ts)
supabase/          Migrations, seed data, CLI config
docs/              Todo list, chart-update runbook, gotchas, hours log
```

## Docs

- [docs/todo.md](docs/todo.md) — every open bug and task, tiered T0 (data loss) to T4 (not built)
- [docs/CHART_UPDATE_INSTRUCTIONS.md](docs/CHART_UPDATE_INSTRUCTIONS.md) — the monthly chart-update runbook
- [docs/gotchas.md](docs/gotchas.md) — traps hit on this project, one line each

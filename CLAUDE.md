@AGENTS.md

# Arcaea Score Viewer — Project Context

Personal project + learning exercise (first time with TypeScript, Next.js, Supabase/SQL). Built incrementally with heavy explanation at each step — prioritize understanding over speed when helping on this project.

## Stack

- **Frontend/Backend:** Next.js (App Router, TypeScript, Tailwind CSS — defaults from `create-next-app`)
- **Database/Auth/Storage:** Supabase (Postgres)
- **OCR (Stage 2, not started):** Python service, likely using `arcaea-offline-ocr` (PyPI) or a custom pipeline
- **Package manager:** npm

## Saving method

- Guest users: UUID stored in an `httpOnly` cookie (`guest_id`), refreshed on every visit (~1yr maxAge)
- Google login: planned for Stage 3, not yet implemented
- Guest UUID is **not** cryptographically tied to auth — currently just a self-issued cookie value. Before adding UPDATE/DELETE policies on `scores`, this needs to be replaced with Supabase's built-in anonymous auth (`signInAnonymously()`) so RLS can trust `auth.uid()` instead of a client-supplied value.

## Database schema (Supabase/Postgres)

### `charts`
| column | type | notes |
|---|---|---|
| id | int8 | PK, identity/auto-increment |
| title | text | |
| difficulty | text | e.g. "BYD", "FTR", "ETR" |
| level | text | e.g. "11", "11+" — text because of the "+" suffix |
| chart_constant | float4 | precise difficulty value |
| note_count | int4 | |

Only FTR/BYD/ETR difficulties are tracked (matches original Google Sheets setup; PST/PRS rarely matter for best-N ranking).

### `scores`
| column | type | notes |
|---|---|---|
| id | int8 | PK, identity/auto-increment |
| chart_id | int8 | FK → charts.id, ON DELETE/UPDATE: No Action (Restrict) |
| user_id | uuid | actually stores the guest UUID (not a Supabase auth user yet — naming is a holdover, functions as guest identifier) |
| score | int8 | required |
| pure | int4 | **nullable** — optional field |
| far | int4 | **nullable** — optional field |
| lost | int4 | **nullable** — optional field |
| created_at | timestamptz | default `now()` |

**Design principle:** store raw facts only. Grade, Play Rating, Play Potential, and PM-distance are all *calculated*, never stored — see `utils/rating.ts`. This avoids stale derived data if the formula or a chart_constant is ever corrected.

### RLS / Grants
Both tables have RLS enabled (project-wide "automatic RLS on new tables" setting was turned on at project creation; "automatically expose new tables" was turned off).

- `charts`: SELECT policy (`using (true)`) + `GRANT SELECT ON public.charts TO anon;`
- `scores`: SELECT + INSERT policies (`using/with check (true)`) + `GRANT SELECT, INSERT ON public.scores TO anon;`
- **No UPDATE/DELETE policies yet** — deliberately deferred until real auth exists (see Saving method note above).
- Note: RLS policies and table-level GRANTs are separate and both required — a missing GRANT throws error `42501` even with a correct RLS policy.

## Key files (as of last session)

```
app/
├── layout.tsx                 — root layout; <body> carries the page-wide background (bg-linear-to-r from-[#0f1014] to-[#191621]).
│                                 globals.css's old plain-CSS `body { background: ... }` rule was removed — it lived outside
│                                 any Tailwind @layer, so as unlayered CSS it always beat the bg-* utility class regardless
│                                 of specificity (Tailwind's own utilities are generated inside @layer utilities).
├── page.tsx                   — homepage; fetches charts + scores, sorts by Play Rating (not chart_constant), slices to top 50,
│                                 renders <AddScoreButton> + a <ul> grid of <ScoreCard>
├── ScoreCard.tsx               — client component, one B50 grid cell: rank badge (#N, from .map's index), grade (colored via
│                                 getGradeColor) + Play Rating, jacket art, difficulty-colored border + title bar (via inline
│                                 `style`, since Tailwind can't statically resolve a color computed at runtime — see style.ts
│                                 below). Fully styled with Tailwind. Jacket art is still a single hardcoded placeholder URL
│                                 (Testify.webp) for every card — see "Not yet built".
├── AddScoreButton.tsx          — client component: button + native <dialog> (opened/closed via useRef + showModal()/close())
│                                 wrapping the add-score form. Fully styled: dialog centered via `m-auto` (restores the
│                                 `margin: auto` centering a modal <dialog> gets by default, which Tailwind's Preflight
│                                 reset zeroes out), dialog's own default white background/border stripped (`bg-transparent`)
│                                 so only the form's rounded card is visible, backdrop dimmed + blurred via the `backdrop:`
│                                 variant (`backdrop:bg-black/50 backdrop:backdrop-blur-sm`) targeting the dialog's `::backdrop`
│                                 pseudo-element. Submits via a client-side handleSubmit that awaits the addScore Server
│                                 Action then closes the dialog. Input validation (ranges, chart_id sanity, etc.) not yet added.
├── scores/
│   ├── actions.ts              — `addScore` server action (inserts a score row, handles optional pure/far/lost as null);
│   │                              revalidates `/` (the add-score form now lives on the homepage, not `/scores`). No server-side
│   │                              validation yet — currently trusts whatever the client sends.
│   └── ChartSearch.tsx         — client component: searchable/filterable chart picker, used inside AddScoreButton's form.
│                                  Styled (dropdown list, hover states); good enough for now.
├── utils/
│   ├── supabase/
│   │   ├── client.ts           — browser Supabase client
│   │   ├── server.ts           — server Supabase client (takes cookieStore param)
│   │   └── middleware.ts       — used by root middleware.ts, refreshes Supabase auth session cookies
│   ├── guest.ts                — `getGuestId()` (Server Action use only) + `getGuestIdReadOnly()` (Server Components —
│   │                              added and in use on the homepage)
│   ├── rating.ts               — COMPLETE. See below.
│   └── style.ts                 — `getDifficultyColor(difficulty)` → hex color string per difficulty; `getGradeColor(grade)`
│                                   → hex color string per grade. Both applied via inline `style`, not `className` — Tailwind's
│                                   JIT scanner only picks up complete literal class strings in source, so a template-literal
│                                   class like `` `bg-[${color}]` `` never generates real CSS. `getTextSize(title)` → Tailwind
│                                   text-size class, bucketed by title length (this one IS a plain static class, so template-
│                                   literal interpolation onto className is fine for it).
middleware.ts                   — root middleware, refreshes Supabase session via utils/supabase/middleware.ts

alt/                            — experimental/abandoned design variants, kept for reference, NOT wired into the app
├── app/ScoreCardNew.tsx         — alternate ScoreCard layout (score positioned under the grade instead of over the jacket).
│                                   page.tsx still imports the real `app/ScoreCard.tsx`, not this one.
└── utils/style copy.ts          — matching alt copy of style.ts used only by ScoreCardNew.tsx
```

`app/scores/page.tsx` (the old standalone add-score page) has been deleted — the homepage + `AddScoreButton` + `<dialog>` pattern won out; that reconciliation is done.

## `utils/rating.ts` — complete, verified against real Sheets data

```ts
export function getGrade(score: number, noteCount: number, pure: number | null, far: number | null, lost: number | null): string {
    if (score >= 10000000) {
        if (isPM(score, noteCount, far, lost) || noteCount < 2237) return "PM"
        else return "EX+"
    }
    else if (score >= 9900000) return "EX+"
    else if (score >= 9800000) return "EX"
    else if (score >= 9500000) return "AA"
    else if (score >= 9200000) return "A"
    else if (score >= 8900000) return "B"
    else if (score >= 8600000) return "C"
    else return "D"
}

export function getScoreModifier(score: number): number {
    if (score >= 10000000) return 2
    else if (score >= 9800000) return 1 + (score - 9800000) / 200000
    else return (score - 9500000) / 300000
}

export function getPlayRating(score: number, chartConstant: number): number {
    const rating = getScoreModifier(score)
    return Math.max(rating + chartConstant, 0)
}

export function getPmRating(score: number, noteCount: number, pure: number | null): string {
    if (score < 10000000) return "N/A"
    else if (pure === null) return "? MAX"
    else if (noteCount === pure) return "MAX"
    else return "MAX - " + (noteCount - pure)
}

function isPM(score: number, noteCount: number, far: number | null, lost: number | null): boolean {
    if (score < 10000000) return false
    else if (noteCount < 2237) return true // no chart currently has >=2237 notes, so score>=10M is only achievable via true PM below this threshold
    else if (far === null || lost === null) return false
    else return far === 0 && lost === 0
}
```

Verified against real data: Testify (chart_constant 12.0, score 9,438,838) → Play Rating delta -0.2039, Play Potential 11.7961, matches the original Google Sheets exactly.

Naming note (unresolved, cosmetic only): `getPlayRating`/`getScoreModifier` names don't perfectly match the Sheets' own column labels ("Play Rating" = delta alone, "Play Potential" = constant+delta in the Sheets) — functionally correct either way, just a possible future rename for clarity.

Note: `getGrade`'s PM branch now returns a bare `"PM"` instead of `"PM (" + getPmRating(...) + ")"` — simplified so it fits the small `ScoreCard` grid cell (there's no room for "PM (MAX-3)" at that size). `getPmRating` is still exported/available if the fuller detail is ever needed elsewhere (e.g. a per-chart detail view).

## Not yet built

**Stage 1 is ~90% done — the one remaining piece is real song jacket art / a jacket database.** Everything else (homepage grid, ScoreCard styling, AddScoreButton + ChartSearch styling, rating math) is functionally and visually complete.

- **Real song jacket art — the last Stage 1 item.** `ScoreCard.tsx` still hardcodes one placeholder image URL (`Testify.webp`) for every card. Architecture decided: a public Supabase Storage bucket (`jackets`) plus a `jacket_url`-equivalent lookup on `charts`.
  - Jacket source has been found: images named `Song` (base jacket, shared across all difficulties of that song) or `Song_BYD` (difficulty-specific alt art override — only used difficulties get an override file, most songs only have the base). Filenames are Latin-only even though `charts.title` is unicode, so **matching can't be done on title text** — confirmed to be a job for Arcaea's internal `song_id` (the stable, Latin-only slug the game itself uses for every asset, independent of the localized display title).
  - Decided approach: add a `song_id` column to `charts`. One-time backfill matches existing rows against a reference id↔title dataset (a slightly-stale third-party DB is fine for this since it's a one-time historical catch-up); going forward, `song_id` is filled in by hand at the same time every other chart field already is (there's no in-app "add chart" flow — `charts` has only ever been populated manually/via SQL, so this isn't a new burden, just one more manual field alongside `chart_constant`/`note_count`). Jacket lookup then becomes deterministic: check for `{song_id}_{difficulty}.ext` first (the alt-art override case), falling back to `{song_id}.ext`.
  - Not yet decided/done: which reference dataset to use for the one-time backfill, the actual `song_id` column + migration, the backfill script, and wiring `ScoreCard.tsx` up to `getPublicUrl()` instead of the hardcoded string.
- Stage 2 (OCR) — not started. Candidate library: `arcaea-offline-ocr` on PyPI (KNN + SIFT-based, extracts score/pure/far/lost/song_id from a screenshot). Worth noting it likely uses the same internal `song_id` system being adopted for jackets above.
- Stage 3 (Google login, public deployment, real RLS policies for UPDATE/DELETE)
- Minor/deferred: no input validation yet on the add-score form (client-side ranges or server-side checks in `addScore`).

## Working style notes

- User is learning — prefers being walked through concepts and writing code themselves over being handed finished files, especially for new concepts (Server Actions, useState, useRef, destructuring, RLS, etc.)
- User is a Waterloo CS student, comfortable with general programming/CS concepts, genuinely new to this specific web stack
- **CSS/Tailwind specifically: user had never done CSS before this project.** For new-to-them CSS concepts, explain thoroughly with illustrative (non-literal) examples rather than inserting large code blocks directly — let the user write the real implementation and review it after. Small mechanical fixes (typos, misplaced tags, dead/invalid classes, one-line corrections to code the user already wrote) are fine to edit directly. Once a concept is understood, the user wants direct, concrete answers (real class names, real prop names) rather than re-explaining from scratch each time.
- A friend (also Waterloo CS, also plays Arcaea) may join as a second contributor — repo should assume a `.env.example` + shared Supabase project workflow, not a single-owner setup
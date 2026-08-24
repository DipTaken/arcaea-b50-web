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
├── page.tsx                  — homepage; fetches charts + scores, intended to show user's B30/B50-style list
├── AddScoreButton.tsx         — client component, toggle button + form (WIP, shell only — form contents not yet moved in)
├── scores/
│   ├── page.tsx               — original scores page (fetch charts + scores, form, list) — may be redundant with app/page.tsx now that "add score" is moving to a homepage button+modal pattern; needs reconciling
│   ├── actions.ts             — `addScore` server action (inserts a score row, handles optional pure/far/lost as null)
│   └── ChartSearch.tsx        — client component: searchable/filterable chart picker (replaces a plain <select>), used inside the add-score form
├── utils/
│   ├── supabase/
│   │   ├── client.ts          — browser Supabase client
│   │   ├── server.ts          — server Supabase client (takes cookieStore param)
│   │   └── middleware.ts      — used by root middleware.ts, refreshes Supabase auth session cookies
│   ├── guest.ts               — `getGuestId()` (Server Action use only — reads/creates/refreshes the guest_id cookie)
│   │                              NOTE: a read-only variant (`getGuestIdReadOnly`) is also needed for Server Components,
│   │                              since Server Components cannot set cookies. Confirm this got added.
│   └── rating.ts              — COMPLETE. See below.
middleware.ts                  — root middleware, refreshes Supabase session via utils/supabase/middleware.ts
```

## `utils/rating.ts` — complete, verified against real Sheets data

```ts
export function getGrade(score: number, noteCount: number, pure: number | null, far: number | null, lost: number | null): string {
    if (score >= 10000000) {
        if (isPM(score, noteCount, far, lost) || noteCount < 2237) return "PM (" + getPmRating(score, noteCount, pure) + ")"
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

export function getPmRating(score: number, noteCount: number, pures: number | null): string {
    if (score < 10000000) return "N/A"
    else if (pures === null) return "MAX Unknown"
    else if (noteCount === pures) return "MAX"
    else return "MAX - " + (noteCount - pures)
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

## Not yet built

- Wiring `rating.ts` into any actual UI (currently unused by any component)
- Finishing `AddScoreButton.tsx` (move the form/ChartSearch into the conditionally-rendered block)
- Reconciling `app/scores/page.tsx` vs the newer `app/page.tsx` + `AddScoreButton` approach — pick one pattern
- Sorting/rendering the scores list (join `scores` + `charts`, sort by chart_constant or play potential, render with rating.ts applied)
- Any Tailwind styling pass (everything is currently unstyled/plain HTML)
- Stage 2 (OCR) — not started. Candidate library: `arcaea-offline-ocr` on PyPI (KNN + SIFT-based, extracts score/pure/far/lost/song_id from a screenshot)
- Stage 3 (Google login, public deployment, real RLS policies for UPDATE/DELETE)

## Working style notes

- User is learning — prefers being walked through concepts and writing code themselves over being handed finished files, especially for new concepts (Server Actions, useState, destructuring, RLS, etc.)
- User is a Waterloo CS student, comfortable with general programming/CS concepts, genuinely new to this specific web stack
- A friend (also Waterloo CS, also plays Arcaea) may join as a second contributor — repo should assume a `.env.example` + shared Supabase project workflow, not a single-owner setup
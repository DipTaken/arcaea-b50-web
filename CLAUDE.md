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
├── page.tsx                  — homepage; fetches charts + scores, sorts by Play Rating (not chart_constant), slices to top 50,
│                                 renders <AddScoreButton> + a <ul> grid of <ScoreCard>
├── ScoreCard.tsx              — client component, one B50 grid cell: rank badge (#N, from .map's index), grade + Play Rating,
│                                 jacket art with a gradient-faded score overlay, difficulty-colored title bar (chart_constant
│                                 bottom-right). Fully styled with Tailwind. Jacket art is currently a single hardcoded
│                                 placeholder URL for every card (see "Not yet built" — song jacket art).
├── AddScoreButton.tsx         — client component: button + native <dialog> (opened/closed via useRef + showModal()/close())
│                                 wrapping the add-score form. Functionally complete — submits via a client-side handleSubmit
│                                 that awaits the addScore Server Action then closes the dialog. NOT yet styled (plain HTML).
├── scores/
│   ├── actions.ts             — `addScore` server action (inserts a score row, handles optional pure/far/lost as null);
│   │                              revalidates `/` (the add-score form now lives on the homepage, not `/scores`)
│   └── ChartSearch.tsx        — client component: searchable/filterable chart picker, used inside AddScoreButton's form.
│                                  NOT yet styled (plain HTML).
├── utils/
│   ├── supabase/
│   │   ├── client.ts          — browser Supabase client
│   │   ├── server.ts          — server Supabase client (takes cookieStore param)
│   │   └── middleware.ts      — used by root middleware.ts, refreshes Supabase auth session cookies
│   ├── guest.ts               — `getGuestId()` (Server Action use only) + `getGuestIdReadOnly()` (Server Components —
│   │                              added and in use on the homepage)
│   ├── rating.ts              — COMPLETE. See below.
│   └── style.ts                — `getDifficultyColor(difficulty)` → hex color string per difficulty (applied via inline
│                                   `style`, not `className` — Tailwind can't statically pick up a computed/dynamic value);
│                                   `getTextSize(title)` → Tailwind text-size class, bucketed by title length
middleware.ts                  — root middleware, refreshes Supabase session via utils/supabase/middleware.ts
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

- **Styling `AddScoreButton.tsx` and `ChartSearch.tsx`** — both still plain unstyled HTML (button, `<dialog>`, inputs, search list). The immediate next task; stands out now that `ScoreCard`/the homepage grid is fully styled.
- **Real song jacket art.** Architecture decided: a public Supabase Storage bucket (`jackets`) plus a `jacket_url` column on `charts` (not yet added — deliberately deferred until real art assets exist). `ScoreCard.tsx` currently hardcodes one placeholder image URL for every card, purely so layout work had something to render against. One test image (`Testify.webp`) is already uploaded to the bucket.
- Stage 2 (OCR) — not started. Candidate library: `arcaea-offline-ocr` on PyPI (KNN + SIFT-based, extracts score/pure/far/lost/song_id from a screenshot)
- Stage 3 (Google login, public deployment, real RLS policies for UPDATE/DELETE)

Done since the previous version of this doc (kept here for history, remove once stale): `rating.ts` is wired into the UI; `AddScoreButton.tsx` + `app/scores/page.tsx` were reconciled in favor of a single homepage + modal `<dialog>` pattern (`app/scores/page.tsx` deleted); the score list is sorted by Play Rating and sliced to top 50; the homepage grid has a full Tailwind styling pass.

## Working style notes

- User is learning — prefers being walked through concepts and writing code themselves over being handed finished files, especially for new concepts (Server Actions, useState, useRef, destructuring, RLS, etc.)
- User is a Waterloo CS student, comfortable with general programming/CS concepts, genuinely new to this specific web stack
- **CSS/Tailwind specifically: user had never done CSS before this project.** For new-to-them CSS concepts, explain thoroughly with illustrative (non-literal) examples rather than inserting large code blocks directly — let the user write the real implementation and review it after. Small mechanical fixes (typos, misplaced tags, dead/invalid classes, one-line corrections to code the user already wrote) are fine to edit directly. Once a concept is understood, the user wants direct, concrete answers (real class names, real prop names) rather than re-explaining from scratch each time.
- A friend (also Waterloo CS, also plays Arcaea) may join as a second contributor — repo should assume a `.env.example` + shared Supabase project workflow, not a single-owner setup
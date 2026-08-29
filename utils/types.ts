export type Chart = {
    id: number
    title: string
    song_id: string
    difficulty: string
    level: string
    chart_constant: number
    note_count: number
    artist: string
    bpm: string
    length: string
    version: string
    chart_designer: string | null
    jacket_designer: string | null
    jacket_override: boolean
}

export type Score = {
    id: number
    chart_id: number
    user_id: string
    score: number
    pure: number | null
    far: number | null
    lost: number | null
    created_at: string
    clear_status: string
}

// a score with its associated chart data
export type ScoreWithChart = Score & { charts: Chart }

// one row of the B50 table, with rank, score, playRating, and weight
export type B50Entry = { 
    rank: number
    score: ScoreWithChart
    playRating: number
    weight: 1 | 2
}
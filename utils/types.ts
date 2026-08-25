export type Chart = {
    id: number
    title: string
    song_id: string
    difficulty: string
    level: string
    chart_constant: number
    note_count: number
    bpm: string
    version: string
    chart_designer: string | null
    jacket_designer: string | null
    jacket_override: boolean
}
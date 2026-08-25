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
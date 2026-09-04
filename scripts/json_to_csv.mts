import type { Chart } from '@/utils/types'
import Papa from 'papaparse'
import { readFileSync } from 'node:fs'
import { join } from 'node:path'

type ChartRow = Omit<Chart, 'id' | 'chart_constant' | 'note_count'>
              & { chart_constant: number | null; note_count: number | null }


type SongListFile = {
    songs: SongEntry[]
}

type SongEntry = {
    title_localized: {en: string}
    id: string
    artist: string
    bpm: string
    version: string
    difficulties?: DifficultyEntry[]
    deleted?: boolean
}

type DifficultyEntry = {
    ratingClass: number
    chartDesigner: string
    jacketDesigner: string 
    rating: number
    jacketOverride?: boolean
    ratingPlus?: boolean
    version?: string
    title_localized?: {en: string}
    artist?: string
    bpm?: string
}

type ChartConstantFile = Record<string, (ChartConstantEntry | null)[]>

type ChartConstantEntry = { constant: number }
    
type NoteCountFile = { notes: Record<string, (number | null)[]> }

type LengthFile = Record<string, string>

const COLUMNS = ["title", "difficulty", "level", "chart_constant", "note_count", "bpm", "length", "version",
"chart_designer", "jacket_designer", "song_id", "jacket_override", "artist"] as const satisfies readonly (keyof ChartRow)[]

function readJson<T>(filename: string): T {
    const path = join(import.meta.dirname, 'data', filename)
    const text = readFileSync(path, 'utf-8')
    return JSON.parse(text) as T
}

function toCsv(rows: ChartRow[]): string {
    return ""
}
import type { Chart } from '@/utils/types'
import Papa from 'papaparse'
import { readFileSync, writeFileSync } from 'node:fs'
import { join } from 'node:path'

type ChartRow = Omit<Chart, 'id' | 'chart_constant' | 'note_count'>
    & { chart_constant: number | null; note_count: number | null }

type SongListFile = {
    songs: SongEntry[]
}

type SongEntry = {
    title_localized: { en: string }
    id: string
    artist: string
    bpm: string
    set: string
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
    title_localized?: { en: string }
    artist?: string
    bpm?: string
}

type ChartConstantFile = Record<string, (ChartConstantEntry | null)[]>

type ChartConstantEntry = { constant: number }

type NoteCountFile = { notes: Record<string, (number | null)[]> }

type LengthFile = Record<string, string>

const DIFFICULTIES = ['PST', 'PRS', 'FTR', 'BYD', 'ETR'] as const

const songslist = readJson<SongListFile>('songlist.json').songs
const chartConstants = readJson<ChartConstantFile>('cc.json')
const noteCounts = readJson<NoteCountFile>('note_count.json').notes
const lengths = readJson<LengthFile>('length.json')

const charts = songslist.flatMap(song =>
    song.difficulties?.map<ChartRow>((diff) => {
        const title = song.title_localized.en
        const song_id = song.id
        const difficulty = getDifficultyName(song.set, diff.ratingClass)
        const level = diff.ratingPlus ? `${diff.rating}+` : `${diff.rating}`
        const chart_constant = chartConstants[song.id]?.[diff.ratingClass]?.constant ?? null
        const note_count = noteCounts[song.id]?.[diff.ratingClass] ?? null
        const artist = diff.artist ?? song.artist
        const bpm = diff.bpm ?? song.bpm
        const length = lengths[song.id] ?? null
        const version = diff.version ?? song.version
        const chart_designer = diff.chartDesigner || null
        const jacket_designer = diff.jacketDesigner || null
        const jacket_override = diff.jacketOverride ?? false

        return { title, song_id, difficulty, level, chart_constant, note_count, artist, bpm, length, version, chart_designer, jacket_designer, jacket_override }
    }) ?? []
) 

function getDifficultyName(set: string, ratingClass: number): string {
    const difficulty = DIFFICULTIES[ratingClass]
    if (set === 'konzetsu' && ratingClass === 3) {
        return 'INS'
    }
    else {
        return difficulty
    }
}

function readJson<T>(filename: string): T {
    const path = join(import.meta.dirname, 'data', filename)
    const text = readFileSync(path, 'utf-8')
    return JSON.parse(text) as T
}

function toCsv(rows: ChartRow[]): string {
    return Papa.unparse(rows, {})
}

const outPath = join(import.meta.dirname, 'data', 'charts.csv')
function writeCsv(path: string, csv: string): void {
    writeFileSync(path, csv, 'utf-8')
}

writeCsv(outPath, toCsv(charts))
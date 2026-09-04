import type { Chart } from '@/utils/types'
import Papa from 'papaparse'
import { readFileSync, writeFileSync } from 'node:fs'
import { join } from 'node:path'

type ChartRow = Omit<Chart, 'id' | 'chart_constant' | 'note_count' | 'length' >
    & { chart_constant: number | null; note_count: number | null; length: string | null }

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

type LengthFile = Record<string, string | undefined>

const DIFFICULTIES = ['PST', 'PRS', 'FTR', 'BYD', 'ETR'] as const

const songslist = readJson<SongListFile>('songlist.json').songs
const chartConstants = readJson<ChartConstantFile>('cc.json')
const noteCounts = readJson<NoteCountFile>('note_count.json').notes
const lengths = readJson<LengthFile>('length.json')

const charts = songslist.flatMap(song =>
    song.difficulties?.flatMap<ChartRow>((diff) => {
        const chart: ChartRow = {
            title: song.title_localized.en,
            song_id: song.id,
            difficulty: getDifficultyName(song.set, diff.ratingClass),
            level: diff.ratingPlus ? `${diff.rating}+` : `${diff.rating}`,
            chart_constant: chartConstants[song.id]?.[diff.ratingClass]?.constant ?? null,
            note_count: noteCounts[song.id]?.[diff.ratingClass] ?? null,
            artist: diff.artist ?? song.artist,
            bpm: diff.bpm ?? song.bpm,
            length: lengths[song.id] ?? null,
            version: diff.version ?? song.version,
            chart_designer: diff.chartDesigner || null,
            jacket_designer: diff.jacketDesigner || null,
            jacket_override: diff.jacketOverride ?? false,
        }
        
        return shouldDropChart(chart, song.deleted ?? false) ? [] : getChartTitleExceptions(chart)
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

function getChartTitleExceptions(chart: ChartRow): ChartRow {
    if (chart.song_id === 'axiumcrisis' && chart.difficulty === 'BYD') {
        return { ...chart, title: 'Axium Divergence' }
    }
    else if (chart.song_id === 'dropdead' && chart.difficulty === 'BYD') {
        return { ...chart, title: 'overdead.' }
    }
    else if (chart.song_id === 'viciousheroism' && chart.difficulty === 'BYD') {
        return { ...chart, title: 'Vicious [ANTi] Heroism' }
    }
    else if (chart.song_id === 'singularity' && chart.difficulty === 'BYD') {
        return { ...chart, title: 'Singularity VVVIP' }
    }
    else if (chart.song_id === 'pragmatism' && chart.difficulty === 'BYD') {
        return { ...chart, title: 'PRAGMATISM -RESURRECTION-' }
    }
    else if (chart.song_id === 'last' && chart.difficulty === 'BYD') {
        return { ...chart, title: 'Last | Moment' }
    }
    else if (chart.song_id === 'ignotus' && chart.difficulty === 'BYD') {
        return { ...chart, title: 'Ignotus Afterburn' }
    }
    else if (chart.song_id === 'redandblue' && chart.difficulty === 'BYD') {
        return { ...chart, title: 'Red and Blue and Green' }
    }

    return chart
}

function shouldDropChart(chart: ChartRow, isDeleted: boolean): boolean {
    const isNotLastEternityBYD = chart.song_id === 'lasteternity' && chart.difficulty !== 'BYD'
    return isDeleted || isNotLastEternityBYD
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
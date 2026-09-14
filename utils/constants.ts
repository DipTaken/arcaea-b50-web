import { SortOption } from "./types"
import { getDifficultyValue, getLengthValue, getBPMValue, compareVersions } from "./sortOptions"

//note that in our data shows PST = 0, PRS = 1, FTR = 2, BYD/INS = 3, ETR = 4
export const DIFFICULTY_ORDER = ["PST", "PRS", "FTR", "ETR", "BYD", "INS"] as const

export const LEVEL_LIST = ['1', '2', '3', '4', '5', '6', '7', '7+', '8', '8+', '9', '9+', '10', '10+', '11', '11+', '12']

export const MAX_BASE_SCORE = 10000000 //10 million

export const SORT_OPTIONS: SortOption[] = [
    {
        key: 'title',
        label: 'Title',
        sortFn: (a, b) => a.title.localeCompare(b.title),
        displayFn: () => ''
    },
    {
        key: 'chartConstant',
        label: 'Chart Constant',
        sortFn: (a, b) => (a.chart_constant ?? 0) - (b.chart_constant ?? 0),
        displayFn: (chart) => "Chart Constant: " + (chart.chart_constant ? chart.chart_constant.toFixed(1) : "N/A") // some charts may not have a cc
    },
    {
        key: 'difficulty',
        label: 'Difficulty',
        sortFn: (a, b) => getDifficultyValue(a.difficulty) - getDifficultyValue(b.difficulty),
        displayFn: (chart) => "Difficulty: " + chart.difficulty
    },
    {
        key: 'artist',
        label: 'Artist',
        sortFn: (a, b) => a.artist.localeCompare(b.artist),
        displayFn: (chart) => "Artist: " + chart.artist

    },
    {
        key: 'length',
        label: 'Length',
        sortFn: (a, b) => getLengthValue(a.length) - getLengthValue(b.length),
        displayFn: (chart) => "Length: " + chart.length
    },
    {
        key: 'bpm',
        label: 'BPM',
        sortFn: (a, b) => getBPMValue(a.bpm) - getBPMValue(b.bpm),
        displayFn: (chart) => "BPM: " + chart.bpm
    },
    {
        key: 'noteCount',
        label: 'Note Count',
        sortFn: (a, b) => (a.note_count ?? 0) - (b.note_count ?? 0),
        displayFn: (chart) => "Note Count: " + (chart.note_count ? chart.note_count.toString() : "N/A")
    },
    {
        key: 'version',
        label: 'Version',
        sortFn: (a, b) => compareVersions(a.version, b.version),
        displayFn: (chart) => "Version: " + chart.version
    }
]
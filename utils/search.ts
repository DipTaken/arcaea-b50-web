import { Chart } from '@/utils/types'

export function filterCharts(charts: Chart[], search: string, levelFilter?: string | null, filterComparison: string | null = "ge", difficultyFilter?: number | null): Chart[] {
    const query = search.toLowerCase()
    const levelOrder = ['1', '2', '3', '4', '5', '6', '7', '7+', '8', '8+', '9', '9+', '10', '10+', '11', '11+', '12']
    const levelIndex = levelFilter ? levelOrder.indexOf(levelFilter) : -1
    const comparisonOp = filterComparison ? getComparisonOp(filterComparison) : null

    return charts.filter((chart) => {
        const matchesSearch =
            chart.title.toLowerCase().includes(query) ||
            chart.song_id.toLowerCase().includes(query)

        const chartIndex = levelOrder.indexOf(chart.level)
        const matchesLevel = comparisonOp ? comparisonOp(chartIndex, levelIndex) : true
        const matchesDifficulty = difficultyFilter ? getDifficultyValue(chart.difficulty) === difficultyFilter : true

        return matchesSearch && matchesLevel && matchesDifficulty
    })
}

export function sortCharts(charts: Chart[], sortOption: string | null = 'cc', sortDirection: 'asc' | 'desc' = 'desc'): Chart[] {
    let sortedCharts: Chart[]

    if (sortOption === 't') {
        sortedCharts = charts.slice().sort((a, b) => a.title.localeCompare(b.title))
    }
    else if (sortOption === 'cc') {
        sortedCharts = charts.slice().sort((a, b) => (a.chart_constant ?? 0) - (b.chart_constant ?? 0))
    }
    else if (sortOption === 'dif') {
        sortedCharts = charts.slice().sort((a, b) => getDifficultyValue(a.difficulty) - getDifficultyValue(b.difficulty))
    }
    else if (sortOption === 'art') {
        sortedCharts = charts.slice().sort((a, b) => a.artist.localeCompare(b.artist))
    }
    else if (sortOption === 'len') {
        sortedCharts = charts.slice().sort((a, b) => getLengthValue(a.length) - getLengthValue(b.length))
    }
    else if (sortOption === 'bpm') {
        sortedCharts = charts.slice().sort((a, b) => getBPMValue(a.bpm) - getBPMValue(b.bpm))
    }
    else if (sortOption === 'nc') {
        sortedCharts = charts.slice().sort((a, b) => a.note_count - b.note_count)
    }
    else if (sortOption === 'ver') {
        sortedCharts = charts.slice().sort((a, b) => compareVersions(a.version, b.version))
    }
    else sortedCharts = charts

    return sortDirection === 'asc' ? sortedCharts : sortedCharts.reverse()
}

function getComparisonOp(filterComparison: string | null): ((a: number, b: number) => boolean) | null {
    switch (filterComparison) {
        case 'lt':
            return (a: number, b: number) => a < b
        case 'le':
            return (a: number, b: number) => a <= b
        case 'eq':
            return (a: number, b: number) => a === b
        case 'ge':
            return (a: number, b: number) => a >= b
        case 'gt':
            return (a: number, b: number) => a > b
        default:
            return null
    }
}

export function getSortDisplayValue(chart: Chart, sortOption: string | null): string {
    switch (sortOption) {
        case 'cc':
            return "Chart Constant: " + (chart.chart_constant ? chart.chart_constant.toFixed(1) : "N/A")
        case 'dif':
            return "Difficulty: " + chart.difficulty
        case 'art':
            return "Artist: " + chart.artist
        case 'bpm':
            return "BPM: " + chart.bpm
        case 'len':
            return "Length: " + chart.length
        case 'nc':
            const noteCount = chart.note_count ? chart.note_count.toString() : "N/A"
            return "Note Count: " + noteCount
        case 'ver':
            return "Version: " + chart.version
        default:
            return ""
    }
}

function getDifficultyValue(difficulty: string): number {
    switch (difficulty) {
        case "PST":
            return 1
        case "PRS":
            return 2
        case "FTR":
            return 3
        case "ETR":
            return 4
        case "BYD":
            return 5 
        default:
            return 0
    }
}

function getLengthValue(length: string): number {
    const parts = length.split(':')
    if (parts.length === 2) {
        const minutes = parseInt(parts[0], 10)
        const seconds = parseInt(parts[1], 10)
        return minutes * 60 + seconds
    }
    return 0
}

function getBPMValue(bpm: string): number {
    const bpmValue = parseFloat(bpm)
    return isNaN(bpmValue) ? 0 : bpmValue
}

function compareVersions(versionA: string, versionB: string): number {
    const partsA = versionA.split('.').map(Number)
    const partsB = versionB.split('.').map(Number)

    for (let i = 0; i < Math.max(partsA.length, partsB.length); i++) {
        const diff = (partsA[i] || 0) - (partsB[i] || 0)
        if (diff !== 0) return diff
    }
    return 0
}
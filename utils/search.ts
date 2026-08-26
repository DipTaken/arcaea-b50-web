import { Chart } from '@/utils/types'

// takes in a list of charts and filters them based on search, level, and difficulty
export function filterCharts(charts: Chart[], search: string, levelFilter?: string | null, filterComparison: string | null = "ge", difficultyFilter?: number | null): Chart[] {
    const query = search.toLowerCase()
    //using this to compare levels since they are strings 
    const levelOrder = ['1', '2', '3', '4', '5', '6', '7', '7+', '8', '8+', '9', '9+', '10', '10+', '11', '11+', '12'] 
    const levelIndex = levelFilter ? levelOrder.indexOf(levelFilter) : -1
    const comparisonOp = filterComparison ? getComparisonOp(filterComparison) : null

    return charts.filter((chart) => {
        //matching search against either the title or song_id of the chart, ignoring case and using partial matches
        const matchesSearch =
            chart.title.toLowerCase().includes(query) ||
            chart.song_id.toLowerCase().includes(query)

        //matching level and difficulty filters
        const chartIndex = levelOrder.indexOf(chart.level)
        const matchesLevel = comparisonOp && levelIndex >= 0 ? comparisonOp(chartIndex, levelIndex) : true
        const matchesDifficulty = difficultyFilter ? getDifficultyValue(chart.difficulty) === difficultyFilter : true

        return matchesSearch && matchesLevel && matchesDifficulty
    })
}

export function sortCharts(charts: Chart[], sortOption: string | null = 'chartConstant', sortDirection: 'asc' | 'desc' = 'desc'): Chart[] {
    let sortedCharts: Chart[]
    //sorting the charts based on the selected sort option and direction
    switch (sortOption) {
        case 'title':
            sortedCharts = charts.slice().sort((a, b) => a.title.localeCompare(b.title))
            break
        case 'chartConstant':
            sortedCharts = charts.slice().sort((a, b) => (a.chart_constant ?? 0) - (b.chart_constant ?? 0))
            break
        case 'difficulty':
            sortedCharts = charts.slice().sort((a, b) => getDifficultyValue(a.difficulty) - getDifficultyValue(b.difficulty))
            break
        case 'artist':
            sortedCharts = charts.slice().sort((a, b) => a.artist.localeCompare(b.artist))
            break
        case 'length':
            sortedCharts = charts.slice().sort((a, b) => getLengthValue(a.length) - getLengthValue(b.length))
            break
        case 'bpm':
            sortedCharts = charts.slice().sort((a, b) => getBPMValue(a.bpm) - getBPMValue(b.bpm))
            break
        case 'noteCount':
            sortedCharts = charts.slice().sort((a, b) => a.note_count - b.note_count)
            break
        case 'version':
            sortedCharts = charts.slice().sort((a, b) => compareVersions(a.version, b.version))
            break
        default:
            sortedCharts = charts.slice()
    }
    return sortDirection === 'asc' ? sortedCharts : sortedCharts.reverse()
}

// converts the filterComparison string into a comparison function
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

// returns a string representation of the chart's value based on the sort option
export function getSortDisplayValue(chart: Chart, sortOption: string | null): string {
    switch (sortOption) {
        case 'chartConstant':
            return "Chart Constant: " + (chart.chart_constant ? chart.chart_constant.toFixed(1) : "N/A") // some charts may not have a cc
        case 'difficulty':
            return "Difficulty: " + chart.difficulty
        case 'artist':
            return "Artist: " + chart.artist
        case 'bpm':
            return "BPM: " + chart.bpm
        case 'length':
            return "Length: " + chart.length
        case 'noteCount':
            const noteCount = chart.note_count ? chart.note_count.toString() : "N/A"
            return "Note Count: " + noteCount
        case 'version':
            return "Version: " + chart.version
        default:
            return ""
    }
}

// converts difficulty string to a number for sorting purposes
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

// converts length string to a number for sorting purposes
function getLengthValue(length: string): number {
    const parts = length.split(':')
    if (parts.length === 2) {
        const minutes = parseInt(parts[0], 10)
        const seconds = parseInt(parts[1], 10)
        return minutes * 60 + seconds
    }
    return 0
}

// converts bpm string to a number for sorting purposes
function getBPMValue(bpm: string): number {
    const bpmValue = parseFloat(bpm)
    return isNaN(bpmValue) ? 0 : bpmValue
}

// compares two version strings
function compareVersions(versionA: string, versionB: string): number {
    const partsA = versionA.split('.').map(Number)
    const partsB = versionB.split('.').map(Number)

    for (let i = 0; i < Math.max(partsA.length, partsB.length); i++) {
        const diff = (partsA[i] || 0) - (partsB[i] || 0)
        if (diff !== 0) return diff
    }
    return 0
}
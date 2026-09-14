import { Chart } from '@/utils/types'
import { LEVEL_LIST, SORT_OPTIONS } from '@/utils/constants'
import { getDifficultyValue, getComparisonOp } from '@/utils/sortOptions'

// takes in a list of charts and filters them based on search, level, and difficulty
export function filterCharts(charts: Chart[], search: string, levelFilter?: string | null, filterComparison: string | null = "ge", difficultyFilter?: number | null): Chart[] {
    const query = search.toLowerCase()
    //using this to compare levels since they are strings 

    const levelIndex = levelFilter ? LEVEL_LIST.indexOf(levelFilter) : -1
    const comparisonOp = filterComparison ? getComparisonOp(filterComparison) : null

    return charts.filter((chart) => {
        //matching search against either the title or song_id of the chart, ignoring case and using partial matches
        const matchesSearch =
            chart.title.toLowerCase().includes(query) ||
            chart.song_id.toLowerCase().includes(query)

        //matching level and difficulty filters
        const chartIndex = LEVEL_LIST.indexOf(chart.level)
        const matchesLevel = comparisonOp && levelIndex >= 0 ? comparisonOp(chartIndex, levelIndex) : true
        const matchesDifficulty = difficultyFilter ? getDifficultyValue(chart.difficulty) === difficultyFilter : true

        return matchesSearch && matchesLevel && matchesDifficulty
    })
}

export function sortCharts(charts: Chart[], sortOption: string | null = 'chartConstant', sortDirection: 'asc' | 'desc' = 'desc'): Chart[] {
    //sorting the charts based on the selected sort option and direction
    const found = SORT_OPTIONS.find((option) => option.key === sortOption)
    if (!found) {
        return charts
    }
    const sortOrder = sortDirection === 'asc' ? 1 : -1
    const sortedCharts = charts.slice().sort((a, b) => sortOrder * found.sortFn(a, b)) //using sortOrder to reverse the sort direction
    return sortedCharts
}

// returns a string representation of the chart's value based on the sort option
export function getSortDisplayValue(chart: Chart, sortOption: string | null): string {
    const displayValue = SORT_OPTIONS.find((option) => option.key === sortOption)
    if (!displayValue) {
        return ''
    }
    return displayValue.displayFn(chart)
}
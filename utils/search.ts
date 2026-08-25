import { Chart } from '@/utils/types'

export function filterCharts(charts: Chart[], search: string) {
    const query = search.toLowerCase()
    return charts.filter((chart) =>
        chart.title.toLowerCase().includes(query) ||
        chart.song_id.toLowerCase().includes(query)
    )
}
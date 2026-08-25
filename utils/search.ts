import { Chart } from '@/utils/types'

export function filterByTitle(charts: Chart[], search: string) {
    return charts.filter((chart) => chart.title.toLowerCase().includes(search.toLowerCase()))      
}
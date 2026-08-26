'use client'

import { useState } from 'react'
import { filterCharts } from '@/utils/search'
import { Chart } from '@/utils/types'
import { useSetSelectedChart } from './AddScoreButton'

interface ChartSearchProps {
    charts: Chart[]
}

export default function ChartSearch({ charts }: ChartSearchProps) {
    const [search, setSearch] = useState('')
    //track the selected chart
    const [selectedId, setSelectedId] = useState<number | null>(null)
    //filter charts based on search input, ignoring case and using partial matches
    const filteredCharts = filterCharts(charts, search)
    const setSelectedChart = useSetSelectedChart()

    return (
        <div>
            {/* Display the selected chart */}
            {selectedId && (
                <p>
                    Selected: {charts.find((c) => c.id === selectedId)?.title} — {charts.find((c) => c.id === selectedId)?.difficulty}
                </p>
            )}

            {/* Input field for searching charts */}
            <input
                type="text"
                placeholder="Search charts..."
                value={search}
                className="w-full h-10 text-center"
                onChange={(e) => setSearch(e.target.value)}
            />

            {/* this displays the charts, but we also need to map it to the chart id in the database
                also only displays if there are results and if user has typed anything */}
            {search && filteredCharts.length > 0 && (
                <ul className="absolute left-10 right-10 z-50 max-h-55 overflow-y-auto bg-gray-600 rounded-md p-2 mt-2 scrollbar-thin scrollbar-thumb-gray-400 scrollbar-track-gray-700">
                    {filteredCharts.map((chart) => (
                        <li
                            key={chart.id}
                            onClick={() => {
                                setSelectedId(chart.id)
                                setSearch('')
                                setSelectedChart(chart)
                            }}
                            style={{
                                fontWeight: chart.id === selectedId ? 'bold' : 'normal',
                                cursor: 'pointer',
                            }}
                            className="p-2 hover:bg-gray-700 rounded-md text-left"
                        > {chart.title} — {chart.difficulty}
                        </li>
                    ))}
                </ul>
            )}
            
            {/* Hidden input for chart id */}
            <input type="hidden" name="chart_id" value={selectedId ?? ''} />
        </div>
    )
}
'use client'

import { useState } from 'react'

type Chart = {
    id: number
    title: string
    difficulty: string
}

export default function ChartSearch({ charts }: { charts: Chart[] }) {
    const [search, setSearch] = useState('')
    //track the selected chart
    const [selectedId, setSelectedId] = useState<number | null>(null)
    //filter charts based on search input, ignoring case and using partial matches
    const filteredCharts = charts.filter((chart) =>
        chart.title.toLowerCase().includes(search.toLowerCase())
    )
    
    return (
        <div>
            
            {selectedId && (
                <p>
                    Selected: {charts.find((c) => c.id === selectedId)?.title + ' — ' + charts.find((c) => c.id === selectedId)?.difficulty}
                </p>
            )}

            <input 
                type="text" 
                placeholder="Search charts..." 
                value={search} 
                onChange={(e) => setSearch(e.target.value)}
            />

            {/* this displays the charts, but we also need to map it to the chart id in the database
                also only displays if there are results and if user has typed anything */}
            { search && filteredCharts.length > 0  && (
            <ul>
                {filteredCharts.map((chart) => (
                    <li 
                        key={chart.id}
                        onClick={() => {
                            {/* for debugging */}
                            console.log('clicked', chart.id, chart.title) 
                            setSelectedId(chart.id)}
                        }
                        style={{
                            fontWeight: chart.id === selectedId ? 'bold' : 'normal',
                            cursor: 'pointer',
                        }}
                    >
                        {chart.title} — {chart.difficulty}
                    </li>
                ))}
            </ul>
            )}
            <input type="hidden" name="chart_id" value={selectedId ?? ''} />
        </div>
    )
}
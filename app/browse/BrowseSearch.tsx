'use client'

import { useState } from 'react'
import { filterCharts } from '@/utils/search'
import { Chart } from '@/utils/types'
import BrowseCard from './BrowseCard'

export default function BrowseSearch({ charts }: { charts: Chart[] }) {
    const [search, setSearch] = useState('')
    //filter charts based on search input, ignoring case and using partial matches
    const filteredCharts = filterCharts(charts, search)
    
    return (
        <div className="flex flex-col items-center justify-center gap-10 py-5">
            <input 
                type="text" 
                placeholder="Search charts..." 
                value={search} 
                className="w-full h-10 text-center"
                onChange={(e) => setSearch(e.target.value)}
            />
            <ul className="grid grid-cols-[repeat(5,230px)] gap-y-10 w-fit justify-items-center mx-auto">
                {filteredCharts.map((chart) => (
                <BrowseCard key={chart.id} chart={chart}/>
              ))}
            </ul>
        </div>
    )
}
'use client'

import { useState } from 'react'
import { filterCharts, getSortDisplayValue, sortCharts } from '@/utils/search'
import { Chart } from '@/utils/types'
import BrowseCard from './BrowseCard'

export default function BrowseSearch({ charts }: { charts: Chart[] }) {
    const [search, setSearch] = useState('')
    const [levelFilter, setLevelFilter] = useState<string | null>(null)
    const [sortOption, setSortOption] = useState<string | null>('cc')
    const [filterComparison, setFilterComparison] = useState<string | null>('ge')
    const [sortDirection, setSortDirection] = useState<'asc' | 'desc'>('desc')
    const [difficultyFilter, setDifficultyFilter] = useState<number | null>(null)
    
    
    //filter charts based on search input, ignoring case and using partial matches
    const filteredCharts = sortCharts(filterCharts(charts, search, levelFilter, filterComparison, difficultyFilter), sortOption, sortDirection)
    
    
    return (
        <div className="flex flex-col items-center justify-center gap-10 py-5">
            <input 
                type="text" 
                placeholder="Search charts..." 
                value={search} 
                className="w-full h-10 text-center"
                onChange={(e) => setSearch(e.target.value)}
            />
            <div className="flex items-center justify-between gap-6 h-30 border-1 p-4 rounded-lg"> 
                <div className="flex items-center justify-center gap-0">
                    <select className="bg-gray-700 text-white text-center p-6 py-4 rounded-md border-2 "
                        onChange={(e) => setSortOption(e.target.value)}>
                        <option value="" hidden >Sort by...</option>
                        <option value="t">Title</option>
                        <option value="cc">Chart Constant</option>
                        <option value="dif">Difficulty</option>
                        <option value="art">Artist</option>
                        <option value="bpm">BPM</option>
                        <option value="len">Length</option>
                        <option value="nc">Note Count</option>
                        <option value="ver">Version</option>
                    </select>
                
                    <button className="bg-gray-700 text-white text-center p-6 py-4 rounded-md border-2"
                        onClick={() => setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc')}>
                        {sortDirection === 'asc' ? '↑' : '↓'}
                    </button>
                </div>

                <div className="flex items-center justify-center gap-0">
                    <select className="bg-gray-700 text-white text-center p-2 py-4 rounded-md border-2"
                        onChange={(e) => setFilterComparison(e.target.value)}>
                        <option value="eq" hidden >=</option>
                        <option value="lt"> {'<'} </option>
                        <option value="le">{'<='}</option>
                        <option value="eq">=</option>
                        <option value="ge">{'>='}</option>
                        <option value="gt">{'>'}</option>
                    </select>

                    <select className="bg-gray-700 text-white text-center p-6 py-4 rounded-md border-2"
                        onChange={(e) => setLevelFilter(e.target.value)}>
                        <option value="" >Level</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="7+">7+</option>
                        <option value="8">8</option>
                        <option value="8+">8+</option>
                        <option value="9">9</option>
                        <option value="9+">9+</option>
                        <option value="10">10</option>
                        <option value="10+">10+</option>
                        <option value="11">11</option>
                        <option value="11+">11+</option>
                        <option value="12">12</option>
                    </select>
                </div>

                <select className="bg-gray-700 text-white text-center p-6 py-4 rounded-md border-2"
                    onChange={(e) => setDifficultyFilter(Number(e.target.value))}>
                    <option value="" >Difficulty</option>
                    <option value="1">PST</option>
                    <option value="2">PRS</option>
                    <option value="3">FTR</option>
                    <option value="4">ETR</option>
                    <option value="5">BYD</option>
                </select>
            </div>
            <ul className="grid grid-cols-[repeat(5,230px)] gap-y-10 w-fit justify-items-center mx-auto">
                {filteredCharts.map((chart) => (
                <BrowseCard key={chart.id} info={getSortDisplayValue(chart, sortOption)} chart={chart}/>
              ))}
            </ul>
        </div>
    )
}
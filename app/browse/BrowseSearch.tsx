'use client'

import { useState } from 'react'
import { filterCharts } from '@/utils/search'
import { Chart } from '@/utils/types'
import BrowseCard from './BrowseCard'

export default function BrowseSearch({ charts }: { charts: Chart[] }) {
    const [search, setSearch] = useState('')
    const [levelFilter, setLevelFilter] = useState<string | null>(null)
    const [sortOption, setSortOption] = useState<string | null>(null)
    const [filterComparison, setFilterComparison] = useState<string | null>(null)

    const levelOrder = ['1', '2', '3', '4', '5', '6', '7', '7+', '8', '8+', '9', '9+', '10', '10+', '11', '11+', '12']
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
            <div className="flex gap-2"> 
                <select className="bg-gray-700 text-white text-center rounded-md w-full border-2"
                    onChange={(e) => setSortOption(e.target.value)}>
                    <option value=""  >Sort by...</option>
                    <option value="cc">Chart Constant</option>
                </select>
                <select className="bg-gray-700 text-white text-center rounded-md w-full border-2"
                    onChange={(e) => setFilterComparison(e.target.value)}>
                    <option value=""  >Filter by...</option>
                    <option value="lt"> {'<'} </option>
                    <option value="le">{'<='}</option>
                    <option value="eq">=</option>
                    <option value="ge">{'>='}</option>
                    <option value="gt">{'>'}</option>
                </select>
                <select className="bg-gray-700 text-white text-center rounded-md w-full border-2"
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
            <ul className="grid grid-cols-[repeat(5,230px)] gap-y-10 w-fit justify-items-center mx-auto">
                {filteredCharts.map((chart) => (
                <BrowseCard key={chart.id} chart={chart}/>
              ))}
            </ul>
        </div>
    )
}
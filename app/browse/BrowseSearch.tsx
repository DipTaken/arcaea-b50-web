'use client'

import { useEffect, useRef, useState } from 'react'
import { filterCharts, getSortDisplayValue, sortCharts } from '@/utils/search'
import { Chart } from '@/utils/types'
import BrowseCard from './BrowseCard'
import BrowseModal from './BrowseModal'

const CARDS_PER_PAGE = 100

export default function BrowseSearch({ charts }: { charts: Chart[] }) {
    const [search, setSearch] = useState('')
    const [levelFilter, setLevelFilter] = useState<string | null>(null)
    const [sortOption, setSortOption] = useState<string | null>('chartConstant')
    const [filterComparison, setFilterComparison] = useState<string | null>('eq')
    const [sortDirection, setSortDirection] = useState<'asc' | 'desc'>('desc')
    const [difficultyFilter, setDifficultyFilter] = useState<number | null>(null)

    const [selectedChart, setSelectedChart] = useState<Chart | null>(null)
    const dialogRef = useRef<HTMLDialogElement>(null)

    // Open the shared dialog once the newly selected chart has rendered into it.
    useEffect(() => {
        if (selectedChart) dialogRef.current?.showModal()
    }, [selectedChart])

    // How many of the filtered charts are currently rendered.
    const [visibleCount, setVisibleCount] = useState(CARDS_PER_PAGE)

    // reset the loaded count whenever the filters change
    const filterKey = `${search}|${levelFilter}|${filterComparison}|${difficultyFilter}|${sortOption}|${sortDirection}`
    const [prevFilterKey, setPrevFilterKey] = useState(filterKey)
    if (prevFilterKey !== filterKey) {
        setPrevFilterKey(filterKey)
        setVisibleCount(CARDS_PER_PAGE)
    }

    //filter charts based on search input, ignoring case and using partial matches
    const filteredCharts = sortCharts(filterCharts(charts, search, levelFilter, filterComparison, difficultyFilter), sortOption, sortDirection)
    const visibleCharts = filteredCharts.slice(0, visibleCount)

    return (
        <div className="flex flex-col items-center justify-center gap-5">
            <div className="flex flex-col items-center justify-center gap-1 rounded-lg p-4">
                {/* Search Input */}
                <input
                    type="text"
                    placeholder="Search charts..."
                    value={search}
                    className="w-full h-15 text-center text-xl border-2 border-gray-400 rounded-md"
                    onChange={(e) => setSearch(e.target.value)}
                />
                {/* Sort and Filter Options */}
                <div className="flex items-center justify-center gap-6 h-20 w-full rounded-lg">
                    {/* Sort Options */}
                    <div className="flex  items-center justify-center gap-1">
                        <select className=" bg-gray-800 text-white text-center p-6 py-3 border-gray-400 rounded-md border-2  "
                            onChange={(e) => setSortOption(e.target.value)}>
                            <option value="" hidden >Sort by...</option>
                            <option value="title">Title</option>
                            <option value="chartConstant">Chart Constant</option>
                            <option value="difficulty">Difficulty</option>
                            <option value="artist">Artist</option>
                            <option value="bpm">BPM</option>
                            <option value="length">Length</option>
                            <option value="noteCount">Note Count</option>
                            <option value="version">Version</option>
                        </select>

                        {/* Sort Direction Button */}
                        <button className="bg-gray-800 text-white text-center p-5 py-3 border-gray-400 rounded-md border-2 "
                            onClick={() => setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc')}>
                            {sortDirection === 'asc' ? '↑' : '↓'}
                        </button>
                    </div>

                    {/* Filter Options */}
                    <div className="flex items-center justify-center gap-1">
                        {/* Filter Comparison */}
                        <select className="bg-gray-800 text-white text-center p-2 py-3 border-gray-400 rounded-md border-2 "
                            onChange={(e) => setFilterComparison(e.target.value)}>
                            <option value="eq" hidden >=</option>
                            <option value="lt"> {'<'} </option>
                            <option value="le">{'≤'}</option>
                            <option value="eq">=</option>
                            <option value="ge">{'≥'}</option>
                            <option value="gt">{'>'}</option>
                        </select>

                        {/* Level Filter */}
                        <select className="bg-gray-800 text-white text-center p-6 py-3 border-gray-400 rounded-md border-2 "
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

                    {/* Difficulty Filter */}
                    <select className="bg-gray-800 text-white text-center p-6 py-3 border-gray-400 rounded-md border-2 "
                        onChange={(e) => setDifficultyFilter(Number(e.target.value))}>
                        <option value="" >Difficulty</option>
                        <option value="1">PST</option>
                        <option value="2">PRS</option>
                        <option value="3">FTR</option>
                        <option value="4">ETR</option>
                        <option value="5">BYD</option>
                    </select>
                </div>
            </div>

            {/* Chart List */}
            <ul className="grid grid-cols-[repeat(5,230px)] gap-y-10 w-fit justify-items-center mx-auto">
                {visibleCharts.map((chart) => (
                    <BrowseCard key={chart.id} info={getSortDisplayValue(chart, sortOption)} chart={chart} onSelect={setSelectedChart} />
                ))}
            </ul>

            {/* Only shown while some of the filtered charts are still unrendered */}
            {filteredCharts.length > visibleCount && (
                <button
                    onClick={() => setVisibleCount(visibleCount + CARDS_PER_PAGE)}
                    className="bg-gray-800 hover:bg-gray-600 text-white text-center p-6 py-4 rounded-md border-2"
                >
                    Load More ({filteredCharts.length - visibleCount} remaining)
                </button>
            )}
            
            {/* The single modal shared by every card in the grid */}
            <BrowseModal chart={selectedChart} ref={dialogRef} onClose={() => setSelectedChart(null)} />
        </div>
    )
}
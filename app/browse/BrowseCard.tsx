'use client'

import { getDifficultyColor, getTextSize } from '@/utils/style'
import { Chart } from '@/utils/types'
import { bgColor } from '@/utils/style'
import { getJacketUrl } from '@/utils/jacket'

// A single chart in the browse grid. The card owns no modal of its own — clicking it just
// reports the chart upward, and BrowseSearch opens the one shared modal.
export default function BrowseCard({ chart, info, onSelect }: { chart: Chart, info: string, onSelect: (chart: Chart) => void }) {
    return (
        // Chart Card
        <li
            className={`relative flex flex-col justify-between w-[200px] h-[150px] ${bgColor} rounded-md border-2 bg-cover bg-center cursor-pointer hover:scale-105 transition-transform duration-200 ease-in-out`}
            style={{
                // set the background image to the jacket of the chart
                backgroundImage: `url(${getJacketUrl(chart.song_id, chart.difficulty, chart.jacket_override)})`,
                // set the border color to the difficulty color of the chart
                borderColor: getDifficultyColor(chart.difficulty ?? "")
            }}
            onClick={() => onSelect(chart)}
        >

            {/* Difficulty and Level (displayed in the top-left corner) */}
            <div className={`absolute z-20 -top-3 -left-3 w-[80px] h-[30px] flex items-center justify-center ${bgColor} text-[15px] p-1 rounded-sm border-2`}
                style={{ borderColor: getDifficultyColor(chart.difficulty ?? "") }}>
                {chart.difficulty}  {chart.level}
            </div>

            {/* Gradient overlay */}
            <div className="absolute inset-0 z-0"
                style={{ backgroundImage: `linear-gradient(to top, ${getDifficultyColor(chart.difficulty ?? "")}b3 10%, transparent)` }}>
            </div>

            {/* Dynamic Info (displayed above title ) */}
            <div className="absolute z-30 bottom-11 left-2 right-2 text-base font-bold text-shadow-lg/60 truncate">
                {info}
            </div>

            {/* Title and Constant (displayed in the bottom) */}
            <div style={{ backgroundColor: getDifficultyColor(chart.difficulty ?? "") }}
                className="absolute z-10 bottom-0 left-0 w-full h-10"
            >
                <div className={`flex flex-col justify-center line-clamp-2 w-3/4 h-full p-2 ${getTextSize(chart.title ?? "")}`}> {chart.title} </div>
                <div className="absolute bottom-0 right-1 text-right"> {chart.chart_constant?.toFixed(1)} </div>
            </div>
        </li>
    )
}

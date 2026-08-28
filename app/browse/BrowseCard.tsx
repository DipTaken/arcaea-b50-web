'use client'

import { getDifficultyColor } from '@/utils/style'
import { Chart } from '@/utils/types'
import { getJacketUrl } from '@/utils/jacket'
import { Card, CardPill, CardBottomBar } from '@/app/components/Card'

// A single chart in the browse grid. The card owns no modal of its own — clicking it just
// reports the chart upward, and BrowseSearch opens the one shared modal.
export default function BrowseCard({ chart, info, onSelect }: { chart: Chart, info: string, onSelect: (chart: Chart) => void }) {
    const accent = getDifficultyColor(chart.difficulty ?? "")
    
    return (
        // Chart Card
        <Card accent={accent} 
            jacketUrl={getJacketUrl(chart.song_id, chart.difficulty, chart.jacket_override)} 
            onClick={() => onSelect(chart)}
        >
            {/* Difficulty and level (top left) */}
            <CardPill accent={accent}
                wide={true}>
                {chart.difficulty}  {chart.level}
            </CardPill>

            {/* Gradient overlay */}
            <div className="absolute inset-0 z-0"
                style={{ backgroundImage: `linear-gradient(to top, ${getDifficultyColor(chart.difficulty ?? "")}b3 10%, transparent)` }}>
            </div>

            {/* Dynamic Info (displayed above title ) */}
            <div className="absolute z-30 bottom-11 left-2 right-2 text-base font-bold text-shadow-lg/60 truncate">
                {info}
            </div>

            {/* Title and Constant (displayed in the bottom) */}
            <CardBottomBar accent={accent} 
                title={chart.title}
                constant={chart.chart_constant}
            />
        </Card>
    )
}

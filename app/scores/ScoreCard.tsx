'use client'

import { getGrade, getPlayRating, getClearStatus } from '@/utils/rating'
import { getDifficultyColor, getClearStatusColor, getGradeColor } from '@/utils/style'
import { getJacketUrl } from '@/utils/jacket'
import { B50Entry } from '@/utils/types'
import { Card, CardPill, CardBottomBar } from '@/app/components/Card'

//A single score card
export default function ScoreCard({ entry, onSelect }: { entry: B50Entry, onSelect: (entry: B50Entry) => void }) {
    const accent = getDifficultyColor(entry.score.charts?.difficulty ?? "")
    const clearStatusColor = getClearStatusColor(entry.score.clear_status)
    return (
        <Card accent={accent}
            onClick={() => onSelect(entry)}
        >
            {/* Rank number (top left) */}
            <CardPill accent={accent}>
                {`#${entry.rank}`}
            </CardPill>

            {/* Grade and rating (center left) */}
            <div className="absolute z-40 top-4 bottom-13 left-2 flex flex-col justify-between w-[94px]">
                <div style={{ color: getGradeColor(getGrade(entry.score.score, entry.score.charts?.note_count, entry.score.pure, entry.score.far, entry.score.lost)) }}
                    className="text-[32px] font-extrabold"> 
                    {getGrade(entry.score.score, entry.score.charts?.note_count, entry.score.pure, entry.score.far, entry.score.lost)}
                </div>
                <div className="flex gap-2 items-center w-14">
                    <span className="text-[18px] font-bold">{entry.playRating.toFixed(2)} </span>
                    <span className="text-sm text-white font-bold rounded-sm px-2" 
                        style={{ backgroundColor: `color-mix(in srgb, ${clearStatusColor} 30%, var(--color-card))`,
                        color: clearStatusColor }}>
                        {getClearStatus(entry.score.clear_status)}
                    </span>
                </div>
            </div>

            {/* Jacket and score (right) */}
            <div className="absolute right-0">
                <img src={getJacketUrl(entry.score.charts?.song_id, entry.score.charts?.difficulty, entry.score.charts?.jacket_override)}
                    alt="Song jacket"
                    className="object-cover w-[106px] h-[106px] ">
                </img>
                <div className="absolute z-10 bottom-0 left-0 flex flex-col justify-center w-full bg-linear-to-t from-black/70 from-60% to-transparent text-[18px] font-light p-1">
                    {entry.score.score.toLocaleString()}
                </div>
            </div>

            {/* Chart title and constant (bottom) */}
            <CardBottomBar accent={accent}
                title={entry.score.charts?.title}
                constant={entry.score.charts?.chart_constant}
            />
        </Card>
    )
}

'use client'

import { getGrade, getPlayRating } from '@/utils/rating'
import { getDifficultyColor, getTextSize, getGradeColor } from '@/utils/style'
import { getJacketUrl } from '@/utils/jacket'
import { ScoreWithChart } from '@/utils/types'
import { Card, CardPill, CardBottomBar } from '@/app/components/Card'

//A single score card
export default function ScoreCard({ score, index, onSelect }: { score: ScoreWithChart, index: number, onSelect: (score: ScoreWithChart) => void }) {
    const accent = getDifficultyColor(score.charts?.difficulty ?? "")
    return (
        <Card accent={accent}
            onClick={() => onSelect(score)}
        >
            {/* Rank number (top left) */}
            <CardPill accent={accent}>
                {'#' + (index + 1)}
            </CardPill>

            {/* Grade and rating (center left) */}
            <div className="absolute z-10 top-3 bottom-10 left-1 flex flex-col justify-center p-1 w-[94px]">
                <div style={{ color: getGradeColor(getGrade(score.score, score.charts?.note_count, score.pure, score.far, score.lost)) }}
                    className="flex-1 text-[32px] font-extrabold"> {getGrade(score.score, score.charts?.note_count, score.pure, score.far, score.lost)}
                </div>
                <div className="absolute bottom-1 left-0 p-1 text-[20px] font-bold">
                    {getPlayRating(score.score, score.charts?.chart_constant).toFixed(2)}
                </div>
            </div>

            {/* Jacket and score (right) */}
            <div className="absolute right-0">
                <img src={getJacketUrl(score.charts?.song_id, score.charts?.difficulty, score.charts?.jacket_override)}
                    alt="Song jacket"
                    className="object-cover w-[106px] h-[106px] ">
                </img>
                <div className="absolute z-10 bottom-0 left-0 flex flex-col justify-center w-full bg-linear-to-t from-black/70 from-60% to-transparent text-[18px] font-light p-1">
                    {score.score.toLocaleString()}
                </div>
            </div>

            {/* Chart title and constant (bottom) */}
            <CardBottomBar accent={accent}
                title={score.charts?.title}
                constant={score.charts?.chart_constant}
            />
        </Card>
    )
}

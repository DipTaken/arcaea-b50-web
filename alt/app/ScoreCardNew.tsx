'use client'

import { getGrade, getPlayRating } from '@/utils/rating'
import { getDifficultyColor, getTextSize } from '@/alt/utils/style copy'

export default function ScoreCard({ score, index }: { score: any, index: number }) {
    const bgColor = "bg-[#16222d]"
    
    return (
        <li key={score.id} className={`relative flex flex-col justify-between w-[200px] h-[150px] ${bgColor} rounded-md border-2 bg-[url('https://jkdyzmjuiojlitzvslmx.supabase.co/storage/v1/object/public/jackets/Testify.webp')] bg-cover bg-center bg-linear-to-t from-black/70 from-60% to-transparent`}>
            <div className="absolute inset-0 z-0"
                style={{
                    backgroundImage: `linear-gradient(to top, ${getDifficultyColor(score.charts?.difficulty ?? "")}b3 30%, transparent)`
                }}>
            </div>
        
            <div className={`absolute z-20 -top-3 -left-3 w-[40px] h-[30px] flex items-center justify-center ${bgColor} text-[15px] p-1 rounded-sm border-2`}>
                {'#' + (index + 1)}
            </div>  
            
            <div className={`absolute top-9 z-10 text-center font-bold w-full p-1 truncate ${getTextSize(score.charts?.title ?? "")}`}> {score.charts?.title} </div>
            
            <div className="absolute z-10 top-17 left-0 text-center w-full text-xl font-light p-1 ="> 
                {score.score.toLocaleString()}
            </div>

            <div className="absolute flex z-10 bottom-0 left-0 w-full h-10 text-[18px] font-light p-1">
                <div className="flex-none text-[32px] font-extrabold p-1 -my-3 "> {getGrade(score.score, score.charts?.note_count, score.pure, score.far, score.lost)} </div>
                <div className="flex-auto text-right py-2"> {score.charts?.chart_constant.toFixed(2)} {'->'} {getPlayRating(score.score, score.charts?.chart_constant).toFixed(2)} </div>               
            </div>
        </li>
    )
}

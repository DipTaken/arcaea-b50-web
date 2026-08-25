'use client'

import { getGrade, getPlayRating } from '@/utils/rating'
import { getDifficultyColor, getTextSize, getGradeColor } from '@/utils/style'

export default function BrowseCard({ chart }: { chart: any }) {
    const bgColor = "bg-[#16222d]"
    
    return (
        <li key={chart.id} className={`relative flex flex-col justify-between w-[200px] h-[150px] ${bgColor} rounded-md border-2 bg-[url('https://jkdyzmjuiojlitzvslmx.supabase.co/storage/v1/object/public/jackets/Testify.webp')] bg-cover bg-center bg-linear-to-t from-black/70 from-60% to-transparent`}
            style={{ borderColor: getDifficultyColor(chart.difficulty ?? "") }}>

            <div className="absolute inset-0 z-0"
                style={{ backgroundImage: `linear-gradient(to top, ${getDifficultyColor(chart.difficulty ?? "")}b3 10%, transparent)` }}>
            </div>

            <div className={`absolute z-20 -top-3 -left-3 w-[80px] h-[30px] flex items-center justify-center ${bgColor} text-[15px] p-1 rounded-sm border-2`}
                style={{ borderColor: getDifficultyColor(chart.difficulty ?? "") }}>
                {chart.difficulty}  {chart.level}
            </div>  
           
            <div style={{backgroundColor:getDifficultyColor(chart.difficulty ?? "")}} className="absolute z-10 bottom-0 left-0 w-full h-10">
                <div className={`flex flex-col justify-center line-clamp-2 w-3/4 h-full p-2 ${getTextSize(chart.title ?? "")}`}> {chart.title} </div>
                <div className="absolute bottom-0 right-1 text-right"> {chart.chart_constant?.toFixed(2)} </div>               
            </div>
        </li>
    )
}

'use client'

import { getGrade, getPlayRating } from '@/utils/rating'
import { getDifficultyColor, getTextSize, getGradeColor } from '@/utils/style'
import { bgColor } from '@/utils/style'
import { getJacketUrl } from '@/utils/jacket'

export default function ScoreCard({ score, index }: { score: any, index: number }) {
  return (
    <li key={score.id} className={`relative flex flex-col z-10 justify-between w-[200px] h-[150px] ${bgColor} rounded-md border-2`}
      style={{ borderColor: getDifficultyColor(score.charts?.difficulty ?? "") }}>
       
      <div className={`absolute z-20 -top-3 -left-3 w-[40px] h-[30px] flex items-center justify-center ${bgColor} text-[15px] p-1 rounded-sm border-2`}
        style={{ borderColor: getDifficultyColor(score.charts?.difficulty ?? "") }}>
        {'#' + (index + 1)}
      </div>  

      <div className="absolute z-10 top-3 bottom-10 left-1 flex flex-col justify-center p-1 w-[94px]">
        <div style={{ color: getGradeColor(getGrade(score.score, score.charts?.note_count, score.pure, score.far, score.lost)) }} 
          className="flex-1 text-[32px] font-extrabold"> {getGrade(score.score, score.charts?.note_count, score.pure, score.far, score.lost)}
        </div>
        <div className="absolute bottom-1 left-0 p-1 text-[20px] font-bold"> {getPlayRating(score.score, score.charts?.chart_constant).toFixed(2)} </div> 
      </div> 

      <div className="absolute right-0">
        <img src={getJacketUrl(score.charts?.song_id, score.charts?.difficulty, score.charts?.jacket_override)}
            alt="Song jacket" 
            className="z-0 right-0 object-cover w-[106px] h-[106px] ">
        </img>
        <div className="absolute z-10 bottom-0 left-0 flex flex-col justify-center w-full bg-linear-to-t from-black/70 from-60% to-transparent text-[18px] font-light p-1"> 
            {score.score.toLocaleString()}
        </div>
      </div>
           
      <div style={{backgroundColor:getDifficultyColor(score.charts?.difficulty ?? "")}} className="absolute z-10 bottom-0 left-0 w-full h-10">
        <div className={`flex flex-col justify-center line-clamp-2 w-3/4 h-full p-2 ${getTextSize(score.charts?.title ?? "")}`}> {score.charts?.title} </div>
        <div className="absolute bottom-0 right-1 text-right"> {score.charts?.chart_constant.toFixed(1)} </div>               
      </div>
    </li>
  )
}

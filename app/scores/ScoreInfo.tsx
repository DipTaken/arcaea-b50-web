import { ScoreWithChart } from '@/utils/types'
import { getPlayRating, getShinyPureCount, getPmRating, getGrade } from '@/utils/rating'
import { getGradeColor } from '@/utils/style'

export default function ScoreInfo({ score }: { score: ScoreWithChart }) {
    const flexClasses = "flex gap-4 items-center w-full text-white font-bold"    
    return (
        <div className="flex flex-col gap-4 p-4 justify-start items-center rounded-lg bg-gray-900 border-2 border-gray-600 w-full">
            <div className={`${flexClasses} text-2xl justify-start`}>
                <p>Score: {score.score.toLocaleString()}

                    <span className="text-base text-gray-400 font-normal">
                        {' ('} {getPmRating(score.score, score.charts?.note_count, score.far, score.lost)} {')'}
                    </span>
                </p>
                
                 <p>Play Rating: {getPlayRating(score.score, score.charts?.chart_constant).toFixed(2)}</p>

                 <p>
                    <span> {'Grade: '} </span>
                    <span style={{color: getGradeColor(getGrade(score.score, score.charts?.note_count, score.pure, score.far, score.lost))}}>
                        {getGrade(score.score, score.charts?.note_count, score.pure, score.far, score.lost)}
                    </span>
                 </p>
            </div>

            <div className={`${flexClasses} justify-start`}>
                <p>Pure: {score.pure ?? 'N/A'}</p>
                <p>Far: {score.far ?? 'N/A'}</p>
                <p>Lost: {score.lost ?? 'N/A'}</p>
            </div>
            
            
            <div className={`${flexClasses} justify-between`}>
                <p>Shiny Pures: {getShinyPureCount(score.score, score.charts?.note_count)}</p>
                <p className="justify-end text-sm">Achieved: {score.created_at ? new Date(score.created_at).toLocaleString() : 'N/A'} </p>
            </div>
           

        </div>
    )
}
import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import { getGuestIdReadOnly } from '@/utils/guest'
import { getGrade, getPlayRating } from '@/utils/rating'
import { getDifficultyColor } from '@/utils/style'
import AddScoreButton from './AddScoreButton'

export default async function Page() {
  const cookieStore = await cookies()
  const supabase = createClient(cookieStore)
  const guestId = await getGuestIdReadOnly()

  const { data: charts } = await supabase.from('charts').select().order('title')
  const { data: scores} = await supabase
    .from('scores')
    .select('*, charts(title, difficulty, chart_constant, note_count)')
    .eq('user_id', guestId)

  const sortedScores = scores?.slice()
    .sort((a, b) => 
      getPlayRating(b.score, b.charts?.chart_constant ?? 0) - 
      getPlayRating(a.score, a.charts?.chart_constant ?? 0)
    )
    .slice(0,50)

  return (
    <div>
      <AddScoreButton charts={charts ?? []} />
    <ul className="grid grid-cols-[repeat(5,230px)] gap-y-10 w-fit justify-items-center mx-auto">
        {sortedScores?.map((score) => (
            <li key={score.id} className="relative flex flex-col justify-between w-[200px] h-[150px] bg-sky-500/15 rounded-md border-2">
                
                <div className="absolute z-10 top-0 flex flex-col justify-center w-1/2 h-full border-2">
                  <div className="flex-1 text-[32px]"> {getGrade(score.score, score.charts?.note_count ?? 0, score.pure, score.far, score.lost)} </div>
                  <div className="flex-1"> {getPlayRating(score.score, score.charts?.chart_constant ?? 0).toFixed(2)} </div> 
                </div>

                <div className="absolute flex flex-col right-0 justify-between border-2">
                  <img src="https://jkdyzmjuiojlitzvslmx.supabase.co/storage/v1/object/public/jackets/Testify.webp" 
                      alt="Song jacket" 
                      className="z-0 right-0 object-cover w-[100px] h-[100px] ">
                  </img>
                  <div className="absolute flex-1 z-10 bottom-0 left-0 w-full bg-black/70 text-[15px] p-1"> 
                      {score.score.toLocaleString()}
                  </div>
                </div>
                
                <div style={{backgroundColor:getDifficultyColor(score.charts?.difficulty ?? "")}} className="absolute flex z-10 bottom-0 left-0 w-full h-10 border-2">
                  <div className="flex-1 justify-center border-1"> {score.charts?.title} </div>
                  <div className="absolute flex-none bottom-0 right-0 text-right"> {score.charts?.chart_constant.toFixed(2) ?? 0.00} </div>               
                </div>
            </li>
        ))}
      </ul>
    </div>
  )
}
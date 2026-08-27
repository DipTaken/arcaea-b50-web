import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import { getGuestIdReadOnly } from '@/utils/guest'
import { getPlayRating } from '@/utils/rating'
import AddScoreButton from './AddScoreButton'
import ImportFromBrowserButton from '@/app/scores/ImportFromBrowserButton'
import ChartSearch from './ChartSearch'
import ScoreGrid from './ScoreGrid'
import { getB50Rating } from '@/utils/rating'

export default async function Page() {
  const cookieStore = await cookies()
  const supabase = createClient(cookieStore)
  const guestId = await getGuestIdReadOnly()
  const { data: { user } } = await supabase.auth.getUser()
  const userId = user?.id ?? guestId

  const { data: charts } = await supabase.from('charts').select().order('title').limit(5000)
  const { data: scores } = await supabase
    .from('scores')
    .select('*, charts(*)')
    .eq('user_id', userId)
    .limit(5000)

    //B50 scores
    const sortedScores = scores?.slice()
    .sort((a, b) =>
      getPlayRating(b.score, b.charts?.chart_constant ?? 0) -
      getPlayRating(a.score, a.charts?.chart_constant ?? 0)
    )
    .slice(0, 50)

  return (
    <div className="flex flex-col items-center justify-center gap-4 py-10">
      <h1 className="text-3xl font-bold">B50 View</h1>
      <h2 className="text-xl font-light">Click on a score for more info</h2>
      <div className="flex justify-center items-center gap-4 p-4 ">
        <ImportFromBrowserButton>
          <AddScoreButton showSongInfo={false} sizeClasses="py-4 px-12">
            <div className={`bg-gray-500 text-white text-center rounded-md w-full border-2`}>
              <ChartSearch charts={charts ?? []} />
            </div>
          </AddScoreButton>
        </ImportFromBrowserButton>      
      </div>
      <div className="flex w-full items-start gap-4 px-50 p-4">
        <p className="font-bold text-xl border-2 border-gray-400 rounded-md bg-gray-800 text-white px-4 py-2"> 
          PTT: {getB50Rating(sortedScores ?? []).toFixed(2)} </p>
      </div>
      <ScoreGrid scores={sortedScores ?? []} />
    </div>
  )
}
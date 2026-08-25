import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import { getGuestIdReadOnly } from '@/utils/guest'
import { getPlayRating } from '@/utils/rating'
import ScoreCard from '@/app/ScoreCard'
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
    <div className="flex flex-col items-center justify-center gap-10 py-10">
      <AddScoreButton charts={charts ?? []} />
      <ul className="grid grid-cols-[repeat(5,230px)] gap-y-10 w-fit justify-items-center mx-auto">
          {sortedScores?.map((score, index) => (
            <ScoreCard key={score.id} score={score} index={index} />
          ))}
      </ul>
    </div>
  )
}
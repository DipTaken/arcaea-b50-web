import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import { getGuestIdReadOnly } from '@/utils/guest'
import { getGrade, getPlayRating } from '@/utils/rating'
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

  const sortedScores = scores?.slice().sort(
    (a, b) => (b.charts?.chart_constant ?? 0) - (a.charts?.chart_constant ?? 0)
  )

  return (
    <div>
      <AddScoreButton charts={charts ?? []} />
    <ul>
        {sortedScores?.map((score) => (
          <li 
            key = {score.id}>{score.charts?.title} {score.charts?.difficulty} — {score.score}  
              {' '} {getGrade(score.score, score.charts?.note_count ?? 0, score.pure, score.far, score.lost)} 
              {' '}({score.charts?.chart_constant ?? 0} {'->'} {getPlayRating(score.score, score.charts?.chart_constant ?? 0).toFixed(2)}) 
          </li>
        ))}
      </ul>
    </div>
  )
}
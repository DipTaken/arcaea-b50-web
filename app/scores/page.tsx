import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import { getGuestIdReadOnly } from '@/utils/guest'
import { getB50FromScores } from '@/utils/rating'
import AddScoreButton from './AddScoreButton'
import ImportFromBrowserButton from '@/app/scores/ImportFromBrowserButton'
import ChartSearch from './ChartSearch'
import ScoreGrid from './ScoreGrid'
import { getB50Rating } from '@/utils/rating'
import { PageShell } from '@/app/components/PageShell'

export default async function Page() {
  const cookieStore = await cookies()
  const supabase = createClient(cookieStore)
  const guestId = await getGuestIdReadOnly()
  const { data: { user } } = await supabase.auth.getUser()
  const userId = user?.id ?? guestId

  const { data: charts } = await supabase.from('charts').select().limit(5000)
  const { data: scores } = await supabase
    .from('scores')
    .select('*, charts(*)')
    .eq('user_id', userId)
    .limit(5000)

  const b50Scores = getB50FromScores(scores ?? [])

  return (
    <PageShell
      title="B50 View"
      subtitle="Click on a score for more info">

      <div className="flex justify-center items-center gap-4 p-4">
        <ImportFromBrowserButton>
          <AddScoreButton showSongInfo={false} size='md'>
            <div className="bg-gray-500 text-white text-center rounded-md w-full border-2">
              <ChartSearch charts={charts ?? []} />
            </div>
          </AddScoreButton>
        </ImportFromBrowserButton>
      </div>

      <div className="mx-auto flex w-full max-w-6xl flex-col items-start gap-4 p-4">
        <p className="font-bold text-xl border-2 border-gray-400 rounded-md bg-gray-800 text-white px-4 py-2">
          B50: {getB50Rating(b50Scores).toFixed(3)} </p>
      </div>
      <ScoreGrid entries={b50Scores} />

    </PageShell>
  )
}
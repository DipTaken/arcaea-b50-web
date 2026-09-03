import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import { getB50FromScores } from '@/utils/rating'
import AddScoreButton from './AddScoreButton'
import ChartSearch from './ChartSearch'
import ScoreGrid from './ScoreGrid'
import { getB50Rating } from '@/utils/rating'
import { PageShell } from '@/app/components/PageShell'
import ImportCSVButton from './ImportCSVButton'

export default async function Page() {
  const cookieStore = await cookies()
  const supabase = createClient(cookieStore)

  //grab the user from supabase
  const { data: { user: user } } = await supabase.auth.getUser()

  const { data: charts } = await supabase
    .from('charts')
    .select()
    .limit(5000)
    .order('id')

  //if the user is signed in, get their scores, otherwise return an empty array
  const { data: scores } = user ? await supabase
    .from('scores')
    .select('*, charts(*)')
    .eq('user_id', user.id)
    .limit(5000)
    : { data: [] }

  const b50Scores = getB50FromScores(scores ?? [])

  return (
    <PageShell
      title="B50 View"
      subtitle="Click on a score for more info">

      <div className="flex justify-center items-center gap-4 p-4">
        <AddScoreButton showSongInfo={false} size='lg'>
          <div className="bg-gray-500 text-white text-center rounded-md w-full border-2">
            <ChartSearch charts={charts ?? []} />
          </div>
        </AddScoreButton>

        <ImportCSVButton charts={charts ?? []} />
      </div>

      <div className="mx-auto flex w-full max-w-6xl flex-col items-start gap-4 p-4">
        <p className="font-bold text-xl border-2 border-gray-400 rounded-md bg-gray-800 text-white px-4 py-2">
          B50: {getB50Rating(b50Scores).toFixed(3)} </p>
      </div>
      <ScoreGrid entries={b50Scores} />

    </PageShell>
  )
}
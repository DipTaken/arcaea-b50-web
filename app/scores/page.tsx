import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import { getGuestIdReadOnly } from '@/utils/guest'
import { getPlayRating } from '@/utils/rating'
import AddScoreButton from './AddScoreButton'
import ImportFromBrowserButton from '@/app/scores/ImportFromBrowserButton'
import ChartSearch from './ChartSearch'
import ScoreGrid from './ScoreGrid'

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

    const sortedScores = scores?.slice()
        .sort((a, b) =>
            getPlayRating(b.score, b.charts?.chart_constant ?? 0) -
            getPlayRating(a.score, a.charts?.chart_constant ?? 0)
        )
        .slice(0, 50)

    return (
        <div className="flex flex-col items-center justify-center gap-10 py-10">
            <h1 className="text-3xl font-bold">B50 View</h1>
            <h2 className="text-xl font-light">Click on a score for more info</h2>
            
            {/* Display the Add Score and import buttons */}
            <div className="flex">
                <AddScoreButton>
                    <div className={`bg-gray-500 text-white text-center rounded-md w-full border-2`}>
                        <ChartSearch charts={charts ?? []} />
                    </div>
                </AddScoreButton>
                <ImportFromBrowserButton />
            </div>
            {/* Display the score cards */}
            <ScoreGrid scores={sortedScores ?? []} />
        </div>
    )
}
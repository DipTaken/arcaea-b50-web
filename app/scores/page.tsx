import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import { addScore } from './actions'
import ChartSearch from './ChartSearch'

export default async function ScoresPage() {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    const { data: charts } = await supabase.from('charts').select().order('title')

    return (
        <div>
            <form action={addScore}>
                <ChartSearch charts={charts ?? []} />

                <input type="number" name="score" placeholder="Score" required />
                <input type="number" name="pure" placeholder="Pure" />
                <input type="number" name="far" placeholder="Far" />
                <input type="number" name="lost" placeholder="Lost" />

                <button type="submit">Add Score</button>
            </form>
        </div>
        )
    }
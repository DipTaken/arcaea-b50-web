import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import BrowseSearch from '@/app/browse/BrowseSearch'

export default async function BrowsePage() {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    const { data: charts } = await supabase.from('charts').select().order('title').limit(5000)

    return (
        <div className="flex flex-col items-center justify-center gap-5 py-10">
            <h1 className="text-3xl font-bold">Browse Charts</h1>
            <h2 className="text-xl font-light">Click on a chart to view details</h2>
            <BrowseSearch charts={charts ?? []} />

        </div>
    )
}

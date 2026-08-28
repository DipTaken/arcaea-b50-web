import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import BrowseSearch from '@/app/browse/BrowseSearch'
import { PageShell } from '@/app/components/PageShell'

export default async function BrowsePage() {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    const { data: charts } = await supabase.from('charts').select().order('title').limit(5000)

    return (
        <PageShell 
            title="Browse Charts" 
            subtitle="Click on a chart to view details">
            <BrowseSearch charts={charts ?? []} />
        </PageShell>
    )
}

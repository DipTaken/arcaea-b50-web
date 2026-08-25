import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import { getGuestIdReadOnly } from '@/utils/guest'
import BrowseCard from '@/app/browse/BrowseCard'

export default async function BrowsePage() {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)
    const guestId = await getGuestIdReadOnly()

    const { data: charts } = await supabase.from('charts').select().order('title')
    
    return (
        <div className="flex flex-col items-center justify-center gap-10 py-10">
          <ul className="grid grid-cols-[repeat(5,230px)] gap-y-10 w-fit justify-items-center mx-auto">
              {charts?.map((chart) => (
                <BrowseCard key={chart.id} chart={chart}/>
              ))}
          </ul>
        </div>
    )
}

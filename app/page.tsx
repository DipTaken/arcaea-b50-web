import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'

export default async function Page() {
  const cookieStore = await cookies()
  const supabase = createClient(cookieStore)

  const { data: charts, error } = await supabase.from('charts').select()

  console.log('charts:', charts)
  console.log('error:', error)
  return (
    <ul>
      {charts?.map((chart) => (
        <li key={chart.id}>{chart.title} — {chart.difficulty}</li>
      ))}
    </ul>
  )
}
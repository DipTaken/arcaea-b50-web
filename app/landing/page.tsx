import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import { getGuestIdReadOnly } from '@/utils/guest'
import LoginButton from '@/app/landing/LoginButton'

export default async function LandingPage() {
    const cookieStore = await cookies()
    //const supabase = createClient(cookieStore)
    //const guestId = await getGuestIdReadOnly()
    
    return (
        <div className="flex flex-col items-center justify-center gap-10 py-10">
            <h1 className="text-3xl font-bold">Arcaea B50 Web</h1>
            <h2 className="text-xl font-light">Login to begin</h2>
            <div>
                <LoginButton/>
            </div>
        </div>
    )
}

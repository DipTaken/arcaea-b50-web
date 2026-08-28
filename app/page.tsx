import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import LoginButton from '@/app/components/LoginButton'
import { PageShell } from './components/PageShell'

export default async function LandingPage() {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)
    const { data: { user } } = await supabase.auth.getUser()

    return (
        <PageShell 
            title="Arcaea B50 Web" 
            subtitle="">
           
            {/* Display a welcome message if the user is logged in, or a login prompt if not */}
            {user ? (
                <span>Welcome, {user.email?.split('@')[0]}</span>
            ) : (
                <div className="flex flex-col items-center gap-4">
                    <h2 className="text-xl font-light">Login to begin</h2>
                    <LoginButton />
                </div>
            )}
        </PageShell>
    )
}

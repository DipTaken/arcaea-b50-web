import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import LoginButton from '@/app/components/LoginButton'
import { PageShell } from './components/PageShell'
import { Panel } from './components/Panel'
import Link from 'next/link'

export default async function LandingPage() {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)
    const { data: { user } } = await supabase.auth.getUser()

    return (
        <PageShell
            title="Arcaea B50 Web"
            subtitle="">

            {/*Show Welcome message if user is logged in*/}
            {user && !user.is_anonymous && (
                <span>Welcome, {user.email?.split('@')[0]}</span>
            )}
            {/*Show Link Account button if user is not logged in (and has submitted one or more scores) */}
            {user && user.is_anonymous && (
                <div className="flex flex-col items-center gap-4">
                    <h2 className="text-xl font-light">Login to begin</h2>
                    <Link href="/auth/link"
                        className="text-base font-light border-2 p-2 rounded-md"
                    >
                        Sign in
                    </Link>
                </div>
            )}
            {/*Show LoginButton if user is not logged in*/}
            {!user && (
                <div className="flex flex-col items-center gap-4">
                    <h2 className="text-xl font-light">Login to begin</h2>
                    <LoginButton />
                </div>
            )}


            {/*CHANGELOG*/}
            <Panel>
                <div className="flex flex-col gap-6 p-4">
                    <h1>
                        <span className="text-4xl font-bold text-white text-center">Changelog</span>
                    </h1>

                    {/*THIS SHOULD BE REVERSE CHRONOLOGICAL ORDER*/}
                    <p className="text-white">
                        <span className="font-bold">v1.1.2</span> {`(2026-09-04) - Charts and Chart Constants now updated to Version 7.0`}
                    </p>
                    <p className="text-white">
                        <span className="font-bold">v1.1.1</span> {`(2026-09-03) - Bugfixes: Import CSV now correctly matches with title and song_id and ignores empty rows; Add Score now displays charts in correct order.`}
                    </p>
                    <p className="text-white">
                        <span className="font-bold">v1.1.0</span> {`(2026-09-02) - Added score import functionality. Users can now import scores from CSV files.`}
                    </p>
                    <p className="text-white">
                        <span className="font-bold">v1.0.0</span> {`(2026-08-31) - Initial release of Arcaea B50 Web. Users can log in, and view, add, edit, and delete their scores.`}
                    </p>
                </div>
            </Panel>
        </PageShell>
    )
}

import { cookies } from "next/headers"
import { createClient } from "@/utils/supabase/server"
import Link from "next/link"
import ProfileButton from "./ProfileButton"
import LoginButton from "./LoginButton"

export default async function NavBar() {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)
    const { data: { user } } = await supabase.auth.getUser()

    return (
        <nav className="grid grid-cols-[1fr_2fr_1fr] gap-4 items-center p-4 bg-gray-800 text-white">
            {/* Logo */}
            <Link href="/" className="justify-self-start text-lg font-bold">
                Arcaea B50 Web
            </Link>

            {/* Navigation Buttons */}
            <div className="flex justify-between justify-self-center gap-30">
                <Link href="/scores">View Scores</Link>
                <Link href="/browse">Browse Charts</Link>
                <Link href="/leaderboard">Leaderboard</Link>
            </div>
            
            {/* Profile/Login Button */}
            <div className="justify-self-end">
                {user ? (
                    <ProfileButton user={user} />
                ) : (
                    <LoginButton />
                )}
            </div>
        </nav>
    )
}
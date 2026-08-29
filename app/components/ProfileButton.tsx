'use client'

import { useState } from "react"
import { createClient } from "@/utils/supabase/client"
import { useRouter } from "next/navigation"
import { User } from "@supabase/supabase-js"

export default function ProfileButton({ user }: { user: User }) {
    const [profileMenuOpen, setProfileMenuOpen] = useState(false)
    const router = useRouter()
    const supabase = createClient()

    // Handle user sign-out
    const handleSignOut = async () => {
        const { error } = await supabase.auth.signOut()
        if (error) console.error('Error signing out:', error)
        else router.refresh()
    }

    return (
        <div className="flex items-center gap-4">

            {/* User Name */}
            <span className="hidden md:inline">Welcome, {user.email?.split('@')[0]}</span>

            <div className="relative">
                {/* Profile Button/Avatar */}
                <button onClick={() => setProfileMenuOpen(!profileMenuOpen)}
                    className="bg-gray-700 text-white text-center rounded-md w-12 h-12 overflow-hidden border-2"
                >
                    <img src={user.user_metadata.avatar_url} alt="Profile" className="w-full h-full object-cover" />
                </button>

                {/* Profile Menu (only opened when the profile button is clicked) */}
                {profileMenuOpen && (
                    <div className="absolute right-0 mt-2 w-40 bg-gray-700 rounded-md p-2 z-50">
                        <button onClick={handleSignOut}
                            className="w-full text-left bg-gray-500 hover:bg-gray-600 p-2"
                        >
                            Sign Out
                        </button>
                    </div>
                )}
            </div>

        </div>
    )
}

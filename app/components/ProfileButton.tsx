'use client'

import { useState } from "react"
import { createClient } from "@/utils/supabase/client"
import { useRouter } from "next/navigation"
import { User } from "@supabase/supabase-js"

// linkIdentity() writes the provider profile to auth.identities.identity_data but NOT to
// raw_user_meta_data, so a linked-from-anonymous account has an empty user_metadata until its
// next full sign-in. Fall back to the identities for the avatar.
function getAvatarUrl(user: User): string | null {
    const fromMetadata = user.user_metadata?.avatar_url ?? user.user_metadata?.picture
    if (typeof fromMetadata === 'string') return fromMetadata

    for (const identity of user.identities ?? []) {
        const fromIdentity = identity.identity_data?.avatar_url ?? identity.identity_data?.picture
        if (typeof fromIdentity === 'string') return fromIdentity
    }
    return null
}

export default function ProfileButton({ user }: { user: User }) {
    const [profileMenuOpen, setProfileMenuOpen] = useState(false)
    const [avatarFailed, setAvatarFailed] = useState(false)
    const router = useRouter()
    const supabase = createClient()

    const avatarUrl = getAvatarUrl(user)
    const initial = user.email?.[0]?.toUpperCase() ?? '?'

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
                    {avatarUrl && !avatarFailed ? (
                        // Google rate-limits lh3.googleusercontent.com per referrer; no-referrer
                        // avoids the intermittent 429/403 that renders an empty box.
                        <img src={avatarUrl} alt="Profile" referrerPolicy="no-referrer"
                            onError={() => setAvatarFailed(true)}
                            className="w-full h-full object-cover"
                        />
                    ) : (
                        <span className="text-lg font-semibold">{initial}</span>
                    )}
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

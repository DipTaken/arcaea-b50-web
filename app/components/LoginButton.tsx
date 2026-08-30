'use client'

import { createClient } from '@/utils/supabase/client'

interface LoginButtonProps {
    size?: 'sm' | 'md' | 'lg'
}

export default function LoginButton({size = 'sm' }: LoginButtonProps) {
    const supabase = createClient()
    // google auth login button
    const login = async () => {
        await supabase.auth.signInWithOAuth({
            provider: 'google',
            options: {
                redirectTo: `${window.location.origin}/auth/callback`,
                scopes: 'profile email',
            },
        })
    }

    const sizeClasses = {
        sm: 'text-sm p-1',
        md: 'text-base p-2',
        lg: 'text-2xl p-3',
    }

    return (
        <div>
            <button
                onClick={login}
                className={`${sizeClasses[size]} font-light border-2 rounded-md`}
            >
                Sign in
            </button>
        </div>
    )
}
'use client'

import { createBrowserClient } from '@supabase/ssr'

export default function LoginButton() {
    const supabase = createBrowserClient(
        process.env.NEXT_PUBLIC_SUPABASE_URL!,
        process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY!
    )
    // google auth login button
    const login = async () => {
        await supabase.auth.signInWithOAuth({
            provider: 'google',
            options:{
                redirectTo: `${window.location.origin}/auth/callback`,
                scopes: 'profile email',
            },
        })
    }
    return (
        <div>
            <button
                onClick={login}
                className="text-base font-light border-2 p-2 rounded-md"
            >
                Sign in
            </button>
        </div>
    )
}
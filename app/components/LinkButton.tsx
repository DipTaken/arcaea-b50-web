'use client'

import { createClient } from '@/utils/supabase/client'

export default function LinkButton() {
    const supabase = createClient()
    // google auth link button
    const link = async () => {
        await supabase.auth.linkIdentity({
            provider: 'google',
            options: {
                redirectTo: `${window.location.origin}/auth/callback`,
                scopes: 'profile email',
            },
        })
    }

    return (
        <div>
            <button
                onClick={link}
                className="text-xl font-light border-2 p-4 rounded-md"
            >
                Link Account
            </button>
        </div>
    )
}
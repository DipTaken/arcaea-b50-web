'use server'

import { createClient } from "@/utils/supabase/server"
import { cookies } from "next/headers"
import { getGuestIdReadOnly } from "@/utils/guest"
import { revalidatePath } from "next/cache"

export default async function ImportFromBrowser() {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
        return { error: 'You must be logged in to import scores.' }
    }

    const guestId = cookieStore.get('guest_id')?.value 

    if (!guestId) {
    return { error: 'No guest session cookie found on this browser.' }
    }

    const { data: guestScores, error: fetchError } = await supabase
        .from('scores')
        .select('*')
        .eq('user_id', guestId)
    
    if (fetchError || !guestScores || guestScores.length === 0) {
        return { error: fetchError?.message || 'No scores found to import.' }
    }
    
    const duplicatedScores = guestScores.map(score => {
        const { id, created_at, ...scoreData } = score
        return {
            ...scoreData,
            user_id: user.id,
        }
    })

    const { data, error: insertError } = await supabase
        .from('scores')
        .insert(duplicatedScores)
        .select()

    if (insertError) {
        return { error: insertError.message }
    }

    revalidatePath('/')
    return { success: true, count: data.length }
}
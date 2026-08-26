'use server'

import { createClient } from "@/utils/supabase/server"
import { cookies } from "next/headers"
import { revalidatePath } from "next/cache"

export default async function ImportFromBrowser() {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    // Get the currently logged-in user, and return error if user tries to import scores without being logged in
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
        return { error: 'You must be logged in to import scores.' }
    }

    // Get the guest_id cookie from the browser, and return error if it doesn't exist
    const guestId = cookieStore.get('guest_id')?.value
    if (!guestId) {
        return { error: 'No guest session cookie found on this browser.' }
    }

    const { data: guestScores, error: fetchError } = await supabase
        .from('scores')
        .select('*')
        .eq('user_id', guestId)

    // If there are no scores to import, return an error
    if (fetchError || !guestScores || guestScores.length === 0) {
        return { error: fetchError?.message || 'No scores found to import.' }
    }

    // Duplicate the scores, replacing the guest_id with the logged-in user's id
    const duplicatedScores = guestScores.map(score => {
        const { id, created_at, ...scoreData } = score
        return {
            ...scoreData,
            user_id: user.id,
        }
    })
    
    // Insert the duplicated scores into the database, and error if the insertion fails
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
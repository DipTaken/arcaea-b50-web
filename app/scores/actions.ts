'use server'

import { createClient } from "@/utils/supabase/server"
import { cookies } from "next/headers"
import { getGuestId } from '@/utils/guest'
import { revalidatePath } from 'next/cache'

export async function addScore(formData: FormData) {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    // Get the form data
    const chartId = Number(formData.get('chart_id'))
    const score = Number(formData.get('score'))
    const pure = parseOptionalNumber(formData.get('pure'))
    const far = parseOptionalNumber(formData.get('far'))
    const lost = parseOptionalNumber(formData.get('lost'))

    // Validate the form data
    const { data: chart, error: chartError } = await supabase
        .from('charts')
        .select('note_count')
        .eq('id', chartId)
        .single()

    if (chartError || !chart) {
        return {error: "Chart not found"}
    }

    // Validate the score
    const maxScore = 10000000 + (chart?.note_count ?? 0)
    if (score < 0 || score > maxScore) {
        return {error: `Invalid score. Must be between 0 and ${maxScore}`}
    }

    //Validate pure, far, lost values
    if (pure !== null && (pure < 0 || pure > chart.note_count)) {
        return {error: `Invalid pure value. Must be between 0 and ${chart.note_count}`}
    }
    if (far !== null && (far < 0 || far > chart.note_count)) {
        return {error: `Invalid far value. Must be between 0 and ${chart.note_count}`}
    }
    if (lost !== null && (lost < 0 || lost > chart.note_count)) {
        return {error: `Invalid lost value. Must be between 0 and ${chart.note_count}`}
    }
    if (pure !== null && far !== null && lost !== null && (pure + far + lost > chart.note_count)) {
        return {error: `Invalid values. The sum of pure, far, and lost must not exceed ${chart.note_count}`}
    }

    const guestId = await getGuestId()
    const { data: { user } } = await supabase.auth.getUser()
    const userId = user?.id ?? guestId

    // Insert the score into the database
    await supabase.from('scores').insert({
        chart_id: chartId,
        user_id: userId,
        score: score,
        pure: pure,
        far: far,
        lost: lost
    })
    revalidatePath('/scores')
}

// Helper function to parse optional number values from FormData
function parseOptionalNumber(value: FormDataEntryValue | null) {
    if (!value) return null
    return Number(value)
}
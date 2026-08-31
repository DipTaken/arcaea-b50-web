'use server'

import { createClient } from "@/utils/supabase/server"
import { cookies } from "next/headers"
import { revalidatePath } from 'next/cache'
import { getOrCreateUser } from "@/utils/auth"
import { validateScore, parseScoreFormData, getClearStatus } from "./validateScore"

export async function addScore(formData: FormData) {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    // Parse and validate the form data
    //return error if validation fails or values dont exist
    const result = await parseAndValidate(supabase, formData)
    if (result.error !== null) return { error: result.error }
    const { values, clearStatus } = result

    //locates current user, and creates one if it doesn't exist
    const { user, error: authError } = await getOrCreateUser(supabase)
    if (authError) return { error: authError.message }
    const userId = user.id

    // Insert the score into the database, and check if there was an error
    const { error: insertError } = await supabase.from('scores').insert({
        chart_id: values.chartId,
        user_id: userId,
        score: values.score,
        pure: values.pure,
        far: values.far,
        lost: values.lost,
        clear_status: clearStatus
    })

    if (insertError) return { error: insertError.message }
    revalidatePath('/scores')
}

export async function editScore(formData: FormData) {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    // Parse and validate the form data
    //return error if validation fails or values dont exist
    const result = await parseAndValidate(supabase, formData)
    if (result.error !== null) return { error: result.error }
    const { values, clearStatus } = result

    // Get the score ID from the form data
    const scoreId = Number(formData.get('score_id'))

    // Insert the score into the database, and check if there was an error
    const { data, error: updateError } = await supabase.from('scores').update({
        chart_id: values.chartId,
        score: values.score,
        pure: values.pure,
        far: values.far,
        lost: values.lost,
        clear_status: clearStatus
    })
        .eq('id', scoreId)
        .select()

    if (updateError) return { error: updateError.message }
    if (!data?.length) return { error: 'Score not found.' }

    revalidatePath('/scores')
}

export async function deleteScore(formData: FormData) {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    // Get the score ID from the form data
    const scoreId = Number(formData.get('score_id'))

    // Delete the score from the database, and check if there was an error
    const { data, error: deleteError } = await supabase.from('scores').delete().eq('id', scoreId).select()

    if (deleteError) return { error: deleteError.message }
    if (!data?.length) return { error: 'Score not found.' }

    revalidatePath('/scores')
}

async function parseAndValidate(supabase: ReturnType<typeof createClient>, formData: FormData) {
    // Parse the form data
    const values = parseScoreFormData(formData)

    const { data: chart, error: chartError } = await supabase
        .from('charts')
        .select('note_count')
        .eq('id', values.chartId)
        .single()

    // Validate the form data
    if (chartError || !chart) return { error: "Chart not found" }

    // Get the clear status with no NULL guarantee (type String)
    const clearStatus = getClearStatus(values.score, chart.note_count, values.far, values.lost, values.rawClearStatus, values.isCleared)

    const validationError = validateScore(values.score, values.pure, values.far, values.lost, clearStatus, chart.note_count)
    if (validationError) return { error: validationError }

    return { values: values, clearStatus: clearStatus, error: null }
}
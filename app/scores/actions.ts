'use server'

import { createClient } from "@/utils/supabase/server"
import { cookies } from "next/headers"
import { revalidatePath } from 'next/cache'
import { getOrCreateUser } from "@/utils/auth"
import { validateScore, parseScoreFormData, getClearStatus, CLEAR_STATUS_VALUES } from "./validateScore"
import { ImportScore } from "@/utils/types"

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

    // update the score from the database, and check if there was an error
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

export async function deleteScore(scoreId: number) {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    if (!Number.isInteger(scoreId)) {
        return { error: 'Invalid score ID.' }
    }

    // Delete the score from the database, and check if there was an error
    const { data, error: deleteError } = await supabase.from('scores').delete().eq('id', scoreId).select()

    if (deleteError) return { error: deleteError.message }
    if (!data?.length) return { error: 'Score not found.' }

    revalidatePath('/scores')
}

export async function importScores(scores: ImportScore[]) {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    if (scores.length === 0) {
        return { error: 'No scores to import.' }
    }

    //create a set of unique chart IDs from the scores to import
    const chartIds = [... new Set(scores.map(s => s.chartId))]
    //fetch the note counts for the charts from the database
    const { data: charts, error: chartError } = await supabase.from('charts').select('id, note_count').in('id', chartIds)
    if (chartError) return { error: chartError.message }
    //create a map of chart IDs to note counts for validation
    const chartNotecountMap = new Map(charts.map(c => [c.id, c.note_count]))

    for (const score of scores) {
        // Validate each score before inserting
        const chartNotecount = chartNotecountMap.get(score.chartId)
        
        if (chartNotecount === undefined) {
            return { error: `Chart with ID ${score.chartId} not found.` }
        }

        const isClearStatusValid = CLEAR_STATUS_VALUES.includes(score.clear_status)
        if (!isClearStatusValid) {
            return { error: `Invalid clear status ${score.clear_status}.` }
        }

        const validationError = validateScore(score.scoreValue, score.pure, score.far, score.lost, score.clear_status, chartNotecount)
        if (validationError) {
            return { error: validationError }
        }
    }

    //locates current user, and creates one if it doesn't exist
    const { user, error: authError } = await getOrCreateUser(supabase)
    if (authError) return { error: authError.message }
    const userId = user.id

    // Insert the score into the database, and check if there was an error
    const { data, error: insertError } = await supabase.from('scores').insert(scores.map(s => ({
        chart_id: s.chartId,
        user_id: userId,
        score: s.scoreValue,
        pure: s.pure,
        far: s.far,
        lost: s.lost,
        clear_status: s.clear_status
    })))
        .select()
    if (insertError) return { error: insertError.message }

    revalidatePath('/scores')
    return { imported: data.length }
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
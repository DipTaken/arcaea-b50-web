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

    const guestId = await getGuestId()

    const { data: { user } } = await supabase.auth.getUser()
    const userId = user?.id ?? guestId

    await supabase.from('scores').insert({
        chart_id: chartId,
        user_id: userId,
        score: score,
        pure: pure,
        far: far,
        lost: lost
    })

    revalidatePath('/')
}

function parseOptionalNumber(value: FormDataEntryValue | null) {
    if (!value) return null
    return Number(value)
}
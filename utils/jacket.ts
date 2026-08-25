import { createClient } from '@/utils/supabase/client'

function getJacketFileName(songId: string, difficulty: string, jacketOverride: boolean): string {
    if (jacketOverride) return `${songId}_${difficulty.toLocaleLowerCase()}.jpg`
    else return `${songId}.jpg`
}

export function getJacketUrl(songId: string, difficulty: string, jacketOverride: boolean): string {
    const supabase = createClient()
    const fileName = getJacketFileName(songId, difficulty, jacketOverride)
    return supabase.storage.from('jackets').getPublicUrl(fileName).data.publicUrl
}
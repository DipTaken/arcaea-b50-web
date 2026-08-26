// Get the filename for a jacket based on its song ID, difficulty, and override flag.
function getJacketFileName(songId: string, difficulty: string, jacketOverride: boolean): string {
    if (jacketOverride) return `${songId}_${difficulty.toLocaleLowerCase()}.jpg` // append _{difficulty} if jacketOverride is true
    else return `${songId}.jpg`
}

// Get the public URL from supabase using determinastic url
export function getJacketUrl(songId: string, difficulty: string, jacketOverride: boolean): string {
    const fileName = getJacketFileName(songId, difficulty, jacketOverride)
    return `${process.env.NEXT_PUBLIC_SUPABASE_URL}/storage/v1/object/public/jackets/${fileName}`
}
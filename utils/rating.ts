export function getGrade(score: number, noteCount: number, pure: number | null, far: number | null, lost: number | null): string {
    if (score >= 10000000) {
        if (isPM(score, noteCount, far, lost) || noteCount < 2237) return "PM"
        else return "EX+"
    }
    else if (score >= 9900000) return "EX+"
    else if (score >= 9800000) return "EX"
    else if (score >= 9500000) return "AA"
    else if (score >= 9200000) return "A"
    else if (score >= 8900000) return "B"
    else if (score >= 8600000) return "C"
    else return "D"
}

export function getScoreModifier(score: number): number {
    if (score >= 10000000) return 2
    else if (score >= 9800000) return 1 + (score - 9800000) / 200000
    else return (score - 9500000) / 300000
}

export function getPlayRating(score: number, chartConstant: number): number {
    const rating = getScoreModifier(score)
    return Math.max(rating + chartConstant, 0)
}

export function getPmRating(score: number, noteCount: number, pure: number | null): string {
    if (score < 10000000) return "N/A"
    else if (pure === null) return "? MAX"
    else if (noteCount === pure) return "MAX"
    else return "MAX - " + (noteCount - pure)
}

function isPM(score: number, noteCount: number, far: number | null, lost: number | null): boolean {
    if (score < 10000000) return false
    else if (noteCount < 2237) return true //theorically if there is a chart with >2237 notes its possible to get a score >= 10M without getting no fars/losts
    else if (far === null || lost === null) return false
    else return far === 0 && lost === 0
}
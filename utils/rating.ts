import { ScoreWithChart, B50Entry } from "./types"

export function getGrade(score: number, noteCount: number, pure: number | null, far: number | null, lost: number | null): string {
    if (score >= 10000000 && (isPM(score, noteCount, far, lost) || noteCount < 2237)) return "PM"
    else if (score >= 9900000) return "EX+"
    else if (score >= 9800000) return "EX"
    else if (score >= 9500000) return "AA"
    else if (score >= 9200000) return "A"
    else if (score >= 8900000) return "B"
    else if (score >= 8600000) return "C"
    else return "D"
}

export function getClearStatus(clearStatus: string, length: 'short' | 'long' = 'short'): string {
    switch (clearStatus) {
        case "fail":
            return length === 'short' ? "L" : "Fail"
        case "clearEasy":
            return length === 'short' ? "C" : "Clear (Easy)"
        case "clearNormal":
            return length === 'short' ? "C" : "Clear (Normal)"
        case "clearHard":
            return length === 'short' ? "C" : "Clear (Hard)"
        case "fullRecall":
            return length === 'short' ? "F" : "Full Recall"
        case "pureMemory":
            return length === 'short' ? "P" : "Pure Memory"
        default:
            return "?"
    }
}

// returns score modifier (ex. cc = 10.0, scoreModifier = 1.274, so playRating = 11.274)
export function getScoreModifier(score: number): number {
    if (score >= 10000000) return 2
    else if (score >= 9800000) return 1 + (score - 9800000) / 200000
    else return (score - 9500000) / 300000
}

export function getPlayRating(score: number, chartConstant: number, clearStatus: string): number {
    const rating = getScoreModifier(score) + getClearFactor(clearStatus)
    return Math.max(rating + chartConstant, 0)
}

function getClearFactor(clearStatus: string): number {
    if (clearStatus === "fail") return 0
    else return 0.2
}

// returns the number of shiny pure notes in a score. Used to calculate PM rating (MAX - n)
export function getShinyPureCount(score: number, noteCount: number): number {
    // a unit is 5,000,000 points / noteCount, so a pure is 2 units, and a far is 1 unit
    const unitsHit = Math.ceil(((score + 1) * noteCount) / 5000000) - 1
    const unitsHitClamped = Math.min(unitsHit, 2 * noteCount) // clamp to 2 * noteCount since you cannot get more than noteCount number of pure notes
    return score - Math.floor((unitsHitClamped * 5000000) / noteCount)
}

// returns PM rating if the score is a PM
export function getPmRating(score: number, noteCount: number, far: number | null, lost: number | null): string {
    if (!isPM(score, noteCount, far, lost)) return "N/A"
    else {
        const shiny = getShinyPureCount(score, noteCount)
        return shiny === noteCount ? "MAX" : `MAX - ${noteCount - shiny}`
    }
}

const MAX_NOTES_SAFE_PM_THRESHOLD = 2237  //theorically if there is a chart with >2237 notes its possible to get a score >= 10M without getting no fars/losts

// checks if a score is a PM (Pure Memory) and is future-proofed for charts with a high number of notes
export function isPM(score: number, noteCount: number, far: number | null, lost: number | null): boolean {
    if (score < 10000000) return false
    else if (noteCount < MAX_NOTES_SAFE_PM_THRESHOLD) return true
    else if (far === null || lost === null) return false
    else return far === 0 && lost === 0
}

export function getB50Rating(sortedScores: B50Entry[]): number {
    let totalRating = 0.0
    for (let i = 1; i <= sortedScores.length; i++) {
        totalRating += sortedScores[i - 1].playRating * sortedScores[i - 1].weight
    }
    return totalRating / 60.0
}

export function getB50FromScores(scores: ScoreWithChart[]): B50Entry[] {
    const bestScores = new Map<number, ScoreWithChart>()
    for (const score of scores) {
        const prevScore = bestScores.get(score.chart_id)
        if (!prevScore || score.score > prevScore.score)
            bestScores.set(score.chart_id, score)
    }
    const b50Scores = [...bestScores.values()]
        .map((score) => ({
            ...score,
            playRating: getPlayRating(score.score, score.charts?.chart_constant ?? 0, score.clear_status),
        }))
        .sort((a, b) => b.playRating - a.playRating)
        .slice(0, 50)
        .map((score, index): B50Entry => ({
            rank: index + 1,
            score,
            playRating: score.playRating,
            weight: index < 10 ? 2 : 1,
        }))
    return b50Scores
}
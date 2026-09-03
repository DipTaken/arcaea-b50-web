import { isPM } from "@/utils/rating"

export const CLEAR_STATUS_VALUES = [
    "fail", "clearEasy", "clearNormal", "clearHard", "fullRecall", "pureMemory"
]

export function validateScore(
    score: number,
    pure: number | null,
    far: number | null,
    lost: number | null,
    clearStatus: string,
    noteCount: number):
    string | null {

    for (const value of [score, pure, far, lost]) {
        if (value !== null && !Number.isInteger(value)) {
            return `Invalid value. Must be an integer.`
        }
    }

    // Validate the score
    const maxScore = 10000000 + (noteCount ?? 0)
    if (score < 0 || score > maxScore) {
        return `Invalid score. Must be between 0 and ${maxScore}`
    }

    //Validate pure, far, lost values
    if (pure !== null && (pure < 0 || pure > noteCount)) {
        return `Invalid pure value. Must be between 0 and ${noteCount}`
    }
    if (far !== null && (far < 0 || far > noteCount)) {
        return `Invalid far value. Must be between 0 and ${noteCount}`
    }
    if (lost !== null && (lost < 0 || lost > noteCount)) {
        return `Invalid lost value. Must be between 0 and ${noteCount}`
    }
    if (pure !== null && far !== null && lost !== null && (pure + far + lost > noteCount)) {
        return `Invalid values. The sum of pure, far, and lost must not exceed ${noteCount}`
    }

    if (clearStatus) {
        if (clearStatus === "fullRecall" && lost !== null && lost !== 0) {
            return `Invalid full recall. Lost must be 0.`
        }
        if (clearStatus === "pureMemory" && ((lost !== null && lost !== 0) || (far !== null && far !== 0))) {
            return `Invalid pure memory. Far and lost must both be 0.`
        }
    }

    return null
}

// Helper function to parse optional number values from FormData
function parseOptionalNumber(value: FormDataEntryValue | null) {
    if (!value) return null
    return Number(value)
}

// get score form data
export function parseScoreFormData(formData: FormData) {
    return {
        chartId: Number(formData.get('chart_id')),
        score: Number(formData.get('score')),
        pure: parseOptionalNumber(formData.get('pure')),
        far: parseOptionalNumber(formData.get('far')),
        lost: parseOptionalNumber(formData.get('lost')),
        rawClearStatus: formData.get('clear_status') as string | null,
        isCleared: formData.get('is_cleared') === 'on'
    }
}

// Get the clear status with no NULL guarantee
export function getClearStatus(score: number, noteCount: number, far: number | null, lost: number | null, rawClearStatus: string | null, isCleared: boolean): string {
    const pm = isPM(score, noteCount, far, lost)
    let clearStatus: string
    if (pm) {
        clearStatus = 'pureMemory' //autofill pm if score is valid pm
    }
    else if (rawClearStatus || !pm) {
        clearStatus = 'clearNormal' //when changing score from pm to non-pm, we want to default to clearNormal 
    }
    else {
        clearStatus = isCleared ? 'clearNormal' : 'fail'
    }
    return clearStatus
}
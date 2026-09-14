import { DIFFICULTY_ORDER } from '@/utils/constants'

// converts the filterComparison string into a comparison function
export function getComparisonOp(filterComparison: string | null): ((a: number, b: number) => boolean) | null {
    switch (filterComparison) {
        case 'lt':
            return (a: number, b: number) => a < b
        case 'le':
            return (a: number, b: number) => a <= b
        case 'eq':
            return (a: number, b: number) => a === b
        case 'ge':
            return (a: number, b: number) => a >= b
        case 'gt':
            return (a: number, b: number) => a > b
        default:
            return null
    }
}

// converts difficulty string to a number for sorting purposes
export function getDifficultyValue(difficulty: string ): number {
    if (!difficulty || !(DIFFICULTY_ORDER as readonly string[]).includes(difficulty)) return 0
    else return (DIFFICULTY_ORDER as readonly string[]).indexOf(difficulty) + 1 // +1 to make it 1-based instead of 0-based
}

// converts length string to a number for sorting purposes
export function getLengthValue(length: string | null): number {
    if (!length) return 0
    const parts = length.split(':')
    if (parts.length === 2) {
        const minutes = parseInt(parts[0], 10)
        const seconds = parseInt(parts[1], 10)
        return minutes * 60 + seconds
    }
    return 0
}

// converts bpm string to a number for sorting purposes
export function getBPMValue(bpm: string | null): number {
    if (!bpm) return 0
    const bpmValue = parseFloat(bpm)
    return isNaN(bpmValue) ? 0 : bpmValue
}

// compares two version strings
export function compareVersions(versionA: string, versionB: string): number {
    const partsA = versionA.split('.').map(Number)
    const partsB = versionB.split('.').map(Number)

    for (let i = 0; i < Math.max(partsA.length, partsB.length); i++) {
        const diff = (partsA[i] || 0) - (partsB[i] || 0)
        if (diff !== 0) return diff
    }
    return 0
}
import Papa from "papaparse"

import { Chart } from "@/utils/types"
import { validateScore, getClearStatus, CLEAR_STATUS_VALUES } from "./validateScore"

type ImportScore = {
    chartId: number;
    scoreValue: number;
    pure: number | null;
    far: number | null;
    lost: number | null;
    clear_status: string;
}

type RawRow = {
    song: string | undefined;
    difficulty: string | undefined;
    artist: string | undefined;
    score: string | undefined;
    pure: string | undefined;
    far: string | undefined;
    lost: string | undefined;
    clear_status: string | undefined;
}

type RowError = {
    rowNumber: number;
    error: string;
}


export function parseCsv(csvString: string) {
    const config = {
        header: true,
        skipEmptyLines: true,
        transformHeader: (h: string) => h.trim().toLowerCase()
    }
    const { data, errors } = Papa.parse<RawRow>(csvString, { ...config });
    return { data, errors };
}

export function validateImportScores(charts: Chart[], scores: RawRow[]): { scores: ImportScore[], errors: RowError[] } {
    const errorArray: RowError[] = []
    const validScores: ImportScore[] = []

    //create a map of charts with key as chart title + difficulty, and value as an array of charts with that title and difficulty
    const chartMap = new Map<string, Chart[]>()
    for (const chart of charts) {
        const key = chartKey(chart.title, chart.difficulty)
        const existing = chartMap.get(key) ?? []
        existing.push(chart)
        chartMap.set(key, existing)
    }

    //looping through each of the scores
    for (const [index, scoreRow] of scores.entries()) {
        const { song, difficulty, artist, score, pure, far, lost, clear_status } = scoreRow
        const rowNumber = convertIndexToRowNumber(index) //since the first row is the header, we add 2 to the index to get the actual row number in the CSV

        //validate that the required fields are present
        if (!song?.trim()) {
            errorArray.push({ rowNumber: rowNumber, error: `Invalid song data on row: ${rowNumber} ` });
            continue
        }
        if (!difficulty?.trim()) {
            errorArray.push({ rowNumber: rowNumber, error: `Invalid difficulty data on row: ${rowNumber} ` });
            continue
        }
        if (!score?.trim()) {
            errorArray.push({ rowNumber: rowNumber, error: `Invalid score data on row: ${rowNumber} ` });
            continue
        }

        //validate the clear status
        const clearStatus = clear_status?.trim()
        if (!clearStatus || !CLEAR_STATUS_VALUES.includes(clearStatus)) {
            errorArray.push({ rowNumber: rowNumber, error: `Invalid clear status: "${clearStatus}"` })
            continue
        }

        //find the chart(s) that match the song and difficulty
        const candidates = chartMap.get(chartKey(song, difficulty))
        if (!candidates) {
            errorArray.push({ rowNumber: rowNumber, error: `Chart not found for song "${song}" with difficulty "${difficulty}"` });
            continue
        }

        //match the artist if there are multiple charts with the same song and difficulty
        const chart = candidates.length === 1 ?
            candidates[0] :
            candidates.find(c => c.artist.trim().toLowerCase() === artist?.trim().toLowerCase())

        //if there are multiple charts and the artist is not provided, ask the user to provide the artist in the CSV
        if (!chart) {
            errorArray.push({ rowNumber: rowNumber, 
                error: `Multiple charts found for song "${song}" with difficulty "${difficulty}". Please add one of these artists ${candidates.map(c => c.artist).join(', ')} to the Artist column.` });
            continue
        }

        const parsedScore = Number(score)
        const parsedPure = parseNumber(pure)
        const parsedFar = parseNumber(far)
        const parsedLost = parseNumber(lost)
        const validatingScore: ImportScore = {
            chartId: chart.id,
            scoreValue: parsedScore,
            pure: parsedPure,
            far: parsedFar,
            lost: parsedLost,
            clear_status: getClearStatus(parsedScore, chart.note_count, parsedFar, parsedLost, clearStatus, true)
        }

        //validate the score
        const validationError = validateScore(
            validatingScore.scoreValue,
            validatingScore.pure,
            validatingScore.far,
            validatingScore.lost,
            validatingScore.clear_status,
            chart.note_count
        )

        if (validationError) {
            errorArray.push({ rowNumber: rowNumber, error: validationError });
            continue
        }

        //if everything is good, add the score to the validScores array
        validScores.push(validatingScore)
    }

    return { scores: validScores, errors: errorArray }
}

function parseNumber(value: string | undefined): number | null {
    if (!value?.trim()) return null
    return Number(value)
}

function convertIndexToRowNumber(index: number): number {
    return index + 2 // +2 to account for header row and 0-based index
}

function chartKey(chartTitle: string, chartDifficulty: string): string {
    return `${chartTitle.trim().toLowerCase()}-${chartDifficulty.trim().toLowerCase()}`
}
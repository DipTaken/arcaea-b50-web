'use client'

import { Chart } from "@/utils/types"
import { ChangeEvent, SubmitEvent, createContext, useContext, useState } from "react"
import { Button } from "../components/Button"
import { getDifficultyColor } from "@/utils/style"
import { getJacketUrl } from "@/utils/jacket"

type InitialValues = {
    score?: number
    pure?: number | null
    far?: number | null
    lost?: number | null
    clear_status?: string | null
}

interface ScoreFormProps {
    defaultChart: Chart | null
    initialValues?: InitialValues
    onSubmit: (formData: FormData) => Promise<{ error?: string } | undefined>
    onClose: () => void
    submitLabel: string
    showSongInfo?: boolean
    children?: React.ReactNode
}
const SelectedChartContext = createContext<(chart: Chart | null) => void>(() => { })
export const useSetSelectedChart = () => useContext(SelectedChartContext)

const CLEAR_STATUSES = [
    { value: "fail", label: "Fail", cleared: false },
    { value: "clearEasy", label: "Clear (Easy)", cleared: true },
    { value: "clearNormal", label: "Clear (Normal)", cleared: true },
    { value: "clearHard", label: "Clear (Hard)", cleared: true },
    { value: "fullRecall", label: "Full Recall", cleared: true },
    { value: "pureMemory", label: "Pure Memory", cleared: true }
] as const

export default function ScoreForm({ defaultChart, initialValues, onSubmit, onClose, submitLabel, showSongInfo = true, children }: ScoreFormProps
): React.ReactNode {
    const [selectedChart, setSelectedChart] = useState<Chart | null>(defaultChart)
    const [scoreText, setScoreText] = useState<string>(initialValues?.score?.toString() ?? '') // Track the score input value
    const [errorMessage, setErrorMessage] = useState<string | null>(null)

    // submit the form data to the server and close the modal
    async function handleSubmit(e: SubmitEvent<HTMLFormElement>) {
        e.preventDefault()
        const form = e.currentTarget
        const formData = new FormData(form)
        setErrorMessage(null) // Clear any previous error message

        const result = await onSubmit(formData)

        if (result?.error) {
            setErrorMessage(result.error)
            return
        }
        onClose() // close the modal
    }

    // Handle input validation for the input fields
    const handleInput = (e: ChangeEvent<HTMLInputElement>) => {
        const input = e.currentTarget;

        if (input.validity.rangeUnderflow) {
            input.setCustomValidity("Please select a value that is no less than 0");
        }
        else if (input.validity.rangeOverflow) {
            const formattedMax = Number(input.max).toLocaleString()
            input.setCustomValidity(`Please select a value that is no greater than ${formattedMax}`);
        }
        else {
            input.setCustomValidity("");
        }
    };

    const chartInfoElement = (
        <div className="flex items-center justify-start gap-4 ">
            <img src={getJacketUrl(selectedChart?.song_id || "", selectedChart?.difficulty || "", selectedChart?.jacket_override || false)}
                alt="Song Jacket"
                className="w-32 h-32 rounded-lg" />

            <div className="flex flex-col items-start gap-1">
                <span className="text-white text-2xl font-bold">{selectedChart?.title}</span>
                <span className="text-white text-lg font-bold p-2 rounded-md"
                    style={{ backgroundColor: getDifficultyColor(selectedChart?.difficulty ?? "") }}
                >
                    {selectedChart?.difficulty}  {selectedChart?.level}</span>
            </div>
        </div>
    );

    const judgementInputProps = {
        type: "number",
        max: selectedChart?.note_count ?? 0,
        min: 0,
        disabled: !selectedChart,
        onChange: handleInput,
        className: "no-spinner flex-auto bg-gray-700 text-xl text-center text-white rounded-md border-2 border-gray-400"
    } as const

    const max = selectedChart ? 10000000 + selectedChart.note_count : 10000000

    return (
        <SelectedChartContext.Provider value={setSelectedChart}>
            <form onSubmit={handleSubmit}
                className={`flex flex-col gap-4 gap-y-7 p-10 justify-center rounded-lg bg-gray-800 border-2 border-gray-400 w-full max-w-5xl`}
            >
                <h1 className="text-left text-white text-3xl font-bold w-full">Add Score</h1>
                {showSongInfo && chartInfoElement}

                {/*Hidden input for chart id*/}
                {children}

                <div key={selectedChart?.id ?? 'none'} className="contents">
                    {/* Score input field */}
                    <div className="flex flex-col gap-1 w-full justify-center items-center">
                        <input
                            type="number"
                            name="score"
                            placeholder="Score"
                            defaultValue={initialValues?.score ?? ''}
                            required
                            min={0}
                            max={max}
                            disabled={!selectedChart}
                            onChange={(e) => { handleInput(e); setScoreText(e.currentTarget.value) }}
                            className={`no-spinner bg-gray-700 h-20 text-white text-center text-4xl rounded-md w-full border-2 border-gray-400`}
                        />
                        {scoreText && <span className="text-gray-400 text-sm ">{Number(scoreText).toLocaleString('en-US')}</span>}
                    </div>
                    {/* Input fields for Pure, Far, and Lost */}
                    <div className="flex gap-2 h-15 w-full">
                        <input name="pure" placeholder="Pure" defaultValue={initialValues?.pure ?? ''} {...judgementInputProps} />
                        <input name="far" placeholder="Far" defaultValue={initialValues?.far ?? ''} {...judgementInputProps} />
                        <input name="lost" placeholder="Lost" defaultValue={initialValues?.lost ?? ''} {...judgementInputProps} />
                    </div>

                    {/* Cleared checkbox and Clear Status dropdown */}
                    <ClearInfo initialValues={initialValues} />
                </div>

                {/* Display error message if any */}
                {errorMessage && (
                    <div className="text-red-500 text-center text-lg font-bold">
                        {errorMessage}
                    </div>
                )}

                {/* Submit and Cancel buttons */}
                <div className="flex gap-4 w-full justify-center items-center h-15">
                    <Button
                        type="submit"
                        disabled={!selectedChart}
                        variant="primary"
                        size="fill"
                    > {submitLabel}
                    </Button>

                    <Button
                        type="button"
                        onClick={() => onClose()}
                        variant="danger"
                        size="fill"
                    > Cancel
                    </Button>
                </div>
            </form>
        </SelectedChartContext.Provider>
    )
}

function ClearInfo({ initialValues }: { initialValues?: InitialValues }): React.ReactNode {
    const [isCleared, setIsCleared] =
        useState(CLEAR_STATUSES.find(status => status.value === initialValues?.clear_status)?.cleared ?? true) // Track if the chart has been cleared (search for the prev set clear status)
    const [clearStatus, setClearStatus] = useState<string | null>(initialValues?.clear_status ?? null) // Track the clear status of the chart

    return (
        <div className="flex h-15 w-full justify-between items-center">
            <div className="flex items-center justify-center gap-2">
                <label htmlFor="is_cleared" className="text-white text-xl font-bold mr-2">Cleared:</label>
                <input
                    type="checkbox"
                    name="is_cleared"
                    placeholder="Cleared"
                    id="is_cleared"
                    checked={isCleared}
                    onChange={(e) => {
                        const checked = e.target.checked
                        setIsCleared(checked)
                        if (CLEAR_STATUSES.find(status => status.value === clearStatus)?.cleared !== checked) {
                            setClearStatus(null)
                        }
                    }}
                    className="w-8 h-8 accent-blue-500"
                />
            </div>

            <input type="hidden" name="clear_status" value={clearStatus ?? (isCleared ? "clearNormal" : "fail")} />
            <select className={`bg-gray-700 text-white text-center py-3 border-gray-400 rounded-md border-2 px-5`}
                onChange={(e) => setClearStatus(e.target.value)}
                value={clearStatus ?? ""}
            >
                <option value="" hidden>Select Clear Status...</option>
                {CLEAR_STATUSES.map((status) => (
                    <option key={status.value} value={status.value} disabled={isCleared !== status.cleared}>
                        {status.label}
                    </option>
                ))}
            </select>
        </div>
    )
}
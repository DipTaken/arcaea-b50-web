'use client'

import { useRef, useState, createContext, useContext, ChangeEvent, SubmitEvent } from 'react'
import { addScore } from './actions'
import { Chart } from '@/utils/types'
import Modal from '@/app/components/Modal'
import { getJacketUrl } from '@/utils/jacket'
import { getDifficultyColor } from '@/utils/style'
import { Button } from '@/app/components/Button'

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

interface AddScoreButtonProps {
    children?: React.ReactNode
    showSongInfo?: boolean
    defaultChart?: Chart | null
    size?: 'md' | 'lg'
}

export default function AddScoreButton({ children, defaultChart = null, showSongInfo = true, size = 'lg' }: AddScoreButtonProps) {
    const dialogRef = useRef<HTMLDialogElement>(null)
    const [selectedChart, setSelectedChart] = useState<Chart | null>(defaultChart)
    const [errorMessage, setErrorMessage] = useState<string | null>(null)
    const [resetKey, setResetKey] = useState<number>(0) // Used to reset the form after submission
    const [scoreText, setScoreText] = useState<string>('') // Track the score input value

    const max = selectedChart ? 10000000 + selectedChart.note_count : 10000000

    // submit the form data to the server and close the modal
    async function handleSubmit(e: SubmitEvent<HTMLFormElement>) {
        e.preventDefault()
        const form  = e.currentTarget
        const formData = new FormData(form)
        setErrorMessage(null) // Clear any previous error message
        const result = await addScore(formData)

        if (result?.error) {
            setErrorMessage(result.error)
            return
        }
        dialogRef.current?.close()
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

    const judgementInputProps = {
        type: "number",
        max: selectedChart?.note_count ?? 0,
        min: 0,
        disabled: !selectedChart,
        onChange: handleInput,
        className: "no-spinner flex-auto bg-gray-700 text-xl text-center text-white rounded-md border-2 border-gray-400"
    } as const

    const chartInfoElement = (
        <div className="flex items-center justify-start gap-4 ">
            <img src={getJacketUrl(defaultChart?.song_id || "", defaultChart?.difficulty || "", defaultChart?.jacket_override || false)}
                alt="Song Jacket"
                className="w-32 h-32 rounded-lg" />

            <div className="flex flex-col items-start gap-1">
                <span className="text-white text-2xl font-bold">{defaultChart?.title}</span>
                <span className="text-white text-lg font-bold p-2 rounded-md"
                    style={{ backgroundColor: getDifficultyColor(defaultChart?.difficulty ?? "") }}
                >
                    {defaultChart?.difficulty}  {defaultChart?.level}</span>
            </div>
        </div>
    );

    return (
        <SelectedChartContext.Provider value={setSelectedChart}>
            {/* Button to open the add score modal */}
            <Button
                onClick={() => dialogRef.current?.showModal()}
                variant='default'
                size={size}
            >Add Score
            </Button>

            <Modal ref={dialogRef} width="w-[min(40vw,40rem)]"
                onClose={() => {
                    setSelectedChart(defaultChart)
                    setErrorMessage(null)
                    setResetKey(prev => prev + 1)
                    setScoreText('')
                }}
            >
                <form onSubmit={handleSubmit}
                    className={`flex flex-col gap-4 gap-y-7 p-10 justify-center rounded-lg bg-gray-800 border-2 border-gray-400 w-full max-w-5xl`}
                >
                    <h1 className="text-left text-white text-3xl font-bold w-full">Add Score</h1>
                    {showSongInfo && chartInfoElement}

                    <div key={resetKey} className="contents">
                        {/*Hidden input for chart id*/}
                        {children}

                        <div key={selectedChart?.id ?? 'none'} className="contents">
                            {/* Score input field */}
                            <div className="flex flex-col gap-1 w-full justify-center items-center">
                                <input
                                    type="number"
                                    name="score"
                                    placeholder="Score"
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
                                    <input name="pure" placeholder="Pure" {...judgementInputProps} />
                                    <input name="far" placeholder="Far" {...judgementInputProps} />
                                    <input name="lost" placeholder="Lost" {...judgementInputProps} />
                                </div>
                            

                            {/* Cleared checkbox and Clear Status dropdown */}
                            <ClearInfo />
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
                            > Add Score
                            </Button>

                            <Button
                                type="button"
                                onClick={() => dialogRef.current?.close()}
                                variant="danger"
                                size="fill"
                            > Cancel
                            </Button>
                        </div>
                    </div>
                </form>
            </Modal>
        </SelectedChartContext.Provider>
    )
}

function ClearInfo(): React.ReactNode {
    const [isCleared, setIsCleared] = useState(true) // Track if the chart has been cleared
    const [clearStatus, setClearStatus] = useState<string | null>(null) // Track the clear status of the chart

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
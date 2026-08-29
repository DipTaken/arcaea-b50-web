'use client'

import { useRef, useState, createContext, useContext, ChangeEvent } from 'react'
import { addScore } from './actions'
import { Chart } from '@/utils/types'
import Modal from '@/app/components/Modal'
import { getJacketUrl } from '@/utils/jacket'
import { getDifficultyColor } from '@/utils/style'
import { Button } from '@/app/components/Button'

const SelectedChartContext = createContext<(chart: Chart | null) => void>(() => { })
export const useSetSelectedChart = () => useContext(SelectedChartContext)

interface AddScoreButtonProps {
    children?: React.ReactNode
    showSongInfo?: boolean
    defaultChart?: Chart | null
    size?: 'md' | 'lg'
}

export default function AddScoreButton({ children, defaultChart = null, showSongInfo = true, size = 'lg' }: AddScoreButtonProps) {
    const dialogRef = useRef<HTMLDialogElement>(null)
    const [selectedChart, setSelectedChart] = useState<Chart | null>(defaultChart)
    const [isCleared, setIsCleared] = useState(true) // Track if the chart has been cleared
    const [clearStatus, setClearStatus] = useState<string | null>(null) // Track the clear status of the chart
    const [errorMessage, setErrorMessage] = useState<string | null>(null)
    const [resetKey, setResetKey] = useState<number>(0) // Used to reset the form after submission

    const max = selectedChart ? 10000000 + selectedChart.note_count : 10000000

    // submit the form data to the server and close the modal
    async function handleSubmit(formData: FormData) {
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

    const CLEAR_STATUSES = [
        { value: "fail", label: "Fail", cleared: false },
        { value: "easyClear", label: "Clear (Easy)", cleared: true },
        { value: "normalClear", label: "Clear (Normal)", cleared: true },
        { value: "hardClear", label: "Clear (Hard)", cleared: true },
        { value: "fullRecall", label: "Full Recall", cleared: true },
        { value: "pureMemory", label: "Pure Memory", cleared: true }
    ] as const 

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
                    setIsCleared(true)
                    setClearStatus(null)
                }}
            >
                <form action={handleSubmit}
                    className={`flex flex-col gap-4 gap-y-7 p-10 justify-center rounded-lg bg-gray-800 border-2 border-gray-400 w-full max-w-5xl`}
                >
                    <h1 className="text-left text-white text-3xl font-bold w-full">Add Score</h1>
                    {showSongInfo && chartInfoElement}
                   
                    <div key={resetKey} className="contents">
                        {/*Hidden input for chart id*/}
                        {children}

                        <div key={selectedChart?.id ?? 'none'} className="contents">
                            {/* Score input field */}
                            <input
                                type="number"
                                name="score"
                                placeholder="Score"
                                required
                                min={0}
                                max={max}
                                disabled={!selectedChart}
                                onChange={handleInput}
                                className={`no-spinner bg-gray-700 h-20 text-white text-center text-4xl rounded-md w-full border-2 border-gray-400`}
                            />

                            {/* Input fields for Pure, Far, and Lost */}
                            <div className="flex gap-2 h-15 w-full">
                                <input name="pure" placeholder="Pure" {...judgementInputProps} />
                                <input name="far" placeholder="Far" {...judgementInputProps} />
                                <input name="lost" placeholder="Lost" {...judgementInputProps} />
                            </div>

                            {/* Cleared checkbox and Clear Status dropdown */}
                            <div className="flex gap-20 h-15 w-full justify-center items-center">
                                <div className="flex items-center justify-center gap-2">
                                    <label htmlFor="is_cleared" className="text-white text-lg font-bold mr-2">Cleared:</label>
                                    <input 
                                        type="checkbox" 
                                        name="is_cleared" 
                                        placeholder="Cleared"
                                        id="is_cleared" 
                                        checked={isCleared} 
                                        onChange={(e) => setIsCleared(e.target.checked)}
                                        className="w-6 h-6 accent-blue-500"
                                    />
                                </div>
                                
                                <select className={`bg-gray-800 text-white text-center py-3 border-gray-400 rounded-md border-2 px-2`}
                                    onChange={(e) => setClearStatus(e.target.value)}
                                    name="clear_status"
                                    value={clearStatus ?? ""}
                                >
                                    <option value="" disabled hidden>Select Clear Status...</option>
                                    <option value="" hidden >Clear Status...</option>
                                    {CLEAR_STATUSES.map((status) => (
                                        <option key={status.value} value={status.value} disabled={isCleared !== status.cleared}>
                                            {status.label}
                                        </option>
                                    ))}
                                </select>
                            </div>
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
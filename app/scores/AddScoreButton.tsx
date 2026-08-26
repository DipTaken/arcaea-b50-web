'use client'

import { useRef, useState, createContext, useContext, ChangeEvent } from 'react'
import { addScore } from './actions'
import { Chart } from '@/utils/types'
import Modal from '@/app/components/Modal'

const SelectedChartContext = createContext<(chart: Chart | null) => void>(() => { })
export const useSetSelectedChart = () => useContext(SelectedChartContext)

interface AddScoreButtonProps {
    children?: React.ReactNode
    defaultChart?: Chart | null
    sizeClasses?: string
    textClasses?: string
    borderClasses?: string
}

export default function AddScoreButton({ children, defaultChart = null, sizeClasses = "p-2", textClasses = "text-white", borderClasses = "border-white" }: AddScoreButtonProps) {
    const dialogRef = useRef<HTMLDialogElement>(null)
    const [selectedChart, setSelectedChart] = useState<Chart | null>(defaultChart)
    const max = selectedChart ? 10000000 + selectedChart.note_count : 10000000
    const bgColor = "bg-[#16222d]"

    // submit the form data to the server and close the modal
    async function handleSubmit(formData: FormData) {
        await addScore(formData)
        dialogRef.current?.close()
    }

    // Handle input validation for the score input field
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

    return (
        <SelectedChartContext.Provider value={setSelectedChart}>
            <div>
                <button
                    onClick={() => dialogRef.current?.showModal()}
                    className={`${bgColor} hover:bg-gray-700 text-white font-bold ${sizeClasses} ${textClasses} ${borderClasses} rounded-md`
                    }>Add Score</button>
                <Modal ref={dialogRef}>
                    <form
                        action={handleSubmit}
                        className={`flex flex-col h-100 gap-4 gap-y-7 p-10 justify-center items-center rounded-lg bg-gray-800 border-2 border-white w-full max-w-5xl`}>

                        {children}

                        <input
                            type="number"
                            name="score"
                            placeholder="Score"
                            required
                            min={0}
                            max={max}
                            onChange={handleInput}
                            className={`bg-gray-500 h-10 text-white text-center rounded-md w-full border-2`}
                        />

                        <div className="flex gap-2">
                            <input
                                type="number"
                                name="pure"
                                placeholder="Pure"
                                min={0}
                                className="flex-auto bg-gray-500 text-center text-white rounded-md border-2"
                            />
                            <input
                                type="number"
                                name="far"
                                placeholder="Far"
                                min={0}
                                className="flex-auto bg-gray-500 text-center text-white rounded-md border-2"
                            />
                            <input
                                type="number"
                                name="lost"
                                placeholder="Lost"
                                min={0}
                                className="flex-auto bg-gray-500 text-center text-white rounded-md border-2"
                            />
                        </div>

                        <div className="flex gap-4 w-full justify-center items-center h-15">
                            <button
                                type="submit"
                                className={`flex-1 h-full bg-blue-500 font-bold text-white rounded-md border-2`}
                            >Add Score
                            </button>
                            <button
                                type="button"
                                onClick={() => dialogRef.current?.close()}
                                className={`flex-1 h-full bg-red-400 font-bold text-white rounded-md border-2`}
                            >Cancel
                            </button>
                        </div>
                    </form>
                </Modal>
            </div>
        </SelectedChartContext.Provider>
    )
}
'use client'

import { useRef } from 'react'
import ChartSearch from './ChartSearch'
import { addScore } from './actions'
import { Chart } from '@/utils/types'

export default function AddScoreButton({ charts }: { charts: Chart[] }) {
    const dialogRef = useRef<HTMLDialogElement>(null)
    const bgColor = "bg-[#16222d]"
    async function handleSubmit(formData: FormData) {
        await addScore(formData)
        dialogRef.current?.close()
    }

    return (
        <div>
            <button 
                onClick={() => dialogRef.current?.showModal()}
                className={`${bgColor} hover:bg-gray-700 text-white font-bold py-2 px-4 rounded-md`
                }>Add Score</button>
            <dialog 
                ref={dialogRef}
                className="m-auto backdrop:bg-black/50 backdrop:backdrop-blur-sm bg-transparent">
                
                <form 
                    action={handleSubmit}
                    className={`flex flex-col h-100 gap-4 gap-y-7 p-10 justify-center items-center rounded-lg bg-gray-800 border-2 border-white w-full max-w-5xl`}>
                    
                    <div className={`bg-gray-500 text-white text-center rounded-md w-full border-2`}>
                        <ChartSearch charts={charts ?? []} />
                    </div>
    
                    <input 
                        type="number" 
                        name="score" 
                        placeholder="Score" 
                        required 
                        className={`bg-gray-500 h-10 text-white text-center rounded-md w-full border-2`}
                    />
                    
                    <div className="flex gap-2">
                        <input 
                            type="number" 
                            name="pure" 
                            placeholder="Pure" 
                            className="flex-auto bg-gray-500 text-center text-white rounded-md border-2"
                        />
                        <input 
                            type="number" 
                            name="far" 
                            placeholder="Far" 
                            className="flex-auto bg-gray-500 text-center text-white rounded-md border-2"
                        />
                        <input 
                            type="number" 
                            name="lost" 
                            placeholder="Lost" 
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
            </dialog>
        </div>
    )
}
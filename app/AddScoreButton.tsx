'use client'

import { useRef } from 'react'
import ChartSearch from './scores/ChartSearch'
import { addScore } from './scores/actions'

type Chart = {
    id: number
    title: string
    difficulty: string
}

export default function AddScoreButton({ charts }: { charts: Chart[] }) {
    const dialogRef = useRef<HTMLDialogElement>(null)

    async function handleSubmit(formData: FormData) {
        await addScore(formData)
        dialogRef.current?.close()
    }

    return (
        <div>
            <button onClick={() => dialogRef.current?.showModal()}>Add Score</button>
            <dialog ref={dialogRef}>
                <form action={handleSubmit}>
                    <ChartSearch charts={charts ?? []} />
    
                    <input type="number" name="score" placeholder="Score" required />
                    <input type="number" name="pure" placeholder="Pure" />
                    <input type="number" name="far" placeholder="Far" />
                    <input type="number" name="lost" placeholder="Lost" />
    
                    <button type="submit">Add Score</button>
                    <button type="button" onClick={() => dialogRef.current?.close()}>Cancel</button>
                </form>
            </dialog>
        </div>
    )
}
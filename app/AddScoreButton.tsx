'use client'

import { useState } from 'react'
import ChartSearch from './scores/ChartSearch'
import { addScore } from './scores/actions'

type Chart = {
    id: number
    title: string
    difficulty: string
}

export default function AddScoreButton({ charts }: { charts: Chart[] }) {
    const [open, setOpen] = useState(false)

    return (
        <div>
            <button onClick={() => setOpen(!open)}> Add Score </button>
            {open && (
                <form action={addScore}>
                    <ChartSearch charts={charts ?? []} />
    
                    <input type="number" name="score" placeholder="Score" required />
                    <input type="number" name="pure" placeholder="Pure" />
                    <input type="number" name="far" placeholder="Far" />
                    <input type="number" name="lost" placeholder="Lost" />
    
                    <button type="submit">Add Score</button>
                </form>)}
        </div>
    )
}
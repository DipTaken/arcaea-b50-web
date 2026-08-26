'use client'

import { ScoreWithChart } from '@/utils/types'
import { useRef, useState, useEffect } from 'react'
import ScoreCard from './ScoreCard'
import ScoreModal from './ScoreModal'

export default function ScoreGrid({ scores }: { scores: ScoreWithChart[] }) {
    const [selectedScore, setSelectedScore] = useState<ScoreWithChart | null>(null)
    const dialogRef = useRef<HTMLDialogElement>(null)
    
    useEffect(() => {
        if (selectedScore) dialogRef.current?.showModal()
    }, [selectedScore])

    return (
        <div>
            {/* Display the scores in a grid */}
            <ul className="grid grid-cols-[repeat(5,230px)] gap-y-10 w-fit justify-items-center mx-auto">
                {scores?.map((score, index) => (
                    <ScoreCard key={score.id} score={score} index={index} onSelect={setSelectedScore} />
                ))}
            </ul>

            {/* Score Modal (opened when a score card is clicked) */}
            <ScoreModal score={selectedScore} ref={dialogRef} onClose={() => setSelectedScore(null)} />
        </div>
    )
}

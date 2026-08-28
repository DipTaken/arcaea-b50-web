'use client'

import { ScoreWithChart } from '@/utils/types'
import { useRef, useState, useEffect } from 'react'
import ScoreCard from './ScoreCard'
import ScoreModal from './ScoreModal'
import { CardGrid } from '@/app/components/CardGrid'

export default function ScoreGrid({ scores }: { scores: ScoreWithChart[] }) {
    const [selectedScore, setSelectedScore] = useState<ScoreWithChart | null>(null)
    const dialogRef = useRef<HTMLDialogElement>(null)
    
    useEffect(() => {
        if (selectedScore) dialogRef.current?.showModal()
    }, [selectedScore])

    return (
        <>
            {/* Display the scores in a grid */}
            <CardGrid>
                {scores?.map((score, index) => (
                    <ScoreCard key={score.id} score={score} index={index} onSelect={setSelectedScore} />
                ))}
            </CardGrid>

            {/* Score Modal (opened when a score card is clicked) */}
            <ScoreModal score={selectedScore} ref={dialogRef} onClose={() => setSelectedScore(null)} />
        </>
    )
}

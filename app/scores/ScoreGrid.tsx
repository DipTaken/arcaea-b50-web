'use client'

import { B50Entry } from '@/utils/types'
import { useRef, useState, useEffect } from 'react'
import ScoreCard from './ScoreCard'
import ScoreModal from './ScoreModal'
import { CardGrid } from '@/app/components/CardGrid'

export default function ScoreGrid({ entries }: { entries: B50Entry[] }) {
    const [selectedId, setSelectedId] = useState<number | null>(null)
    const selectedEntry = entries.find(e => e.score.id === selectedId) ?? null
    const dialogRef = useRef<HTMLDialogElement>(null)
    
    useEffect(() => {
        if (selectedEntry) dialogRef.current?.showModal()
    }, [selectedEntry])

    return (
        <>
            {/* Display the scores in a grid */}
            <CardGrid>
                {entries?.map((entry) => (
                    <ScoreCard key={entry.score.id} entry={entry} onSelect={(entry) => setSelectedId(entry.score.id)} />
                ))}
            </CardGrid>

            {/* Score Modal (opened when a score card is clicked) */}
            <ScoreModal score={selectedEntry?.score ?? null} ref={dialogRef} onClose={() => setSelectedId(null)} />
        </>
    )
}

'use client'

import { useRef, useState } from 'react'
import { Chart, ScoreWithChart } from '@/utils/types'
import Modal from '@/app/components/Modal'
import { Button } from '@/app/components/Button'
import { deleteScore } from './actions'

interface DeleteScoreButtonProps {
    defaultChart?: Chart | null
    score?: ScoreWithChart | null
    size?: 'md' | 'lg'
}

export default function DeleteScoreButton({ defaultChart = null, score, size = 'lg' }: DeleteScoreButtonProps) {
    const dialogRef = useRef<HTMLDialogElement>(null)

    return (
        //waiting on jeaneskut's branch to be merged before implementing this button
        <div>
            <Button variant='danger' size={size} onClick={() => dialogRef.current?.showModal()}>Delete Score</Button>
        </div>
    )
}


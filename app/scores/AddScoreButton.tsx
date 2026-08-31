'use client'

import { useRef, useState } from 'react'
import { Chart } from '@/utils/types'
import Modal from '@/app/components/Modal'
import { Button } from '@/app/components/Button'
import ScoreForm from './ScoreForm'
import { addScore } from './actions'

interface AddScoreButtonProps {
    children?: React.ReactNode
    showSongInfo?: boolean
    defaultChart?: Chart | null
    size?: 'md' | 'lg'
}

export default function AddScoreButton({ children, defaultChart = null, showSongInfo = true, size = 'lg' }: AddScoreButtonProps) {
    const dialogRef = useRef<HTMLDialogElement>(null)
    const [resetKey, setResetKey] = useState<number>(0) // Used to reset the form after submission

    return (
        <div>
            {/* Button to open the add score modal */}
            <Button
                onClick={() => dialogRef.current?.showModal()}
                variant='default'
                size={size}
            >Add Score
            </Button>

            <Modal ref={dialogRef} width="w-[min(40vw,40rem)]"
                onClose={() => {
                    setResetKey(prev => prev + 1)
                }}
            >
                <ScoreForm key={resetKey}
                    defaultChart={defaultChart}
                    onSubmit={addScore}
                    onClose={() => dialogRef.current?.close()}
                    submitLabel="Add Score"
                    showSongInfo={showSongInfo}
                >
                    {children}
                </ScoreForm>
            </Modal>
        </div>
    )
}


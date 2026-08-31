'use client'

import { useRef, useState } from 'react'
import { Chart, ScoreWithChart } from '@/utils/types'
import Modal from '@/app/components/Modal'
import { Button } from '@/app/components/Button'
import ScoreForm from './ScoreForm'
import { editScore } from './actions'

interface EditScoreButtonProps {
    defaultChart?: Chart | null
    score?: ScoreWithChart | null
    size?: 'md' | 'lg'
}

export default function EditScoreButton({ defaultChart = null, score, size = 'lg' }: EditScoreButtonProps) {
    const dialogRef = useRef<HTMLDialogElement>(null)
    const [resetKey, setResetKey] = useState<number>(0) // Used to reset the form after submission

    const initialValues = score ? {
        score: score.score,
        pure: score.pure,
        far: score.far,
        lost: score.lost,
        clear_status: score.clear_status,
    } : undefined

    return (
        <div>
            {/* Button to open the edit score modal */}
            <Button
                onClick={() => dialogRef.current?.showModal()}
                variant='default'
                size={size}
            >Edit Score
            </Button>

            <Modal ref={dialogRef} width="w-[min(40vw,40rem)]"
                onClose={() => {
                    setResetKey(prev => prev + 1)
                }}
            >
                {score ? (
                    <ScoreForm key={resetKey}
                        defaultChart={defaultChart}
                        onSubmit={editScore}
                        onClose={() => dialogRef.current?.close()}
                        submitLabel="Edit Score"
                        showSongInfo={true}
                        initialValues={initialValues}
                    >
                        <input type="hidden" name="score_id" value={score?.id} />
                        <input type="hidden" name="chart_id" value={score?.charts.id} />
                    </ScoreForm>
                ) :
                    <p className="text-center text-3xl text-red-500">No score data available for editing.</p>
                }


            </Modal>
        </div>
    )
}


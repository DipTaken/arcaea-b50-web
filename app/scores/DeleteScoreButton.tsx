'use client'

import { useRef, useState } from 'react'
import { ScoreWithChart } from '@/utils/types'
import Modal from '@/app/components/Modal'
import { Button } from '@/app/components/Button'
import { deleteScore } from './actions'

interface DeleteScoreButtonProps {
    score?: ScoreWithChart | null
    size?: 'md' | 'lg'
    onDeleted?: () => void
}

export default function DeleteScoreButton({ score, size = 'lg', onDeleted }: DeleteScoreButtonProps) {
    const dialogRef = useRef<HTMLDialogElement>(null)
    const [errorMessage, setErrorMessage] = useState<string | null>(null)

    // submit the form data to the server and close the modal
    async function handleDelete() {
        setErrorMessage(null) // Clear any previous error message

        if (!score) {
            setErrorMessage("No score to delete")
            return
        }

        const result = await deleteScore(score.id);

        if (result?.error) {
            setErrorMessage(result.error)
            return
        }
        dialogRef.current?.close() // close the modal
        onDeleted?.()
    }


    return (
        <div>
            <Button variant='danger' size={size} onClick={() => dialogRef.current?.showModal()}>Delete Score</Button>

            <Modal ref={dialogRef} width="w-[min(40vw,40rem)]" onClose={() => setErrorMessage(null)}>
                <div className="flex flex-col gap-4 gap-y-7 p-10 justify-center rounded-lg bg-gray-800 border-2 border-gray-400 w-full max-w-5xl text-white" >
                    <h1 className="text-center text-white text-3xl font-bold w-full"> Delete Score? </h1>
                    <h2 className="text-center text-red-500 text-lg font-bold w-full"> This cannot be undone. </h2>

                    {score ? (
                        <div className="flex gap-4 w-full justify-center items-center h-15">
                            <Button
                                type="button"
                                onClick={handleDelete}
                                variant="danger"
                                size="fill"
                            > Delete Score
                            </Button>

                            <Button
                                type="button"
                                onClick={() => dialogRef.current?.close()}
                                variant="primary"
                                size="fill"
                            > Cancel
                            </Button>
                        </div>
                    ) :
                        <p className="text-center text-white font-bold text-2xl">No score to delete</p>
                    }
                    {errorMessage && (<p className="text-center text-red-500 font-bold text-2xl">{errorMessage}</p>)}
                </div>
            </Modal >
        </div >
    )
}
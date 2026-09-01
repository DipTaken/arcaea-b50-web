'use client'
import Modal from "../components/Modal"
import { Button } from "../components/Button"
import { useRef, useState } from "react"

export function DeleteScoreModal() {
    const dialogRef = useRef<HTMLDialogElement>(null)

    return (
        <div>
            <Button onClick={()=>dialogRef.current?.showModal()} variant="default" size="lg">
                Delete Score
            </Button>

            <Modal ref={dialogRef} width="w-[min(40vw,40rem)]">
                <div className="flex flex-col gap-4 gap-y-7 p-10 justify-center rounded-lg bg-gray-800 border-2 border-gray-400 w-full max-w-5xl text-white" > 
                    <h1 className="text-center text-white text-3xl font-bold w-full"> Delete Score? </h1>
                    <h2 className="text-center text-red-500 text-lg font-bold w-full"> This cannot be undone. </h2>

                    <div className="flex gap-4 w-full justify-center items-center h-15">
                            <Button
                                type="reset"
                                onClick={() => dialogRef.current?.close()}
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

                </div>

            </Modal>

        </div>


    )

}
'use client'

import { ReactNode, useState, useTransition } from 'react'
import ImportFromBrowser from "./ImportFromBrowser"

export default function ImportFromBrowserButton({ children }: { children?: ReactNode }) {
    const [isPending, startTransition] = useTransition()
    const [message, setMessage] = useState<string | null>(null)

    // Handle the import process when the button is clicked
    const handleImport = () => {
        setMessage(null)
        startTransition(async () => {
            const res = await ImportFromBrowser()
            if (res.error) {
                setMessage(`${res.error}`)
            }
            else {
                setMessage(`Imported ${res.count} scores`)
            }
        })
    }

    return (
        // Button to trigger the import process
        <div className="flex flex-col items-start gap-2">
            <div className="flex gap-5">
                {children}
                <button
                    onClick={handleImport}
                    disabled={isPending}
                    className={`border-2 border-gray-400 bg-gray-800 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded-md disabled:opacity-80`}
                >
                    Import Browser Scores to Account
                </button>
            </div>
            <div className="h-5 w-full items-center justify-end">
                {message && <p className="text-sm text-neutral-400 text-right">{message}</p>}
            </div>
        </div>
    )
}
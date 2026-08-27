'use client'

import { useState, useTransition } from 'react'
import ImportFromBrowser from "./ImportFromBrowser"

export default function ImportFromBrowserButton() {
    const [isPending, startTransition] = useTransition()
    const [message, setMessage] = useState<string | null>(null)

    const bgColor = "bg-[#16222d]"

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
            <button
                onClick={handleImport}
                disabled={isPending}
                className={`${bgColor} hover:bg-gray-700 text-white font-bold py-2 px-4 rounded-md disabled:opacity-80`}
            >
                Import Browser Scores to Account
            </button>
            {message && <p className="text-sm text-neutral-400">{message}</p>}
        </div>
    )
}
'use client'

import { useState, useTransition } from 'react'
import ImportFromBrowser from "./ImportFromBrowser"

export default function ImportFromBrowserButton() {
    const [isPending, startTransition] = useTransition()
    const [message, setMessage] = useState<string | null>(null)

    const handleImport = () => {
        setMessage(null)
        startTransition(async () => {
            const res = await ImportFromBrowser()
            if (res.error) {
                setMessage(`${res.error}`)
            } else {
                setMessage(`Successfully imported ${res.count} scores!`)
            }
        })
    }
    const bgColor = "bg-[#16222d]"
    return (
        <div className="flex flex-col items-start gap-2">
            <button
                onClick={handleImport}
                disabled={isPending}
                className={`${bgColor} hover:bg-gray-700 text-white font-bold py-2 px-4 rounded-md disabled:opacity-80`}
            >
                {isPending ? 'Importing...' : 'Import Guest Scores to Account'}
            </button>
            {message && <p className="text-sm text-neutral-400">{message}</p>}
        </div>
    )
}
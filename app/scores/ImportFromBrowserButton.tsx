'use client'

import { ReactNode, useState, useTransition } from 'react'
import ImportFromBrowser from "./ImportFromBrowser"
import { Button } from '../components/Button'

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
                <Button
                    onClick={handleImport}
                    disabled={isPending}
                    variant="default"
                    size="md"
                >
                    Import Browser Scores to Account
                </Button>
            </div>
            <div className="h-5 w-full">
                {message && <p className="text-sm text-neutral-400 text-center">{message}</p>}
            </div>
        </div>
    )
}
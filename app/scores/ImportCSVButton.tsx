'use client'

import Modal from "@/app/components/Modal";
import { useRef, useState } from "react";
import { Button } from "../components/Button";
import { Chart, ImportScore, RowError } from "@/utils/types"
import { parseCsv, validateImportScores } from "./parseCsv";
import { getClearStatus } from "@/utils/rating";
import { Panel } from "../components/Panel";
import Link from "next/link";
import { getDifficultyColor, scrollbarStyle } from "@/utils/style";

export default function ImportCSVButton({ charts }: { charts: Chart[] }) {
    const dialogRef = useRef<HTMLDialogElement>(null)
    const [isImporting, setIsImporting] = useState(false)
    const [showTable, setShowTable] = useState(false)
    const [text, setText] = useState('')
    const { scores, errors } = validateImportScores(charts, parseCsv(text).data)

    const chartsById = new Map(charts.map(c => [c.id, c]))

    async function handleImport() {
        //not working yet
    }

    return (
        <div>
            {/* Button to open the Import CSV modal */}
            <Button
                onClick={() => dialogRef.current?.showModal()}
                variant='default'
                size={'lg'}
            >Import From CSV
            </Button>

            <Modal ref={dialogRef} width="w-[min(90vw,90rem)]"
                onClose={() => {
                    setShowTable(false)
                    setText('')
                    setIsImporting(false)
                }}>
                {!showTable && (
                    <ImportTextArea
                        scores={scores}
                        errors={errors}
                        text={text}
                        isImporting={isImporting}
                        setIsImporting={setIsImporting}
                        setText={setText}
                        setShowTable={setShowTable}
                    />
                )}
                {showTable && (
                    <ImportPreview
                        scores={scores}
                        charts={chartsById}
                        isImporting={isImporting}
                        handleImport={handleImport}
                        setShowTable={setShowTable}
                    />
                )}
            </Modal>
        </div>
    )
}

interface ImportTextAreaProps {
    scores: ImportScore[];
    errors: RowError[];
    text: string;
    isImporting: boolean;
    setIsImporting: (isImporting: boolean) => void;
    setText: (text: string) => void;
    setShowTable: (showTable: boolean) => void;
}

function ImportTextArea({ scores, errors, text, isImporting, setIsImporting, setText, setShowTable }: ImportTextAreaProps) {
    return (
        <Panel>
            <h1 className="text-white text-2xl font-bold">
                Import Scores from Spreadsheet/CSV
            </h1>
            <h2 className="text-white text-lg">
                {`Need help? Check out the `}
                <Link href="/docs/importing-scores" className="text-blue-400 underline">
                    documentation
                </Link>
                {` for more information.`}
            </h2>

            {/* text area to paste csv/tsv */}
            <textarea
                className={`w-full p-2 bg-gray-700 text-white border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 font-mono ${scrollbarStyle}`}
                autoCapitalize="off"
                autoCorrect="off"
                spellCheck={false}
                wrap="off"
                rows={12}
                placeholder="Paste your CSV data here..."
                value={text}
                onChange={(e) => setText(e.target.value)}
            />
            <div className="flex justify-between items-center gap-4">
                <p className="text-sm text-gray-500">Paste your data here. The first row should be the header.</p>
            </div>

            <ImportErrorList errors={errors} />

            {scores.length > 0 && (
                <p className="text-sm text-white font-bold">
                    {scores.length} scores will be imported, {errors.length} rows skipped.
                </p>
            )}
            {errors.length > 0 && (
                <p className="text-sm text-white font-bold">
                    Skipped rows won't be imported — fix them and paste again to include them.
                </p>
            )}
            
            <Button variant='default' size={'lg'} onClick={() => setShowTable(true)} disabled={scores.length === 0}>
                {isImporting ? 'Importing...' : 'Import'}
            </Button>

        </Panel>
    )
}

interface ImportPreviewProps {
    scores: ImportScore[];
    charts: Map<number, Chart>;
    isImporting: boolean;
    handleImport: () => void;
    setShowTable: (show: boolean) => void;
}

function ImportPreview({ scores, charts, isImporting, handleImport, setShowTable }: ImportPreviewProps) {
    return (
        <Panel>
            <h1 className="text-white text-2xl font-bold">
                Import Preview
            </h1>
            <h2 className="text-white text-lg">
                {scores.length} scores will be imported. Errors will be skipped. Please review the data below before importing.
            </h2>

            <PreviewTable scores={scores} charts={charts} />

            <div className="flex justify-between items-center gap-4 mt-4">
                <Button variant='primary' size={'lg'} onClick={handleImport} disabled={scores.length === 0}>
                    {isImporting ? 'Importing...' : `Import ${scores.length} Scores`}
                </Button>

                <Button variant='default' size={'lg'} onClick={() => setShowTable(false)} disabled={scores.length === 0 || isImporting}>
                    Go back
                </Button>
            </div>
        </Panel >

    )
}

function ImportErrorList({ errors }: { errors: RowError[] }) {
    return (
        <div className="w-full ">
            {errors.length > 0 && (
                <ul className={`p-2 border border-gray-300 rounded-md bg-gray-700 max-h-28 overflow-y-auto ${scrollbarStyle}`}>
                    {errors.map((error, index) => (
                        <li key={index} className="text-red-700 text-sm font-bold">
                            Row {error.rowNumber}: {error.error}
                        </li>
                    ))}
                </ul>
            )}
        </div>
    )
}

function PreviewTable({ scores, charts }: { scores: ImportScore[], charts: Map<number, Chart> }) {
    const tableHeaderClass = "sticky top-0 bg-gray-700 border border-gray-300 p-2"
    const tableCellClass = "border border-gray-300 p-2"

    return (
        <div className={`w-full max-h-96 overflow-y-auto border-2 border-gray-300 rounded-lg ${scrollbarStyle}`}>
            <table className="w-full border-collapse  text-white ">
                <thead>
                    <tr>
                        <th className={tableHeaderClass}>Chart</th>
                        <th className={tableHeaderClass}>Score</th>
                        <th className={tableHeaderClass}>Pure</th>
                        <th className={tableHeaderClass}>Far</th>
                        <th className={tableHeaderClass}>Lost</th>
                        <th className={tableHeaderClass}>Clear Status</th>
                    </tr>
                </thead>
                <tbody>
                    {scores.map((score, index) => {
                        const chart = charts.get(score.chartId)
                        return (
                            <tr key={index} className="even:bg-white/10 odd:bg-gray-800 hover:bg-blue-600/50">
                                <td className={tableCellClass}>
                                    <div className="flex gap-3">
                                        <span>{chart ? chart.title : 'Unknown'}</span>
                                        <div>
                                            <span className="py-1 px-2 rounded-md font-bold text-sm"
                                                style={{ backgroundColor: getDifficultyColor(chart?.difficulty ?? "") }}
                                            >
                                                {chart ? chart.difficulty : 'Unknown'}

                                            </span>
                                        </div>
                                    </div>
                                </td>
                                <td className={tableCellClass}>{Number(score.scoreValue).toLocaleString('en-US')}</td>
                                <td className={tableCellClass}>{score.pure ?? '—'}</td>
                                <td className={tableCellClass}>{score.far ?? '—'}</td>
                                <td className={tableCellClass}>{score.lost ?? '—'}</td>
                                <td className={tableCellClass}>{getClearStatus(score.clear_status, 'long')}</td>
                            </tr>
                        )
                    })}
                </tbody>
            </table>
        </div>
    )
}
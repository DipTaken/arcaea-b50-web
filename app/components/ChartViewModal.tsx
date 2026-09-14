import Modal from '@/app/components/Modal'
import SongInfo from '@/app/components/SongInfo'
import { Chart, Score } from '@/utils/types'
import AddScoreButton from '../scores/AddScoreButton'
import { Panel } from '@/app/components/Panel'

interface ChartViewModalProps {
    chart: Chart
    score: Score | null
    ref: React.RefObject<HTMLDialogElement | null>
    onClose: () => void
    detailPanel?: React.ReactNode
    buttonBar?: React.ReactNode
}

export default function ChartViewModal({ chart, score, ref, onClose, detailPanel, buttonBar }: ChartViewModalProps) {
    return (
        <Modal ref={ref} onClose={onClose}>
            {chart && (
                <div>
                    {/* Modal content */}
                    <Panel>
                        <SongInfo chart={chart} />
                        {detailPanel}
                    </Panel>

                    {/* Button Bar */}
                    <div className="flex justify-between gap-2 mt-4">
                        {buttonBar ?? (
                            <div className="flex justify-center w-full">
                                <AddScoreButton key={chart.id} defaultChart={chart}>
                                    <input type="hidden" name="chart_id" value={chart.id} />
                                </AddScoreButton>
                            </div>
                        )}
                    </div>
                </div>
            )}
        </Modal>
    )
}

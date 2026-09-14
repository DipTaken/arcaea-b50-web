import ChartViewModal from '@/app/components/ChartViewModal'
import { ScoreWithChart } from '@/utils/types'
import AddScoreButton from '../scores/AddScoreButton';
import ScoreInfo from './ScoreInfo';
import EditScoreButton from './EditScoreButton';
import DeleteScoreButton from './DeleteScoreButton';

interface ScoreModalProps {
    scoreWithChart: ScoreWithChart | null
    ref: React.RefObject<HTMLDialogElement | null>
    onClose: () => void
    onDeleted: () => void
}

// One shared modal for the whole score grid.
export default function ScoreModal({ scoreWithChart, ref, onClose, onDeleted }: ScoreModalProps) {
    if (!scoreWithChart) return null
    return (
        <ChartViewModal
            chart={scoreWithChart.charts}
            score={scoreWithChart}
            ref={ref}
            onClose={onClose}
            detailPanel={<ScoreInfo score={scoreWithChart} />}
            buttonBar={
                <div>
                    <AddScoreButton key={scoreWithChart.charts.id} defaultChart={scoreWithChart.charts}>
                        <input type="hidden" name="chart_id" value={scoreWithChart.charts.id} />
                    </AddScoreButton>
                    <EditScoreButton key={`edit-${scoreWithChart.id}`} defaultChart={scoreWithChart.charts} score={scoreWithChart} />
                    <DeleteScoreButton key={`delete-${scoreWithChart.id}`} score={scoreWithChart} onDeleted={onDeleted} />
                </div>
            }
        />
    )
}
import ChartViewModal from '@/app/components/ChartViewModal'
import { Chart } from '@/utils/types'

// One shared modal for the whole browse grid.
export default function BrowseModal({ chart, ref, onClose }: { chart: Chart | null; ref: React.RefObject<HTMLDialogElement | null>; onClose: () => void }) {
    if (!chart) return null
    return (
        <ChartViewModal chart={chart} score={null} ref={ref} onClose={onClose} />
    )
}
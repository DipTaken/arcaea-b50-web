import Modal from '@/app/components/Modal'
import SongInfo from '@/app/components/SongInfo'
import { Chart } from '@/utils/types'
import AddScoreButton from '../scores/AddScoreButton';

export default function BrowseModal({ chart, ref }: { chart: Chart; ref: React.RefObject<HTMLDialogElement | null> }) {
    return (
        <div>
            <Modal ref={ref}>
                <div className="flex flex-col gap-4 p-10 justify-center items-center rounded-lg bg-gray-800 border-2 border-white w-full max-w-5xl">
                    <SongInfo chart={chart} />
                </div>
                <AddScoreButton>
                    <input type="hidden" name="chart_id" value={chart.id} />
                </AddScoreButton>
            </Modal>
        </div>

    )
}
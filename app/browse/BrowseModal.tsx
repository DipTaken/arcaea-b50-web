import Modal from '@/app/components/Modal'
import SongInfo from '@/app/components/SongInfo'
import { Chart } from '@/utils/types'
import AddScoreButton from '../scores/AddScoreButton';

// This modal component pops up when the browse card is clicked
export default function BrowseModal({ chart, ref }: { chart: Chart; ref: React.RefObject<HTMLDialogElement | null> }) {
    return (
        <div>
            <Modal ref={ref}>   
                {/* Modal content */}
                <div className="flex flex-col gap-4 p-10 justify-center items-center rounded-lg bg-gray-800 border-2 border-white w-full max-w-5xl">
                    <SongInfo chart={chart} />
                </div>
                
                {/* Add Score Button */}
                <div className="flex justify-center">
                    <AddScoreButton defaultChart={chart} sizeClasses="py-5 px-15" textClasses="text-white text-xl" borderClasses="border-2 border-white">
                        <input type="hidden" name="chart_id" value={chart.id} />
                    </AddScoreButton>
                </div>
            </Modal>
        </div>
    )
}
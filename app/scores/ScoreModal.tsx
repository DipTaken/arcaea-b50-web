import Modal from '@/app/components/Modal'
import SongInfo from '@/app/components/SongInfo'
import { ScoreWithChart } from '@/utils/types'
import AddScoreButton from '../scores/AddScoreButton';
import ScoreInfo from './ScoreInfo';


// One shared modal for the whole score grid.
export default function ScoreModal({ score, ref, onClose }: { score: ScoreWithChart | null; ref: React.RefObject<HTMLDialogElement | null>, onClose: () => void }) {
    return (
        <Modal ref={ref} onClose={onClose}>
            {score && (
                <>
                    {/* Modal content */}
                    <div className="flex flex-col gap-4 p-10 justify-center items-center rounded-lg bg-gray-800 border-2 border-white w-full max-w-5xl">
                        <SongInfo chart={score.charts} />
                        <ScoreInfo score={score} />
                    </div>

                    {/* Add Score Button. */}
                    <div className="flex justify-center">
                        <AddScoreButton key={score.charts.id} defaultChart={score.charts} sizeClasses="py-5 px-15" textClasses="text-white text-xl" borderClasses="border-2 border-white">
                            <input type="hidden" name="chart_id" value={score.charts.id} />
                        </AddScoreButton>
                    </div>
                </>
            )}
        </Modal>
    )
}
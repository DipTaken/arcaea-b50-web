import Modal from '@/app/components/Modal'
import SongInfo from '@/app/components/SongInfo'
import { ScoreWithChart } from '@/utils/types'
import AddScoreButton from '../scores/AddScoreButton';
import ScoreInfo from './ScoreInfo';
import { Panel } from '@/app/components/Panel';


// One shared modal for the whole score grid.
export default function ScoreModal({ score, ref, onClose }: { score: ScoreWithChart | null; ref: React.RefObject<HTMLDialogElement | null>, onClose: () => void }) {
    return (
        <Modal ref={ref} onClose={onClose}>
            {score && (
                <>
                    {/* Modal content */}
                    <Panel>
                        <SongInfo chart={score.charts} />
                        <ScoreInfo score={score} />
                    </Panel>

                    {/* Add Score Button. */}
                    <div className="flex justify-center">
                        <AddScoreButton key={score.charts.id} defaultChart={score.charts}>
                            <input type="hidden" name="chart_id" value={score.charts.id} />
                        </AddScoreButton>
                    </div>
                </>
            )}
        </Modal>
    )
}
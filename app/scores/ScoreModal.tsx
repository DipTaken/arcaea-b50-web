import Modal from '@/app/components/Modal'
import SongInfo from '@/app/components/SongInfo'
import { ScoreWithChart } from '@/utils/types'
import AddScoreButton from '../scores/AddScoreButton';
import ScoreInfo from './ScoreInfo';
import { Panel } from '@/app/components/Panel';
import EditScoreButton from './EditScoreButton';
import DeleteScoreButton from './DeleteScoreButton';


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

                    {/* Button Bar */}
                    <div className="flex justify-between gap-2 mt-4">
                        <AddScoreButton key={score.charts.id} defaultChart={score.charts}>
                            <input type="hidden" name="chart_id" value={score.charts.id} />
                        </AddScoreButton>

                        <EditScoreButton key={`edit-${score.id}`} defaultChart={score.charts} score={score} />

                        <DeleteScoreButton key={`delete-${score.id}`} defaultChart={score.charts} score={score} />
                    </div>
                </>
            )}
        </Modal>
    )
}
import Modal from '@/app/components/Modal'
import SongInfo from '@/app/components/SongInfo'
import { Chart } from '@/utils/types'
import AddScoreButton from '../scores/AddScoreButton'
import { Panel } from '@/app/components/Panel'

// One shared modal for the whole browse grid. BrowseSearch renders this once and points
// it at whichever chart is selected, so the page holds a single <dialog> rather than one
// per card. `chart` is null while nothing is open, which unmounts the contents entirely.
export default function BrowseModal({ chart, ref, onClose }: { chart: Chart | null; ref: React.RefObject<HTMLDialogElement | null>; onClose: () => void }) {
    return (
        <Modal ref={ref} onClose={onClose}>
            {chart && (
                <>
                    {/* Modal content */}
                    <Panel>
                        <SongInfo chart={chart} />
                    </Panel>

                    {/* Add Score Button. Keyed on the chart so it remounts (and re-seeds its
                        defaultChart state) whenever a different chart is opened. */}
                    <div className="flex justify-center">
                        <AddScoreButton key={chart.id} defaultChart={chart}>
                            <input type="hidden" name="chart_id" value={chart.id} />
                        </AddScoreButton>
                    </div>
                </>
            )}
        </Modal>
    )
}

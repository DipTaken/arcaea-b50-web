import Modal from '@/app/components/Modal'
import SongInfo from '@/app/components/SongInfo'
import { Chart } from '@/utils/types'
import AddScoreButton from '../scores/AddScoreButton'

// One shared modal for the whole browse grid. BrowseSearch renders this once and points
// it at whichever chart is selected, so the page holds a single <dialog> rather than one
// per card. `chart` is null while nothing is open, which unmounts the contents entirely.
export default function BrowseModal({ chart, ref, onClose }: { chart: Chart | null; ref: React.RefObject<HTMLDialogElement | null>; onClose: () => void }) {
    return (
        <Modal ref={ref} onClose={onClose}>
            {chart && (
                <>
                    {/* Modal content */}
                    <div className="flex flex-col gap-4 p-10 justify-center items-center rounded-lg bg-gray-800 border-2 border-gray-400 w-full max-w-5xl">
                        <SongInfo chart={chart} />
                    </div>

                    {/* Add Score Button. Keyed on the chart so it remounts (and re-seeds its
                        defaultChart state) whenever a different chart is opened. */}
                    <div className="flex justify-center">
                        <AddScoreButton key={chart.id} defaultChart={chart} sizeClasses="py-5 px-15" textClasses="text-white text-xl" borderClasses="border-2 border-gray-400">
                            <input type="hidden" name="chart_id" value={chart.id} />
                        </AddScoreButton>
                    </div>
                </>
            )}
        </Modal>
    )
}

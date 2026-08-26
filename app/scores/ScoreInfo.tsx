import { ScoreWithChart } from '@/utils/types'

export default function ScoreInfo({ score }: { score: ScoreWithChart }) {
    return (
        <div className="flex gap-4 p-4 justify-start items-center rounded-lg bg-gray-800 border-2 border-white w-full">
            <p className="text-white text-lg font-bold">Score: {score.score.toLocaleString()}</p>
        </div>
    )
}
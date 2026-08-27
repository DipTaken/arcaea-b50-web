import { Chart } from '@/utils/types'
import { getJacketUrl } from '@/utils/jacket'
import { getDifficultyColor } from '@/utils/style'

//shows the song info for a given chart, including
//jacket, title, artist, difficulty, level, constant, note count, bpm, length, version, chart designer, and jacket artist
export default function SongInfo({ chart }: { chart: Chart }) {
    return (
        <div className="grid grid-cols-[1fr_2fr] w-full">
            <div className="flex flex-col text-lg justify-center text-white w-full gap-5">
                {/* Difficulty */}
                <p>
                    <span className="font-bold">Difficulty: </span>
                    <span className="py-1 px-3 rounded-md font-bold"
                        style={{ backgroundColor: getDifficultyColor(chart?.difficulty ?? "")}}>
                        {chart.difficulty ? chart.difficulty : 'Unknown'}
                    </span>
                </p>
                {/* Level */}
                <p>
                    <span className="font-bold ">Level: </span>
                    <span>{chart.level ? chart.level : 'Unknown'}</span>
                </p>
                {/* Constant */}
                <p>
                    <span className="font-bold">Constant: </span>
                    <span>{chart.chart_constant ? chart.chart_constant?.toFixed(1) : 'Unknown'}</span>
                </p>
                {/* Note Count */}
                <p>
                    <span className="font-bold">Note Count: </span>
                    <span>{chart.note_count ? chart.note_count : 'Unknown'}</span>
                </p>
                {/* BPM */}
                <p>
                    <span className="font-bold">BPM: </span>
                    <span>{chart.bpm ? chart.bpm : 'Unknown'}</span>
                </p>
                {/* Length */}
                <p>
                    <span className="font-bold">Length: </span>
                    <span>{chart.length ? chart.length : 'Unknown'}</span>
                </p>
                {/* Version */}
                <p>
                    <span className="font-bold">Version: </span>
                    <span>{chart.version ? chart.version : 'Unknown'}</span>
                </p>
                {/* Chart Designer */}
                <p>
                    <span className="font-bold">Chart Designer: </span>
                    <span>{chart.chart_designer ? chart.chart_designer : 'Unknown'}</span>
                </p>
                {/* Jacket Artist */}
                <p>
                    <span className="font-bold">Jacket Artist: </span>
                    <span>{chart.jacket_designer ? chart.jacket_designer : 'Unknown'}</span>
                </p>
            </div>

            {/* Jacket, Title, Artist */}
            <div className="flex flex-col items-center justify-center gap-4 w-full">
                <img
                    src={getJacketUrl(chart.song_id, chart.difficulty, chart.jacket_override)}
                    alt={chart.title}
                    className="w-80 h-80 object-cover rounded-lg"
                />
                <h2 className="text-white text-xl font-bold ">{chart.title}</h2>
                <p className="text-gray-400">{chart.artist}</p>
            </div>

        </div>
    )
}
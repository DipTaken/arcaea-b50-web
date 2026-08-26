import { Chart } from '@/utils/types'
import { getJacketUrl } from '@/utils/jacket'
import { getDifficultyColor } from '@/utils/style'

export default function SongInfo({ chart }: { chart: Chart }) {
    return (
        <div className="grid grid-cols-[1fr_2fr]">
            <div className="flex flex-col text-left text-lg items-center justify-center gap-4">
                <p className="text-white text-lg w-full">
                    <span className="text-white font-bold">Difficulty: </span> 
                    <span style={{ color: getDifficultyColor(chart.difficulty ?? "") }}>
                        {chart.difficulty ? chart.difficulty : 'Unknown'}
                    </span>
                </p>
                <p className="text-white w-full">
                    <span className="font-bold">Level: </span> 
                    <span>{chart.level ? chart.level : 'Unknown'}</span>
                </p>
                <p className="text-white w-full">
                    <span className="font-bold">Constant: </span> 
                    <span>{chart.chart_constant ? chart.chart_constant?.toFixed(1) : 'Unknown'}</span>
                </p>
                <p className="text-white w-full">
                    <span className="font-bold">Note Count: </span> 
                    <span>{chart.note_count ? chart.note_count : 'Unknown'}</span>
                </p>
                <p className="text-white w-full">
                    <span className="font-bold">BPM: </span> 
                    <span>{chart.bpm ? chart.bpm : 'Unknown'}</span>
                </p>
                <p className="text-white w-full">
                    <span className="font-bold">Length: </span> 
                    <span>{chart.length ? chart.length : 'Unknown'}</span>
                </p>
                <p className="text-white w-full">
                    <span className="font-bold">Version: </span> 
                    <span>{chart.version ? chart.version : 'Unknown'}</span>
                </p>
                <p className="text-white w-full">
                    <span className="font-bold">Chart Designer: </span> 
                    <span>{chart.chart_designer ? chart.chart_designer : 'Unknown'}</span>
                </p>
                <p className="text-white w-full">
                    <span className="font-bold">Jacket Artist: </span> 
                    <span>{chart.jacket_designer ? chart.jacket_designer : 'Unknown'}</span>
                </p>
            </div>  
            
            <div className="flex flex-col items-center justify-center gap-4">
                <img
                    src={getJacketUrl(chart.song_id, chart.difficulty, chart.jacket_override)}
                    alt={chart.title}
                    className="w-64 h-64 object-cover rounded-lg"
                />
                <h2 className="text-white text-center text-xl font-bold w-full">{chart.title}</h2>
                <p className="text-gray-400 text-center w-full">{chart.artist}</p>
            </div>

 
        </div>
    )
}
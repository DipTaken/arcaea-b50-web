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
                <InfoRow label="Difficulty">
                    <span className="py-1 px-3 rounded-md font-bold"
                        style={{ backgroundColor: getDifficultyColor(chart?.difficulty ?? "")}}
                    >
                        {chart.difficulty || 'Unknown'}
                    </span>
                </InfoRow>

                {/* Level */}
                <InfoRow label="Level"> {chart.level || 'Unknown'} </InfoRow>
                    
                {/* Constant */}
                <InfoRow label="Constant"> {chart.chart_constant?.toFixed(1) || 'Unknown'} </InfoRow>
                    
                {/* Note Count */}
                <InfoRow label="Note Count"> {chart.note_count || 'Unknown'} </InfoRow>
                
                {/* BPM */}
                <InfoRow label="BPM"> {chart.bpm || 'Unknown'} </InfoRow>
                   
                {/* Length */}
                <InfoRow label="Length"> {chart.length || 'Unknown'}  </InfoRow>
                  
                {/* Version */}
                <InfoRow label="Version"> {chart.version || 'Unknown'} </InfoRow>
                
                {/* Chart Designer */}
                <InfoRow label="Chart Designer"> {chart.chart_designer || 'Unknown'} </InfoRow>
                    
                {/* Jacket Artist */}
                <InfoRow label="Jacket Artist"> {chart.jacket_designer || 'Unknown'} </InfoRow>
                
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

function InfoRow({ label, children }: { label: string; children: React.ReactNode }) {
    return (
        <p>
            <span className="font-bold">{label}: </span>
            {children}
        </p>
    )
}
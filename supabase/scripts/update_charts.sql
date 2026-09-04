begin;

INSERT INTO public.charts (
    title, 
    difficulty, 
    level, 
    chart_constant, 
    note_count, 
    bpm, 
    length, 
    version, 
    chart_designer, 
    jacket_designer, 
    song_id, 
    jacket_override, 
    artist
)
SELECT 
    temp.title, 
    temp.difficulty, 
    temp.level, 
    temp.chart_constant, 
    temp.note_count, 
    temp.bpm, 
    temp.length, 
    temp.version, 
    temp.chart_designer, 
    temp.jacket_designer, 
    temp.song_id, 
    COALESCE(temp.jacket_override, false) AS jacket_override,
    temp.artist
FROM public.charts_temp temp
ON CONFLICT (song_id, difficulty) DO UPDATE SET
    title = EXCLUDED.title,
    level = EXCLUDED.level,
    chart_constant = EXCLUDED.chart_constant,
    note_count = EXCLUDED.note_count,
    bpm = EXCLUDED.bpm,
    length = EXCLUDED.length,
    version = EXCLUDED.version,
    chart_designer = EXCLUDED.chart_designer,
    jacket_designer = EXCLUDED.jacket_designer,
    jacket_override = EXCLUDED.jacket_override,
    artist = EXCLUDED.artist;

commit;

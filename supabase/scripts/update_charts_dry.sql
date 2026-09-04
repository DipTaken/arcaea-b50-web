SELECT 
    COALESCE(c.song_id, temp.song_id) AS song_id,
    COALESCE(c.difficulty, temp.difficulty) AS difficulty,
    CASE
        WHEN c.id IS NULL THEN 'NEW'
        WHEN temp.song_id IS NULL THEN 'MISSING FROM CSV'
        ELSE 'CHANGED'
    END AS change_type,
    c.title AS old_title, temp.title AS new_title,
    c.level AS old_level, temp.level AS new_level,
    c.chart_constant AS old_chart_constant, temp.chart_constant AS new_chart_constant,
    c.note_count AS old_note_count,  temp.note_count AS new_note_count,
    c.bpm AS old_bpm, temp.bpm AS new_bpm,
    c.length AS old_length, temp.length AS new_length,
    c.version AS old_version, temp.version AS new_version,
    c.chart_designer AS old_chart_designer, temp.chart_designer AS new_chart_designer,
    c.jacket_designer AS old_jacket_designer, temp.jacket_designer AS new_jacket_designer,
    c.song_id AS old_song_id, temp.song_id AS new_song_id,
    c.jacket_override AS old_jacket_override,  temp.jacket_override AS new_jacket_override,
    c.artist AS old_artist, temp.artist AS new_artist,
    (SELECT COUNT(*) FROM public.scores s WHERE s.chart_id = c.id) AS attached_scores
FROM public.charts c

FULL JOIN public.charts_temp temp
    ON temp.song_id = c.song_id AND temp.difficulty = c.difficulty
WHERE c.id IS NULL OR temp.song_id IS NULL
    OR (c.title, c.level, c.chart_constant, c.note_count, c.bpm, c.length, c.version, c.chart_designer, c.jacket_designer, c.jacket_override, c.artist)
    IS DISTINCT FROM (temp.title, temp.level, temp.chart_constant, temp.note_count, temp.bpm, temp.length, temp.version, temp.chart_designer, temp.jacket_designer, temp.jacket_override, temp.artist)
ORDER BY change_type, song_id, difficulty;
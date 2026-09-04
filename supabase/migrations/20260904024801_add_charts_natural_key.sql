alter table public.charts
  add constraint charts_song_id_difficulty_key unique (song_id, difficulty);

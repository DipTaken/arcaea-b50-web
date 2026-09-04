# Monthly chart update

Arcaea ships new charts roughly monthly; major versions also move constants and levels. This is the
procedure.

**Never delete and reload `charts`.** `scores.chart_id` is a *foreign key* to `charts.id`, so ids must survive.
The update is UPDATE-existing + INSERT-new, never DELETE.

## Every month

### 1. **Load the new files**
   In `scripts/data/`, use the filenames: `songlist.json`, `cc.json`, `note_count.json`, `length.json`.

### 2. **Convert JSON to CSV**
   ```
   node scripts/json_to_csv.mts
   ```
   Writes `scripts/data/charts.csv`. Fails on
      charts with a missing constant or note count that isn't a `rating: 0` placeholder.

### 3. **Stage** 
   In the supabase dashboard, duplicate `charts` to `charts_temp` *without* data, then import the CSV
      into it. Duplicating means `charts_temp` inherits the unique constraints of `charts`, so a CSV
      with duplicate charts is rejected at import rather than at merge.

### 4. **Dry run**
```
npx supabase db query -f supabase/scripts/update_charts_dry.sql --linked
```
   Read every row:
   - `NEW` — should match the new songs.
   - `CHANGED` — the constant/level diff. On a run where nothing has changed, this should be *empty*;
     anything here is a converter bug.
   - `MISSING FROM CSV` — **think.** A removal, a renamed `song_id`, or a truncated export all look
     identical. `attached_scores` is the stakes. A renamed charts shows up as one `MISSING` plus one `NEW`; fix it
     with an `UPDATE charts SET song_id = …` *before* merging.

### 5. **Merge**
```
npx supabase db query -f supabase/scripts/update_charts.sql --linked
```

### 6. **Drop staging**
```
npx supabase db query --linked "drop table public.charts_temp;"
```
   Kept out of the merge script to allow for verification before deleting the old table.

### 7. **Re-dump the seed and commit**
```
npx supabase db dump --linked --data-only --use-copy --schema public -x public.scores -f supabase/seed.sql
```
   The git diff on `seed.sql` is the permanent record of what changed. Read it before committing.
   Using `--schema public` prevents `auth` and `storage` from being included, which has session tokens.

### 8. **Upload jackets** 
For new songs, put their: `{song_id}.jpg` into the `jackets` bucket, plus
   `{song_id}_{difficulty}.jpg` for anything with `jacket_override`.
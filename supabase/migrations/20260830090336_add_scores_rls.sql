-- Step 3 of docs/anon_auth_migration.md


-- 1. Drop score rows made before migration and not signed in
delete from public.scores s
where not exists (
    select 1 from auth.users u where u.id = s.user_id
);


-- 2. make sure all scores.user_id values are non-null and non-default
alter table public.scores alter column user_id drop default;
alter table public.scores alter column user_id set not null;



-- 3. drop chartsoldold
drop table if exists public.chartsoldold;


-- 4. revoke grants
revoke all on table public.charts from anon, authenticated;
revoke all on table public.scores from anon, authenticated;

-- catalog is public
grant select on table public.charts to anon, authenticated;

-- scores are only seen by logged-in users
grant select, insert, update, delete on table public.scores to authenticated;


-- 5. ownership checks.
drop policy if exists "Enable read access for all users" on public.charts;

create policy "charts_select_all" on public.charts
    for select to anon, authenticated
    using (true);

drop policy if exists "Enable read access for all users" on public.scores;
drop policy if exists "Enable insert for all users" on public.scores;

create policy "scores_select_own" on public.scores
    for select to authenticated
    using ((select auth.uid()) = user_id);

create policy "scores_insert_own" on public.scores
    for insert to authenticated
    with check ((select auth.uid()) = user_id);

create policy "scores_update_own" on public.scores
    for update to authenticated
    using ((select auth.uid()) = user_id)
    with check ((select auth.uid()) = user_id);

create policy "scores_delete_own" on public.scores
    for delete to authenticated
    using ((select auth.uid()) = user_id);

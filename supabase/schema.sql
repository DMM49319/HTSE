-- HTSE shared dashboard state
-- Run this in Supabase SQL Editor.

create table if not exists public.htse_state (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.htse_state enable row level security;

drop policy if exists "htse_state_select_anon" on public.htse_state;
drop policy if exists "htse_state_insert_anon" on public.htse_state;
drop policy if exists "htse_state_update_anon" on public.htse_state;

-- Simple shared mode for a static GitHub Pages app.
-- Anyone with the Supabase URL + anon key can read/write this table.
-- For stricter team-only access, replace these policies with Supabase Auth rules later.
create policy "htse_state_select_anon"
  on public.htse_state
  for select
  to anon
  using (true);

create policy "htse_state_insert_anon"
  on public.htse_state
  for insert
  to anon
  with check (true);

create policy "htse_state_update_anon"
  on public.htse_state
  for update
  to anon
  using (true)
  with check (true);

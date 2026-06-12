-- Hot Takes Wall - Supabase Schema
-- Run this in your Supabase SQL Editor (Dashboard > SQL Editor > New Query)

-- Takes table
create table takes (
  id uuid default gen_random_uuid() primary key,
  text text not null check (char_length(text) <= 120),
  tag text not null default 'general' check (char_length(tag) <= 20),
  agree int not null default 0,
  disagree int not null default 0,
  spicy int not null default 0,
  created_at timestamptz default now()
);

-- Enable Row Level Security
alter table takes enable row level security;

-- Allow anyone to read takes
create policy "Takes are publicly readable"
  on takes for select
  using (true);

-- Allow anyone to insert takes (anonymous posting)
create policy "Anyone can post a take"
  on takes for insert
  with check (true);

-- Allow anyone to update reaction counts
create policy "Anyone can update reactions"
  on takes for update
  using (true)
  with check (true);

-- Index for ordering by newest first
create index takes_created_at_idx on takes (created_at desc);

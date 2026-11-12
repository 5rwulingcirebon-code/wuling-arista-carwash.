-- Jalankan seluruh SQL ini di Supabase Dashboard > SQL Editor.
create table if not exists public.wash_records (
  id uuid primary key default gen_random_uuid(),
  plate_number text not null,
  vehicle_type text not null,
  wash_date date not null default (now() at time zone 'Asia/Jakarta')::date,
  description text not null default '',
  findings text not null default '',
  created_by uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists wash_records_wash_date_idx on public.wash_records (wash_date desc);
create index if not exists wash_records_plate_idx on public.wash_records (plate_number);

alter table public.wash_records enable row level security;

-- Semua pengguna yang sudah login dapat melihat data bersama.
drop policy if exists "Authenticated users can view wash records" on public.wash_records;
create policy "Authenticated users can view wash records"
on public.wash_records for select to authenticated using (true);

-- Pengguna login dapat menambahkan data atas nama akunnya.
drop policy if exists "Authenticated users can add wash records" on public.wash_records;
create policy "Authenticated users can add wash records"
on public.wash_records for insert to authenticated with check (auth.uid() = created_by);

-- Pengguna login dapat mengubah dan menghapus catatan bersama.
drop policy if exists "Authenticated users can update wash records" on public.wash_records;
create policy "Authenticated users can update wash records"
on public.wash_records for update to authenticated using (true) with check (true);

drop policy if exists "Authenticated users can delete wash records" on public.wash_records;
create policy "Authenticated users can delete wash records"
on public.wash_records for delete to authenticated using (true);

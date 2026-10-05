-- Test fixtures loaded after migrations on `supabase db reset`.
-- Buckets exercise the generated storage client extension.
insert into storage.buckets (id, name, public)
values ('avatars', 'avatars', true), ('documents', 'documents', false)
on conflict (id) do nothing;

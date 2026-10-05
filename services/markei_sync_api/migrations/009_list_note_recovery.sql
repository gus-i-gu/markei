begin;

do $$
begin
  if not exists (select 1 from public.migration_ledger
      where migration_id = '008_automatic_membership'
        and checksum = 'lp-c00-automatic-membership-v1') then
    raise exception 'list note recovery requires validated migration 008';
  end if;
  if exists (select 1 from public.migration_ledger
      where migration_id = '009_list_note_recovery'
        and checksum <> 'c02-list-note-recovery-v1') then
    raise exception 'migration 009 checksum mismatch';
  end if;
end;
$$;

-- Notes use the existing Account/Device event stream. No note text is stored
-- in the migration ledger. Format 2 preserves revisions in recovery snapshots
-- and lets older clients decline recovery instead of dropping those notes.
alter table public.recovery_snapshots
  drop constraint recovery_snapshots_recovery_format_version_check,
  drop constraint recovery_snapshots_compatible_schema_version_check,
  add constraint recovery_snapshots_recovery_format_version_check
    check (recovery_format_version in (1, 2)),
  add constraint recovery_snapshots_compatible_schema_version_check
    check ((recovery_format_version = 1 and compatible_schema_version = 6)
        or (recovery_format_version = 2 and compatible_schema_version = 13));

insert into public.migration_ledger(migration_id, checksum)
values ('009_list_note_recovery', 'c02-list-note-recovery-v1')
on conflict(migration_id) do nothing;

commit;

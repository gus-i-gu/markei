begin;

-- Never discard note-bearing snapshots just to make an older client fit.
do $$
begin
  if exists (select 1 from public.recovery_snapshots
      where recovery_format_version = 2) then
    raise exception 'retain note-bearing snapshots; rollback is blocked';
  end if;
end;
$$;

alter table public.recovery_snapshots
  drop constraint recovery_snapshots_recovery_format_version_check,
  drop constraint recovery_snapshots_compatible_schema_version_check,
  add constraint recovery_snapshots_recovery_format_version_check
    check (recovery_format_version = 1),
  add constraint recovery_snapshots_compatible_schema_version_check
    check (compatible_schema_version = 6);

delete from public.migration_ledger
where migration_id = '009_list_note_recovery'
  and checksum = 'c02-list-note-recovery-v1';

commit;

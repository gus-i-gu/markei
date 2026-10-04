begin;
-- Roll back the server to the prior release BEFORE removing these functions.
-- Existing Accounts, memberships, cursor state and Device data are retained.
do $$
begin
  if exists (select 1 from public.migration_ledger
      where migration_id = '008_automatic_membership'
        and checksum <> 'lp-c00-automatic-membership-v1') then
    raise exception 'migration 008 checksum mismatch';
  end if;
end;
$$;
drop function if exists public.markei_hosted_runtime_ready_v3();
drop function if exists public.markei_onboard_identity_membership(text,text);
delete from public.migration_ledger
  where migration_id = '008_automatic_membership'
    and checksum = 'lp-c00-automatic-membership-v1';
commit;

begin;

do $$
begin
  if not exists (select 1 from public.migration_ledger
      where migration_id = '007_account_cursor_provisioning'
        and checksum = 'c10-mcg02-account-cursor-provisioning-v1') then
    raise exception 'automatic membership requires validated migration 007';
  end if;
  if exists (select 1 from public.migration_ledger
      where migration_id = '008_automatic_membership'
        and checksum <> 'lp-c00-automatic-membership-v1') then
    raise exception 'migration 008 checksum mismatch';
  end if;
end;
$$;

-- The trusted hosted service calls this only after JWT verification.
-- Caller-supplied Account IDs/roles and email matching are deliberately absent.
create or replace function public.markei_onboard_identity_membership(
  p_issuer text, p_subject text
)
returns table(identity_id uuid, account_id uuid, role text)
language plpgsql
security definer
set search_path = pg_catalog, public
as $$
declare
  v_identity_id uuid;
  v_status text;
  v_account_id uuid;
begin
  if p_issuer is null or length(p_issuer) not between 12 and 512
      or p_subject is null or length(p_subject) not between 1 and 256 then
    return;
  end if;

  -- Serializes first use even when there is no identity row to lock yet.
  perform pg_advisory_xact_lock(hashtextextended(
    jsonb_build_array(p_issuer, p_subject)::text, 0));
  select ei.identity_id, ei.status into v_identity_id, v_status
    from public.external_identities ei
    where ei.issuer = p_issuer and ei.subject = p_subject for update;

  if v_identity_id is null then
    insert into public.external_identities(identity_id, issuer, subject, status)
      values(gen_random_uuid(), p_issuer, p_subject, 'active')
      on conflict on constraint external_identities_issuer_subject_key do nothing
      returning external_identities.identity_id into v_identity_id;
    if v_identity_id is null then
      -- A serializable snapshot predating another first-use transaction retries.
      raise exception using errcode = '40001', message = 'retry identity onboarding';
    end if;
    v_account_id := gen_random_uuid();
    insert into public.accounts(account_id) values(v_account_id);
    insert into public.account_memberships(account_id, identity_id, role, status)
      values(v_account_id, v_identity_id, 'owner', 'active');
  elsif v_status <> 'active' then
    return;
  end if;

  -- Existing identities with no active membership are never re-bootstrapped.
  -- Multiple memberships are returned for explicit server-side selection rejection.
  return query select am.identity_id, am.account_id, am.role
    from public.account_memberships am
    where am.identity_id = v_identity_id and am.status = 'active'
    order by am.account_id for update;
end;
$$;

revoke all on function public.markei_onboard_identity_membership(text,text) from public;
grant execute on function public.markei_onboard_identity_membership(text,text) to markei_runtime;

create or replace function public.markei_hosted_runtime_ready_v3()
returns boolean language sql security definer stable
set search_path = pg_catalog, public
as $$
  select public.markei_hosted_runtime_ready_v2()
    and exists (select 1 from public.migration_ledger
      where migration_id = '008_automatic_membership'
        and checksum = 'lp-c00-automatic-membership-v1')
    and has_function_privilege('markei_runtime',
      'public.markei_onboard_identity_membership(text,text)', 'EXECUTE');
$$;
revoke all on function public.markei_hosted_runtime_ready_v3() from public;
grant execute on function public.markei_hosted_runtime_ready_v3() to markei_runtime;

insert into public.migration_ledger(migration_id, checksum)
  values('008_automatic_membership', 'lp-c00-automatic-membership-v1')
  on conflict(migration_id) do nothing;
commit;

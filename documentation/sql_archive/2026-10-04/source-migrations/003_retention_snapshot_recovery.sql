begin;

insert into migration_ledger(migration_id, checksum)
values('003_retention_snapshot_recovery', 'c10-s02-retention-snapshot-recovery-v1')
on conflict(migration_id) do nothing;

do $$
begin
  if not exists (select 1 from pg_roles where rolname = 'markei_recovery_worker') then
    create role markei_recovery_worker;
  end if;
end
$$;

alter table devices
  add column if not exists last_seen_at timestamptz,
  add column if not exists lease_expires_at timestamptz;

update devices
   set last_seen_at = coalesce(last_seen_at, created_at),
       lease_expires_at = coalesce(lease_expires_at, created_at + interval '7 days');

create table if not exists account_retention_state (
  account_id uuid primary key references accounts(account_id),
  earliest_incremental_cursor bigint not null default 1 check (earliest_incremental_cursor > 0),
  current_snapshot_id uuid,
  policy_version integer not null,
  recovery_format_version integer not null check (recovery_format_version = 1),
  updated_at timestamptz not null default now()
);

create table if not exists recovery_snapshots (
  account_id uuid not null references accounts(account_id),
  snapshot_id uuid not null,
  state text not null check (state in ('building', 'validating', 'available', 'failed', 'superseded')),
  covered_through_cursor bigint not null check (covered_through_cursor > 0),
  captured_high_water_cursor bigint not null check (captured_high_water_cursor >= covered_through_cursor),
  recovery_format_version integer not null check (recovery_format_version = 1),
  compatible_event_version integer not null check (compatible_event_version = 3),
  compatible_schema_version integer not null check (compatible_schema_version = 6),
  chunk_count integer not null check (chunk_count > 0),
  total_bytes integer not null check (total_bytes > 0),
  manifest_hash text not null check (length(manifest_hash) = 64),
  total_hash text not null check (length(total_hash) = 64),
  fact_counts jsonb not null,
  supersedes_snapshot_id uuid,
  built_at timestamptz,
  validated_at timestamptz,
  published_at timestamptz,
  primary key (account_id, snapshot_id)
);

create table if not exists recovery_snapshot_chunks (
  account_id uuid not null,
  snapshot_id uuid not null,
  chunk_index integer not null check (chunk_index >= 0),
  byte_length integer not null check (byte_length > 0),
  content_hash text not null check (length(content_hash) = 64),
  chunk_bytes bytea not null,
  primary key (account_id, snapshot_id, chunk_index),
  foreign key (account_id, snapshot_id)
    references recovery_snapshots(account_id, snapshot_id)
    on delete cascade
);

create table if not exists cleanup_runs (
  account_id uuid not null references accounts(account_id),
  cleanup_run_id uuid not null,
  policy_version integer not null,
  snapshot_id uuid,
  proposed_through_cursor bigint not null check (proposed_through_cursor > 0),
  committed_through_cursor bigint,
  state text not null check (state in ('planned', 'committed', 'failed')),
  attempts integer not null default 0 check (attempts >= 0),
  deleted_count integer not null default 0 check (deleted_count >= 0),
  started_at timestamptz not null default now(),
  finished_at timestamptz,
  primary key (account_id, cleanup_run_id)
);

create table if not exists rebootstrap_sessions (
  account_id uuid not null,
  device_id uuid not null,
  recovery_session_id uuid not null,
  snapshot_id uuid not null,
  request_hash text not null check (length(request_hash) = 64),
  state text not null check (
    state in (
      'preparing',
      'downloading',
      'downloaded',
      'applying',
      'catching-up',
      'recovery-completed',
      'recovery-interrupted'
    )
  ),
  expires_at timestamptz not null,
  stored_result jsonb not null,
  last_chunk_index integer,
  completed_cursor bigint,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (account_id, device_id, recovery_session_id),
  foreign key (account_id, device_id)
    references devices(account_id, device_id),
  foreign key (account_id, snapshot_id)
    references recovery_snapshots(account_id, snapshot_id)
);

create index if not exists recovery_snapshots_available_idx
  on recovery_snapshots(account_id, recovery_format_version, state, covered_through_cursor);

create index if not exists cleanup_runs_claim_idx
  on cleanup_runs(account_id, state, started_at);

create index if not exists rebootstrap_sessions_replay_idx
  on rebootstrap_sessions(account_id, device_id, recovery_session_id, request_hash);

create index if not exists recovery_snapshot_chunks_order_idx
  on recovery_snapshot_chunks(account_id, snapshot_id, chunk_index);

alter table account_retention_state enable row level security;
alter table recovery_snapshots enable row level security;
alter table recovery_snapshot_chunks enable row level security;
alter table cleanup_runs enable row level security;
alter table rebootstrap_sessions enable row level security;

drop policy if exists account_retention_state_account_isolation on account_retention_state;
create policy account_retention_state_account_isolation on account_retention_state
  using (account_id::text = current_setting('markei.account_id', true))
  with check (account_id::text = current_setting('markei.account_id', true));

drop policy if exists recovery_snapshots_account_isolation on recovery_snapshots;
create policy recovery_snapshots_account_isolation on recovery_snapshots
  using (account_id::text = current_setting('markei.account_id', true))
  with check (account_id::text = current_setting('markei.account_id', true));

drop policy if exists recovery_snapshot_chunks_account_isolation on recovery_snapshot_chunks;
create policy recovery_snapshot_chunks_account_isolation on recovery_snapshot_chunks
  using (account_id::text = current_setting('markei.account_id', true))
  with check (account_id::text = current_setting('markei.account_id', true));

drop policy if exists cleanup_runs_account_isolation on cleanup_runs;
create policy cleanup_runs_account_isolation on cleanup_runs
  using (account_id::text = current_setting('markei.account_id', true))
  with check (account_id::text = current_setting('markei.account_id', true));

drop policy if exists rebootstrap_sessions_account_isolation on rebootstrap_sessions;
create policy rebootstrap_sessions_account_isolation on rebootstrap_sessions
  using (
    account_id::text = current_setting('markei.account_id', true)
    and device_id::text = current_setting('markei.device_id', true)
  )
  with check (
    account_id::text = current_setting('markei.account_id', true)
    and device_id::text = current_setting('markei.device_id', true)
  );

grant usage on schema public to markei_recovery_worker;
grant select on accounts to markei_recovery_worker;
grant select, update(last_seen_at) on devices to markei_runtime;
grant select on account_retention_state, recovery_snapshots, recovery_snapshot_chunks to markei_runtime;
grant select, insert, update on rebootstrap_sessions to markei_runtime;

grant select on accounts, devices, account_cursor_state, device_acknowledgements to markei_recovery_worker;
grant select, insert, update on account_retention_state to markei_recovery_worker;
grant select, insert, update on recovery_snapshots to markei_recovery_worker;
grant select, insert, update, delete on recovery_snapshot_chunks to markei_recovery_worker;
grant select, insert, update on cleanup_runs to markei_recovery_worker;
grant select, delete on sync_events to markei_recovery_worker;

commit;

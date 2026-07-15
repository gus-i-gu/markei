do $$
begin
  if not exists (select 1 from pg_roles where rolname = 'markei_runtime') then
    create role markei_runtime;
  end if;
end
$$;

create table if not exists accounts (
  account_id uuid primary key,
  created_at timestamptz not null default now()
);

create table if not exists devices (
  account_id uuid not null references accounts(account_id),
  device_id uuid not null,
  status text not null check (status in ('active', 'revoked')),
  next_expected_sequence bigint not null check (next_expected_sequence > 0),
  created_at timestamptz not null default now(),
  primary key (account_id, device_id)
);

create table if not exists account_cursor_state (
  account_id uuid primary key references accounts(account_id),
  next_cursor bigint not null check (next_cursor > 0)
);

create table if not exists submissions (
  account_id uuid not null,
  device_id uuid not null,
  submission_id uuid not null,
  request_hash text not null check (length(request_hash) = 64),
  stored_result jsonb not null,
  created_at timestamptz not null default now(),
  primary key (account_id, device_id, submission_id)
);

create table if not exists sync_events (
  event_id uuid primary key,
  account_id uuid not null,
  device_id uuid not null,
  device_sequence bigint not null check (device_sequence > 0),
  server_cursor bigint not null check (server_cursor > 0),
  event_type text not null,
  payload_version integer not null,
  occurrence_time timestamptz not null,
  payload jsonb not null,
  content_hash text not null check (length(content_hash) = 64),
  received_at timestamptz not null default now(),
  unique(account_id, device_id, device_sequence),
  unique(account_id, server_cursor)
);

create table if not exists device_acknowledgements (
  account_id uuid not null,
  device_id uuid not null,
  greatest_contiguous_cursor bigint not null check (greatest_contiguous_cursor > 0),
  updated_at timestamptz not null default now(),
  primary key (account_id, device_id)
);

alter table sync_events enable row level security;
create policy sync_events_account_isolation on sync_events
  using (account_id::text = current_setting('markei.account_id', true))
  with check (account_id::text = current_setting('markei.account_id', true));

grant usage on schema public to markei_runtime;
grant select, insert, update on accounts to markei_runtime;
grant select, insert, update on devices to markei_runtime;
grant select, insert, update on account_cursor_state to markei_runtime;
grant select, insert, update on submissions to markei_runtime;
grant select, insert, update on sync_events to markei_runtime;
grant select, insert, update on device_acknowledgements to markei_runtime;

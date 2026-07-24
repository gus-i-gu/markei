-- MARKEI NEON ACTION CATALOGUE
--
-- This file is SQL-only. Explanatory text is written as SQL comments.
-- NEON_CHECK.ps1 extracts exactly one block between ACTION markers.
-- Every routine action is read-only, returns sanitized evidence, and ends
-- with ROLLBACK.
--
-- BLOCK INDEX
-- NA-01  connection              Role/database/read-only connection proof
-- NA-02  gate02-preflight        Historical/current Gate 02 prerequisite view
-- NA-03  gate02-postflight       Current migration-007 and privilege proof
-- NA-04  migration-ledger        Ordered provider migration inventory
-- NA-05  runtime-privileges      Runtime table/schema privilege inventory
-- NA-06  schema-inventory        Public tables and RLS policy inventory
-- NA-07  list-devices-sanitized  Device-state aggregates without UUIDs
-- NA-08  verify-device           Local UUID input; sanitized device counters

-- ============================================================================
-- NA-01 | SANITIZED CONNECTION PROOF
-- ACTION: connection
-- Purpose: prove the authenticated PostgreSQL role, selected database, and
--          read-only transaction state. TLS/channel binding are enforced by
--          the launcher and are not inferred from proxy-sensitive server data.
-- Manual variable: none.
-- Expected: selected role; markei_sync_dev; transaction_read_only = on;
--           terminal ROLLBACK.
BEGIN TRANSACTION READ ONLY;
SELECT
    current_user AS connected_role,
    current_database() AS connected_database,
    current_setting('transaction_read_only') AS transaction_read_only;
ROLLBACK;
-- END ACTION

-- ============================================================================
-- NA-02 | GATE 02 PREFLIGHT / HISTORICAL DIAGNOSTIC
-- ACTION: gate02-preflight
-- Purpose: inspect migrations 006/007, readiness/provisioning objects, and
--          Account cursor-state coverage without changing the provider.
-- Manual variable: none.
-- Expected after Gate 02 closure: migrations 006 and 007 present; readiness-v2
--          and provisioning objects present; trigger count 1; no Account
--          missing cursor state; terminal ROLLBACK.
BEGIN TRANSACTION READ ONLY;
SELECT migration_id, checksum, applied_at
FROM public.migration_ledger
WHERE migration_id IN (
    '006_hosted_authorization_r3',
    :'current_migration_id'
)
ORDER BY migration_id;

SELECT
    to_regprocedure('public.markei_hosted_runtime_ready_v2()') AS readiness_v2,
    to_regprocedure(
        'public.markei_provision_account_cursor_state()'
    ) AS provisioning_function,
    (
        SELECT count(*)
        FROM pg_trigger
        WHERE tgname = 'accounts_provision_cursor_state_after_insert'
          AND NOT tgisinternal
    ) AS provisioning_trigger_count;

SELECT
    (SELECT count(*) FROM public.accounts) AS account_count,
    (SELECT count(*) FROM public.account_cursor_state)
        AS cursor_state_count,
    (
        SELECT count(*)
        FROM public.accounts AS a
        LEFT JOIN public.account_cursor_state AS cs USING (account_id)
        WHERE cs.account_id IS NULL
    ) AS accounts_missing_cursor_state;
ROLLBACK;
-- END ACTION

-- ============================================================================
-- NA-03 | GATE 02 POSTFLIGHT
-- ACTION: gate02-postflight
-- Purpose: repeat the authoritative migration-007, readiness, provisioning,
--          cursor-integrity, and least-privilege inspection.
-- Manual variable: none.
-- Expected: current migration present with checksum_matches true; readiness-v2
--          true; trigger count 1; missing/orphan counts 0; runtime SELECT and
--          next_cursor UPDATE true; runtime INSERT, DELETE, and provisioning
--          EXECUTE false; ROLLBACK.
BEGIN TRANSACTION READ ONLY;
SELECT
    migration_id,
    checksum,
    checksum = :'current_migration_checksum' AS checksum_matches,
    applied_at
FROM public.migration_ledger
WHERE migration_id = :'current_migration_id';

SELECT public.markei_hosted_runtime_ready_v2() AS readiness_v2;

SELECT
    to_regprocedure(
        'public.markei_provision_account_cursor_state()'
    ) AS provisioning_function,
    (
        SELECT count(*)
        FROM pg_trigger
        WHERE tgname = 'accounts_provision_cursor_state_after_insert'
          AND tgrelid = 'public.accounts'::regclass
          AND NOT tgisinternal
    ) AS provisioning_trigger_count;

SELECT
    (SELECT count(*) FROM public.accounts) AS account_count,
    (SELECT count(*) FROM public.account_cursor_state)
        AS cursor_state_count,
    (
        SELECT count(*)
        FROM public.accounts AS a
        LEFT JOIN public.account_cursor_state AS cs USING (account_id)
        WHERE cs.account_id IS NULL
    ) AS accounts_missing_cursor_state,
    (
        SELECT count(*)
        FROM public.account_cursor_state AS cs
        LEFT JOIN public.accounts AS a USING (account_id)
        WHERE a.account_id IS NULL
    ) AS orphan_cursor_state_rows;

SELECT
    has_table_privilege(
        :'runtime_user', 'public.account_cursor_state', 'SELECT'
    ) AS runtime_select,
    has_table_privilege(
        :'runtime_user', 'public.account_cursor_state', 'INSERT'
    ) AS runtime_insert,
    has_table_privilege(
        :'runtime_user', 'public.account_cursor_state', 'DELETE'
    ) AS runtime_delete,
    has_column_privilege(
        :'runtime_user',
        'public.account_cursor_state',
        'next_cursor',
        'UPDATE'
    ) AS runtime_update_next_cursor,
    has_function_privilege(
        :'runtime_user',
        'public.markei_hosted_runtime_ready_v2()',
        'EXECUTE'
    ) AS runtime_execute_readiness_v2,
    has_function_privilege(
        :'runtime_user',
        'public.markei_provision_account_cursor_state()',
        'EXECUTE'
    ) AS runtime_execute_provisioning;
ROLLBACK;
-- END ACTION

-- ============================================================================
-- NA-04 | MIGRATION LEDGER
-- ACTION: migration-ledger
-- Purpose: list every applied provider migration in ledger order.
-- Manual variable: none.
-- Expected: ordered migration rows including
--          007_account_cursor_provisioning; terminal ROLLBACK.
BEGIN TRANSACTION READ ONLY;
SELECT migration_id, checksum, applied_at
FROM public.migration_ledger
ORDER BY migration_id;
ROLLBACK;
-- END ACTION

-- ============================================================================
-- NA-05 | RUNTIME PRIVILEGE INVENTORY
-- ACTION: runtime-privileges
-- Purpose: display the runtime role's public-table grants and schema boundary.
-- Manual variable: none.
-- Expected: intended table privileges; schema USAGE true; schema CREATE false;
--          terminal ROLLBACK.
BEGIN TRANSACTION READ ONLY;
SELECT table_name, privilege_type
FROM information_schema.role_table_grants
WHERE grantee = :'runtime_user'
  AND table_schema = 'public'
ORDER BY table_name, privilege_type;

SELECT
    has_schema_privilege(:'runtime_user', 'public', 'USAGE')
        AS schema_usage,
    has_schema_privilege(:'runtime_user', 'public', 'CREATE')
        AS schema_create;
ROLLBACK;
-- END ACTION

-- ============================================================================
-- NA-06 | SCHEMA AND RLS INVENTORY
-- ACTION: schema-inventory
-- Purpose: list public tables and their Row-Level Security policy names.
-- Manual variable: none.
-- Expected: committed schema tables and aligned public policies; ROLLBACK.
BEGIN TRANSACTION READ ONLY;
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

SELECT tablename, policyname
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;
ROLLBACK;
-- END ACTION

-- ============================================================================
-- NA-07 | SANITIZED DEVICE INVENTORY
-- ACTION: list-devices-sanitized
-- Purpose: group devices by status and next sequence without returning UUIDs.
-- Manual variable: none.
-- Expected: aggregate status/sequence rows only; terminal ROLLBACK.
BEGIN TRANSACTION READ ONLY;
SELECT status, next_expected_sequence, count(*) AS device_count
FROM public.devices
GROUP BY status, next_expected_sequence
ORDER BY status, next_expected_sequence;
ROLLBACK;
-- END ACTION

-- ============================================================================
-- NA-08 | EXACT DEVICE COUNTERS
-- ACTION: verify-device
-- Purpose: inspect submission/event counts and next expected sequence for one
--          UUID supplied locally to psql by NEON_CHECK.ps1.
-- Manual variable: device_id, requested in the terminal and never stored here.
-- Expected: sanitized counts/sequence for the selected device; ROLLBACK.
BEGIN TRANSACTION READ ONLY;
SELECT count(*) AS submission_count
FROM public.submissions
WHERE device_id = :'device_id'::uuid;

SELECT count(*) AS sync_event_count
FROM public.sync_events
WHERE device_id = :'device_id'::uuid;

SELECT next_expected_sequence AS device_next_expected_sequence
FROM public.devices
WHERE device_id = :'device_id'::uuid;
ROLLBACK;
-- END ACTION

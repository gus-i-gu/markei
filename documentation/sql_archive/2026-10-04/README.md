# Marc Neon schema archive — 4 October 2026

This archive preserves the observed development database structure for project history and personal SQL study.

## Account answer

Keep the existing Auth0 user and the existing Neon project. GS-AUTH-03 creates the missing application Account, external identity mapping, active owner membership and Account cursor for that authenticated user. It does not require a new Auth0 signup or Neon account.

## What was already deployed

Fresh read-only capture: 2026-10-04T03:14:27.451628+00:00; database markei_sync_dev; PostgreSQL 18.6 (4e955f5).
The public schema has 17 tables, 126 columns, 194 constraints, 33 indexes, 15 RLS policies, 5 application functions and 1 non-internal trigger.
The ledger records migrations 002–007, applied on 25 September 2026; 007 has checksum c10-mcg02-account-cursor-provisioning-v1. Migration 001 created the initial schema before the migration ledger existed, so absence of a 001 ledger row alone does not imply a missing initial schema.
The prior 3 October audit found zero Accounts, identities, memberships, Devices and enrollments. This capture reads structure and the migration ledger only; it does not recheck business-row counts.
Schema installation, full permission correctness, runtime database-target alignment, user provisioning and successful two-Device Sync are separate claims. This capture proves the inspected schema exists; registered postflights and runtime-target alignment remain execution gates.

## Files

- live-schema-catalog.json: metadata exported from Neon, including columns/defaults, constraints, indexes, RLS policies, application function definitions, triggers, ACLs, non-secret role flags, extensions and migration ledger.
- live-schema-reference.sql: readable SQL rendered from the observed catalogue, with all statements commented out. ACLs are preserved in metadata/comments; privileges are not reconstructed as an executable restore.
- SHA256SUMS.txt: SHA-256 of these archive files for integrity checking.
- source-migrations/: dated, LF-normalized copies of all seven canonical SQL migrations at the recorded source.
- manifest.json: source pin, capture scope, counts and canonical migration hashes.

This is a study/evidence archive, not a pg_dump backup, an application-data backup or a tested disaster-recovery image. It excludes passwords, connection URLs, real identity subjects and Account/Device IDs, business rows, platform-managed objects and physical storage configuration.

## Canonical SQL and history

The seven original migration files remain authoritative and are already tracked on GitHub:
[Ordered migrations at the source pin](https://github.com/gus-i-gu/markei/tree/fdd901f8ebeab7f530f4c277e0add39cb6a5b52a/services/markei_sync_api/migrations)

Read in order:
1. 001_init.sql — basic Account, Device, event and cursor tables and runtime/RLS foundation.
2. 002_coordination_hardening.sql — ledger and coordination hardening.
3. 003_retention_snapshot_recovery.sql — retention, snapshots and recovery structures.
4. 004_hosted_identity_enrollment.sql — external identities, memberships and enrollment.
5. 005_hosted_authorization_fence.sql — protected membership authorization boundary.
6. 006_hosted_authorization_r3.sql — authorization revision.
7. 007_account_cursor_provisioning.sql — automatic Account cursor creation and readiness-v2.

[Database management catalogue](https://github.com/gus-i-gu/markei/blob/fdd901f8ebeab7f530f4c277e0add39cb6a5b52a/documentation/DB_MGMT.sql) contains separate manual checks, indexed automation and migration registry. Do not execute that entire mixed catalogue as one script.
[GS-AUTH-03 and execution catalogue](https://github.com/gus-i-gu/markei/blob/fdd901f8ebeab7f530f4c277e0add39cb6a5b52a/documentation/G_SCRIPTS.md#L5104) is the guarded provisioning route.
The launcher obtains secrets through masked local prompts and derives the identity subject locally. Do not manually reproduce raw INSERTs against the live database.

## Study route

Trace Auth0 user → external_identities → account_memberships → accounts → devices/device_enrollments → submissions/sync_events → account_cursor_state.
Inspect PRIMARY KEY, FOREIGN KEY, CHECK and UNIQUE constraints first; then study RLS USING/WITH CHECK policies and role grants. Finally inspect the security-definer membership function and cursor trigger, and compare each feature with the migration that introduced it.
Use a separate disposable local PostgreSQL database for experiments. Do not run historical migration files or uncomment this reference against the live development database as a learning exercise.

## Execution boundary

Authority: direct human request to preserve the existing SQL locally and on GitHub for legacy/history and study.
Acceptance: read-only capture, verified archive metadata and hashes, source-pinned migration references, scoped archival publication.
Stop after archive publication and local verification. No provider schema/role/data changes, deployment, database reset, Account provisioning or live Sync test is performed in this task.


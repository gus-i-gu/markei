# D_OPS_STAGE — Account Cursor Provisioning Repair

> Unit: C10-MCG02-ACCOUNT-CURSOR-PROVISIONING-REPAIR_20260722
> Sequence: FLX-ORD-01
> Authority: Main Chat
> Baseline: `80935f1c312484d0819e119553a11691ec2216b4`
> Status: READY FOR LOCAL MATERIALIZATION; PROVIDER ACTION BLOCKED

## 1. Accepted boundary

Commit `75dc7bed0789d693af93abb3ed15e107fd77433a` locally reproduced the protected
submission failure and corrected it to a sanitized HTTP 503 `service-unavailable` /
`not-applied`. It did not create the missing `account_cursor_state` row.

Repository inventory at `80935f1c312484d0819e119553a11691ec2216b4` establishes:

- `accounts` and `account_cursor_state` are separate tables under migrations 001–006;
- the foreign key and cursor-state primary key permit zero or one cursor row per Account;
- runtime cannot insert Accounts after migration 002, but retains an unnecessary direct cursor-state
  insert grant;
- enrollment resolves a pre-existing membership/Account and creates Device/enrollment state only;
- every successful local harness manually seeds both Account and cursor state;
- there is no production Account-provisioning service whose exclusivity can currently be proved;
- a 006-only database reports ready through `markei_hosted_runtime_ready()` even though this invariant
  is not enforced.

Main therefore selects a database-enforced Account provisioning invariant. Enrollment and first Sync
must consume or verify the invariant; neither may create or repair it.

## 2. Operational objective

Add one forward-only migration after 006 that:

1. records exact migration identity/checksum transactionally;
2. backfills only missing `account_cursor_state` rows;
3. derives a missing row's `next_cursor` as `max(sync_events.server_cursor) + 1`, or `1` when the
   Account has no events;
4. preserves every existing cursor row byte-for-byte, including values above observed high-water;
5. installs an Account-insert trigger that creates `(account_id, 1)` after each future Account insert
   within the same transaction;
6. makes trigger execution safe through qualified objects, fixed safe search path, controlled owner,
   no dynamic SQL and no exposed callable capability;
7. revokes runtime `INSERT` on `account_cursor_state` while preserving only the already-required
   select/update behavior;
8. adds a new no-argument exact hosted-readiness function for the 007 contract and updates the API to
   use it, while retaining the 006 function for rollback compatibility;
9. fails closed when the new readiness function is absent or false.

Provisional migration identity to materialize exactly:

```text
007_account_cursor_provisioning
checksum: c10-mcg02-account-cursor-provisioning-v1
readiness function: public.markei_hosted_runtime_ready_v2()
```

Do not edit migrations 001–006.

## 3. Required failing-first evidence

Before implementing the migration, add a disposable-PostgreSQL regression that proves the 006 state
allows all of the following defects:

- an Account commits without cursor state;
- an existing Account with no cursor row remains incomplete;
- a 006 database can satisfy the old readiness function;
- runtime retains direct cursor-state insertion capability.

Then prove the correction against fresh and upgrade paths.

## 4. Required migration and concurrency matrix

The local producer must cover:

- fresh 001→007 application;
- upgrade 001→006→007 with no Accounts;
- upgrade with an Account missing cursor state and no events → `next_cursor = 1`;
- upgrade with missing cursor state and existing cursors/events → `max(server_cursor) + 1`;
- upgrade with an existing cursor row → exact value preserved;
- mixed complete/incomplete Accounts → only missing rows inserted;
- duplicate 007 application → one ledger row, no reset and no duplicate state;
- concurrent Account insertion/transaction behavior → no committed Account without exactly one
  cursor row;
- Account insert rollback → neither Account nor cursor row remains;
- injected migration failure → ledger, backfill, trigger, grants and readiness-v2 changes roll back;
- first protected submission after provisioning allocates the expected cursor monotonically;
- missing-row 503 behavior remains as defense in depth and is not removed.

Use deterministic transactions/barriers where concurrency matters; do not use timing sleeps as proof.

## 5. ACL, RLS and catalog proof

Prove:

- migration/trigger/readiness ownership is the migrator identity;
- trigger function is security-definer only if required for the selected enforcement, with fixed
  `pg_catalog, public` search path and fully qualified relations;
- `PUBLIC` and runtime cannot invoke the trigger function directly;
- runtime cannot insert Accounts or cursor rows, cannot delete cursor rows, cannot read the migration
  ledger, cannot create schema objects and cannot manage roles;
- runtime can still select and update the Account-scoped cursor under the established transaction
  context and RLS policy;
- object shadowing cannot change readiness or trigger targets;
- the new readiness function exposes only the exact 006+007 contract and returns a scalar boolean;
- a new binary on a 006-only database reports not-ready;
- the existing 006 readiness capability remains available only for rollback compatibility and is not
  used by the new application.

No grant may broaden runtime authority.

## 6. Required repository adaptations

Update all explicit migration lists and local proof producers to include 007. Fixtures that create
Accounts should rely on the trigger rather than manually hiding the invariant, except where a test
deliberately constructs pre-007 or corrupt/missing-state history. Keep those exceptions named and
isolated.

Expected bounded surface:

```text
services/markei_sync_api/migrations/007_account_cursor_provisioning.sql
services/markei_sync_api/src/http/app.ts
services/markei_sync_api/src/hosted_local_harness.ts
services/markei_sync_api/src/proof/*migration/account provisioning producers as needed
services/markei_sync_api/test/*focused readiness/protocol tests as needed
services/markei_sync_api/package.json only if a named proof script is required
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Broader edits require an evidenced dependency and must be reported.

## 7. Validation floor

Run and report:

- failing-before/passing-after provisioning regression;
- full migration 007 fresh/upgrade/backfill/preserve/duplicate/rollback/concurrency/ACL/RLS/readiness
  producer;
- focused protected-submission and missing-state 503 regressions;
- hosted local authorization/convergence/recovery producers affected by migration sequencing;
- API format check, lint, typecheck, complete tests and build;
- npm audit under the repository's established policy;
- Dart format, Flutter analysis and complete tests if any shared contract changes or as the final
  regression floor;
- disposable Sync convergence and recovery harnesses;
- Windows release and Android debug builds when supported;
- protected Python checks;
- `git diff --check`, changed-path review and secret-safe scan.

Provider deployment, provider SQL and a real retry are not validation for this local unit.

## 8. Prohibitions and stops

Do not:

- contact, configure or mutate Auth0, Render or Neon;
- deploy migration 007 or application changes;
- execute ordinary Sync or retry the preserved unresolved submission;
- modify human local data, events 1–2, sequence 3 or enrollment state;
- repair cursor state in enrollment or first Sync;
- reset, decrease or recompute an existing cursor row;
- edit migrations 001–006;
- weaken RLS, runtime/migrator separation, JWT/JWKS, route inventory or exact retry identity;
- edit permanent notebook memory or begin MCG-03/04 or Cycle 11.

Stop on inability to prove atomic Account+cursor creation, ambiguous high-water derivation, privilege
broadening, non-transactional backfill, destructive repair, nondeterministic concurrency evidence,
provider dependency or unrelated dirty overlap.

Success terminal:

`C10_MCG02_ACCOUNT_CURSOR_PROVISIONING_REPAIR_MATERIALIZED_LOCAL`

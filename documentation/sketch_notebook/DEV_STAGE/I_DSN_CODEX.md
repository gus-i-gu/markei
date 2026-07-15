# I_DSN_CODEX — C10-S02 Design Evidence

Sequence: FLX-INV-02 -> Main D/E/F -> Codex materialization report
Role: Codex design/architecture evidence
Round or unit: C10-S02 disposable local retention, snapshot and rebootstrap proof
Branch: `intermid-cycle-recovery`
Baseline / inspected HEAD: `dee41af3a24bf85e4dcd7db40d3e1179bf0a7471`
Authority: `F_DSN_STAGE.md` plus J/D/E
Evidence boundary: architecture materialized locally; no production/provider boundary crossed

## Dependency direction

Preserved:

```text
Flutter domain/application ports
-> Drift + HTTP infrastructure
-> authenticated Fastify application services
-> PostgreSQL repositories/transactions
-> lab-only SnapshotStore/cleanup worker CLI
```

Flutter does not connect to PostgreSQL and receives no storage credentials. Recovery logic did not enter pages/widgets.

## Version and schema IDs

- Event type/version: `purchase.registered` payload version 3, unchanged.
- Cursor token: `c10b:<integer>`, unchanged.
- Recovery snapshot format: 1.
- Server migration: `003_retention_snapshot_recovery.sql`, forward-only; 001/002 unchanged.
- Drift schema: v6, additive recovery session/chunk progress only.

## Policy injection

- Added `RetentionPolicy` and `Clock`.
- Lab composition injects conspicuous fixture values.
- Normal API construction has no recovery/cleanup behavior unless explicitly composed.
- Physical cleanup is only available through `src/recovery_lab.ts`, not through Fastify routes.

## Snapshot format and chunk rules

- Manifest includes AccountId, SnapshotId, format version, covered cursor, compatible event/schema versions, chunk descriptors, total byte/hash and deterministic fact counts.
- Chunks are bounded by injected byte ceiling.
- Hashes cover canonical UTF-8 facts and manifest/chunk bytes.
- Snapshot excludes Devices, queues, acknowledgements, credentials, recovery sessions and UI state.
- Lab builder folds accepted append-only `purchase.registered` v3 events into deterministic facts.

## Transaction and cleanup invariants

- Snapshot cut uses current Account high-water and publishes only after chunks are stored.
- Cleanup recomputes minimum-age, eligible-Device acknowledgement and available snapshot floors.
- Cleanup deletes only a bounded cursor prefix and advances earliest incremental cursor in the same transaction.
- Harness proved lagging eligible Device blocks cleanup, lease expiry releases that block, old cursor expires, and later event remains.

## API behavior

- Added:
  - `GET /v1/sync/capabilities`
  - `POST /v1/sync/rebootstrap`
  - `GET /v1/sync/rebootstrap/:sessionId`
  - `GET /v1/sync/rebootstrap/:sessionId/chunks/:index`
  - `POST /v1/sync/rebootstrap/:sessionId/complete`
- Incremental download now returns typed expiry for cursors before retained availability.
- Rebootstrap sessions are Account/Device/Snapshot bound and replayable by same identity/hash.
- Chunk responses carry index, length, hash and base64 bytes; no database/storage credential is returned.

## RLS and role evidence

- Migration/RLS probe applied 001 -> 002 -> 003 twice.
- `migration_ledger` contained `003_retention_snapshot_recovery`.
- Five new recovery/retention tables existed.
- Runtime role with transaction-local Account/Device context saw only one scoped Device.
- Runtime DDL attempt was denied.
- Recovery worker Device revoke/update-status attempt was denied.

## Drift v6 and recovery ports

- Added recovery session/chunk progress tables.
- Recovery progress AccountId is metadata, not an Account fact FK, so fresh-target download progress can exist before snapshot fact apply.
- Added application ports for recovery transport, progress repository, local guard and snapshot fact applier.
- Snapshot fact applier validates chunk ordering/length/hash/total hash and applies facts plus covered cursor atomically.

## Fixture containment

- Synthetic Account and Device UUIDs only.
- Disposable PostgreSQL 18 Docker volume removed after harness/probes.
- Generated lab passwords were synthetic and not tracked.
- `.vscode/` and local Neon notes remained untracked and unread.

## Architectural deviations

- Lab snapshot storage is PostgreSQL bytea chunks behind local service code; this is not a production storage decision.
- The snapshot builder is scoped to the current append-only v3 purchase event slice.
- Production database swap/replacement, Device replacement/enrollment and merge/export of unsafe local work remain unimplemented.

## Deferred decisions

- Production durations.
- Scheduler/worker hosting.
- Object storage/provider backup integration.
- Hosted auth and Device enrollment.
- Production database file swap.
- Account deletion and broader retention policy.
- Cycle 11 UI/UX representation.

Terminal state:

```text
C10-S02_LOCAL_RECOVERY_PROVED
MCG-01_EVIDENCE_NOT_RECONCILED
```

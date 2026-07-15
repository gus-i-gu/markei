# I_DSN_CODEX — C10-S01 Design Evidence

Sequence: FLX-ORD-01
Role: Codex materialization evidence
Source stages: `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`

## Dependency Direction

Implemented direction:

```text
Flutter domain/application sync ports
← Drift local adapters
← optional HTTP/API transport boundary
TypeScript Fastify API
→ pg transaction adapter
→ disposable PostgreSQL 18 lab
```

Flutter does not connect to PostgreSQL. Domain/application sync code does not import Flutter widgets, Fastify, `pg`, Docker or Neon.

## Protocol And Hashing

Protocol version: `purchase.registered` payload v3.

Canonical JSON rule: recursively sort object keys, encode UTF-8 JSON, hash SHA-256 lowercase hex over event content excluding `contentHash`. Dart and TypeScript parity is tested against `contracts/shared_beta/v3/fixtures/purchase_registered.valid.json`; final hash is `2c65e7beafe73f1df5b6d48cbeaeab945efb2847108c2bece82e4a7db41e1906`.

## Local Schema

Local Drift schema: v5.

Migration ID: `v4-to-v5-sync-submissions-inbox`.

Added logical units:

- `installation_metadata`
- `sync_submissions`
- `sync_submission_events`
- `sync_inbox`

Generated output: `clients/markei_flutter/lib/infrastructure/local/local_database.g.dart`.

Device ownership now uses singleton installation metadata. Multiple usable UUID Devices without metadata stop with typed migration/bootstrap failure; earliest-device silent selection was removed.

## Server Schema And Roles

Server migration: `services/markei_sync_api/migrations/001_init.sql`.

Tables:

- `accounts`
- `devices`
- `account_cursor_state`
- `submissions`
- `sync_events`
- `device_acknowledgements`

Role direction:

- `markei_migrator` owns local disposable migration execution through the container.
- `markei_runtime` receives DML grants only.

Evidence:

- runtime DDL probe failed with `permission denied for schema public`;
- cross-Account `sync_events` insert failed under RLS.

## Idempotency And Transactions

Local:

- bounded pending leasing;
- durable Submission attempt state;
- unknown outcome reuses same SubmissionId;
- inbox duplicate same EventId/hash is equivalent;
- cursor acknowledgement waits for committed inbox cursor.

Server:

- upload path checks SubmissionId/request hash, EventId/content hash, verified Account/Device, and exact DeviceSequence in a serializable transaction helper.
- same SubmissionId/request hash returns stored response.
- same identity with different hash returns typed terminal failure.

## Auth Boundary

`AuthVerifier` is an API port. `FixtureAuthVerifier` exists for direct test construction only. The normal runtime entrypoint uses `RefusingAuthVerifier` and requires a database URL; no production auth adapter or enrollment endpoint was implemented.

## Architectural Deviations And Deferred Decisions

Implemented proof is partial relative to the full D/E/F floor:

- complete remote Purchase aggregate application from downloaded pages is not finished;
- API integration tests do not yet exercise full upload/download/ack against Postgres;
- serialization retry exhaustion and crash-matrix tests are not complete;
- `tool/sync_lab.dart` cannot be run with plain `dart run` because this Flutter package imports `path_provider`/`dart:ui`; executable harness evidence lives in Flutter tests.

This is not Neon, production authentication, deployment, retention, backup, UI/UX acceptance or release acceptance.

WAITING_FOR_MCG_01

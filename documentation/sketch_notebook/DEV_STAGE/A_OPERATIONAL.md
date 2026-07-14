<!-- TEMPORAL_MARKER:C10-ENTRY-2026-07-14 -->
# A_OPERATIONAL — Cycle 10 Inter-Device Coordination

Sequence: FLX-INV-02
Role: Operational [O]
Branch: `intermid-cycle-recovery`
Required ancestor: `0b3c8320069723ff94617bd6d83630684993c4f3`
Evidence date: 2026-07-14
Authority: investigation and A staging only; no source, provider, configuration or permanent-memory mutation.

## 1. Retained methodology and baseline

Loaded INDEX, both AGENTS files, METHOD_FOUNDATIONS, FLUX, PROMOTION_RULES and CHAT_PROTOCOL in canonical order. Project memory precedes source; source/executable evidence corrects prose; PRC-01 separates implemented, proposed, contradicted, deferred and unvalidated. Operational owns execution, environment, failure, validation, recovery, cost and stop analysis. A is evidence for Main, not canon or D/E/F. PROMPT_COLLECTION was not used.

The required commit is the merge base. The inspected branch was two commits ahead, zero behind, with only B/C staging changes; A had no overlap. Connector-only evidence cannot establish local worktree/tool versions.

Inspected: 00, 06, Cycle 10 J, Operational memory, Cycle 10 B/C, Drift schema/repositories/composition/pubspec/tests, protocol fixtures and older API planning. Official Neon branching/databases/roles/pooling/pricing, PostgreSQL 18 RLS/INSERT/isolation, and Node releases were inspected 2026-07-14.

## 2. Current facts and provider constraints

Implemented locally:

- schema v4 app-private Drift/SQLite;
- provisional `local-account`;
- durable UUID Devices and monotonic per-Device sequence;
- immutable SyncEvent envelope and unique Account/Device/sequence;
- PendingEvent state/enqueued time and one nullable Account cursor;
- atomic Purchase + Items + SyncEvent + PendingEvent;
- rollback, reopen, sequence/envelope and migration tests.

Absent: authenticated Account; installation→current Device invariant; enrollment/revocation; SubmissionId; durable attempts/lease/backoff/result; inbox/applied ledger; transactional remote apply/cursor; API/server schema; upload/download/ack/retention; conflict quarantine; convergence; two-device evidence. Connectivity proves none of them.

Current official facts:

- Neon branches are isolated copy-on-write clones and may expire; databases/roles belong to branches.
- SQL-created roles can receive selective grants; Neon offers no ordinary Postgres superuser.
- PgBouncer accepts many clients, but active transactions remain compute/pool bounded.
- Advertised Free limits include 100 CU-hours/project/month, 0.5 GB/project, up to 2 CU, scale-to-zero, and a six-hour or 1 GB-change restore window. Recheck at MCG-01.
- PostgreSQL 18 `ON CONFLICT` depends on matching uniqueness; serializable aborts require whole-transaction retry.
- Node 24 is LTS; runtime/framework remains a Main decision.

## 3. Dependencies and disposable lab

Candidate lab, only after D/E/F:

- pinned Flutter/Dart/Drift;
- Docker Desktop or Podman;
- disposable PostgreSQL matching selected Neon major version;
- candidate Node 24 LTS + TypeScript API; framework, driver and migration tool undecided;
- contract validator/test runner and controllable HTTP fault transport;
- Android JDK/SDK/emulator under separate host authority.

Record lock/config changes, licenses, graph, install and rollback commands. Prefer repository-local/container tools. Flutter never receives Neon/database-owner credentials.

Command families after selection:

```text
git status --short --branch
git merge-base --is-ancestor <required> HEAD
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze && flutter test
dart run build_runner build --delete-conflicting-outputs
<container> compose up --wait / down --volumes
<package-manager> install-frozen / lint / typecheck / test
<migration-tool> status / apply / verify
flutter build windows --release
flutter build apk --debug
python -m unittest discover tests
git diff --check
```

Placeholders are not execution authority.

## 4. Ten-phase map

| Phase | Output/evidence | Stop boundary |
| --- | --- | --- |
| 1 Baseline/threat | pinned versions, data inventory, trust map, secret scan | unknown personal data/credential |
| 2 Account/Device | installation metadata, enrollment/revoke/reinstall fixtures | auth/pairing/current Device unresolved |
| 3 Outbox/inbox | SubmissionId, retry state, applied ledger, atomic apply/cursor | no network before crash replay passes |
| 4 API/Postgres | schemas, local migrations, least-privilege probes | runtime role can DDL/cross-Account |
| 5 Transfer/ack | bounded batches, stored duplicate result, retention simulation | deletion can strand eligible Device |
| 6 Conflict/retry | duplicate/reorder/gap/timeout/hash/revocation/concurrency | quarantine; never reset local facts |
| 7 Recovery/export | v1/v2/v3 migration failure/reopen, export integrity | restore copy; sync is not backup |
| 8 Measure/extract | fixed fixture timings, behavior-preserving extraction | no unmeasured optimization/restyle |
| 9 Platforms | Windows/Android plus local01/local02 lifecycle/convergence | classify host gaps separately |
| 10 Promote/close | G/H/I, permanent promotion, 00/05/06, teardown | no unclassified skipped gate |

## 5. Failure-injection floor

- upload disconnect before request, mid-body and after server commit/before response; retry same SubmissionId/EventIds;
- equivalent duplicate succeeds identically; same ID/different hash is terminal conflict;
- duplicated/reordered/gapped/invalid-version/oversized downloads;
- crash after inbox insert, during apply, before cursor, and after commit/before ack;
- wrong Account, revoked Device, runtime-role DDL, pool exhaustion, serialization and rate/size failures;
- invalid fixture, constraint collision and interrupted local/server migration;
- offline/never-ack/revoked Device, expired cursor and rebootstrap;
- A offline Purchase → upload → B apply → duplicate → both reopen and compare facts/Lists.

Pass requires atomic durable state, typed outcome and safe retry/non-retry. Logs contain IDs/status/timing/counts, never secrets or payloads.

## 6. Manual Configuration Gates

### MCG-01 Neon

Codex: migration templates, privilege probe, sanitized checklist. Human: isolated project, expiring/dev branch, database, region/version, migration owner and SQL-created runtime role; confirm limits/teardown. Secret names: `NEON_DATABASE_URL_MIGRATION`, `NEON_DATABASE_URL_RUNTIME`. Probe: migration applies; runtime DML succeeds but DDL/cross-Account fails. Record only aliases, region/version, role names, timestamps, migration hash and redacted results. Stop on wrong environment, broad role, visible URL, billing surprise or production data. Return by revoking credentials/deleting disposable branch and using local harness.

### MCG-02 API/TLS

Codex: health/readiness, environment schema, local auth/DB fakes, redaction tests. Human: runtime/host, TLS, secret injection, identities and network policy. Names: `API_BASE_URL`, `DATABASE_URL_RUNTIME`, `DATABASE_URL_MIGRATION`, `AUTH_ISSUER`, `AUTH_AUDIENCE`, `AUTH_JWKS_URL`. Probe: TLS health; unauthenticated data denied; authenticated disposable transaction; no migration endpoint. Record runtime/version, region, approved hostname, status/deployment ID and redacted logs. Stop on plaintext, leaked secret, runtime owner or auth bypass. Return by disabling deployment/revoking secrets/local harness.

### MCG-03 Account/Devices

Codex: deterministic Account/installation/Device fixtures and revoke contract. Human: one disposable auth subject and two controlled Device enrollments. Names: `TEST_ACCOUNT_SUBJECT`, `TEST_DEVICE_A_ENROLLMENT`, `TEST_DEVICE_B_ENROLLMENT`. Probe Account isolation, revoked/unknown denial and selected reinstall result. Record hashed IDs/state transitions/results. Stop on cross-Account access, personal identity or reusable material. Return by revoke/delete and local fixtures.

### MCG-04 local01/local02

Codex: isolated app-data roots, deterministic fixtures, fault schedule, comparison and teardown manifest. Human: controlled instances and confirmation that ordinary data is excluded. Name: `MARKEI_TEST_PROFILE` plus prior API/auth names. Probe offline A→upload→B apply→ack→duplicate→restart/hash comparison and bounded retention observation. Record commit, fixture hash, platforms, counts, outcomes/timing and sanitized screenshots. Stop on ordinary data, divergence, silent cursor skip, payload logs, cost or cleanup uncertainty. Return: disable sync, preserve diagnostics/local facts as required, revoke identities and delete only inventoried disposable resources.

## 7. Validation matrix

| Layer | Required evidence |
| --- | --- |
| Contract | valid/invalid fixtures; canonical JSON/hash; version/size/unknown fields |
| Local DB | fresh+v1/v2/v3 migration; failure rollback/reopen; outbox/inbox/cursor atomicity |
| API | auth isolation; validation; duplicate submission; typed rejection/unknown |
| Postgres | migration, constraints, runtime privilege, concurrent append/retry |
| Protocol | offline, duplicate, reorder, gap, interruption, ack, expiry/rebootstrap |
| Recovery/export | deterministic export; selected round-trip; no sync-as-backup |
| Performance | fixed-volume queue/download/query measurements |
| Windows | release/manual workflow, loss/retry, reopen and local-only fallback |
| Android | doctor/build/install/launch, secure storage, Back/rotation/lifecycle/offline retry |
| Two Device | bidirectional append-only Purchase convergence, replay and teardown |
| Privacy | secret scan, sanitized logs/docs, retention/deletion, no analytics payloads |

## 8. Costs, cleanup, rollback and stops

Recheck Neon compute/storage/restore/branch/pooling limits and API-host egress/function/auth limits at each MCG. Scale-to-zero latency and pool queue timeout can distort tests.

Inventory containers/volumes, DB copies, profiles, deployments, Neon resources, auth subjects/Devices, logs and artifacts. Never delete ordinary data, an SDK root, unrelated emulator or provider project without ownership.

Stop broad refactoring until Main freezes auth/enrollment, first payload, IDs/cursors, retention/rebootstrap, runtime/driver/migration tool, local/server schema/roles, export boundary and platform matrix. Stop on secret exposure, cross-Account access, partial transaction, silent reset, unsafe retry, divergence, unbounded cost or loss of local-only fallback.

Rollback is additive and checkpointed: disable sync adapter; preserve local writes/outbox; revert one dependency/schema/API unit; restore representative DB copy; never destructively downgrade facts.

## 9. Main decisions and first slice

Main must select: auth and recovery; pairing/reinstall/revoke; InstallationId/current Device; EventId/SubmissionId/sequence epoch/cursor/inbox/ack; runtime/host/driver/migrations; Neon layout and optional RLS; canonical `purchase.registered` payload/hash/limits/collision; retention/snapshot/rebootstrap/deletion; export-only versus backup/restore; available Windows/Android/two-device gates; whether MCG-01 waits for local green evidence.

Recommended first slice:

```text
no provider
→ deterministic purchase.registered fixtures
→ disposable local PostgreSQL + API transaction
→ additive installation/outbox-attempt/inbox schema
→ A offline register
→ upload duplicate/timeout retry
→ B atomic download/apply/cursor
→ acknowledgement
→ restart fact/hash comparison
→ teardown
```

Only after green local proof should Main authorize MCG-01. The last runnable checkpoint remains local-first with synchronization disabled.

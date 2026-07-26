# D_OPS_STAGE — Step 12 Error Protocol Tightening

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Operational materialization authority
Round or unit: C10-GCM02-S12-ERR-01
Branch: `cycle10-intermid-grimoire`
Required remote baseline:
`5f30b9d7a55e1312889873bdb3728233cce72ff2`
Authority: Main Chat under explicit human direction
Status: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
Evidence boundary: repository source and tests plus the append-only
`System Diagnosis` in `[M]_STAGE/J_MAIN_STAGE.md`; no live provider or user
database evidence may be created in this unit

## 1. Accepted starting state

Treat the following as controlling:

- Gate 12.6 is `PASS`;
- the current hosted Device scope contains:
  - `pending=0`;
  - `uploading=0`;
  - `failed=2`;
  - `unknown=0`;
  - `next_sequence=3`;
- the two failed events are the proved `failed/notApplied` lineage at Device
  sequences `1–2`;
- the existing `Retry unresolved submission` control is an unknown-outcome
  preflight and is inapplicable to this lineage;
- the latest button press was locally blocked by
  `unknown-retry-queue-not-isolated`;
- that blocked press performed no local mutation and no protected provider
  request;
- the earlier `sync-unavailable` remains phase-unresolved because current
  instrumentation collapses several distinct paths;
- ordinary Sync, unknown Retry, Repair, Enroll, deployment, provider mutation,
  and direct database mutation remain unauthorized during this unit;
- Gate 12.7 is blocked on action/interface and diagnostic alignment.

Do not reinstate the superseded proposal that unknown-outcome Retry is the
Gate 12.7 action for this `failed/notApplied` lineage.

## 2. Objective

Materialize one source-only, non-provider tightening unit that:

1. establishes one versioned machine-readable Sync diagnostic registry;
2. makes that registry callable from Flutter and TypeScript source;
3. generates one readable documentation view from the same registry;
4. emits typed diagnostics at their actual detecting boundaries;
5. records the last proved pipeline phase and mutation/contact outcomes;
6. makes blocked UI actions unmissable and explains their meaning;
7. adds a separate read-only `failed/notApplied` candidate preflight;
8. corrects the five source hazards named in J before any Gate 12.7 mutation;
9. proves the behavior with isolated and disposable tests;
10. returns evidence through G/H/I without reopening Gate 12.7.

This unit does not implement or authorize an executing
`failed/notApplied` recovery control.

## 3. Writable surfaces

Codex may create or modify only task-relevant files under:

```text
contracts/shared_beta/diagnostics_v1/
scripts/
documentation/SYNC_DIAGNOSTICS.md

clients/markei_flutter/lib/application/
clients/markei_flutter/lib/app/
clients/markei_flutter/lib/domain/sync/
clients/markei_flutter/lib/infrastructure/auth/
clients/markei_flutter/lib/infrastructure/local/
clients/markei_flutter/lib/infrastructure/remote/
clients/markei_flutter/test/
clients/markei_flutter/pubspec.yaml

services/markei_sync_api/src/application/
services/markei_sync_api/src/domain/
services/markei_sync_api/src/http/
services/markei_sync_api/src/postgres/
services/markei_sync_api/test/
services/markei_sync_api/package.json

documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

The list authorizes new task-specific files inside these established folders.
Keep additions minimal. Do not create a new Sketch Notebook file or directory.

An additive local Drift migration and its generated Dart file are authorized
only if required to persist the diagnostic envelope. Its migration source may
be tested against in-memory or disposable copied fixtures. Do not open or
migrate the user's live database.

No hosted PostgreSQL migration is authorized.

## 4. Prohibited surfaces and actions

Do not modify:

- migrations under `services/markei_sync_api/migrations/`;
- methodology files;
- permanent Operational, Didactic, or Design memory;
- Main-root continuity files;
- J;
- D/E/F after beginning materialization;
- product data or unrelated application pages;
- generated platform runner files unless ordinary Flutter generation strictly
  requires it.

Do not:

- contact Render, Auth0, Neon, or another live service;
- read, rotate, log, or persist credentials;
- run the application against a live provider;
- execute Sync, Retry, Repair, Enroll, acknowledgement, rebootstrap, cleanup,
  or provider probes;
- deploy or build a release intended for human execution;
- mutate, copy, inspect, or migrate the user's real SQLite database;
- authorize Gate 12.7 or close GCM-02;
- add a provider-connected failed-recovery action;
- turn a generic HTTP 500 into automatic retry permission.

Stop on branch divergence, dirty overlap, secret exposure, a required hosted
schema change, or a design that cannot distinguish `unknown` from trusted
`not-applied`.

## 5. Canonical machine registry

Create a versioned contract area:

```text
contracts/shared_beta/diagnostics_v1/
```

It must contain:

- a machine-readable diagnostic registry;
- a JSON Schema for the registry;
- a compact README defining generation and ownership;
- all 159 unique `MKS-*` codes presently catalogued in J's
  `System Diagnosis`.

The machine registry becomes the implementation source of truth. J remains the
historical Main synthesis that authorized it.

Every registry entry must include at least:

```text
code
layer
title
meaning
severity
defaultOutcome
operationKinds
phases
nativeCodes
detectionFingerprint
detectorComponent
detectorSourceRefs
causeDomain
causeConfidenceRule
externalDependency
retryPolicy
safeAction
userGuidance
publicVisibility
logVisibility
sensitiveFieldsForbidden
```

Required closed vocabularies include:

```text
severity:
  INFO | WARNING | ERROR | UNKNOWN | CRITICAL

outcome:
  blocked | not-applied | applied | duplicate-equivalent | unknown | completed

providerContact:
  not-started | request-started | headers-received | trusted-response | unknown

transaction:
  not-started | started | committed | rolled-back | unknown

causeConfidence:
  confirmed | inferred | boundary-only | unknown

retryPolicy:
  never | same-identity-only | after-freshness-check | operator-review
```

Registry validation must reject:

- duplicate codes;
- malformed `MKS-<LAYER>-<NNN>` identifiers;
- unknown layer/severity/outcome/phase values;
- missing causal owner or detection site;
- a `retryPolicy` inconsistent with outcome;
- raw URL, token, SQL, ID, payload, full hash, stack, or exception-message
  fields;
- a source reference that does not exist;
- a user-visible entry without meaning and safe guidance.

## 6. Deterministic generation

Implement one deterministic generator/check command that reads the machine
registry and produces:

```text
clients/markei_flutter/lib/domain/sync/sync_diagnostic_registry.g.dart
services/markei_sync_api/src/domain/sync_diagnostic_registry.generated.ts
documentation/SYNC_DIAGNOSTICS.md
```

The exact generator location may be selected within the authorized `scripts/`
surface. It must use repository-owned source and deterministic ordering.

Generation requirements:

- generated files declare that they must not be edited manually;
- running generation twice produces no diff;
- a check mode fails if generated files are stale;
- the Dart and TypeScript registries expose all 159 codes;
- generated code provides typed lookup, not ad hoc string maps;
- documentation is a derived view and contains no independent hand-written
  error catalogue;
- tests prove the registry, Dart adapter, TypeScript adapter, and documentation
  expose the same code set and version.

Add task-specific package scripts only where needed. Do not introduce a runtime
dependency merely to generate static files.

## 7. Diagnostic envelope and correlation

Implement diagnostic schema version `1` using J's required envelope. Preserve
at least:

```text
diagnosticVersion
protocolCode
nativeCode
severity
outcome
operationKind
phase
operationFingerprint
correlationFingerprint
requestOrdinal
submissionFingerprint
requestHashShape
accountScopeFingerprint
deviceScopeFingerprint
sourceRevision
clientBuild
apiBuild
routeClass
queueScope
pendingCount
uploadingCount
failedCount
unknownCount
memberCount
firstSequence
lastSequence
nextSequence
localMutation
providerContact
providerTransaction
httpStatus
headersReceived
responseTrusted
elapsedBand
retryable
safeAction
exceptionClass
```

`sqlStateClass` is server-log-only.

Rules:

- generate one random operation identity per top-level UI action;
- derive a 12-hex SHA-256 `operationFingerprint`;
- assign `requestOrdinal=0` to local preflight and `1..n` to child HTTP
  requests;
- generate a distinct full correlation ID for each child request and persist
  only its 12-hex fingerprint;
- do not reuse the constant `native-closure` correlation;
- persist only normalized/sanitized allowlisted fields;
- preserve current top-level action and each child phase independently;
- if transmission may have started and no trusted response or provider
  transaction result exists, outcome is `unknown`;
- absence of an uninstrumented field is not evidence of `not-started`;
- a later refinement may resolve an earlier `unknown` but must not erase its
  historical event.

## 8. Local persistence and migration

Inspect `SyncAttempts` and choose the smallest additive local representation
that can preserve:

- one parent operation;
- ordered child phase/request events;
- the diagnostic envelope;
- current result versus prior ordinary Sync result;
- operation and correlation fingerprints;
- local/provider contact and transaction outcomes.

An additive v11 Drift migration is authorized if needed. It must:

- preserve every existing v1–v10 row and Sync state;
- add diagnostic storage without rewriting submissions or pending events;
- remain forward-only;
- record a migration-ledger entry;
- reopen successfully;
- pass quick/integrity checks in disposable tests;
- prove that no token, raw identifier, payload, connection string, SQL, full
  hash, raw exception message, or stack can enter the diagnostic store.

Do not use an unvalidated arbitrary JSON dump. If a bounded JSON envelope is
used, parse it through a closed codec and persist indexed projection fields
needed by Diagnostics.

## 9. Flutter operational behavior

### 9.1 UI corrections

In Native Closure:

- rename the existing control to `Retry unknown-outcome submission`;
- rename source symbols/tests where necessary so semantics are not hidden by
  legacy names;
- visibly distinguish:
  - current action result;
  - last ordinary Sync result;
  - last successful Sync;
- render every blocked preflight in a persistent, in-view diagnostic banner or
  card;
- show:
  - `MKS-*` code;
  - concise meaning;
  - outcome and phase;
  - whether local mutation started;
  - whether provider contact started;
  - safe next action;
  - operation fingerprint;
- offer an expandable technical detail view with only sanitized allowlisted
  fields;
- retain UI evidence after Diagnostics refresh;
- catch page/runner exceptions and project a typed sanitized diagnostic rather
  than leaving `_running=true` or appearing to do nothing.

### 9.2 Failed/notApplied inspection

Add a separate action named clearly as read-only, for example:

```text
Inspect failed/notApplied recovery
```

Its preflight must:

- authenticate and verify exact current Device binding;
- query only the current account/Device scope;
- perform no state transition;
- perform no network request;
- find exactly one recoverable `failed/notApplied` submission;
- validate submission membership, contiguous member positions, canonical
  Device sequences, request-hash equality, event states, absence of active
  overlap, and `next_sequence`;
- return only sanitized candidate data:
  - candidate fingerprint;
  - event count;
  - first/last sequence;
  - next sequence;
  - current Device-scope counts;
  - eligibility or exact blocking code;
- show the current proved candidate as two events, sequences `1–2`,
  `next_sequence=3` when run later against the preserved human state;
- never provide an Execute/Recover/Sync confirmation in this unit.

Tests must use fixtures and must not assume the user's identifiers or database
contents.

### 9.3 Pipeline instrumentation

Instrument the parent Sync action and child phases:

```text
authentication
binding
failed-recovery
upload-lease
upload-transport
upload-provider
upload-result-persistence
download-transport
download-provider
download-local-apply
acknowledgement
terminal
```

Every phase must retain its actual native result and mapped `MKS-*` code.
Top-level `sync-unavailable` may remain a UI projection but must no longer
erase the causal diagnostic.

## 10. Required source-hazard corrections

Correct and test all five hazards named by J.

### 10.1 `MKS-QUE-009` — stranded uploading state

After a lease commits, every exit must persist a trusted result or an
`unknown` outcome before control returns. A transport or parsing exception
after request start must not leave unexplained `uploading` rows.

### 10.2 `MKS-QUE-010` — silent result-persistence miss

`persistUploadResult` must not silently return when the scoped submission is
missing. Emit/throw a typed invariant diagnostic and preserve enough context to
show that provider outcome and local persistence outcome differ.

### 10.3 `MKS-REC-012` — mixed-state recovery ambiguity

The `alreadyPending` route must prove every candidate member is already
pending. Mixed failed/pending/uploading/unknown states must block and roll back;
one pending member must not skip requeue validation for the rest.

### 10.4 `MKS-UPL-012` — partial provider batch commit

`acceptSubmission` must validate the complete batch before the first provider
mutation. A later protocol failure must throw or otherwise mark the transaction
rollback-only. Returning a normal `ProtocolFailure` after earlier writes must
not permit commit.

Prove with a multi-event fixture that a failure in a later member leaves:

- zero new provider events;
- unchanged Device next expected sequence;
- unchanged account cursor;
- no submission row.

### 10.5 `MKS-DNL-013` — duplicate-only cursor non-advancement

Equivalent duplicate-only download pages must advance the local contiguous
cursor transactionally when appropriate. Conflicting duplicates must remain a
hard typed failure.

## 11. API and third-service diagnostics

Add internal typed diagnostics without broadening public data:

- Auth0/JWT failures originate in authentication adapters and map to `AUT`;
- membership/Device failures originate in binding/authorization and map to
  `BND`;
- Fastify route/body/authorization failures originate at API ingress and map
  to `API`;
- PostgreSQL pool, SQLSTATE class, transaction, constraint, commit, and
  rollback failures originate at the database boundary and map to `PDB`;
- upload validation/application maps to `UPL`;
- download maps to `DNL`;
- acknowledgement maps to `ACK`;
- DNS/TCP/TLS/timeout/body-decoding symptoms detected by the Flutter HTTP
  boundary map to `TRN`.

Do not label Auth0, Render, Neon, PostgreSQL, or another external service as the
cause merely because its boundary was last observed. Record:

```text
detectorComponent
causeDomain
causeConfidence
externalDependency
lastProvedPhase
```

When causal ownership is unproved, use `unknown` or `boundary-only`.

The API's public unexpected-error response may remain sanitized:

```text
HTTP 500
code=service-unavailable
outcome=unknown
```

but it must include a safe diagnostic/correlation fingerprint and never claim
`retryable=true` solely from status 500. Internal lifecycle evidence must
retain the `MKS-*` code, phase, route class, provider transaction outcome,
sanitized exception class, and SQLSTATE class when available.

## 12. Required tests

Add focused tests proving at minimum:

1. all 159 registry codes are unique and schema-valid;
2. generated Dart, TypeScript, and Markdown code sets equal the registry;
3. generation is deterministic and check mode detects stale output;
4. every source reference in the registry exists;
5. sensitive-field fixtures are rejected;
6. unknown Retry is visibly blocked for `failed=2/unknown=0`;
7. the action label says `unknown-outcome`;
8. current action and previous Sync result remain distinct;
9. failed/notApplied preflight is read-only and network-free;
10. failed preflight exposes only counts, sequence boundaries, and
    fingerprints;
11. blocked page/runner exceptions become visible typed diagnostics and release
    the action lock;
12. unique operation and child correlation fingerprints are generated;
13. request-start without trusted response becomes `unknown`;
14. no `unknown` result is automatically recovered or requeued;
15. post-lease transport exceptions do not strand unexplained uploading state;
16. missing local submission result persistence is a typed invariant;
17. mixed-state failed recovery blocks and rolls back;
18. provider batch validation/rollback prevents partial commit;
19. duplicate-only download advances the cursor;
20. API typed failures preserve internal phase while public responses remain
    sanitized;
21. an unexpected API exception is not advertised as generically retryable;
22. local migration preserves v10 rows and reopens cleanly, if migration is
    added;
23. all previous synchronization, authentication, enrollment, recovery, and
    closure tests remain green.

## 13. Validation commands

Use repository-supported equivalents and report exact commands.

Minimum:

```text
generator update
generator --check
JSON Schema/registry validation

dart format --output=none --set-exit-if-changed lib test tool
dart run build_runner build --delete-conflicting-outputs
flutter analyze
focused Flutter diagnostic/sync/migration tests
flutter test

npm run format:check
npm run lint
npm run typecheck
npm run build
npm test

git diff --check
changed-file secret/sensitive-field scan
```

Do not claim Windows, Android, Render, Auth0, Neon, or end-to-end provider
validation in this unit.

## 14. Required G/H/I reports

Replace G/H/I for this unit.

G must report:

- exact files changed/created/deleted;
- generator and registry checks;
- migration behavior if used;
- Flutter and Node commands/results;
- each hazard correction and its test;
- unexecuted host/provider validation;
- current gate terminal.

H must report:

- code/meaning/guidance mapping behavior;
- confirmation that documentation is generated from the registry;
- how current versus historical results appear;
- how external-service attribution avoids false causal claims;
- remaining terminology or UI ambiguity.

I must report:

- registry ownership and generation dependency direction;
- detector versus cause boundary;
- diagnostic envelope flow;
- local parent/child persistence design;
- transaction/unknown-outcome invariants;
- failed/notApplied preflight boundary;
- confirmation that no executing failed-recovery action was added.

All three reports must end consistently:

```text
ERROR_PROTOCOL_SOURCE_IMPLEMENTED_OR_BLOCKED
ERROR_PROTOCOL_GENERATION_VALIDATED_OR_BLOCKED
FAILED_NOT_APPLIED_PREFLIGHT_NON_MUTATING
FAILED_NOT_APPLIED_EXECUTION_NOT_IMPLEMENTED
PROVIDER_ACTION_NOT_PERFORMED
GATE_12_7_HELD_FOR_RECONCILIATION
GCM02_OPEN
```

Use the correct `IMPLEMENTED`, `VALIDATED`, `HOST_UNVALIDATED`, or `BLOCKED`
classification supported by evidence. Do not force a passing terminal.

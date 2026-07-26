# D_OPS_STAGE — Explicit recovery boundary and paired client/server observability

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Operational materialization authority
Hierarchy: Cycle 10 → GCM-02 → Step 12 → Gate 12.7 pre-authorization
Unit: C10-GCM02-S12-ERR-04
Parent sequence: C10-GCM02-S12-SYNC-01
Branch: `cycle10-intermid-grimoire`
Required ancestry: `27e1b77b81f658b5e704e46923ea48cce2274b3a`
Authority: Main Chat under explicit human direction
Status: **ACTIVE — SOURCE CORRECTION AUTHORIZED; LIVE ACTIONS PROHIBITED**
Evidence boundary: supplied Windows Closure screenshots, supplied sanitized
Render lifecycle lines, repository source, local tests and replacement G/H/I

## 1. Accepted live evidence

The 2026-07-26 ordinary-Sync assay began at approximately 19:50 local
(`22:50Z`) and produced:

```text
client operation fingerprint=cf23d2a09c74
client terminal=sync-completed
client completedAt=2026-07-26T22:50:27Z
client configured deadline=35000ms
queue before=0 pending / 0 uploading / 2 failed / 0 unknown
queue after=0 pending / 0 uploading / 0 failed / 0 unknown
next Device sequence before=3
next Device sequence after=3
```

The matching Render window proves:

| Route | Operation | Authentication | Terminal | Elapsed |
| --- | --- | --- | --- | --- |
| `POST /v1/sync/submissions` | upload-submission | accepted | HTTP 200 | `<3s` |
| `GET /v1/sync/events` | download-events | accepted | HTTP 200 | `<250ms` |
| `POST /v1/sync/acknowledgements` | acknowledgement | accepted | HTTP 200 | `<250ms` |

All three protected requests carry the same sanitized parent operation
fingerprint `cf23d2a09c74`. Their distinct Render correlation fingerprints
identify separate server requests. Current source derives those fingerprints
from Fastify request IDs, so they do not yet prove an exact match to the
client's outbound child correlation headers. Interleaved `/health/ready` HTTP
200 entries are readiness traffic and not part of aggregate Sync success.

This evidence proves one successful client-orchestrated Sync and its three
successful server-request terminals. It does not yet prove:

- second-device convergence;
- exact provider row contents or counts;
- retention, rebootstrap or revocation behavior;
- a server-owned timeout;
- an empty-queue/no-work Sync;
- a newly allocated submission sequence.

`Next Device sequence=3` is expected. Replaying already allocated sequences
1–2 does not allocate sequence 3.

## 2. Reconciled defect

The intended assay prohibited failed/notApplied recovery, but ordinary Sync
executed it anyway:

```text
HostedSyncCoordinator.run()
  → recoverFailedNotApplied()
  → upload pending work
  → download
  → acknowledgement
```

The call is unconditional after authentication and binding. The queue
transition `failed=2 → failed=0`, the `failed-recovery` phase, the upload
request and the successful terminal jointly prove that the held candidate was
recovered and submitted inside ordinary Sync.

This is not an automatic retry introduced by ERR-03; it is a pre-existing
implicit recovery path that ERR-03 preserved. It nevertheless conflicts with
the explicit Closure model in which:

```text
ordinary Sync
failed/notApplied inspection
controlled failed/notApplied recovery
unknown-outcome Retry
```

are separate user actions. Gate 12.7 remains held. No further live action is
authorized until the source boundary is corrected and locally validated.

## 3. Objective

Materialize one narrow correction that:

1. prevents ordinary Sync from mutating or submitting failed/notApplied work;
2. keeps controlled recovery available only through its explicit
   confirmation/action surface;
3. preserves ordinary upload of genuinely pending events;
4. emits sanitized structured client lifecycle lines to the Flutter-run
   terminal;
5. keeps existing sanitized server-request lifecycle lines in Render;
6. makes parent-operation and child-request evidence readable without false
   aggregate claims;
7. exposes both client-child and server-request fingerprints in Render without
   conflating their ownership;
8. removes misleading `not-received`, `not-started` or `not-observed` wording
   when those values merely mean “not stored on the aggregate attempt row”;
9. preserves the 35-second client deadline and the five-result terminal
   vocabulary;
10. introduces no provider call, retry, migration or broad ERR refactor.

## 4. Required recovery separation

Ordinary Sync must not invoke `RecoverFailedNotApplied`.

Permitted ordinary-Sync work:

```text
authenticate
verify Device binding
upload events already in the ordinary pending state
download remote events
apply remote events
acknowledge applied cursor
persist aggregate client terminal
```

Prohibited ordinary-Sync work:

```text
failed/notApplied inspection mutation
failed/notApplied state transition
failed/notApplied recovery submission
unknown-outcome retry
implicit conversion of failed work into pending work
```

The explicit `Recover failed/notApplied candidate` action remains the sole
entry point for controlled recovery. It must retain:

- read-only inspection before confirmation;
- explicit user confirmation;
- candidate fingerprint and membership validation;
- one bounded transition/submission;
- no automatic repeat;
- existing redaction and Gate wording.

Prefer removing the recovery dependency from `HostedSyncCoordinator` if no
ordinary path needs it. If compatibility requires retaining the constructor
shape temporarily, the ordinary run still must not call it. Report the exact
choice in G/I.

## 5. Client terminal lifecycle logging

Add one injectable client lifecycle observer owned at the top-level Closure
operation boundary. Its default assay/debug sink must emit compact one-line
JSON to the terminal used by `flutter run`.

At minimum emit:

```text
operation-started
phase-completed or phase-terminal for meaningful boundaries
operation-completed
operation-failed
```

Required sanitized fields:

```text
timestamp
event
declarationScope=client-operation | client-phase
operationKind
resultCode
diagnosticCode when applicable
lastProvedPhase
operationFingerprint
correlationFingerprint
configuredDeadlineMs
elapsedBand
providerContactState
trustedResponseState
localMutationState
resultPersistenceState
safeNextActionCode or bounded safe action
```

For paired HTTP evidence, preserve separate meanings:

```text
operationFingerprint
  shared parent join across the complete ordinary Sync

clientCorrelationFingerprint
  fingerprint of the outbound client child correlation header

serverRequestFingerprint
  fingerprint of the server/framework request identity
```

If compatibility requires retaining the existing `correlationFingerprint`
field, define its ownership explicitly and add the missing peer field. Do not
log a server request ID under a name that implies it is the client's child
correlation.

Rules:

- emit only fingerprints, never full operation/correlation identifiers;
- do not emit tokens, headers, URLs, request/response bodies, purchases,
  Account/Device/submission IDs, SQL, exception messages or stack traces;
- do not let logging failures change Sync behavior;
- tests must inject a collector rather than scrape the console;
- production/release behavior must be explicit and documented in G. If the
  sink is debug/assay-only, the UI remains the release-safe projection;
- retain the existing server `declarationScope=server-request` logs.

## 6. Projection corrections

The aggregate client attempt does not own one HTTP status or header flag for
the multi-request Sync. Therefore do not display:

```text
status not-observed
headers not-received
```

as if they prove no server response occurred.

Use explicit scope wording such as:

```text
Aggregate HTTP status: not applicable (see child requests)
Aggregate response headers: not applicable (see child requests)
Server request summary: 3 completed / 0 failed
```

If child request evidence is not persisted locally, say:

```text
Child server evidence: inspect correlated server logs
```

Do not invent a server summary from client inference.

The latest-operation overview must distinguish:

- aggregate client terminal;
- newest phase event;
- causal child phases;
- server evidence available only in Render;
- parent operation fingerprint;
- child correlation fingerprint(s).

A terminal observation phase with default `providerContact=not-started` must
not overwrite earlier proved request contact. Either derive an aggregate
operation summary from all phases or label the field as phase-local. The same
rule applies to trusted response, local mutation and result persistence.

## 7. Expected source surfaces

Inspect and change only the smallest necessary subset around:

```text
clients/markei_flutter/lib/application/hosted_sync_coordinator.dart
clients/markei_flutter/lib/app/native_auth_closure_runner.dart
clients/markei_flutter/lib/app/markei_composition.dart
clients/markei_flutter/lib/app/pages/native_closure_page.dart
clients/markei_flutter/lib/application/closure_diagnostics.dart
clients/markei_flutter/lib/infrastructure/local/closure_diagnostics_repository.dart
clients/markei_flutter/lib/application/sync/*
focused Flutter tests
services/markei_sync_api tests only if server-log regression coverage changes
diagnostic registry/generator only if a vocabulary addition is necessary
replacement G/H/I
```

No Drift or PostgreSQL migration is expected. Stop for Main clarification
before adding one.

## 8. Required tests

Add or update focused tests proving:

- ordinary Sync never calls failed/notApplied recovery;
- failed work remains failed and unchanged during ordinary Sync;
- ordinary pending work can still upload;
- no-new-work ordinary Sync reaches the truthful no-work terminal;
- explicit controlled recovery remains callable only through its own action;
- one explicit recovery cannot repeat automatically;
- Next Device sequence does not change when replaying existing sequence
  allocations;
- structured client lines are emitted with scopes, fingerprints, phases,
  timing and terminal result;
- client logging contains no full IDs, tokens, URLs, headers, payloads, SQL,
  exception messages or stack traces;
- a logging sink failure cannot change protocol behavior;
- aggregate UI fields do not claim headers were absent merely because they
  are not stored on the parent attempt;
- phase-local evidence cannot erase proved earlier provider contact;
- parent operation and child request correlation roles remain distinct;
- Render can pair each request to both the client child and server request
  identities without exposing either full identifier;
- ERR-03 five-result, 35-second, readiness and last-success corrections do not
  regress;
- API structured server-request logging remains unchanged and redacted.

Run:

```text
diagnostic generator update/check when touched
deterministic second generator check when touched
Dart format
focused Flutter tests
full Flutter tests
Flutter analyze
API format check
API lint
API typecheck
focused API tests when touched/relevant
full API tests
API build
git diff --check
changed-content sensitive-pattern scan
```

## 9. Writable and prohibited scope

Authorized:

- necessary Flutter source and tests;
- minimal API tests/source only if required to preserve paired logging;
- registry/generated projections only through the generator;
- replacement G/H/I.

Prohibited:

- J, A/B/C, D/E/F and permanent domain memory;
- methodology or Main-root files;
- migration or schema change without clarification;
- live Sync, Retry, recovery, readiness check or provider request;
- deployment;
- Render, Auth0, Neon or user-database access/mutation;
- GRM/GS/I_SCRIPTS execution;
- broad ERR catalogue/filename refactoring;
- automatic retry;
- diagnostic-only provider requests;
- restoration of `SYNC_DIAGNOSTICS.md`.

## 10. G report requirements

G must report:

- exact changed paths;
- removal/gating of the implicit recovery call;
- ordinary pending-work behavior;
- explicit recovery entry point preservation;
- client log schema, sink ownership and build-mode behavior;
- UI aggregate/phase evidence rules;
- parent, client-child and server-request fingerprint field mapping;
- validation commands and counts;
- any deviation or unavailable validation;
- confirmation that no live action occurred.

Terminal markers:

```text
ORDINARY_SYNC_IMPLICIT_RECOVERY=REMOVED_OR_BLOCKED
FAILED_WORK_IMMOBILE_DURING_ORDINARY_SYNC=VALIDATED_OR_BLOCKED
EXPLICIT_RECOVERY_ENTRYPOINT=PRESERVED_OR_BLOCKED
CLIENT_TERMINAL_LIFECYCLE_LOGS=IMPLEMENTED_OR_BLOCKED
SERVER_REQUEST_LIFECYCLE_LOGS=PRESERVED_OR_BLOCKED
AGGREGATE_CHILD_PROJECTION=CORRECTED_OR_BLOCKED
CLIENT_SYNC_DEADLINE_35S=PRESERVED_OR_BLOCKED
AUTOMATIC_RETRY=ABSENT_OR_BLOCKED
LIVE_PROVIDER_ACTION=NOT_PERFORMED
GATE_12_7=HELD
GCM02=OPEN
```

# D_OPS_STAGE — Ordinary-Sync terminal identity and bounded timing assay

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Operational materialization authority
Unit: C10-GCM02-S12-ERR-03
Branch: `cycle10-intermid-grimoire`
Required ancestry: `3d1e82e5259cf51e8cd2d6baf694423494bab7a5`
Authority: Main Chat under explicit human direction
Status: **ACTIVE — NARROW SOURCE MATERIALIZATION AUTHORIZED; LIVE SYNC,
RECOVERY AND DEPLOYMENT PROHIBITED**
Evidence boundary: repository source, generated diagnostic projections,
disposable local tests and replacement G/H/I only

## 1. Accepted evidence

Preserve the accepted REC-01 implementation, the `MKS-REC-001` correction and
the current failed/notApplied candidate. Gate 12.7 remains held.

The post-REC-01 Windows assays established:

```text
authentication=authenticated
enrollment=device-enrolled
failed events=2
candidate sequence range=1-2
next Device sequence=3
hosted readiness=HTTP 200 in under one second
recovery execution=absent
ordinary Sync execution=absent
```

They also exposed one definite semantic defect:

```text
Before readiness:
Last successful sync = 2026-07-26T19:01:18Z

After readiness:
Last successful sync = 2026-07-26T19:19:04Z
```

The latest attempt was `hosted-connection-ready`, not ordinary Sync.
`ClosureDiagnosticsRepository._lastSuccessfulSync()` currently selects the
newest generic completed attempt and therefore lets readiness impersonate
successful Sync.

Source inspection also confirms:

```text
ordinary Sync operation kind already exists
HttpSyncTransport default deadline = 5 seconds
hosted readiness deadline = 20 seconds
ordinary Sync success states already include:
  sync-completed
  sync-no-new-events
```

The five-second hosted end-to-end observation budget is a credible cause of
the historical `sync-interrupted` result, but the evidence does not yet prove
that it is the only cause.

## 2. Objective

Materialize one narrow diagnostic/semantic correction so a later explicitly
authorized assay can distinguish:

```text
operationKind = ordinary-sync

resultCode =
  sync-completed
  sync-no-new-events
  sync-rejected
  sync-server-timeout
  sync-failed
```

The implementation must:

1. make ordinary-Sync terminals explicit and exhaustive at the client
   orchestration boundary;
2. keep hosted readiness on a separate operation/result contract;
3. project “Last successful sync” only from genuine successful ordinary Sync;
4. expose a compact client declaration in the Closure UI;
5. expose compact correlated server request declarations in structured
   terminal logs;
6. replace the five-second hosted ordinary-Sync deadline with a configurable
   assay budget;
7. preserve failures, timeouts and rejections without automatic retry;
8. avoid broad ERR catalogue refactoring until the focused assays conclude.

## 3. Declaration contract

Use one sanitized top-level operation/correlation lineage across the client
ordinary-Sync run and its server requests. Child route correlations may remain
distinct, but they must point to the same parent operation fingerprint.

Every compact declaration must include:

```text
operationKind
resultCode
declarationScope
operationFingerprint
correlationFingerprint
lastProvedPhase
elapsedMs or bounded elapsedBand
configuredDeadlineMs
timestamp
```

Scopes:

```text
client-operation
server-request
```

The client owns the terminal result of the complete ordinary-Sync
orchestration. The server owns only the terminal of the request/transaction it
actually observed. A server-request declaration must never be presented as
proof that the whole client operation, including local result persistence,
completed.

Client operation terminals:

| Result | Required meaning |
| --- | --- |
| `sync-completed` | ordinary Sync completed and all required local terminal persistence succeeded |
| `sync-no-new-events` | ordinary Sync completed with no new upload/download work and terminal persistence succeeded |
| `sync-rejected` | trusted response proves the relevant server request was rejected/notApplied |
| `sync-server-timeout` | trusted server response or authoritative server declaration proves server-owned timeout/rollback |
| `sync-failed` | classified non-timeout failure; evidence must state whether provider contact and trusted response occurred |

Do not collapse “client stopped waiting before a response” into
`sync-server-timeout`. Preserve it as a client-owned transport diagnostic
under the `sync-failed` terminal, with:

```text
trustedResponse=not-received
serverOutcome=unknown
lastProvedPhase=<actual boundary>
```

Server request declarations may use the same result vocabulary only with
`declarationScope=server-request` and the precise route/phase. In particular:

- `sync-no-new-events` is allowed only when that request itself proves an
  empty Sync page/result;
- `sync-completed` proves only that the named server request/transaction
  completed;
- `sync-rejected` requires a trusted protocol/auth rejection;
- `sync-server-timeout` requires an enforced server-owned deadline and proved
  rollback/cancellation;
- `sync-failed` is the redacted unexpected server terminal.

If the server cannot truthfully enforce and prove a timeout rollback, do not
manufacture `sync-server-timeout`; report the architectural blocker in G and
retain `sync-failed`/unknown evidence.

## 4. UI and terminal visibility

On Closure, provide a compact user-readable latest ordinary-Sync declaration:

```text
Ordinary Sync result
Result: <resultCode>
Client declaration: <resultCode>
Server declaration: <resultCode or not-observed>
Last proved phase: <phase>
Elapsed / deadline: <bounded values>
Operation: <sanitized fingerprint>
Correlation: <sanitized fingerprint>
Safe next action: <bounded text>
```

Requirements:

- readiness remains visibly labelled as hosted readiness;
- readiness never updates “Last successful sync”;
- inspection, cancelled confirmation, recovery and Retry never update it;
- rename `Recent sync attempts` to `Recent Closure attempts`;
- retain attempt history without claiming every attempt is Sync;
- user copy must not expose tokens, full identifiers, payloads, URLs, SQL,
  exceptions, stack traces or secrets;
- do not add a broad developer console, export bundle or new support-data
  collection surface in this unit.

Server output must be one compact structured JSON line per entered lifecycle
event or at minimum per terminal, emitted through the existing lifecycle
observer/logger. It must be readable in Render terminal logs and local API test
output without logging request bodies or identity values.

## 5. Timing experiment

Replace the fixed five-second `HttpSyncTransport` default with an explicit,
configuration-owned hosted ordinary-Sync budget.

Initial assay targets:

```text
client response deadline: 35 seconds
server processing deadline: 25 seconds, only if it can cancel/rollback safely
```

Rules:

- the client deadline must exceed any enforced server deadline;
- readiness keeps its own independent deadline;
- enrollment/auth callback/test-only deadlines are out of scope;
- record the applicable configured deadline and elapsed duration;
- do not extend every timeout globally;
- do not introduce automatic retries;
- do not issue a second request after a terminal;
- a JavaScript timer without authoritative transaction cancellation is not a
  valid server deadline;
- preserve dependency injection so focused tests use short deterministic
  deadlines.

## 6. Expected implementation surfaces

Inspect and change only the smallest necessary set around:

```text
clients/markei_flutter/lib/application/hosted_sync_coordinator.dart
clients/markei_flutter/lib/app/native_auth_closure_runner.dart
clients/markei_flutter/lib/app/pages/native_closure_page.dart
clients/markei_flutter/lib/infrastructure/remote/http_sync_transport.dart
clients/markei_flutter/lib/infrastructure/local/closure_diagnostics_repository.dart
services/markei_sync_api/src/http/app.ts
services/markei_sync_api/src/application/sync_service.ts
services/markei_sync_api/src/domain/protocol.ts
diagnostic registry/generator/generated Dart, TypeScript and ERR_DIAGNOSTICS.md
focused existing tests
replacement G/H/I
```

This list is investigative guidance, not authority to touch every file.
Prefer no Drift or PostgreSQL migration. Existing diagnostic attempt storage
should be sufficient. If source inspection proves otherwise, stop and report
the blocker rather than adding schema casually.

`ERR_DIAGNOSTICS.md` is the canonical generated filename for this baseline.
Do not restore or reference `SYNC_DIAGNOSTICS.md` as a live file.

## 7. Focused tests

Add or update tests proving:

- readiness completion cannot advance `lastSuccessfulSyncAt`;
- inspection, cancelled recovery, failed/unknown Sync and Retry cannot advance
  it;
- only `operationKind=ordinary-sync` with `sync-completed` or
  `sync-no-new-events` advances it;
- all five ordinary-Sync terminal results remain distinct;
- client-before-response timeout does not claim server timeout;
- a proved server timeout maps to `sync-server-timeout`;
- correlation lineage joins client operation and server request declarations;
- declaration scopes prevent server request success from impersonating whole
  client operation success;
- UI exposes compact client/server declarations and sanitized fingerprints;
- server lifecycle logs contain the compact structured fields and no bodies,
  tokens or full Account/Device/submission identifiers;
- ordinary Sync uses the configured 35-second production/assay default while
  tests can inject short deadlines;
- no automatic retry or duplicate request is introduced;
- failed event count, candidate identity and next sequence are not mutated by
  readiness or diagnostic projection;
- existing REC-01, unknown Retry and ordinary-Sync behavior do not regress.

Run:

```text
diagnostic generator update/check and deterministic second check
Dart format
Flutter analyze
focused Flutter tests
full Flutter tests
API format check
API lint
API typecheck
API focused tests
full API tests
API build
git diff --check
changed-content sensitive-pattern scan
```

Do not run a live hosted request, Windows manual assay, provider command or
deployment during materialization.

## 8. Writable and prohibited scope

Authorized:

- necessary Flutter/API source and focused tests;
- existing diagnostic registry, generator and generated projections;
- `documentation/ERR_DIAGNOSTICS.md` only through its generator;
- replacement G/H/I reports.

Prohibited:

- J, A/B/C, D/E/F and permanent domain memory;
- methodology and Main-root continuity files;
- GRM/GS/I_SCRIPTS execution;
- hosted deployment or provider access;
- Auth0, Render, Neon or PostgreSQL mutation;
- user-database inspection or mutation;
- recovery execution, Retry or ordinary Sync;
- new migration without stopping for Main clarification;
- broad ERR renaming, catalogue rewriting or unrelated cleanup.

## 9. G report requirements

G must report exact changed paths, declaration ownership, client/server field
mapping, timing values, timeout cancellation semantics, tests/counts, any
deviation and confirmation that no live action occurred.

Terminal markers:

```text
ORDINARY_SYNC_TERMINAL_VOCABULARY=IMPLEMENTED_OR_BLOCKED
CLIENT_OPERATION_DECLARATION=IMPLEMENTED_OR_BLOCKED
SERVER_REQUEST_DECLARATION=IMPLEMENTED_OR_BLOCKED
LAST_SUCCESSFUL_SYNC_FILTER=CORRECTED_OR_BLOCKED
HOSTED_READINESS_SEPARATION=VALIDATED_OR_BLOCKED
CLIENT_SYNC_DEADLINE_35S=IMPLEMENTED_OR_BLOCKED
SERVER_TIMEOUT_ROLLBACK=VALIDATED_OR_NOT_IMPLEMENTED_WITH_REASON
AUTOMATIC_RETRY=ABSENT_OR_BLOCKED
LIVE_PROVIDER_ACTION=NOT_PERFORMED
GATE_12_7=HELD
GCM02=OPEN
```

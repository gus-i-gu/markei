# F_DSN_STAGE — Correlated ordinary-Sync declaration architecture

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Design materialization authority
Unit: C10-GCM02-S12-ERR-03
Branch: `cycle10-intermid-grimoire`
Required ancestry: `3d1e82e5259cf51e8cd2d6baf694423494bab7a5`
Status: **ACTIVE — SOURCE MATERIALIZATION ONLY; PROVIDER EXECUTION PROHIBITED**

## 1. Architectural objective

Complete the existing ordinary-Sync diagnostic contract without widening the
ERR system:

```text
Closure UI
└─ ordinary-Sync runner
   ├─ top-level operation identity
   ├─ hosted Sync coordinator
   │  ├─ upload request
   │  ├─ download request
   │  └─ acknowledgement request
   ├─ client-operation terminal declaration
   └─ local diagnostic persistence

Sync API
└─ correlated route lifecycle
   ├─ request ingress
   ├─ authentication/authorization
   ├─ database transaction
   └─ server-request terminal declaration
```

One shared sanitized parent operation fingerprint joins the two sides. Child
correlations retain route identity and order.

## 2. Ownership boundary

The client orchestration is the only component that can truthfully decide
whether the complete ordinary Sync finished, because it owns:

- the sequence of upload/download/acknowledgement calls;
- local remote-event application;
- local cursor/result persistence;
- the final UI projection.

The server can truthfully declare only:

- whether a specific request arrived;
- whether authorization passed;
- whether a database transaction began and committed/rolled back;
- which bounded response/result that request produced;
- whether its own enforced deadline fired.

Therefore every declaration carries:

```text
declarationScope=client-operation | server-request
```

Do not add an endpoint that merely echoes the client’s result and call that a
server self-declaration. Do not claim aggregate server knowledge that the
current multi-request protocol does not provide.

## 3. Terminal model

Add or centralize a typed ordinary-Sync terminal model covering exactly:

```text
sync-completed
sync-no-new-events
sync-rejected
sync-server-timeout
sync-failed
```

Map existing outcomes deliberately:

- accepted/duplicate-equivalent request phases may continue toward one of the
  two client success terminals;
- typed notApplied/protocol/auth rejection maps to `sync-rejected`;
- proved server-owned deadline with rollback maps to
  `sync-server-timeout`;
- client deadline without trusted response maps to `sync-failed` with server
  outcome unknown;
- unexpected local, transport or server failure maps to `sync-failed` while
  preserving the last proved phase and evidence axes.

Do not discard the lower-level MKS/native diagnostic that explains the
terminal.

## 4. Correlation and logging

Propagate one top-level ordinary-Sync operation identity through every HTTP
request. Preserve or add child correlation identities where already supported.

The public/log projection uses only sanitized fingerprints. Full operation,
Account, Device, event, submission and token identity remains internal.

Structured server terminal log:

```json
{
  "operationKind": "ordinary-sync",
  "resultCode": "sync-completed",
  "declarationScope": "server-request",
  "routeClass": "sync-submission",
  "operationFingerprint": "<sanitized>",
  "correlationFingerprint": "<sanitized>",
  "lastProvedPhase": "response-completed",
  "elapsedBand": "lt-250ms",
  "configuredDeadlineMs": 25000
}
```

This is a schema example, not an instruction to log this result regardless of
the actual request. Keep log ordering deterministic enough for one narrow UTC
assay window.

## 5. Timing architecture

Separate timing ownership:

```text
readiness deadline
ordinary-Sync client response deadline
ordinary-Sync server processing deadline
test-only injected deadline
```

Set the hosted ordinary-Sync client default to 35 seconds through composition
or explicit configuration rather than burying a new magic value across call
sites.

An optional 25-second server deadline is valid only when:

- it applies to the intended Sync request boundary;
- outstanding database work is cancelled or rolled back;
- the resulting response/log truthfully reports the server timeout;
- the client remains listening long enough to receive it.

Do not implement timeout by racing a response Promise while database work
continues. If safe cancellation is not available within the narrow unit,
leave the server deadline unimplemented, report why, and still add elapsed
structured lifecycle evidence.

## 6. Projection query

Correct the local “Last successful sync” query to require all of:

```text
operationKind = ordinary-sync
outcomeClass = completed
resultCode IN (sync-completed, sync-no-new-events)
completedAt IS NOT NULL
```

Do not infer success from `outcomeClass=completed` alone.

No schema migration is expected. Prefer querying existing attempt/phase
columns. If operation kind is not available in the required stored projection,
stop and report the exact persistence gap rather than weakening the filter.

## 7. Compatibility and validation

Preserve:

- hosted readiness contracts and 20-second readiness timeout;
- REC-01 inspection/recovery separation;
- unknown-outcome Retry behavior;
- current queue/submission/cursor/purchase truth;
- diagnostic registry as single vocabulary owner;
- existing redaction and fingerprint rules;
- no automatic retry;
- no new provider call solely for diagnostics;
- Drift v1–v12 compatibility unless source proves otherwise.

Design validation must prove:

- typed five-result client terminal exhaustiveness;
- truthful server-request scope;
- shared parent correlation with distinct child request identities;
- correct last-success query predicate;
- independent timing ownership;
- no continuing database work behind a reported server timeout;
- no payload/identity leakage;
- no live provider activity during implementation;
- broad ERR refactor remains deferred.

Do not edit permanent design memory.

I terminal markers:

```text
ORDINARY_SYNC_TERMINAL_MODEL=BOUNDARY_STABLE_OR_BLOCKED
CLIENT_OPERATION_OWNERSHIP=VALIDATED_OR_BLOCKED
SERVER_REQUEST_OWNERSHIP=VALIDATED_OR_BLOCKED
CORRELATION_LINEAGE=VALIDATED_OR_BLOCKED
SUCCESS_QUERY_PREDICATE=VALIDATED_OR_BLOCKED
TIMEOUT_OWNERSHIP=VALIDATED_OR_BLOCKED
NO_FALSE_SERVER_TIMEOUT=VALIDATED_OR_BLOCKED
NO_NEW_DIAGNOSTIC_PROVIDER_CALL=PASS_OR_BLOCKED
GATE_12_7=HELD
GCM02=OPEN
```

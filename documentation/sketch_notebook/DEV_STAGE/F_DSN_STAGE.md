# F_DSN_STAGE — Explicit recovery command boundary and paired observability

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Design materialization authority
Hierarchy: Cycle 10 → GCM-02 → Step 12 → Gate 12.7 pre-authorization
Unit: C10-GCM02-S12-ERR-04
Parent sequence: C10-GCM02-S12-SYNC-01
Branch: `cycle10-intermid-grimoire`
Required ancestry: `27e1b77b81f658b5e704e46923ea48cce2274b3a`
Status: **ACTIVE — SOURCE MATERIALIZATION ONLY; PROVIDER EXECUTION PROHIBITED**

## 1. Architectural finding

Current source combines two command boundaries:

```text
ordinary Sync command
└─ HostedSyncCoordinator.run()
   ├─ authentication
   ├─ binding
   ├─ recoverFailedNotApplied()   ← implicit controlled-recovery crossover
   ├─ upload pending
   ├─ download/apply
   └─ acknowledgement
```

The live assay proves that this is reachable: failed work fell from two to
zero and the correlated upload route completed. The design must become:

```text
ordinary Sync command
├─ authentication
├─ binding
├─ upload ordinary pending
├─ download/apply
├─ acknowledgement
└─ aggregate terminal persistence

controlled recovery command
├─ read-only inspection
├─ explicit confirmation
├─ candidate/membership revalidation
├─ one failed→recoverable transition
├─ one bounded submission
└─ recovery terminal persistence
```

The commands may reuse lower-level transport and outbox primitives. They must
not share an implicit entry point or silently invoke each other.

## 2. State and sequence invariants

Ordinary Sync:

- may mutate ordinary pending/uploading rows according to the existing Sync
  protocol;
- must leave failed/notApplied and unknown candidates unchanged;
- must not allocate a new sequence merely because Sync was pressed;
- must not advance Next Device sequence when replaying an already allocated
  event;
- must not convert failed work into pending work.

Controlled recovery:

- acts on exactly one freshly revalidated candidate;
- reuses its existing allocated member sequences;
- never creates a duplicate sequence allocation;
- remains explicit, confirmed and non-repeating.

## 3. Paired observability architecture

Preserve three declaration scopes:

```text
client-operation
client-phase
server-request
```

Identity model:

```text
parent operation identity
├─ sanitized operation fingerprint shared across client and server
├─ client child correlation fingerprint per outbound request
└─ server request fingerprint per received route
```

The full identities remain internal. Only sanitized fingerprints are public
or logged.

Client observer ownership:

- create/inject at the top-level Closure composition boundary;
- pass through the runner/coordinator/phase recorder;
- emit operation and phase declarations through one redacted projector;
- use a test collector for deterministic assertions;
- make the console sink failure-isolated;
- state whether console output is enabled in debug/assay builds, release
  builds or both.

Server observer ownership remains the existing API lifecycle observer and
`consoleLifecycleObserver`.

Current source derives Render's `correlationFingerprint` from
`FastifyRequest.id`, while the client also sends `x-correlation-id`. Preserve
both identities as separately named sanitized fingerprints, or document and
implement an equally explicit mapping. The parent operation fingerprint is
already the proved aggregate join. Do not overwrite the server request
identity with the client value or falsely claim they are identical.

## 4. Aggregate evidence model

Do not flatten child request evidence into nullable scalar fields on the
parent attempt and then interpret null as failure.

Preferred minimal model:

```text
ClientOperationSummary
  resultCode
  lastProvedPhase
  elapsed/deadline
  aggregate provider contact derived from all phases
  aggregate trusted-response evidence derived from all phases
  local/result persistence
  parent operation fingerprint

ClientPhaseEvidence[]
  phase-local axes
  child correlation fingerprint

ServerRequestEvidence (external/log-correlated)
  route
  request terminal
  HTTP status
  server correlation fingerprint
```

No local provider request may be added merely to populate this model.
Persisting more local diagnostic facts may use the existing schema only. If
the correction requires a migration, stop and report the exact gap.

## 5. Reachable result model

Preserve ERR-03:

```text
sync-completed
sync-no-new-events
sync-rejected
sync-server-timeout
sync-failed
```

The current live run is `sync-completed`, not `sync-no-new-events`, because
material upload work occurred. After the recovery crossover is removed, an
ordinary run with no pending/download/acknowledgement work should reach the
existing truthful no-work terminal according to the protocol’s actual
semantics.

Do not implement a server timeout without authoritative cancellation/rollback.
The 35-second client deadline remains independent.

## 6. Compatibility

Preserve:

- explicit failed/notApplied recovery UI and confirmation;
- unknown-outcome Retry separation;
- ERR-03 operation/correlation headers;
- server request lifecycle JSON;
- successful pending upload/download/acknowledgement;
- local cursor and result persistence;
- last-success predicate;
- readiness separation;
- diagnostic registry single ownership;
- Drift v1–v12 compatibility;
- no automatic retry;
- no diagnostic-only network request.

## 7. Validation

Design validation must prove:

- command dependency direction prevents ordinary→controlled recovery calls;
- controlled recovery can reuse lower-level primitives without being called
  by ordinary Sync;
- failed and unknown state invariants hold under ordinary Sync;
- pending event behavior does not regress;
- sequence allocation remains monotonic and replay-safe;
- parent/child identity lineage matches the server log contract;
- each server line exposes a separately owned client-child fingerprint and
  server-request fingerprint when the client header is present;
- aggregate evidence is derived from causal phases, not only the newest row;
- null/not-persisted child HTTP metadata is not treated as transport failure;
- console observer is redacted, injectable and failure-isolated;
- no schema/provider/migration expansion occurred;
- broad ERR refactoring remains deferred.

Do not edit permanent design memory.

I terminal markers:

```text
ORDINARY_CONTROLLED_RECOVERY_BOUNDARY=SEPARATED_OR_BLOCKED
FAILED_STATE_INVARIANT=VALIDATED_OR_BLOCKED
SEQUENCE_REPLAY_INVARIANT=VALIDATED_OR_BLOCKED
CLIENT_OBSERVER_ARCHITECTURE=BOUNDARY_STABLE_OR_BLOCKED
CLIENT_SERVER_LINEAGE=VALIDATED_OR_BLOCKED
AGGREGATE_PHASE_EVIDENCE_MODEL=TRUTHFUL_OR_BLOCKED
NO_DIAGNOSTIC_PROVIDER_CALL=PASS_OR_BLOCKED
NO_SCHEMA_MIGRATION=PASS_OR_BLOCKED
GATE_12_7=HELD
GCM02=OPEN
```

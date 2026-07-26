# F_DSN_STAGE — Step 12 Diagnostic Architecture Completion

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Design materialization authority
Unit: C10-GCM02-S12-ERR-02
Required ancestry: `0636c54e139fc92b16d1e11b2672d61f42f02f1b`
Status: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Architectural baseline

Preserve this dependency direction:

```text
diagnostics_v1 registry
    ↓ deterministic generation
typed Dart projection       typed TypeScript projection
    ↓                               ↓
Flutter detectors/UI        API/provider detectors
    ↓                               ↓
local operation timeline    internal structured evidence
             ↘             ↙
       generated documentation
```

J is provenance, not a runtime dependency. Markdown is a projection, not an
input. Flutter must not import TypeScript and the API must not parse Markdown.

## 2. Parent/child model

`sync_attempts` remains the top-level operation owner. Ordered diagnostic
events remain children.

One top-level action owns:

- one random operation identity;
- one stable sanitized operation fingerprint;
- one operation kind;
- zero or more deterministic child ordinals.

Every child owns:

- a distinct full correlation identity;
- a sanitized correlation fingerprint;
- phase and last-proved-phase;
- typed protocol/native code;
- state evidence and outcome.

The operation identity must not masquerade as child correlation identity.
Network-free local phases still receive ordered child identities so the
timeline has one uniform model.

## 3. Evidence state machine

Model evidence independently across axes:

```text
local mutation
provider contact
trusted response
provider transaction
local result persistence
terminal outcome
```

Precedence:

1. proved provider transaction;
2. trusted typed provider result;
3. trusted transport response;
4. request-start evidence;
5. local preflight evidence.

Required invariants:

- no request start plus no mutation is locally blocked;
- request start without trusted provider outcome is unknown;
- HTTP status alone cannot prove provider commit;
- provider outcome and local persistence outcome cannot overwrite one another;
- later resolution links to historical unknown evidence rather than deleting
  it;
- a terminal UI summary references its causal child event.

## 4. Projection boundaries

Use one internal typed diagnostic event and explicit projections:

```text
internal event
├── local persisted sanitized envelope
├── internal API/log projection
├── public API projection
└── Flutter UI projection
```

The public projection may expose closed codes, safe phase/outcome fields, and
12-hex fingerprints only. Full correlation IDs, exception classes, SQLSTATE,
messages, stack traces, SQL, raw IDs, payloads, and provider details must not
cross the public boundary.

Do not construct public response fields ad hoc in unrelated catch blocks.

## 5. Detector/cause boundary

The registry centralizes meaning; source boundaries own detection.

Each reachable detector must emit through typed lookup and record:

- detector component;
- last proved phase;
- cause domain;
- causal confidence;
- external dependency only when proved.

The ordinary Sync coordinator orchestrates and correlates. It must not
reclassify every child failure as upload or `sync-unavailable`.

`MKS-UPL-012` is reserved for the invariant that a provider batch partially
committed or risked partial commit. Route/body/auth/transport/database and
other upload failures require their own typed code.

## 6. Migration boundary

Prefer the existing v11 child ledger. If required fields cannot be represented
without ambiguity, add the smallest forward-only v12 migration.

No migration may:

- rewrite queue/submission/cursor/purchase truth;
- touch the user's database;
- introduce unbounded diagnostic payloads;
- store forbidden sensitive fields;
- alter hosted PostgreSQL.

Prove v11 preservation and reopen behavior in disposable fixtures.

## 7. Architectural validation

I must provide source and test evidence for:

- registry ownership unchanged;
- dependency direction unchanged;
- all ordinary Sync phases represented;
- unique operation and distinct child correlation identities;
- deterministic ordinals;
- complete bounded persisted envelope;
- one typed internal event feeding explicit projections;
- public/internal field separation;
- precise detector/cause attribution;
- narrow `MKS-UPL-012` ownership;
- read-only failed inspection remaining isolated from execution;
- no provider action or Gate authorization.

Do not claim that all 159 catalogue conditions are runtime-reachable. Report
the audited reachable set and any intentionally non-reachable definitions.

Terminal markers:

```text
DIAGNOSTIC_SINGLE_OWNER=PRESERVED_OR_BLOCKED
OPERATION_CHILD_MODEL=IMPLEMENTED_OR_BLOCKED
EVIDENCE_STATE_MACHINE=IMPLEMENTED_OR_BLOCKED
PROJECTION_BOUNDARIES=VALIDATED_OR_BLOCKED
DETECTOR_CAUSE_ATTRIBUTION=VALIDATED_OR_BLOCKED
FAILED_RECOVERY_EXECUTION=ABSENT
GATE_12_7=HELD
GCM02=OPEN
```

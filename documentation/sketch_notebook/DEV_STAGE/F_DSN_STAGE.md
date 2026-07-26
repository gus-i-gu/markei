# F_DSN_STAGE — Gate 12.7 bounded recovery architecture

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Design materialization authority
Unit: C10-GCM02-S12-REC-01
Branch: `cycle10-intermid-grimoire`
Required ancestry: `76540c45702b027d56b52fea05a8025f14496cdf`
Status: **ACTIVE — SOURCE MATERIALIZATION ONLY; PROVIDER EXECUTION PROHIBITED**

## 1. Architectural objective

Add one narrow recovery-and-upload orchestration boundary without widening
ordinary Sync or coupling the read-only inspection to mutation.

Required dependency shape:

```text
Closure UI
├─ read-only failed inspection
└─ explicit confirmation
   └─ bounded failed-recovery coordinator
      ├─ auth/binding guard
      ├─ exact candidate revalidation
      ├─ atomic local recovery
      ├─ exact recovered-batch lease
      ├─ one upload transport operation
      └─ diagnostic/result persistence
```

The bounded coordinator must not depend on download or acknowledgement ports.
It must not call the ordinary Sync coordinator.

## 2. Identity boundary

The public/UI boundary may carry only sanitized fingerprints and counts.
The application/infrastructure boundary must retain authoritative internal
identity.

Do not pass a truncated fingerprint back as the database selector.

Model the execution input as a confirmation snapshot containing sanitized
expectations, while the transactional repository independently resolves the
single current Account/Device candidate and compares every expected property.
Return an internal bounded batch descriptor only after the exact transition
succeeds.

The descriptor must be sufficient for the uploader to lease exactly the
recovered member set. It must not be serialised to UI, logs, or public API.

## 3. Atomicity and concurrency

The local recovery transaction must:

1. re-read the current scoped candidate;
2. validate membership, identity, content hashes, states, overlap and range;
3. compare the current candidate with the confirmation snapshot;
4. supersede exactly one failed submission;
5. requeue exactly its failed members;
6. return the exact member set and bounded metadata.

The upload-lease transaction must either lease that complete exact set or
lease nothing. Unexpected pending work, membership drift, partial update, or
concurrent state change is a typed pre-contact blocker.

Do not create a state where the uploader can silently include unrelated work.

## 4. Side-effect boundary

Exactly one provider request is permitted by the new coordinator after local
preflight and exact lease succeed.

The coordinator stops after upload-result persistence. It does not:

- download;
- apply remote events;
- acknowledge a cursor;
- enroll/query/revoke a Device;
- repair/rebootstrap;
- run ordinary Sync;
- retry automatically;
- issue a second provider request.

The one-action UI lock is presentation safety; repository/protocol invariants
remain the authoritative safety boundary.

## 5. Outcome and diagnostics architecture

Preserve independent axes:

```text
candidate/preflight state
local recovery transaction
upload lease
provider contact
trusted response
provider transaction outcome
local result persistence
terminal classification
```

Use the accepted parent/child diagnostic model:

- one random top-level operation identity;
- one stable sanitized operation fingerprint;
- distinct child correlations and fingerprints;
- deterministic ordinals;
- typed detector-level MKS/native codes;
- explicit public/local/internal projections.

A final summary may not erase the last causal child event.

Detector ownership must also remain coherent: the historical `MKS-UI-004`
missing-inspection condition cannot be the success code for an existing,
eligible recovery preflight. Route the current detector through a precise REC
definition from the single registry and regenerate its projections.

## 6. Compatibility boundary

Preserve:

- existing `Inspect failed/notApplied recovery` network-free behavior;
- existing unknown-outcome Retry behavior;
- ordinary Sync behavior;
- diagnostic registry single ownership;
- Drift v1–v12 forward compatibility;
- current submission/event/cursor/purchase truth.

Prefer no schema migration. If a new bounded field is unavoidable, use the
smallest additive v13 migration, include ledger/reopen/preservation tests, and
do not touch a user database or hosted PostgreSQL.

## 7. Design validation

I must report source and test evidence for:

- separate inspection and execution dependency paths;
- no ordinary Sync invocation;
- no download/ack dependencies;
- authoritative identity never reduced to a fingerprint;
- atomic candidate recovery and exact-set lease;
- concurrency/mismatch fail-closed behavior;
- exactly one provider request;
- no automatic retry;
- complete outcome/evidence axes;
- coherent REC preflight detector/code ownership without repurposing
  `MKS-UI-004`;
- explicit public/internal redaction;
- no provider action during materialization.

Do not edit permanent design memory.

Terminal markers:

```text
BOUNDED_RECOVERY_COORDINATOR=IMPLEMENTED_OR_BLOCKED
REC_PREFLIGHT_CODE_OWNERSHIP=VALIDATED_OR_BLOCKED
AUTHORITATIVE_IDENTITY_BOUNDARY=VALIDATED_OR_BLOCKED
ATOMIC_EXACT_SET_LEASE=VALIDATED_OR_BLOCKED
ONE_PROVIDER_REQUEST_MAX=VALIDATED_OR_BLOCKED
ORDINARY_SYNC_DOWNLOAD_ACK_ISOLATION=VALIDATED_OR_BLOCKED
GATE_12_7=HELD
GCM02=OPEN
```

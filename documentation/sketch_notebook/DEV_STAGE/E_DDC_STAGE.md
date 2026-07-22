# E_DDC_STAGE — Account Lifecycle Invariant Semantics

> Unit: C10-MCG02-ACCOUNT-CURSOR-PROVISIONING-REPAIR_20260722
> Sequence: FLX-ORD-01
> Authority: Main Chat
> Status: READY FOR LOCAL MATERIALIZATION

## 1. Learning objective

Materialize and explain the distinction:

```text
table permits a cursor row
!= every Account receives one
!= runtime may repair one
```

The cursor row is an Account lifecycle invariant. Account provisioning creates it; enrollment verifies
or consumes the Account; Sync advances it. A fail-closed 503 remains defensive behavior for corrupted
or incomplete state, not the normal initialization path.

## 2. Required vocabulary

Use these bounded meanings consistently in code comments, tests and H:

- **Account provisioning invariant:** every committed Account has exactly one cursor-state row before
  it is externally usable.
- **atomic creation:** Account and initial cursor state commit or roll back together.
- **historical backfill:** a forward-only migration adds only missing derived state for pre-existing
  Accounts; it does not reinterpret or reset established state.
- **cursor high-water:** the greatest already assigned `server_cursor`; a missing row resumes at
  high-water + 1, or 1 when no cursor was ever assigned.
- **preservation:** an existing `next_cursor` value is authoritative and must not be reset, decreased
  or recomputed by repair.
- **defense in depth:** Sync still rejects missing state as `service-unavailable/not-applied` even
  after normal provisioning makes the state mandatory.
- **exact readiness:** the new server accepts a database only when the precise 007 contract is
  installed; generic liveness and 006 readiness are insufficient.

## 3. Required distinctions

Tests and reports must preserve:

```text
backfill applied locally
!= migration deployed to Neon
!= hosted Account repaired
!= protected Sync succeeded
!= GCM02 closed
```

Likewise:

- a trigger enforces future creation but does not alone repair history;
- a backfill repairs history but does not alone prevent recurrence;
- enrollment success proves Device/enrollment state, not Account cursor readiness;
- HTTP 503 proves a bounded not-applied failure, not successful repair;
- readiness proves required database capability, not end-to-end Sync acceptance.

## 4. User/operator semantics

This unit does not authorize a new user-facing retry or provider instruction. Existing Closure history
and unknown event identity remain unchanged. No UI should claim that cursor repair has occurred until
deployment and provider verification are separately evidenced.

If application wording changes only because readiness-v2 is introduced, keep it bounded to
`not-ready`/`service-unavailable`; do not expose migration names, SQL, provider topology, identifiers or
internal exception details.

## 5. Named semantic evidence for H

H must report:

- the pre-007 representable invalid state;
- why Account provisioning—not enrollment or first Sync—owns initialization;
- the exact backfill rule and existing-row preservation rule;
- the trigger's atomic commit/rollback meaning;
- runtime privilege reduction;
- 006 readiness versus 007 exact readiness;
- the difference between local validation, later deployment, provider verification and real Sync;
- synthetic examples only and no learner-maturity inference.

No permanent Didactic files or KANBAN statuses are authorized in this unit.

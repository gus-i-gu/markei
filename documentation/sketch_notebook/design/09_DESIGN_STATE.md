# 09_DESIGN_STATE.md

> Version: 0.6-cycle07-sprint03-unit01
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat [D]
> Scope: Current Design state after Sprint 03 Unit 01 Flutter foundation
> Sources: J section 19, C_DESIGN, I_DSN_CODEX, repository materialization evidence

---

# Current State

Cycle 06 remains accepted and protected. Sprint 03 Unit 01 materially added an isolated Flutter/Dart foundation without replacing Python/PySide6 or accessing its database.

```text
implemented and locally unit-tested
    Dart domain/application boundaries
    Drift fresh local persistence
    account-private catalogue structures
    Purchase + Purchase Items
    atomic local event/queue transaction
    close/reopen persistence
    minimal analytics registry

generated but host-unvalidated
    Android, Windows, iOS platform targets

not implemented
    user purchase workflow
    authentication/authorization
    TypeScript API
    Postgres/Neon
    upload/download synchronization
    cross-device convergence
    legacy import and parity
```

# Materialized Architecture

```text
Flutter composition
→ Register Purchase application port
→ infrastructure-independent Dart domain
→ local repository boundary
→ Drift adapter and fresh SQLite database
```

Widgets own no SQL or durable transaction. The domain imports no Flutter widget, Drift, HTTP, Python, or platform-plugin APIs. Drift is now implemented for the local foundation.

The local Register transaction resolves catalogue references, validates Items, inserts Purchase/Items, prepares `purchase.registered`, enqueues it, and commits atomically. Invalid Items roll back all writes. Network work is absent from the transaction.

# Implemented Representations

- account-private Products and Stores;
- PACKAGED/BULK Product modes;
- MASS/VOLUME/COUNT with canonical KG/L/UNIT;
- six-decimal microunits and fractional COUNT rejection;
- ISO currency plus integer minor units;
- Purchase aggregates with one or more Items;
- identifier/version analytics registry;
- fresh local schema version 1 and migration-ledger structure;
- versioned semantic JSON fixtures.

These claims are local and test-bounded.

# Defects and Provisional Areas

**Likely defect:** repeated Purchase registration may reset the Device sequence and reuse sequence 1. Monotonic device ordering is not accepted as implemented.

**Normalization risk:** current `\w`-based normalization may damage accented Portuguese text. Normalization v1, locale/Unicode policy, and identity migration remain provisional.

**Identifier question:** Product IDs are deterministic UUID-shaped SHA-256 derivations, but RFC UUID semantics and TypeScript parity are unproven.

**Contract gap:** purchase and sync fixtures are examples, not complete schemas or wire specifications.

**Migration gap:** fresh database creation is tested; schema upgrade/recovery and legacy import are not.

**Catalogue gap:** Store reuse is exact-name matching; Store branch/location identity and deduplication remain undefined. Product similarity remains warning-only.

# Validation Boundary

Passed:

- Dart formatting and generation;
- `flutter analyze`;
- nine Flutter tests;
- five Python regression tests;
- atomic rollback and close/reopen tests.

Host-unvalidated:

- Android build/run;
- Windows build/run;
- iOS build/run;
- responsive/shared-application lifecycle.

# Recommended Next Design Route

Design recommends a bounded local shared-client vertical slice first:

```text
correct sequence and Unicode identity defects
→ strengthen canonical fixtures
→ minimal Flutter Purchase UI
→ catalogue and Store selection/creation
→ multi-item staging
→ atomic registration
→ visible local projection/history
→ close/reopen
→ Windows and Android execution
```

The TypeScript/Postgres local protocol harness should follow rather than be silently combined. This is a recommendation, not Sprint 04 authority.

# Authorization and Recovery

Domain permanent reconciliation is complete through this checkpoint. Main must next reconcile domain updates, refresh 00/05/06, and define Sprint 04. D/E/F remain inactive until human approval.

```text
Canonical architecture
    design/01_ARCHITECTURE.md

Derived map
    design/14_MODEL_OVERVIEW.md

Rationale/history
    design/03_DECISION_LOG.md

Main orientation
    [M]_STAGE/J_[M]_STAGE.md section 19
```

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later.

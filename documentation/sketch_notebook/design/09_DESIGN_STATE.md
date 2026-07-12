# 09_DESIGN_STATE.md

> Version: 0.6-cycle07-sprint03-unit01
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat [D]
> Scope: Current Design state after Sprint 03 Unit 01 Flutter foundation
> Sources: J section 19, C_DESIGN, I_DSN_CODEX, repository materialization evidence

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above preserves prior checkpoints. This is the single current Design checkpoint.

# Cycle 07 Sprint 04 Design Checkpoint

> Branch: `cycle-07-mobile-preparation`  
> Inspected implementation head: branch state containing Sprint 04 Codex report and J section 21  
> Evidence: `DEV_STAGE/I_DSN_CODEX.md`  
> Main reconciliation: `[M]_STAGE/J_[M]_STAGE.md`, section 21  
> Pre-materialization Design intent: `DEV_STAGE/C_DESIGN.md`

## Current architecture

Cycle 06 remains accepted, protected, and recoverable. Sprint 04 extends the isolated Flutter/Dart client into a local Windows-executed vertical slice without opening or converting the ordinary PySide6 database.

```text
Flutter presentation
→ application commands/query ports
→ independent Dart domain
→ local repository adapters
→ Drift schema v2
→ application-private SQLite
```

The composition root owns database and adapter construction. Widgets own no SQL or durable transaction. Python remains outside the Flutter runtime.

## Implemented and validated

- Product internal ID and user Product code are distinct; new internal IDs use UUID v4.
- Product codes are required, display-preserving, normalized, and account-scoped unique.
- normalization v2 preserves accented Portuguese text and separates display from normalized facts;
- Purchase remains a one-or-more Item aggregate;
- registration atomically writes catalogue references, Purchase/Items, device sequence, immutable event, and pending queue entry;
- Device creation no longer resets sequence; account/device/sequence uniqueness exists;
- Drift v1→v2 migration preserves Product IDs/references and backfills reviewable legacy codes;
- JSON Schema Draft 7 validates versioned v2 structures; Dart tests own semantic invariants;
- minimal Purchase/History navigation, multi-item staging, local submission, and visible history exist;
- formatting, analysis, 21 Flutter tests, five Python tests, Windows build, and Windows startup smoke passed.

## Evidence limits

```text
validated
    local domain/persistence/migration/contract tests
    Windows build and five-second startup smoke

implemented but not fully accepted
    minimal UI and local history
    schema v2 as one controlled upgrade
    local account/device placeholder composition

blocked or host-unvalidated
    manual UI/accessibility review
    Android build — SDK absent; installation prohibited
    Android execution
    iOS build/run
```

A generated platform target is not platform validation. A pending event queue is not synchronization. Structural schema validation is not cross-language semantic parity.

## Accepted Design boundaries

- Flutter/Dart remains the future shared-client basis with inward dependencies.
- Local persistence is application-private and offline-first.
- User Product code is distinct from immutable relational Product identity.
- Versioned exact Product identity uses normalized catalogue facts; fuzzy matching warns only.
- Purchase and its Items commit as one local aggregate with one prepared append-only event.
- PySide6 and its database remain protected until parity and human/Main acceptance.
- TypeScript API and Neon remain favored planning boundaries, not implemented components.

## Provisional, defective, or incomplete

- the fixed local account/device identifiers are not production identity or authentication;
- Store exact-name reuse is not branch/location identity or deduplication;
- Product-code editing, alias, retirement, and reuse policy is absent;
- fresh-create migration-ledger time remains source-fixed, while upgrade time is runtime UTC;
- one v1→v2 migration does not establish general downgrade, recovery, or import policy;
- manual Windows workflow, responsive behavior, and accessibility remain unevidenced;
- Android/iOS feasibility remains incomplete.

## Deferred

Authentication/authorization, TypeScript API, Neon/Postgres, actual upload/download synchronization, server cursor allocation, second-device convergence, central Product catalogue identity, legacy desktop import, editing/deletion, background/realtime sync, public release, and PySide6 retirement.

## Next valid route

Main should reconcile Sprint 04 evidence and decide whether the next bounded unit is manual Windows acceptance/correction or the first local synchronization/API harness. Any API, auth, Neon, Android-tool installation, import, or retirement work requires fresh Main/human authority through D/E/F.

## Recovery pointers

- Canonical: `design/01_ARCHITECTURE.md`, sections 16–18.
- Derived map: `design/14_MODEL_OVERVIEW.md`, current post-marker segment.
- Observational history: `design/03_DECISION_LOG.md`, Event 16.
- Codex evidence: `DEV_STAGE/I_DSN_CODEX.md`.
- Main decision: `[M]_STAGE/J_[M]_STAGE.md`, section 21.

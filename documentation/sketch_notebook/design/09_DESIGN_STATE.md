# 09_DESIGN_STATE.md

> Version: 0.5-cycle07-sprint02
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat [D]
> Scope: Cycle 07 Sprint 02 Flutter shared-beta planning state
> Sources: `[M]_STAGE/J_[M]_STAGE.md` sections 17–18, `DEV_STAGE/A_OPERATIONAL.md`, `B_DIDACTIC.md`, `C_DESIGN.md`, and permanent Design memory

---

# Current State

Cycle 06 remains accepted and closed. Python/PySide6 and its original user database remain protected as the working desktop beta, behavioral reference, migration source, and rollback.

Cycle 07 Sprint 02 planning is reconciled. No Flutter project, Dart model, physical schema, API, Neon environment, authentication account, or infrastructure exists. D/E/F and G/H/I remain inactive.

# Accepted Planning Architecture

```text
Flutter presentation
→ application/use cases
→ domain/contracts/versioned analytics
→ repository interfaces
→ local persistence/event queue/sync adapters
→ authenticated TypeScript synchronization API
→ Neon Postgres
```

Accepted planning boundaries:

- Flutter/Dart is the future shared Windows/Android/iOS client basis.
- TypeScript is favored for the custom synchronization API.
- Neon is favored as managed shared event persistence behind the API.
- Client operation is offline-first and local-first.
- The custom API is the mandatory client/cloud boundary.
- Products and Stores are account-private catalogue entities.
- Purchase is an atomic aggregate containing one or more Purchase Items.
- The first UI may guide one item while retaining a multi-item contract.
- Quantity is dimensionally explicit; money uses explicit currency and integer minor units.
- Raw catalogue/purchase/item facts are authoritative; projections are rebuildable.
- Dart analytics use stable identifiers and versions.
- First-beta synchronization is append-only.
- Migration is progressive; PySide6 is not retired before parity acceptance.

# Provisional Structural Definitions

- PACKAGED Product identity uses normalized name, brand, package mode, amount, dimension, and canonical unit.
- BULK Product identity uses normalized name, brand, and BULK mode.
- Exact normalized match may reuse; fuzzy similarity only warns.
- Product identity fields remain immutable in the first beta.
- One `purchase.registered` event contains receipt-level facts and immutable Item lines.
- Event UUID provides retry identity; device UUID plus monotonic sequence provides per-device creation order.
- Occurrence timestamp represents business time.
- Account-scoped opaque cursor represents accepted download order.
- Sequence gaps are rejected/requested.
- Upload batches return per-event transactional outcomes.
- Downloaded events and cursor advancement commit together locally.
- Verified email maps to immutable internal account UUID.

These are sufficiently defined for fixtures and experiments, not physical schema implementation.

# Unvalidated Candidates and Open Choices

Experiment candidates—not accepted dependencies:

- Drift for Flutter persistence;
- `sqflite_common_ffi` as retained comparison;
- `flutter_secure_storage` for credentials;
- TypeScript API with disposable local Postgres and fake/test identity issuer;
- non-production Neon only after the local protocol passes.

Open: state management, navigation, auth provider, API framework/host, Postgres migration tool, canonical JSON/schema toolchain, exact repository layout, decimal scale/range, fractional COUNT, currency metadata, normalization-version migration, legacy ambiguity policy, RLS adoption, paging limits, queue-corruption recovery, and parity threshold.

Deterministic account-scoped Product UUID derivation is favored but remains provisional pending Dart/TypeScript/Python canonicalization, Unicode, unit equivalence, collision, and version-migration fixtures.

# No Physical Schema or Implementation

Permanent Design memory defines ownership and relationships only. It does not define physical SQLite/Postgres tables, columns, indexes, migrations, plugin APIs, endpoint syntax, Flutter folders, state-management implementation, or deployed resources.

# Sprint 03 Evidence Boundary

A bounded future Sprint 03 unit should prove, in order:

1. pinned Flutter/Dart and TypeScript/Node environments;
2. shared canonical JSON fixtures;
3. normalization and deterministic identity parity;
4. fresh isolated local databases for devices A and B;
5. catalogue exact/similarity behavior;
6. atomic Purchase + Items + pending event;
7. restart and projection/analytics rebuild;
8. local TypeScript API and disposable Postgres;
9. retry, sequence gap, cursor paging, bootstrap, restart, and cross-account denial;
10. Windows and Android execution;
11. Cycle 06 database isolation and rollback;
12. iOS remains explicitly unvalidated until macOS/Xcode evidence;
13. non-production Neon only after local protocol success.

This is an evidence boundary, not authorization. D/E/F remain postponed.

# Recovery Route

```text
Current checkpoint
    → this file

Accepted architecture
    → design/01_ARCHITECTURE.md

Compact relationship map
    → design/14_MODEL_OVERVIEW.md

Rationale and chronology
    → design/03_DECISION_LOG.md

Cross-domain reconciliation
    → [M]_STAGE/J_[M]_STAGE.md
```

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.

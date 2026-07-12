# H_DDC_CODEX - Cycle 07 Sprint 03 Didactic Codex Report

> Status: Fixture and concept evidence implemented
> Branch: `cycle-07-mobile-preparation`
> Source stage: `E_DDC_STAGE.md`
> Date: 2026-07-12

## Source Stage Files

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Fixture Evidence

Created versioned fixtures in `contracts/shared_beta/v1/`:

- `catalogue_identity.json`
  - PACKAGED Product identity.
  - BULK Product identity.
  - gram/kilogram exact equivalence.
  - similar spelling as warning-only, no automatic merge.
- `purchase_aggregate.json`
  - one-item Purchase expectation.
  - multi-item Purchase expectation.
  - invalid Item rollback expectation.
  - close/reopen expectation.
- `sync_event.json`
  - `purchase.registered` envelope fields, payload version, device sequence, and pending queue state.

## Concept Evidence Demonstrated By Tests

- Stable identity: exact identity key includes account, normalization version, normalized name/brand, mode, and packaged quantity when applicable.
- Immutable Dart model: domain/value objects use final fields and constructor-provided state.
- Reusable catalogue: Purchase Items reference Products rather than embedding mutable product observations as product identity.
- Product Identification Set: PACKAGED includes normalized package amount/unit; BULK excludes package amount.
- Deterministic normalization: `1 kg` and `1000 g` produce the same exact Product identity and Product ID.
- Similarity: spelling-adjacent Products produce advisory similarity without identity reuse.
- Purchase aggregate: Purchase requires at least one Item and validates item/currency invariants.
- Purchase Item: invalid package count fails validation and rolls back the transaction.
- Dimensional quantity: MASS, VOLUME, COUNT and KG, L, UNIT are explicit; fractional COUNT is rejected.
- Minor-unit money: line totals and Purchase totals use ISO currency plus integer minor units.
- Append-only event preparation: a local immutable `purchase.registered` payload is persisted with event ID, account ID, device ID, device sequence, payload version, and content hash.
- Offline queue preparation: pending event queue row is created atomically with the local facts.
- Historical integrity: close/reopen test preserves facts and pending event in a fresh local database file.
- Versioned analytics: a minimal registry boundary resolves `purchase.total_minor_units@1` without touching raw facts.

## Validation Results

- `flutter test`: 9 tests passed.
- `flutter analyze`: no issues.
- `dart format --output=none --set-exit-if-changed .`: passed.
- Python unittest suite: 5 tests passed; no Python source changes.

## No Maturity Change

No KANBAN maturity change is authorized or implied by this report.

## Still Unvalidated

- Authentication and authorization.
- Cross-device eventual consistency.
- Cursor download/application.
- Real server idempotency.
- Android runtime lifecycle.
- Windows desktop runtime lifecycle.
- iOS lifecycle.
- Complete UI workflow.

## Suggested Functional Follow-Up

Didactic Chat can classify this as executable evidence for the local shared-beta concepts only. Server synchronization and platform lifecycle concepts remain Red/unvalidated unless later materialization runs them.

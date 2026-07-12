# I_DSN_CODEX - Cycle 07 Sprint 03 Design Codex Report

> Status: Local Flutter foundation materialized
> Branch: `cycle-07-mobile-preparation`
> Source stage: `F_DSN_STAGE.md`
> Date: 2026-07-12

## Source Stage Files

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Implemented Topology

```text
clients/markei_flutter/
├── android/
├── ios/
├── windows/
├── lib/
│   ├── app/
│   ├── application/
│   ├── domain/
│   │   ├── analytics/
│   │   ├── catalogue/
│   │   ├── purchase/
│   │   ├── shared/
│   │   ├── store/
│   │   └── sync/
│   └── infrastructure/local/
└── test/

contracts/shared_beta/v1/
├── README.md
├── catalogue_identity.json
├── purchase_aggregate.json
└── sync_event.json
```

No `services/sync_api/` directory was created.

## Dependency Direction

- Flutter composition lives in `lib/app/` and `lib/main.dart`.
- Application use-case port lives in `lib/application/register_purchase.dart`.
- Domain models live under `lib/domain/`.
- Drift implementation lives under `lib/infrastructure/local/`.
- Domain imports no Flutter widgets, Drift, HTTP, Python, or platform plugin APIs.
- Widgets issue no SQL and own no durable transaction.

## Dependencies Added

- Runtime: `crypto`, `drift`, `path`, `path_provider`, `sqlite3_flutter_libs`, `uuid`.
- Development: `build_runner`, `drift_dev`, `flutter_lints`, `flutter_test`.
- `pubspec.lock` was generated and retained.

## Schema Responsibilities Implemented

- `local_accounts`
- `devices`
- `products`
- `stores`
- `purchases`
- `purchase_items`
- `sync_events`
- `pending_events`
- `sync_state`
- `migration_ledger`

The schema is fresh and local. It is not the Cycle 06 SQLite schema and does not access the Cycle 06 database.

## Transaction Boundary Implemented

`LocalPurchaseRepository.registerPurchase` performs one Drift transaction:

```text
resolve/create Store
+ resolve/create exact Products
+ validate all Items
+ insert Purchase and Items
+ allocate device sequence
+ insert immutable purchase.registered event
+ enqueue pending event
= one local transaction
```

The invalid Item test proves rollback of Store, Product, Purchase, Purchase Item, sync event, and pending event writes. No network work exists inside the transaction.

## Representation Decisions

- Quantity uses fixed 6-decimal microunits.
- COUNT rejects fractional values in this unit.
- MASS normalizes `g` and `kg` to canonical `KG`.
- VOLUME normalizes `ml` and `l` to canonical `L`.
- Money uses ISO currency code plus integer minor units.
- Product normalization version is `1`.
- Deterministic Product ID uses SHA-256 over namespace `markei.shared-beta.product.v1` and the exact identity key.

## Validation Evidence

- `dart format --output=none --set-exit-if-changed .`: passed.
- `flutter analyze`: no issues.
- `flutter test`: 9 tests passed.
- `python -m unittest discover -s tests`: 5 tests passed.

## Implemented But Host-Unvalidated

- Android, Windows, and iOS project directories were generated.
- Android SDK is unavailable, so Android build/run is unvalidated.
- Visual Studio C++ desktop workload is unavailable, so Windows build/run is unvalidated.
- macOS/Xcode is unavailable, so iOS validation is unclaimed.

## Deviations

- Flutter SDK was unavailable at first; human approved installing/configuring it from the official stable Flutter Git repository.
- `flutter doctor -v` still reports Android SDK, Chrome, and Visual Studio gaps.
- The local foundation is implemented and tested, but platform execution evidence is deferred by host prerequisites.

## Deferred By Scope

Production auth/authorization, Neon, TypeScript API, direct Postgres access, household collaboration, merge/alias, edits/deletion, background/realtime sync, public catalogue, full UI workflow, complete parity, and PySide6 retirement.

## Suggested Functional Follow-Up

Design Chat should treat the local domain/persistence boundary as materialized and tested, while keeping platform runtime and server synchronization as separate future materialization units.

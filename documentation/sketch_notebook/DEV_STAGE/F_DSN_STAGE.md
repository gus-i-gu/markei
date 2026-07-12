# F_DSN_STAGE — Cycle 07 Sprint 03 Flutter Foundation

> Cycle: 07 | Sprint: 03 | Unit: 01
> Status: Main-approved materialization stage
> Branch: `cycle-07-mobile-preparation`
> Baseline: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Sources: `[M]_STAGE/J_[M]_STAGE.md` §§17–18; `00_PROJECT_STATE.md`; `05_SESSION_LOG.md`; `06_SESSION_SCHEME.md`

---

# 1. Exact topology

```text
clients/markei_flutter/
├── android/                 generated when supported
├── ios/                     generated when supported; no validation claim without macOS/Xcode
├── windows/                 generated when supported
├── lib/
│   ├── app/
│   ├── domain/{analytics,catalogue,purchase,store,sync}/
│   ├── application/
│   └── infrastructure/local/
└── test/
contracts/shared_beta/v1/
├── README.md
├── catalogue_identity.json
├── purchase_aggregate.json
└── sync_event.json
```

Conventional Flutter-generated files may appear under the client. Do not create `services/sync_api/` in this unit.

# 2. Dependency direction

```text
Flutter composition → application use cases → domain models/ports
                                      ← infrastructure/local Drift adapters
```

Domain imports neither Flutter widgets, Drift, HTTP, Python, nor platform plugins. Widgets do not issue SQL or own transactions. Infrastructure implements inward-facing ports.

# 3. Immutable domain concepts

AccountId, DeviceId, ProductId, StoreId, PurchaseId, PurchaseItemId, EventId; ProductMode; MeasurementKind; CanonicalUnit; NormalizedQuantity; Money; Product; Store; Purchase; PurchaseItem; SyncEvent; pending state; AnalyticDefinition identifier/version.

Purchase contains at least one Item and one Store. Product identity is account-private. PACKAGED identity includes normalized name, brand, mode, kind, amount, and unit. BULK identity includes account, normalized name, brand, and mode.

# 4. Drift schema responsibilities

- `local_accounts`;
- `devices` with next monotonic sequence;
- `products` with normalization version and account-scoped exact identity key;
- `stores`;
- `purchases` with occurrence time and currency;
- `purchase_items` with Product reference, explicit dimension/unit, and integer line total;
- `sync_events` with immutable versioned payload and unique identity;
- `pending_events`, or an equivalently explicit queue responsibility;
- `sync_state` with nullable future opaque account cursor;
- `migration_ledger` for fresh-schema provenance.

Applied-event/cursor behavior may be represented minimally but cannot claim real sync. Projections may remain rebuildable queries; do not persist duplicate mutable truth without evidence.

# 5. Transaction boundary

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

Any failure rolls back the aggregate. No network work occurs inside it. Stable IDs/uniqueness prepare retry safety but do not prove server idempotency.

# 6. Isolation

The Flutter database uses an app-private path; tests use temporary or in-memory stores. Code must not discover, open, copy, rename, migrate, or hash the ordinary Cycle 06 SQLite database. Legacy import is a later unit.

# 7. Deferred

Production auth/authorization, Neon, TypeScript API, direct Postgres access, household collaboration, merge/alias, edits/deletion, background/realtime sync, public catalogue, full UI workflow, complete parity, and PySide6 retirement.

# 8. Acceptance boundary

This is a local foundation, not the full Sprint 03 vertical slice or Cycle 07 completion. Later D/E/F must separately authorize the purchase UI/platform execution and then the isolated TypeScript/Postgres two-device sync harness.

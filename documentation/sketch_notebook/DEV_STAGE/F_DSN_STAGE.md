# F_DSN_STAGE.md — Cycle 07 Sprint 05 Android Design Directive

> Status: Main-approved temporary implementation directive  
> Authority: Main Chat [M]  
> Branch: `cycle-07-mobile-preparation`  
> Reconciliation: J §23  
> Paired authority: D operational gates and E evidence gates

---

# 1. Architectural objective

Run the existing shared Flutter client on Android without moving business behavior into Android-specific code.

Required direction:

```text
Android host
→ Flutter entrypoint
→ presentation
→ application commands/query ports
→ Dart domain
→ repository adapters
→ Drift app-private SQLite
```

Kotlin and Gradle host the Flutter application. They do not own Product, Purchase, History, Device sequence, analytics, or synchronization semantics.

# 2. Fixed identities

## 2.1 Android application identity

Use:

```text
namespace      com.gusigu.markei
applicationId  com.gusigu.markei
label          Markei
```

Update Kotlin package/path consistently. The application ID owns Android installation/update and sandbox continuity. It is not the Account ID, Device UUID, Flutter package name, or signing key.

## 2.2 Device identity

One app-private database owns one Device UUID v4 and its sequence ledger.

Invariants:

- generated once when absent;
- persisted before use;
- stable across ordinary restart;
- different for distinct fresh databases;
- not hardware-derived;
- not platform-named;
- not user-editable;
- not secret;
- removed with local state by uninstall/data-clear;
- independent of `local-account`.

## 2.3 Existing identities

Preserve Product internal ID, Product user code, Purchase ID, Event UUID, Account placeholder, and sequence semantics. Do not invent central/cloud IDs.

# 3. Device bootstrap ownership

Introduce the smallest infrastructure/application seam needed to load-or-create Device identity before constructing the production registration path.

Preferred responsibility:

```text
composition bootstrap
→ local Device identity repository
→ Drift transaction
→ Device row + sequence state
→ application session receives Device UUID
```

Presentation must not generate identity. Domain must not import Flutter, Drift, Android, path-provider, or UUID package implementation details. Android/Kotlin must not supply a fixed Device string.

If a UUID package already exists, reuse it. Add a dependency only if repository inspection shows no reliable UUID v4 capability; justify and lock it.

# 4. Schema and migration

Inspect current Drift schema before editing.

If no durable Device metadata row exists, add the minimum table/columns required. Requirements:

- additive schema version;
- v2 facts preserved;
- deterministic migration;
- UUID created exactly once for an upgraded local database;
- sequence state remains attached to the resulting Device;
- rollback/transaction failure does not leave partial identity;
- generated Drift files regenerated from source;
- fresh-create and upgrade paths tested.

Do not rewrite Product/Purchase/Event identifiers. Do not delete or recreate the database. Do not access the Cycle 06 SQLite file.

If the existing schema can persist Device identity without a schema change while satisfying ownership and tests, prefer that smaller route and document it.

# 5. Application composition

Refactor `MarkeiComposition.appPrivate()` only as necessary so asynchronous database/identity bootstrap completes before commands can register events.

Allowed patterns:

- awaited composition factory before `runApp`;
- explicit bootstrap state with deterministic error presentation;
- injected Device repository for tests.

Avoid:

- identity generation in widgets;
- global mutable singleton;
- platform channel for Device ID;
- preferences plus database split ownership;
- hidden fallback to `windows-device`;
- silent new database on bootstrap error.

Preserve dependency inversion and test injection.

# 6. Android host boundary

Android changes may include:

- stable namespace/application ID;
- Kotlin package/path;
- visible label;
- SDK/build configuration required by pinned Flutter;
- manifest configuration required for the bounded app;
- generated plugin registration/build outputs through normal Flutter tooling.

Do not add:

- business services in Kotlin;
- broad storage permission;
- hardware identifier permission;
- background service;
- network permission solely for future sync work;
- production signing/keystore;
- analytics/telemetry;
- backup/cloud policy expansion;
- alternate Android-native database.

Keep Flutter embedding v2.

# 7. Persistence and lifecycle

`LocalDatabase.appPrivate()` remains the source-level boundary. Android runtime must confirm it maps to the application sandbox.

Correctness depends on committed transactions and reopen behavior, not graceful shutdown callbacks. Required:

- committed Purchase/Event facts remain atomic;
- History is derived from facts;
- Device UUID is available before sequence allocation;
- process recreation reopens the same database;
- ordinary error never silently resets storage;
- no Windows/Python database path is reachable.

Tests close injected databases deterministically. Production does not require a broad lifecycle framework unless actual Android evidence exposes a fault.

# 8. Presentation boundary

Current UI is an implemented functional scaffold, not accepted visual design.

Sprint 05 may patch only evidence-backed blockers:

- overflow;
- inability to scroll to actions;
- keyboard covering required controls;
- unusable focus/validation;
- broken Android Back;
- safe-area collision;
- rotation corruption;
- blocking text-scale/tap-target issue;
- lifecycle state causing duplicate/partial commit.

Preserve existing Purchase/History navigation and application ports. Do not introduce a design system, navigation package, state-management framework, animations, or broad styling.

Unsaved form state may reset on rotation only if no facts are committed and the reset is visible/deterministic. Committed state must persist.

# 9. Toolchain versus architecture

Android Studio, SDK, Gradle, Java, NDK, emulator, and ADB are operational dependencies. Their installation does not change product architecture.

Generated Android scaffolding is owned through its configuration and build commands. Do not interpret generated files as independent domain layers. Review generated diffs for unexpected permissions, signing, package identity, and SDK changes.

# 10. Test architecture

Add focused tests at the lowest responsible layer:

- infrastructure: Device load/create/reopen/distinct database;
- repository: sequence continuity and transaction ownership;
- migration: existing facts preserved;
- application: composition receives stable Device;
- widget: bounded phone-width workflow without blocking overflow;
- regression: existing Purchase/History behavior.

Do not mock away the central Device persistence invariant. Use temporary databases and deterministic injection where practical. Android lifecycle claims require runtime observation in addition to tests.

# 11. Reversibility

All Sprint 05 source changes must remain additive and separable from:

- protected Python beta;
- cloud/API work;
- UI redesign;
- production release/signing.

If Android runtime is blocked after tool installation, retain valid platform-neutral Device work only when its tests and Windows regressions pass; classify Android as blocked. Do not distort architecture merely to obtain a build.

# 12. Acceptance gates

Pass only when:

- no active `com.example.markei`;
- Android identity is consistent;
- shared production composition contains no `windows-device`;
- Device UUID v4 persists across cold relaunch;
- separate fresh databases produce distinct Device IDs;
- sequence remains monotonic;
- app-private Drift facts survive process restart;
- Android host contains no domain duplication;
- Purchase/History completes on one Android runtime;
- only bounded responsive corrections were made;
- Flutter analysis/tests pass;
- Windows build passes;
- Python regressions pass;
- G/H/I accurately describe deviations and limits.

# 13. Stop gates

Stop if:

- Device identity becomes hardware/platform/account-derived;
- Device and sequence storage are split without a proven recovery protocol;
- schema reset replaces migration;
- existing identifiers are rewritten;
- widgets or Kotlin write SQL;
- Android-specific code enters domain/application layers;
- broad storage or unrelated permissions appear;
- production signing secrets enter the repository;
- cloud/auth/sync enters scope;
- UI work expands into redesign;
- Cycle 06 data is opened;
- source changes exceed D’s authorized paths.

# 14. Required I structure

Replace `I_DSN_CODEX.md` with:

1. authority and inspected commit;
2. before/after topology;
3. Android application identity;
4. Device identity ownership and invariants;
5. schema/migration decision;
6. bootstrap/composition flow;
7. Android host changes;
8. lifecycle/persistence behavior;
9. presentation corrections;
10. dependency/generated-source ownership;
11. tests and runtime evidence;
12. deviations and reversibility;
13. Windows/Python preservation;
14. deferred UI/cloud/release boundaries;
15. unresolved Design questions.

# 15. Completion definition

Sprint 05 design materialization is:

```text
stable Android sandbox identity
+ stable app-private Device owner
+ unchanged shared domain direction
+ Android runtime proof
+ bounded mobile usability
+ preserved desktop and Python boundaries
```

It is not final visual design, synchronization, or production Android release.

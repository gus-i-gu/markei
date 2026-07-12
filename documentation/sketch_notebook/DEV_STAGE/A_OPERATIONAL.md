# Main Synthesis Summary

Cycle 07 Sprint 02 should operationally treat Flutter/Dart as the accepted planning basis for one maintained Windows/Android/iOS client, not as an already validated toolchain. The future shared beta keeps an application-private local database on every installation, performs catalogue and purchase work offline, and synchronizes immutable purchase aggregates through a favored TypeScript API into Neon Postgres. PySide6 remains the accepted reference and rollback until measured parity; the Flutter client must never embed Python or open the ordinary Cycle 06 database.

The smallest useful Sprint 03 experiment is Windows-first plus Android: establish one pinned Flutter workspace, run deterministic Dart fixtures, create a fresh isolated SQLite database, atomically register one multi-item-capable Purchase containing one Purchase Item and its pending event, close/reopen, then exercise a local TypeScript/Postgres two-device protocol harness. iOS must remain explicitly unvalidated until the same lifecycle and plugin gates run on macOS/Xcode.

Drift is the leading persistence candidate for evaluation because it advertises Android/iOS/Windows, transactions, migrations, generated typing, and tests. `sqflite_common_ffi` is a lower-level retained candidate, especially for desktop and unit-test compatibility. `flutter_secure_storage` is a candidate for refresh credentials across the three targets, but its platform behavior, Windows packaging, Android backup settings, logout, upgrade, and reinstall semantics remain assumptions.

# Accepted Planning Direction

The report accepts, without implementation:

```text
Flutter + Dart shared client
TypeScript synchronization API favored
Neon Postgres favored
verified-email identity → immutable account UUID
account-private reusable catalogue
Purchase aggregate → one or more Purchase Items
append-only purchase.registered synchronization
versioned Dart analytics
PySide6 preserved until parity
no embedded Python runtime
```

Packaged catalogue identity normalizes product name, brand, `PACKAGED` mode, package amount, and explicit dimension/unit. Bulk identity uses name, brand, and `BULK`. Exact normalization may reuse; similarity only warns and requires a user choice. Package/brand changes create new identities. Quantity remains dimensionally explicit—mass, volume, and count are never converted into each other. Currency and integer minor-unit amounts remain explicit.

A Purchase is locally atomic with all items and one pending synchronization event. The first UI may collect one item, but storage and fixtures must prove the multi-item-capable aggregate boundary. Raw catalogue/purchase/item facts are authoritative; projections and versioned analytics are rebuildable.

# Flutter/Dart Host and Toolchain Requirements

Windows development requires a pinned Flutter SDK/Dart version, Git, editor tooling, and `flutter doctor` evidence. Windows desktop additionally requires Visual Studio’s Desktop development with C++ workload and the supported Windows SDK/toolchain. Android requires Android Studio or equivalent SDK management, platform SDK, build-tools, command-line tools, emulator/hardware acceleration, accepted licenses, JDK compatibility, ADB, and either an emulator image or physical debug device. Official setup routes are distinct: [Flutter Windows setup](https://docs.flutter.dev/platform-integration/windows/setup) and [Android setup](https://docs.flutter.dev/platform-integration/android/setup).

iOS is a separate host boundary: macOS, compatible Xcode, Xcode command-line tools, CocoaPods/Swift Package Manager as required by plugins, Simulator or provisioned device, signing identity, and Apple project configuration. Windows/Android success proves no iOS compatibility. [Flutter iOS setup](https://docs.flutter.dev/platform-integration/ios/setup).

Windows packaging later requires a release build, bundled native/plugin DLLs, runtime dependency inspection, installer identity, signing/reputation planning, clean-machine install, user-data path verification, upgrade/uninstall behavior, and immediate reopen. App-store publication is excluded.

Pin `pubspec.lock` for the application and record Flutter channel/version, Dart version, Android Gradle/JDK/SDK versions, Visual Studio toolset, Xcode version, plugin versions, and API Node/package-manager versions. CI should use locked dependencies, fail on unexpected lock changes, run static analysis and tests, and build from a clean cache periodically. Untested compatibility between any pinned combination is an **assumption**.

# Local Persistence and Secure Storage

Candidate A, Drift, is favored for the experiment. Its package documentation advertises SQLite, transactions, schema migrations, generated type safety, Android/iOS/Windows, and test support. [Drift package](https://pub.dev/packages/drift). Required validation includes generated-code reproducibility, decimal/minor-unit representation, foreign keys, unique normalized identity constraints, transactions, migration upgrades, release-mode native library inclusion, concurrent reads, close/reopen, and lifecycle interruption.

Candidate B, `sqflite_common_ffi`, advertises Windows plus Android/iOS and in-memory unit testing. Its documentation warns that desktop path selection should use an explicit application path and describes native SQLite packaging concerns. [sqflite_common_ffi](https://pub.dev/packages/sqflite_common_ffi). It remains useful as a simpler comparison, not a selected production layer.

Database path resolution must use the Flutter platform’s application-support/data directory and an environment-specific filename. The experiment asserts that this path differs from Cycle 06 `%LOCALAPPDATA%/Markei/market.sqlite`. It must neither copy nor migrate that file. Legacy import is later, explicit, read-only-first, backed up, deterministic, and reversible.

`flutter_secure_storage` advertises Android/iOS/Windows platform storage and documents Android cipher/backup requirements and iOS Keychain accessibility. [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage). Store refresh tokens or equivalent long-lived credentials there; keep access tokens memory-bounded where practical. Never store Postgres credentials, API secrets, or auth management keys in the client. Test locked-device behavior, backup/restore, reinstall, logout/delete, token rotation, corrupted entry recovery, and plugin upgrade. Cross-platform support is **assumed until packaged builds pass**.

Flutter lifecycle validation must cover cold start, inactive/background/paused/detached transitions where applicable, foreground resume, OS process termination, and reopened database/token state. Correctness must derive from transactional durability, not from receiving a graceful shutdown callback.

# TypeScript API and Neon Environment

Local development services are: Flutter/Dart tests with two isolated device databases; TypeScript API process; locked Node/package manager; runtime JSON-schema validation; disposable local Postgres; migration runner; fake/test OIDC issuer; and captured structured logs. Node’s built-in runner is a plausible protocol-test basis, but framework/test selection remains open. [Node test runner](https://nodejs.org/api/test.html).

The API owns token verification, account authorization, runtime payload validation, event idempotency, device-sequence policy, cursor allocation/download, per-event transactions, protocol versions, stable errors, and diagnostics. Clients contain no privileged Neon URL.

After local Postgres passes, repeat against a non-production Neon project/branch and role. Use a pooled connection for ordinary web/API requests and a direct controlled connection for migrations, dumps/restores, or tools needing session behavior, matching Neon’s current guidance. [Neon pooling](https://neon.com/docs/connect/connection-pooling). Separate local, CI/test, staging, and production auth applications, URLs, roles, databases, API deployments, secrets, logs, and retention. No external provisioning occurs in this restaging.

# Cross-Language Contracts and Fixtures

Dart and TypeScript must exchange canonical JSON fixtures independent of either runtime’s internal classes. One versioned fixture package/directory should contain:

- event envelope schema and stable error codes;
- catalogue normalization cases;
- packaged/bulk product cases;
- Purchase with one and multiple item lines;
- explicit quantity dimension/unit;
- currency and integer minor-unit money;
- expected event UUID/device sequence/cursor behavior;
- expected local projections;
- analytics identifier/version and result.

Canonical JSON rules must specify field names, nullability, UUID text form, integer ranges, decimal serialization, UTC/business timestamps, enum values, unknown-field policy, schema/protocol version, and deterministic normalization. Dart decodes, validates, re-encodes, and compares fixtures; TypeScript does the same with runtime validation. Golden JSON should be byte-stable only where canonicalization is explicitly defined; semantic equality is otherwise the gate.

Dart unit tests own pure normalization, identity, aggregate, projection, and versioned analytics. Database tests own transactions/migrations. Flutter widget/integration tests own staging and lifecycle behavior. API/Postgres tests own authorization, append/cursor semantics, and failure recovery. Python is only a fixture/reference source during parity comparison.

Logs correlate `request_id`, `batch_id`, `event_id`, device UUID, pseudonymous account identifier, device sequence, cursor range, protocol/app/analytics versions, latency, retry class, and sanitized outcome. Tokens, database URLs, verification codes, and sensitive notes are redacted.

# Platform Validation Matrix

| Gate | Windows | Android | iOS |
| --- | --- | --- | --- |
| Clean toolchain | Flutter doctor + VS C++/SDK captured | SDK/JDK/ADB/emulator/device captured | macOS/Xcode/signing captured |
| Build/run | Debug and release app launch | Emulator and physical-device debug/release-relevant launch | Explicitly unvalidated until macOS/Xcode |
| Fresh local DB | App-private path and schema | App-private path and schema | Later identical gate |
| Catalogue exact normalization | Packaged equivalence reuses ID | Same fixture result | Later same fixture |
| Similarity warning | Warning; no automatic merge | Same | Later |
| Packaged/bulk | Distinct identity rules pass | Same | Later |
| Atomic purchase | Purchase + items + pending event commit/rollback together | Same | Later |
| Close/reopen | Facts, cursor, queue persist | After process kill/relaunch | Later lifecycle test |
| Projection parity | Golden catalogue/list facts match | Match Windows | Later |
| Analytics parity | Analytic ID/version/result match fixture | Match Windows | Later |
| Secure token storage | Packaged plugin test | Backup/logout/rotation test | Keychain test later |
| Cycle 06 isolation | Original path/hash untouched | No access route | No access route |

# Synchronization Failure Matrix

| Scenario | Pass condition |
| --- | --- |
| Offline pending event | Local aggregate/event persists with no API |
| Retry after lost response | Identical UUID/content returns prior per-event acceptance; one server event |
| Conflicting duplicate UUID | Rejected with stable error; accepted event unchanged |
| Device-sequence gap | Rejected and missing earlier sequence requested |
| Cursor download | Ordered account-scoped bounded page; opaque next cursor |
| Download interruption | Events and cursor both commit or neither commits |
| Second-device bootstrap | Cursor zero pages rebuild same authoritative facts/projections |
| Cross-account request | Token/account mismatch reads and writes nothing |
| Malformed/version event | Stable validation/protocol error; no cursor allocation |
| API/Postgres restart | Durable append/cursor recover; client retry succeeds |
| Multi-event upload | Per-event transactional results; one failure does not corrupt others |
| Local close/reopen | Queue, applied IDs, cursor, facts and versions persist |

# Migration and Rollback

Flutter-local migrations are ordered, versioned, tested from empty and from every supported prior beta schema. Before migration, close competing connections and create a recoverable backup where the platform permits. Migration failure must leave either the old valid schema/data or a recoverable copy; it must never silently reset user data.

API/Neon migrations are owned by the API boundary. CI applies them to fresh Postgres and representative prior schemas. Deployment order must preserve backward protocol compatibility: expand schema, deploy compatible API, migrate/backfill if required, then remove old fields only after all supported clients no longer depend on them. Ordinary API uses pooled connections; migrations use controlled direct access.

Rollback means application/API rollback plus forward corrective migration by default; destructive down migrations are not assumed safe. Neon branching/restore may support rehearsal/recovery, but does not replace migration tests.

Cycle 06 migration remains deferred. Preserve PySide6 binaries, schema documentation, installer evidence, and original database. A later importer reads a copied backup, deterministically maps legacy IDs/units/money into new UUID facts, produces a report, and never mutates the source.

# Development Cost

Flutter concentrates client UI, lifecycle, persistence access, networking, analytics, and tests in Dart across three targets. Its upfront cost is learning Dart/Flutter, establishing responsive desktop/mobile patterns, selecting plugins, native toolchains, and recreating proven Python behavior through fixtures. Cost grows if Windows plugins lag mobile, native packaging fails, secure storage differs, or iOS issues appear late.

Tauri retains TypeScript familiarity and offers Windows/mobile distribution, but adds Rust, IPC/security capabilities, WebView behavior, and platform/mobile plugin evaluation. Its official prerequisites include Rust, C++/WebView2 on Windows, and separate Android/iOS toolchains. [Tauri prerequisites](https://v2.tauri.app/start/prerequisites/).

React Native plus React Native Windows retains React/TypeScript and native components, but Windows is an additional implementation/package with release alignment, native project/toolchain, module-compatibility, and upgrade responsibilities. Current RNW documentation shows a distinct Windows dependency/project initialization route. [React Native Windows](https://microsoft.github.io/react-native-windows/docs/getting-started/).

Flutter is favored because one client framework/language better matches the product goal. This does not prove lower total cost. The alternatives remain controls if Flutter fails essential SQLite, secure storage, accessibility, packaging, or lifecycle gates.

# Proposed Sprint 03 Experiment

After D/E/F authorization only:

1. pin Flutter/Dart and TypeScript/Node environments;
2. define shared JSON schemas and golden fixtures;
3. evaluate Drift first on Windows and Android;
4. create two fresh app-private local stores;
5. pass exact/similar and packaged/bulk catalogue cases;
6. atomically register one one-item Purchase using a multi-item contract plus pending event;
7. close/reopen and rebuild versioned projections/analytics;
8. run a local TypeScript API with disposable Postgres and fake account tokens;
9. prove retry, gap, cursor, bootstrap, cross-account, restart, and correlation logs;
10. build/run Windows and Android;
11. verify Cycle 06 database path/hash untouched;
12. record iOS as blocked/unvalidated pending macOS/Xcode, then later repeat there.

Do not provision Neon until local protocol and migration gates pass. The experiment ends before broad UI, legacy import, publication, or PySide6 retirement.

# Stop Conditions

Stop if Flutter cannot produce reproducible Windows and Android builds; selected SQLite or secure-storage plugins fail a required target; aggregate/event atomicity cannot be guaranteed; normalization differs across platforms; similarity auto-merges; retry duplicates; gaps are silently accepted; cursor advances without applied facts; another account’s data is exposed; credentials enter client/logs; migrations risk silent reset; original Cycle 06 data is reachable; or scope expands into editing/deletion, global catalogue, household sharing, background/realtime sync, production provisioning, app-store work, or embedded Python.

# Handoff to Main

Main should reconcile Drift-first persistence, secure-storage verification, cross-language canonical fixtures, platform-specific toolchain gates, and the local protocol harness as the smallest future evidence unit. Flutter/Dart is accepted for planning; Windows/Android compatibility remains assumed until built, and iOS remains explicitly unvalidated until macOS/Xcode evidence. Keep Tauri and React Native Windows as cost controls, TypeScript at the API boundary, Neon after local proof, PySide6 as rollback, and D/E/F postponed until Sprint 03 scope is authorized.

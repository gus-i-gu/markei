# C_DESIGN — Cycle 07 Sprint 05 Android Implementation Preparation

> Role: Design Chat [D]  
> Cycle: 07  
> Sprint: 05 investigation  
> Branch: `cycle-07-mobile-preparation`  
> Inspected branch state: four Main-continuity commits after `c195ed9b4197927db9c015076159534aa47c88e3`; J blob `3fd60c0e07155aff339b964e5857eed6e3b7a9ab`  
> Date: 2026-07-12  
> Status: Functional Design stage; temporary and non-canonical  
> Sources: J §22; current `00_PROJECT_STATE.md`; latest Sprint 04 segment of `05_SESSION_LOG.md`; active Android checkpoint in `06_SESSION_SCHEME.md`; `design/09_DESIGN_STATE.md`; current Flutter/Android handwritten structure, manifests, dependencies, persistence, composition, UI, and tests

## 1. Recovered Main State

**Accepted:** Cycle 06 remains a protected, recoverable Python/PySide6 beta. Flutter/Dart remains the future shared Windows/Android/iOS client basis, with inward dependency direction and application-private local-first persistence. TypeScript API, Neon, authentication, and actual synchronization remain deferred.

**Implemented and validated:** Sprint 04 produced Product-code/internal-ID separation, normalization v2, corrected Device sequence allocation, Drift schema v2 with a tested v1→v2 migration, v2 JSON Schemas, multi-item Purchase registration, History projection, 21 Flutter tests, five Python regressions, a Windows release build, and startup smoke evidence.

**New human Windows evidence:** the Purchase registration workflow, History projection, and persistence across relaunch work in direct Windows use. This closes the principal functional/manual uncertainty carried by J §22. It does not accept the current visual design. The interface is a functional scaffold whose controls and workflow expose implemented behavior; it is not the accepted UI/UX target.

**Active direction:** Sprint 05 prepares full Android implementation and validation. New D/E/F are not yet written. Tool installation and source implementation remain inactive.

**Deferred:** synchronization, API/Neon, authentication, central catalogue, legacy import, editing/deletion, iOS validation, production signing/store release, PySide6 retirement, and broad visual redesign.

## 2. Hierarchical Recovery

Recovery followed J §22 → `00_PROJECT_STATE.md` → latest Sprint 04 `05_SESSION_LOG.md` segment → the active Android forward checkpoint in `06_SESSION_SCHEME.md`.

A descent into `design/09_DESIGN_STATE.md` was necessary because Main continuity identifies the Android milestone but does not fully resolve architectural ownership of application identity, Device UUID persistence, composition lifecycle, responsive correction, or the boundary between platform enablement and visual redesign. The checkpoint confirms the accepted local-first boundaries and identifies fixed local account/device identifiers, platform validation, Store identity, migration generality, and manual UI/accessibility as incomplete.

No deeper permanent Design file was required. The checkpoint and J §22 were sufficient for accepted boundaries; repository inspection was required to compare them with current implementation truth.

## 3. Repository Surfaces Inspected

Handwritten or configuration-owned surfaces:

- Flutter entrypoint and composition root;
- Material application and Purchase/History pages;
- application registration and query ports;
- Drift schema v2 and app-private path construction;
- Product/Purchase/Event persistence transaction;
- widget and Device-sequence tests;
- `pubspec.yaml`;
- Android Gradle configuration;
- Android manifest;
- Android `MainActivity`.

Generated platform files were not interpreted as product architecture. They are framework scaffolding owned through Flutter configuration, Gradle inputs, plugin registration, and regeneration/build evidence.

The protected Python beta was not reread deeply because Sprint 05 does not alter its architecture. Its preservation and database isolation are already established and remain mandatory regression boundaries.

## 4. Current Design State of Union

The current client preserves the intended direction:

```text
Flutter presentation
→ application commands/query ports
→ independent Dart domain
→ local repository adapters
→ Drift schema v2
→ application-private SQLite
```

`main.dart` initializes Flutter and constructs `MarkeiComposition.appPrivate()`. The composition root creates the database, registration adapter, catalogue/history query adapter, Account ID, and Device ID. Presentation calls ports and owns no SQL. The Purchase repository owns the aggregate/event transaction. These boundaries survive Android execution without requiring a domain or repository redesign.

The Android surface is still generated scaffolding:

```text
Gradle Android application
→ Flutter embedding v2
→ MainActivity : FlutterActivity
→ shared Dart entrypoint and composition
```

That is the desired architectural shape: Android should remain a platform host for the shared Flutter client. Sprint 05 should not move Product, Purchase, persistence, or application workflow meaning into Kotlin or Android activities.

## 5. Windows Evidence and UI Classification

Human execution now confirms that the current scaffold can register a Purchase, display History, and retain data across relaunch. This evidence is important because it validates the composition-to-persistence path in real use rather than only widget tests and startup smoke.

It must be classified narrowly:

- **validated:** the Windows functional path and persistence behavior reported by the human;
- **implemented:** the current Material Purchase and History scaffold;
- **provisional:** responsive behavior, keyboard ergonomics, navigation depth, error presentation, accessibility, and visual hierarchy;
- **not accepted:** final visual design.

Sprint 05 should not treat weak visual quality as an Android architecture failure. It should also not freeze the scaffold as final design merely because it functions. Android enablement may correct blockers such as overflow, unusable keyboard behavior, inaccessible controls, broken back navigation, or state loss during rotation. A later UI/UX sprint should own broader information architecture, styling, interaction refinement, accessibility review, and visual acceptance.

## 6. Android Application Identity

The current Android namespace and application ID are both `com.example.markei`; the Kotlin package follows the same generated placeholder. This identity is unsuitable as a stable Markei application boundary.

Sprint 05 should establish one stable reverse-domain application ID before meaningful device persistence evidence. Application ID is Android’s installation/update/data-sandbox identity; changing it later creates a different installed application and therefore a different app-private database boundary. It must not be confused with:

- Flutter package name `markei`;
- display label “Markei”;
- Account UUID;
- Device UUID;
- release signing identity.

Design recommends Main/human choose the exact reverse-domain identifier in D/E/F. The change should update Gradle `namespace`, `applicationId`, Kotlin package/path, and any tests or documentation that explicitly reference it. Production signing and store registration remain deferred; stable application identity does not require pretending release signing is complete.

## 7. Persistent Platform-Neutral Device UUID

The composition root currently injects:

```text
accountId = local-account
deviceId  = windows-device
```

The Device ID is neither a UUID nor platform-neutral. Replacing the literal with `android-device` would reproduce the same defect and would incorrectly identify all installations on one platform as one Device.

Device identity should be owned locally per installed application data set:

1. create one standards-valid UUID v4 when no Device identity exists;
2. persist it in the same application-private local database boundary;
3. load and reuse it before constructing commands that allocate event sequences;
4. preserve it across process death, relaunch, rotation, and ordinary application updates;
5. allow uninstall/data-clear to remove it together with local application state;
6. never derive it from Android hardware identifiers, user Product data, platform name, path, or Account email.

The database is the preferred current owner because Device sequence state already lives there and must remain coupled to the Device identity that owns it. A platform preferences plugin would create a two-store transaction/recovery problem and an unnecessary dependency. Secure storage is not justified for a non-secret Device UUID.

This requires an initialization/use-case boundary rather than asynchronous identity generation inside a widget. The composition root may open the database and ask a local identity repository to load-or-create the Device before constructing the application session. Exact API shape is provisional for D/E/F, but domain and presentation must not depend on Android APIs.

The fixed `local-account` remains a separate provisional placeholder. Sprint 05 should not invent authentication or multi-account behavior while correcting Device identity.

## 8. Lifecycle and Persistence Boundaries

`LocalDatabase.appPrivate()` uses `getApplicationSupportDirectory()` and a stable SQLite filename. This is platform-neutral in source and should map into Android’s private sandbox through `path_provider`. Android evidence must confirm the actual runtime path and isolation without introducing a hard-coded Android filesystem path.

Required lifecycle distinctions:

- rotation/configuration recreation must not create a new Device UUID or database;
- activity background/foreground must retain staged or clearly reset presentation state by an explicit policy;
- process termination and cold relaunch must reopen Purchase/History facts and the same Device sequence;
- ordinary relaunch must not depend on Windows-specific identifiers;
- uninstall or clear-data loss is expected local-first behavior unless later backup policy says otherwise;
- the ordinary Cycle 06 database must remain unreachable.

The current composition constructs a database when the app starts but exposes no explicit application-level close/dispose path. Android process teardown does not guarantee a graceful widget disposal callback. Correctness therefore must rely on committed SQLite transactions and reopen behavior, not on a shutdown-only flush. Tests should still close injected databases deterministically. A broad lifecycle framework is unnecessary unless evidence demonstrates a failure.

## 9. Responsive Layout and Generated Android Risks

The Purchase page is a long `ListView`, which is a useful narrow-screen base. Its paired `Row + Expanded` fields and `Wrap` actions may fit common phone widths, but this is unvalidated. Risks include:

- keyboard covering fields or actions despite `adjustResize`;
- excessive scrolling and loss of context across many fields;
- numeric and unit fields using generic text input rather than appropriate keyboard semantics;
- overflow under larger font scale or translated labels;
- staged items or messages disappearing on configuration recreation;
- bottom navigation interacting poorly with system back;
- rotation rebuilding presentation state;
- insufficient semantics, focus order, touch targets, contrast, and error association.

The manifest already declares Flutter-managed configuration changes and `adjustResize`; these are generated host settings, not evidence that the Dart page behaves correctly. Sprint 05 should make only evidence-driven responsive corrections needed for the scaffold to complete the workflow on Android. It should avoid a new state-management package, navigation rewrite, design system, animation layer, or broad visual restructuring unless an Android blocker cannot be corrected locally.

Generated Android structure also carries a debug signing configuration for release builds. Sprint 05 acceptance concerns debug APK/run evidence, so production signing is explicitly outside scope.

## 10. Reversibility and Development Cost

The lowest-risk Android route preserves the shared Dart architecture and changes only platform identity, local Device initialization, narrowly necessary responsive behavior, and tests/configuration. If Android tooling or runtime fails, Windows and Python remain recoverable and the shared domain/persistence evidence remains useful.

Stable application ID has low immediate implementation cost and high avoidance value because postponement risks splitting installed sandboxes later. Persistent Device UUID adds a small initialization/repository seam but prevents corrupt event ownership and preserves future synchronization compatibility.

Broad UI redesign during Android enablement would increase diagnosis cost: platform/toolchain faults, lifecycle faults, and visual changes would become difficult to separate. Conversely, refusing all layout correction would make Android validation artificial. The correct boundary is functional adaptability now, accepted visual design later.

## 11. Questions Requiring Main or Human Resolution

1. What exact stable Android application ID should Markei use?
2. Should the current Flutter package/display version remain `1.0.0+1` for the prototype, or should Sprint 05 define a non-production version identity?
3. Must staged unsaved Purchase Items survive rotation/process recreation, or is a visible reset acceptable for this prototype?
4. Is Android validation expected on emulator, physical device, or both when available?
5. What minimum phone width, orientation set, and text-scale evidence should define the scaffold acceptance boundary?
6. Should the Device row be created through a dedicated local identity repository/use case, or a narrowly expanded composition bootstrap?
7. Is Android application backup intentionally left at platform defaults, or must backup/restore be explicitly disabled/deferred for the prototype?

Design recommends: one stable reverse-domain ID chosen now; persistent database-owned UUID v4; emulator plus one physical device when available but at least one recognized runtime for acceptance; portrait-first narrow-layout evidence plus rotation recovery; and no production backup/signing policy in this sprint.

## 12. Recommended Sprint 05 Materialization Scope

### Unit A — platform identity

- replace `com.example.markei` with the human/Main-approved stable ID;
- keep label, package identity, Account ID, Device ID, and signing responsibilities distinct;
- validate generated/handwritten Android package consistency.

### Unit B — local Device ownership

- introduce load-or-create persistent UUID v4 ownership in local infrastructure;
- remove `windows-device` from shared composition;
- preserve one UUID and monotonic sequence across reopen;
- prove separate fresh databases receive distinct Device UUIDs;
- keep Account placeholder and authentication deferred.

### Unit C — Android execution

- install tools only through explicit Operational D/E/F authority;
- build a debug APK and run the existing shared Dart entrypoint;
- register a multi-item Purchase, inspect History, and relaunch;
- verify app-private persistence and Cycle 06 isolation;
- record actual Android path/lifecycle evidence.

### Unit D — bounded responsive correction

- test narrow portrait layout, keyboard, back, rotation, and text scale;
- correct only workflow-blocking overflow/state/lifecycle issues;
- preserve presentation/application/domain/persistence direction;
- document visual debt for a later UI/UX sprint.

### Unit E — regression and evidence

- rerun formatting, analysis, Flutter tests, Windows build/workflow, and Python tests;
- add Device bootstrap/reopen and Android-relevant widget tests;
- distinguish generated, built, launched, functionally exercised, persisted, and visually accepted states.

## 13. Explicit Non-Goals

- visual redesign or final UI acceptance;
- new state-management/navigation framework;
- TypeScript API, Postgres/Neon, authentication, or authorization;
- real synchronization or cursor behavior;
- hardware-derived Device identity;
- central Product catalogue or legacy import;
- Product/Purchase editing or deletion;
- production signing, Play Store release, telemetry, or background sync;
- iOS implementation;
- PySide6 retirement or ordinary Cycle 06 database access.

## 14. Evidence Matrix

| Claim | Classification | Evidence |
| --- | --- | --- |
| Windows Purchase/History/persistence path works | validated, human-reported | new human evidence |
| Current UI is accepted visual design | provisional / not accepted | human decision |
| Flutter inward dependency direction survives Android | accepted and implemented in source | composition, ports, imports |
| Android project exists | implemented/generated | Gradle, manifest, MainActivity |
| Android app identity is stable | defective/provisional | `com.example.markei` |
| Device sequence allocation is monotonic | implemented/validated locally | repository and sequence tests |
| Device identity is persistent and platform-neutral | defective/not implemented | `windows-device` literal |
| Android app-private Drift path works | proposed/host-unvalidated | `path_provider` source only |
| Android build/run works | blocked | SDK/runtime evidence absent |
| Purchase page is narrow-layout safe | provisional/host-unvalidated | source inspection only |
| Android lifecycle persistence works | host-unvalidated | no Android execution |
| Local queue is synchronization | deferred/not implemented | no networking/API |
| PySide6 rollback remains protected | accepted/validated boundary | Main continuity and regressions |

## 15. Proposed F_DSN Gates and Handoff

A future Sprint 05 Design materialization stage should require:

1. exact Android application identity;
2. database-owned persistent UUID v4 and initialization ownership;
3. no Android/Kotlin domain duplication;
4. unchanged inward dependency direction;
5. app-private Drift isolation and cold-relaunch persistence;
6. sequence continuity under the persistent Device;
7. bounded keyboard/back/rotation/narrow-layout evidence;
8. explicit separation of functional scaffold acceptance from later visual design;
9. Windows/Python regression and rollback preservation;
10. no cloud, auth, production release, or broad UI expansion.

Main should reconcile this report with refreshed Operational and Didactic Sprint 05 stages. The smallest coherent Sprint 05 outcome is an Android-built and executed local Markei scaffold with stable application identity, persistent platform-neutral Device UUID, verified Purchase/History persistence, bounded responsive corrections, and preserved Windows/PySide6 recovery. The later UI/UX sprint should begin only after platform behavior is evidenced cleanly enough that visual work is not masking lifecycle or identity defects.

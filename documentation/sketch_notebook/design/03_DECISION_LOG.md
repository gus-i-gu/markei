# 03_DECISION_LOG.md

> Version: 0.3-cycle06-sprint02
> Status: Active Observational Record
> Persistence Class: Observational History
> Knowledge Class: Design History
> Authority: Design Chat [D]
> Scope: Chronological Design-domain decisions, reconciliation events, materializations, corrections, and deferred boundaries
> Current Coverage: Recovery repopulation through Cycle 06 Sprint 02 installed-lifecycle evidence

---

# 1. Purpose and Reading Rule

This file records what happened in the Design domain and why. It is append-oriented observational history; it does not independently define current architecture.

For current truth, read:

```text
Canonical architecture
    design/01_ARCHITECTURE.md

Derived architecture map
    design/14_MODEL_OVERVIEW.md

Current checkpoint
    design/09_DESIGN_STATE.md
```

Earlier events remain historical even when later events revise current architecture.

---

# 2. Recovery Repopulation Record

## Event 01 — Methodology boot and empty-domain detection

The recovery began after permanent Design files had been intentionally pruned. Domain Symmetry assigned:

```text
C_DESIGN.md          functional reasoning
01_ARCHITECTURE.md   canonical knowledge
14_MODEL_OVERVIEW.md derived knowledge
09_DESIGN_STATE.md   checkpoint
03_DECISION_LOG.md   observational history
```

Application source was evidence, not automatic canon.

## Event 02 — Initial structural review

Repository inspection recovered the application direction:

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

MainWindow was identified as desktop composer and coordinator; ProductService as application facade; Repository as persistence facade; and Database Manager as lifecycle owner.

Functional staging commits:

```text
0c7143e13cd27e1b6a20506cadf045631e2eeeae
    Stage initial design recovery review

3f40e25109ede1501541fa8eefce84465dcb47bd
    Consolidate design structural recovery
```

## Event 03 — Lifecycle and transaction constraints clarified

All four public pages were confirmed to create separate ProductService → Repository → SQLite connection chains. Cleanup capability existed locally, while application-wide shutdown ownership was distributed and implicit.

Receipt registration and purchase deletion/recalculation were confirmed as multi-commit workflows. This was recorded as current implementation property, not accepted future target architecture.

## Event 04 — Main-stage routing correction

The initial lookup used obsolete path:

```text
[M]_STAGE/J_MAIN_STAGE.md
```

The human-corrected authoritative path was:

```text
[M]_STAGE/J_[M]_STAGE.md
```

A concurrent content-SHA conflict was also handled by re-reading before writing. These events established that exact stage paths and current blob SHAs are part of reconciliation safety.

Corrective staging commit:

```text
65199e4e3d02541fc4f25f9f677e307c40447973
    Stage initial design canon candidate
```

## Event 05 — Canonical, derived, and checkpoint repopulation

Main reconciliation authorized stable current architecture while excluding unresolved future targets.

Permanent Design materialization:

| Commit | Result |
| --- | --- |
| `4431a25c8365e0c847c4c97b2775a90eda21ea0b` | Canonical architecture repopulated |
| `b019063163e45dc72ffb04a9010483a035e858e2` | Derived model overview repopulated |
| `32a6834ef845280ed372c518ddcf1edb1e4e2112` | Design checkpoint rebuilt |

Temporary retrospective staging:

```text
ec9a1b6dc5d5252e1031e0890a468ecc38321b55
    Stage design checkpoint retrospective
```

The failed Cycle 05 precedent was classified as cycle-control and knowledge-routing overload, not proof that the layered application architecture had failed.

## Event 06 — Recovery decisions and deliberate non-decisions

Recovery established:

1. functional stages remain temporary reasoning surfaces;
2. Main reconciliation filters what may enter permanent memory;
3. canon stores accepted stable architecture;
4. the overview reorganizes canon without independent truth;
5. the checkpoint stores current state and active tensions;
6. this log stores chronology and rationale.

The recovery deliberately left open shared versus page-local services, shutdown ownership, workflow atomicity, ProductService/Repository decomposition, complete contracts, typed projections, migration versioning, Promotion status, `pages.order`, and Product's long-term hybrid role.

---

# 3. Event 07 — Cycle 06 Primary-Beta Design Reconciliation

## Context

Cycle 06 established one milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

Functional A/B/C reports were reconciled in `J_[M]_STAGE.md`. Main authorized one bounded release-enablement unit without broad application redesign.

## Policy decisions accepted before materialization

### Schema-only production initialization

Decision:

```text
production package includes schema.sql
production package excludes sample-bearing seed.sql
fresh production data contains structural/default settings only
no sample store, category, product, purchase, or business fixture ships
```

Rationale: bundled sample data would blur application resources, development fixtures, and user-owned state.

### Preserve-user-data uninstall policy

Decision:

```text
uninstall removes replaceable program files and shortcuts
uninstall preserves %LOCALAPPDATA%/Markei by default
```

Rationale: the database and settings are user-owned writable state, not installer-owned replaceable content. Optional data-deletion UX was deferred.

### Coordinated release identity

Decision:

```text
Display name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Stable AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
Target: Windows x64 controlled beta
```

Rationale: executable, package, installer, shortcuts, and compatible upgrades require one stable identity contract.

### Authoritative PyInstaller specification

Decision:

```text
Markei.spec
    authoritative package composition

scripts/build_windows.ps1
    invocation wrapper only
```

Rationale: duplicated command flags and spec contents had created two drifting package definitions.

### Shortcut policy

Decision:

```text
Start Menu shortcut required
desktop shortcut optional installer task
```

Rationale: Start Menu launch is part of ordinary installed use; desktop placement remains user choice.

### Validation-first shutdown policy

Decision:

```text
validate distributed cleanup first
add only a bounded close coordinator if direct evidence fails
```

Rationale: distributed lifecycle ownership was a structural concern, not yet proof of a leak or retained lock.

---

# 4. Event 08 — Cycle 06 Sprint 01 Materialization Evidence

## Source boundaries materialized

Codex materialized:

- root `main.py` as launcher and outer startup-diagnostic boundary;
- `app.main.main()` unchanged as Qt application construction;
- `Markei.spec` as authoritative one-folder package definition;
- `scripts/build_windows.ps1` as the invocation wrapper;
- `installer/Markei.iss` as placement, identity, shortcuts, and uninstall-registration source;
- `scripts/build_installer.ps1` as compiler-discovery and compile wrapper;
- external startup logs under `%LOCALAPPDATA%/Markei/logs`;
- schema-only production packaging and exclusion of writable/transient state.

## Frozen evidence

Operational evidence recorded:

```text
configured: yes
built: yes
launched: yes — frozen isolated launch and reopen
validated: partial
```

Source/static checks, five standard-library release tests, frozen build, resource inspection, schema-only first launch, startup-log creation, and frozen reopen passed.

## Observed shutdown failure and bounded correction

The validate-first probe showed the isolated SQLite file remained open after `MainWindow.close()`. Codex added `MainWindow.closeEvent()` and `close_page_services()` to idempotently close Register, Lists, History, and Settings services.

Rerun evidence showed all four repositories closed and the isolated database directory became removable.

Design classification:

```text
MainWindow coordinates final closure
local service/repository close ownership remains intact
not a composition-root redesign
not dependency injection
```

## Installer blocker

`installer/Markei.iss` and `scripts/build_installer.ps1` were configured, but `ISCC.exe` was unavailable.

```text
installer source: configured
compiled installer: blocked
installed execution: blocked
installed lifecycle: unvalidated
beta acceptance: no
```

---

# 5. Event 09 — Sprint 01 Main Post-Codex Reconciliation

Main reviewed G/H/I and critical implementation files in commit:

```text
f402c9394d3401ef8c2df5696d052b18358758dc
    Reconcile Cycle 06 Codex materialization evidence
```

Main accepted the bounded unit as technically successful but insufficient to close Cycle 06.

Accepted Design absorption:

- deployment states remain distinct;
- launcher-owned startup diagnostics are stable;
- `schema.sql` is production resource and `seed.sql` is fixture-only;
- retained user data remains external;
- release identity and stable AppId form one contract;
- MainWindow final service-close coordination is accepted;
- packaging and installer layers do not own workflows or persistence semantics.

Preserved evidence boundary:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

---

# 6. Event 10 — Sprint 02 Installer Toolchain and Structural Defaults

## Installer compiler discovery

Inno Setup 6.7.3 was installed in a per-user location. The original wrapper did not discover that path.

Bounded correction:

```text
scripts/build_installer.ps1
→ add %LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe candidate
```

Design classification: tooling correction only. Packaging authority and installer authority remained unchanged.

## Structural production defaults

The fresh installed Register-equivalent workflow failed with a foreign-key error because the seed-free database lacked current Register defaults.

Bounded correction:

```text
category F / General
store 1 / Default Store
```

These rows were classified as idempotent structural application defaults, not sample business data. Production continued to exclude `seed.sql` and to create zero sample products and purchases.

This refined the earlier schema-only policy without reversing it:

```text
schema.sql
+ structural defaults required by current application invariants
+ zero sample business records
```

---

# 7. Event 11 — Sprint 02 Compiled Installer and Installed Lifecycle

## Artifact and build evidence

The installer compiled successfully:

```text
dist/installer/Markei-Setup-0.1.0-x64.exe
SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
size 34,448,651 bytes
```

The Inno `x64` deprecation warning was recorded as non-blocking tooling debt.

## Installed boundary evidence

The following transitions passed technically:

```text
per-user install
→ installed executable under %LOCALAPPDATA%/Programs/Markei
→ Start Menu shortcut launch
→ external database creation
→ service-backed Register / Lists / History / Settings evidence
→ close and immediate reopen
→ same-version reinstall with preserved data
→ uninstall with retained database
→ reinstall with retained-data recovery
```

Observed installed behavior matched the accepted separation between replaceable program files and `%LOCALAPPDATA%/Markei` user state.

The installed shutdown path used the existing MainWindow close coordination successfully. No broad architecture correction was required.

## Validation environment

The lifecycle used the current ordinary Windows user. Existing Markei data was backed up before testing and restored afterward. Dedicated-account isolation was not evidenced.

## SmartScreen and signing

Defender was enabled and the executable/installer were unsigned. No SmartScreen prompt appeared during silent/programmatic execution.

Design classification:

```text
human-visible SmartScreen behavior: unknown
not an application correctness failure
```

---

# 8. Event 12 — Sprint 02 Main Post-Codex Reconciliation

Main reconciled Sprint 02 G/H/I and implementation evidence in the active `J_[M]_STAGE.md`.

Accepted evidence state:

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Main preserved the distinction:

```text
installed technical workflow path: validated
human-visible UI workflow acceptance: pending
```

Still pending:

- human-visible installer wizard observation;
- human-visible Register / Lists / History / Settings walkthrough;
- human-visible close/reopen confirmation;
- human-visible SmartScreen/security observation;
- final Main/human acceptance;
- artifact-versioning policy resolution.

Main also identified a report/repository contradiction: G described the installer artifact as generated but uncommitted, while branch evidence showed it added. Design records the contradiction but does not decide artifact retention policy.

---

# 9. Explicit Deferrals Preserved

Cycle 06 did not introduce or authorize:

- composition-root or dependency-injection redesign;
- ProductService/Repository decomposition;
- transaction redesign;
- schema redesign or migration ledger;
- mobile, backend/API, synchronization, authentication, or cloud persistence;
- automatic update, signing, rollback framework, or one-file packaging;
- optional uninstall data-deletion UX;
- broad UI/navigation redesign.

Workflow atomicity and broader migration strategy remain inherited Design debt.

---

# 10. Current Observational Result

```text
compiled installer evidenced
installed per-user lifecycle technically validated
structural defaults classified
program/user-state separation observed
same-version reinstall passed
uninstall retention passed
reinstall recovery passed
MainWindow shutdown coordination sufficient in tested installed lifecycle
human-visible acceptance still pending
beta not accepted
Cycle 06 not closed
```

The next append should record human-visible acceptance results, SmartScreen/security observations, artifact-policy resolution, or a bounded failure discovered during those final gates.

---

# 11. Event 13 — Cycle 07 Sprint 01 Mobile Portability Reconciliation

## Knowledge classification

Cycle 07 Sprint 01 completed investigation only. Cycle 06 remains accepted and closed. No application change, framework selection, repository-topology decision, or D/E/F implementation authorization occurred.

The portability inventory established observationally:

- domain dataclasses are platform-neutral and likely reusable where Python runs;
- substantial validation, calculation, and workflow meaning is UI-framework-neutral;
- `ProductService` remains coupled because it constructs the concrete `Repository`;
- Repository construction opens SQLite through desktop-shaped path, resource, connection, commit, and shutdown behavior;
- Python abstract contracts express responsibilities but are not language-neutral contracts;
- PySide6 presentation, page-owned service construction, MainWindow shutdown coordination, and Windows packaging are desktop-specific;
- mobile runtime, sandbox persistence, suspend/resume, Android/iOS packaging, accessibility, and semantic parity remain untested.

## Competing pathways and development-cost models

### Operational challenger — time-boxed Python-native Android experiment

Approach A remains the cheapest bounded way to test direct source reuse. Its initial implementation can be smaller because models, calculations, validations, and perhaps service workflows stay in Python. If it works cleanly, it avoids immediate behavior reimplementation and yields fast Android evidence.

That saving is conditional. Toolchain setup may require Linux or WSL, SDK/NDK/JDK layers, framework packaging recipes, emulator/device work, and mobile-safe resource and database paths. Cost can move into runtime compatibility, lifecycle handling, native integration, accessibility, packaging diagnosis, and framework-specific debugging. Android success would not establish iOS parity: iOS adds macOS/Xcode and a distinct Python packaging path. If the experiment fails late, its construction seams and packaging work may have little lasting product value, although recorded fixtures and failure evidence remain reusable.

Classification:

```text
bounded falsification challenger
not accepted long-term architecture
```

A future spike should stop when mobile SQLite/core behavior, lifecycle safety, packaging, accessibility, or required construction changes cease to be bounded.

### Design strategic candidate — native/cross-platform client with contracts and fixtures

Approach C costs more initially. Stable behavior must be described in language-neutral commands, results, invariants, error cases, and deterministic fixtures; mobile behavior must then be partly reimplemented. Direct Python source reuse is lower, and maintaining semantic parity requires deliberate tests.

That early cost may reduce long-term cost through conventional Android/iOS tooling, explicit application lifecycle and persistence ownership, platform-appropriate presentation, mature accessibility and native integration, clearer debugging boundaries, and framework-independent semantic fixtures. Fixtures make drift observable instead of relying on two implementations merely looking similar. A mobile-local repository boundary also leaves a clearer future synchronization seam without requiring a backend now. Abandoning one unsuccessful C-family framework still loses UI/toolchain work, but language-neutral contracts and fixtures remain usable by another client.

Classification:

```text
favored strategic architecture candidate
framework not selected
implementation not authorized
```

## Human/Main preference

Human/Main currently favors Approach C as the strategic direction. This is stronger than a neutral list of alternatives: planning and documentation should treat contract/fixture specification and explicit mobile ownership as the leading direction. It is weaker than final acceptance: no framework, repository topology, persistence library, schema-sharing policy, or implementation structure is selected. The preference does not authorize implementation, does not erase Approach A as a bounded challenger, and remains revisable when empirical evidence arrives.

## Evidence required before acceptance

Acceptance still requires:

1. deterministic scenarios for first purchase, repeat purchase, status transition, invalid input, structural defaults, atomic registration, and close/reopen persistence;
2. a language-neutral contract boundary excluding presentation labels and formatting;
3. evidence of sandboxed local persistence and lifecycle ownership on Android;
4. an explicit iOS feasibility and parity gate using macOS/Xcode;
5. accessibility, navigation, native integration, packaging, debugging, and migration evidence for a selected framework;
6. a measured comparison of fixture-driven reimplementation cost against a strictly time-boxed direct-reuse spike;
7. confirmation that ordinary desktop data is never accessed;
8. Main/human acceptance after evidence reconciliation.

## Deferrals

Deferred: application implementation, D/E/F, framework and repository-topology selection, permanent source reorganization, backend, authentication, synchronization, household sharing, desktop/mobile database exchange, production migration design, store release, and full feature parity.


---

# 12. Event 14 — Cycle 07 Sprint 02 Flutter Shared-Beta Reconciliation

## Client-language supersession

Human/Main accepted Flutter/Dart as the planning basis for the future shared Windows, Android, and iOS client. This superseded the earlier TypeScript-client exploration direction while retaining TypeScript as the favored custom synchronization-API language.

Rationale: one Dart/Flutter client can own presentation, use cases, local persistence, event queue, synchronization coordination, authenticated session, platform lifecycle, and analytics without embedding Python or coordinating multiple installed client runtimes. Python/PySide6 remains the accepted Cycle 06 implementation, behavioral reference, migration source, and rollback.

Retained alternatives are evidence controls rather than active client directions. TypeScript remains valuable at the API boundary; Python remains a possible API fallback. Exact Flutter persistence, secure storage, state-management, navigation, and packaging dependencies remain unvalidated.

## Catalogue and purchase direction

The first shared beta adopts an account-private reusable catalogue. Product identity distinguishes PACKAGED and BULK modes and uses normalized name, brand, and—when packaged—explicit dimensional package amount/unit. Exact normalized equivalence may reuse; fuzzy similarity warns but never merges automatically. Deterministic account-scoped Product UUID derivation and normalization-v1 mechanics remain provisional pending cross-language fixtures.

Purchase is an atomic aggregate containing one or more Purchase Items. The first UI may guide one item, but the domain contract remains multi-item capable. One append-only `purchase.registered` event containing immutable item lines is the favored first synchronized event.

Dimensional quantity separates MASS/KG, VOLUME/L, and COUNT/UNIT without mass/volume inference. Money carries explicit currency and integer minor units. Line totals and purchase observations are authoritative; normalized prices, price changes, personal inflation/deflation, forecasts, and other analytics are derived.

## Analytics, synchronization, and cloud direction

The Flutter client owns a versioned Dart analytics registry. Stable algorithm identifiers and versions preserve reproducibility; raw facts are never rewritten by analytical evolution.

Synchronization planning accepts event UUID idempotency, device UUID plus monotonic sequence, occurrence time as business time, opaque account-scoped cursor as download order, sequence-gap rejection, per-event upload transactions/results, cursor-zero bootstrap, and transactional local event application plus cursor advancement.

The mandatory boundary is:

```text
Flutter client
→ authenticated custom synchronization API
→ Neon Postgres
```

The TypeScript API owns token verification, account/device authorization, runtime validation, idempotent event append, sequence enforcement, cursor allocation/download, protocol versions, transactions, stable errors, and diagnostics. Neon owns managed persistence and constraints, not synchronization meaning. RLS remains an open defense-in-depth candidate.

## Migration and rollback policy

Transition is additive. The accepted PySide6 beta and original database remain protected until Flutter desktop/mobile parity and human/Main acceptance. Migration operates from a protected copy, uses deterministic legacy-to-UUID mapping and idempotent import evidence, reports ambiguous units/money/package facts instead of guessing, validates counts/totals/dates/projections, and retains rollback. Direct destructive conversion or shared access to the ordinary Cycle 06 database is not authorized.

## Explicit deferrals and empirical questions

Deferred: purchase editing/deletion, aliases/merges, global catalogue, household sharing, product-family/successor UI, complex conflicts, realtime/background sync, broad settings synchronization, app-store/public release, permanent repository split, and PySide6 retirement.

Still empirical or open: Flutter persistence and secure-storage plugins; state management/navigation; auth provider; API framework/runtime/host; Postgres migration tool; canonical JSON toolchain; exact decimal scale/range; fractional COUNT; currency metadata; normalization migration; legacy ambiguity policy; RLS; paging limits; queue-corruption recovery; iOS/macOS evidence; and parity threshold.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.


# 13. Event 15 — Sprint 03 Unit 01 Flutter Foundation Evidence

## Materialized result

Commit `5ef64a1d5b6af6d397d4f3a7aea6d635911be12d` added the authorized Flutter client foundation under `clients/markei_flutter/`, semantic fixtures under `contracts/shared_beta/v1/`, and G/H/I evidence while preserving Python/PySide6.

The materialization confirmed that the planned inward boundaries can exist physically: Flutter composition and application coordination depend on a Dart domain that remains independent of widgets and Drift; Drift implements fresh local persistence; Register Purchase commits catalogue facts, Purchase/Items, an immutable local event, and pending queue state atomically.

Validation observed `flutter analyze`, nine Flutter tests, and five Python regression tests passing. Platform projects were generated but Android, Windows, and iOS build/run remained host-unvalidated.

## Generated versus handwritten ownership

Handwritten Dart is reviewed directly. Drift-generated Dart and Flutter platform runners are reviewed through their source schema/configuration and regeneration evidence. `pubspec.lock` is committed dependency-resolution evidence. Build outputs and local databases remain excluded.

The size of generated topology is not equivalent to business complexity, but generator versions and reproducibility are operational responsibilities.

## Fixture interpretation

The v1 JSON files are useful language-neutral semantic fixtures:

- catalogue identity contains the strongest input/expected-output evidence;
- purchase aggregate and sync event examples remain shallow;
- no complete validator defines types, nullability, ranges, enums, unknown fields, canonical ordering, or compatibility;
- Dart/TypeScript equivalence is untested.

They must not be described as a complete protocol specification.

## Exposed defects and drift

1. Device registration may reset `nextSequence`, allowing repeated sequence 1; monotonic ordering is not implemented reliably.
2. `\w`-based normalization may damage accented Portuguese names; display text and normalized identity require separation.
3. The SHA-256-derived UUID-shaped Product identifier is deterministic but lacks an accepted RFC UUID or cross-language contract.
4. Fresh Drift schema creation is tested; upgrade/recovery is not.
5. Store reuse is exact-name based and is not Store deduplication.
6. Product similarity is warning-oriented and is not merge/alias behavior.

These are recorded as defects or provisional questions, not silently promoted.

## Alternatives and next bounded route

Two candidate routes remain:

- Route 1: correct identity/sequence defects, strengthen fixtures, add the minimal Flutter purchase workflow and visible local projection, then obtain Windows/Android lifecycle evidence.
- Route 2: correct the same defects, complete wire contracts, then build the TypeScript/Postgres local synchronization harness.

Design recommends Route 1 first because it completes the local shared-client vertical slice and platform evidence before distributed infrastructure. Route 2 remains the likely following unit. This recommendation is reversible and is not Sprint 04 authority.

Deferred: authentication, API/Neon, distributed synchronization, legacy import, editing/deletion, household sharing, global catalogue, background/realtime sync, parity, and PySide6 retirement.


# 14. Event 16 — Cycle 07 Sprint 04 Local Shared-Client Materialization

## Reconciled evidence

Sprint 04 materialized the bounded Windows-first local Flutter slice authorized by J section 21. The paired Design report records Drift schema v2, Product-code and display-field separation, normalization v2, JSON Schema validation, a multi-item Purchase UI, local history, sequence correction, migration rehearsal, and Windows build/startup evidence. Repository inspection confirms those responsibilities in handwritten composition, application ports, domain code, Drift schema/migration, repository transaction, and UI composition.

Validation reported:

```text
flutter pub get             validated
Dart formatting             validated
flutter analyze             validated
flutter test                validated — 21 tests
flutter build windows       validated
Windows startup smoke       validated — process alive after 5 seconds
Python regression suite     validated — 5 tests
Android build               blocked — SDK absent and installation prohibited
iOS build/run               host-unvalidated
manual human UI acceptance  blocked/pending
```

## Accepted resolutions materialized

The private catalogue now distinguishes:

- immutable opaque internal Product record ID, generated as UUID v4 for new Products;
- required user-designed Product code, preserved for display and normalized for account-scoped uniqueness;
- versioned normalized identification facts used for exact matching;
- no local field pretending that a future central catalogue identity already exists.

Normalization v2 applies Unicode NFKC, lowercasing, whitespace collapse, a bounded punctuation rule, and preserves accented Portuguese letters. Display name and brand remain separate from normalized facts. Existing v1 Product IDs are preserved as opaque internal identities during migration and legacy rows receive deterministic reviewable bootstrap codes.

Device creation now uses insert-if-absent, so registration does not reset sequence state. Sequence allocation remains inside the Purchase transaction, and the local schema constrains account/device/sequence uniqueness. Tests report monotonic 1, 2, 3 behavior across repeated registration and reopen.

JSON Schema Draft 7 plus readable v2 examples now owns structural contract evidence. Dart domain tests continue to own cross-field semantics; schema validation is not semantic parity and does not establish a TypeScript implementation.

## Architecture and ownership outcome

The physically observed path is now:

```text
Flutter presentation
→ application/query ports
→ independent Dart domain
→ local repository adapters
→ Drift schema v2 / application-private SQLite
```

The composition root supplies one local account placeholder, one local device placeholder, the database, registration repository, catalogue queries, and history queries. Widgets do not execute SQL. The local registration transaction resolves Store/Product references, validates the aggregate, writes Purchase and Items, allocates sequence, writes one immutable event, and enqueues it before commit. Networking remains absent.

The UI is intentionally bounded rather than complete: Purchase and History navigation, multi-item staging, atomic submission, and visible local history exist. Accessibility, responsive depth, error recovery, editing, deletion, Product-code editing, and manual human acceptance remain incomplete.

## Deviations, costs, and reversibility

The Windows host required Visual Studio Build Tools 2022 rather than the incomplete Community installation. This is host/tooling evidence, not canonical product architecture. Android was not attempted because the SDK was absent and installation was outside authority; iOS cannot be validated on this Windows host.

Drift v2 proves one controlled local upgrade, not a general migration system. The upgrade ledger uses runtime UTC time, while fresh schema creation still records a source-fixed timestamp. Store identity remains exact display-name reuse. The app-private composition currently uses fixed local account/device identifiers, so authentication, durable device registration, and multi-account lifecycle remain deferred.

The cost of separating Product identity before UI hardening was additional domain, migration, fixture, and presentation work. It avoided establishing user Product code as relational identity and preserved a future central-catalogue mapping seam. PySide6 and its database remain untouched and recoverable, retaining rollback if Flutter parity is not accepted.

## Deferred distributed boundary

Still deferred: TypeScript API, Neon/Postgres, authentication/authorization, upload/download synchronization, server cursor behavior, second-device convergence, central catalogue identity, legacy desktop import, Product-code editing/aliases, Purchase editing/deletion, background/realtime synchronization, Android/iOS acceptance, and PySide6 retirement.

## Current decision classification

```text
accepted + implemented
    inward Flutter dependency direction
    local-first isolated persistence
    Product code / internal ID separation
    versioned normalized exact identity
    Purchase aggregate and local atomic transaction
    structural JSON Schema plus semantic Dart tests
    protected PySide6 transition

validated
    local tests and migration rehearsal
    Windows build and startup smoke

provisional or blocked
    placeholder account/device lifecycle
    general migration policy
    Store identity
    manual UI/accessibility acceptance
    Android and iOS platform evidence
```


# 15. Event 17 — Cycle 07 Sprint 05 Android Local Slice

## Materialization and validation

Sprint 05 materialized Android debug-development support over the existing shared Flutter architecture. The Android host now uses namespace/application ID `com.gusigu.markei`, label `Markei`, Flutter embedding v2, and a minimal `FlutterActivity`. Shared Dart composition, application ports, domain contracts, Drift repositories, and the protected Python beta remain structurally intact.

Reported and repository-supported evidence includes 27 passing Flutter tests, clean analysis, a debug APK build, APK identity inspection, API 36 emulator boot, APK install/launch, Android app-private database observation, human-confirmed Purchase registration, Windows build regression, and five Python regressions. The runtime database was observed under the Android application sandbox with one UUID v4 Device for `local-account`, sequence advanced to 2, and one Purchase.

This evidence establishes an Android-local functional slice. It does not establish production signing/release, broad device compatibility, complete lifecycle behavior, accessibility acceptance, or final visual design.

## Identity decisions and preserved history

Sprint 05 separated these responsibilities:

```text
Android application ID   installation/update/sandbox identity
Markei label              presentation metadata
local-account             provisional local Account placeholder
Device UUID v4            app-private installation event origin
Device sequence           ordering ledger attached to Device row
Product/Purchase/Event IDs unchanged domain and event identities
```

Runtime composition no longer injects `windows-device`. It asynchronously opens the app-private database and asks `LocalDeviceIdentityRepository` to load or create a Device UUID v4 before registering events.

No Drift schema migration was added. Schema v2 already contains `devices(id, account_id, next_sequence, created_at)` and event uniqueness by account/device/sequence. Reusing that structure was cheaper and safer than manufacturing an unnecessary schema version. Historical non-UUID rows are preserved as evidence and are not selected as the new current Device; destructive conversion could have reassigned historical event ownership.

## Prototype-only Device selection rule

Repository inspection exposed a bounded heuristic: the Device repository reads only the first 20 Account Devices ordered by creation time and selects the first UUID v4 row. Current tests prove UUID creation, reopen reuse, distinct fresh-database identity, sequence 1→2 continuity, and preservation of a historical `windows-device` row.

This rule is acceptable only for the present single-installation prototype because the test population is bounded. It is not the accepted future synchronization invariant. Risks include:

- an existing UUID beyond the first 20 rows being missed;
- multiple UUID rows being resolved only by earliest creation time;
- concurrent bootstrap transactions creating multiple candidates because no installation singleton/key owns uniqueness;
- Account Device history being confused with the identity of this installation.

Before real multi-device synchronization, Design requires an explicit current-installation Device relation: one local installation metadata record must identify exactly one Device row, bootstrap must be idempotent under concurrency, and sequence allocation must remain attached to that selected Device. The exact schema and migration are deferred until the synchronization/device-registration unit.

## Host configuration versus architecture

Compile SDK 36, target SDK 36, NDK resolution, Java 17, Gradle, emulator image, and Android Studio are operational/build configuration. Pinning SDK 36 corrected toolchain drift and made the build reproducible; it does not define domain architecture or a permanent product invariant.

The stable application ID is architectural because it owns Android sandbox continuity. Exact SDK versions may change through controlled Operational evidence without reopening Product, Device, or persistence ownership.

## Functional scaffold boundary

`SafeArea` and the staged BRL total are accepted as bounded functional-scaffold corrections. They support system-inset safety and make the multi-item acceptance path observable without selecting a design system or rewriting navigation/state management.

Phone-width widget evidence and human emulator registration support narrow functional usability. They do not prove keyboard, Back, rotation, background/resume, larger text, accessibility, physical-device behavior, or final visual quality. Any supplemental Android pass should be limited to a recorded lifecycle/ergonomics checklist and evidence-backed blockers. Broader information architecture, styling, accessibility refinement, and visual acceptance belong to a later UI/UX sprint.

## Deviations, reversibility, and cost

Automated ADB form entry was blocked by emulator input overlays/Gboard behavior, while manual registration succeeded. This preserves the distinction between automation limitations and application failure.

The Device repository adds a small local infrastructure seam without new package or schema cost and remains reversible independently of UI, API, or cloud work. Deferring an explicit installation singleton avoids premature migration work now, but carries deliberate debt that becomes unsafe once multiple Devices or concurrent bootstrap are realistic.

Deferred: physical-device validation, full lifecycle matrix, production signing/release, backup policy, authentication, API/Neon, real synchronization, central catalogue, import, broad UI redesign, iOS, and PySide6 retirement.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


---

# Event 18 — Intermid Cycle Edit-Identity Reconciliation

## Context and authority

The Intermid Cycle Recovery identified a presentation defect in staged Purchase Item editing: the stable draft-line key preserved list identity, but the original Product reference was not retained when editable Item values were restored. Main isolated one bounded Ordinary Sequence unit through `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, and `F_DSN_STAGE.md`. Codex materialized commit `409e5f1e013a282165efd5f31bed17a396ad6543`.

## Materialized responsibility

`_PurchasePageState` now owns three associated edit-state values:

```text
_editingKey
_editingReference
_editingProductLabel
```

Entering edit mode copies the staged line key, its `ProductReference`, and its Product label into presentation-local edit state. Saving calls a dedicated edit path that rebuilds the `PurchaseItemDraft` values from editable controls while reusing the retained reference and label. Saving, removing the line currently being edited, and successful Purchase registration clear the associated edit state. Product selection is also cleared after line save to prevent a stale dropdown object from competing with staged-line identity.

This correction remains presentation-local. It changes no application contract, domain identity, repository transaction, Drift table, migration, composition, or navigation responsibility.

## Evidence and limits

Direct regression evidence exists for `ExistingProductReference`: the widget test creates one Product, stages and edits it, changes package count, quantity, and line total, registers, and verifies that the registered Item retains the original Product ID and that Product count remains one.

Final recorded evidence:

- focused app tests: 7 passed;
- full Flutter tests: 32 passed;
- Flutter analysis: no issues;
- touched Dart files formatted.

The common edit-state field is typed as `ProductReference`, and the save path reuses that reference without reconstructing it, so source structure supports preservation of `NewProductReference`. No separate new-Product edit regression was produced; this remains structural support rather than direct regression evidence.

## Decision disposition

Accepted and implemented: staged-line edit identity belongs to presentation edit state; Item values may be rebuilt without changing Product identity.

Corrected: the prior existing-Product edit defect is no longer active at the materialization commit.

Deferred as separate decisions: schema v3, Store identity/normalization, durable `SubmissionId`, installation–Device lifecycle, persisted drafts, query/index policy, backup/restore identity, authentication, API/Neon, and synchronization.

# 19. Event 19 — Cycle 09 Local Product Expansion Reconciliation

## Evidence and promotion boundary

Cycle 09 Unit C09-U02 was materialized at `e37cb700feeca4001cc7835b584c46bb81926af3`. Design reconciliation compared C, F, I, post-Codex J and targeted handwritten source. Generated `local_database.g.dart` was treated only as derived evidence; `local_database.dart` remains the physical schema/migration authority.

Reported materialization evidence includes 39 passing Flutter tests, clean analysis, a Windows release build and bounded launch, file-backed v2→v3 migration/reopen evidence, and five Python regressions. Android, native share, complete manual workflow, injected migration failure, full accessibility and release acceptance remain outside this Design acceptance.

## Accepted and implemented architecture

The inward Flutter/application/domain/adapter dependency direction remains intact. Schema v3 adds People, PaymentMethods and AccountPreferences; Purchases receive nullable Person/Payment Method references; PurchaseItems permits null package count for BULK. Product normalization v3 and migration preflight preserve internal IDs and stop on exact-identity collisions. Legacy null Product codes are deterministically backfilled, while the handwritten Product code columns remain nullable for compatibility.

Home-first navigation, transient versioned Lists projections, History selected-ID state, export DTOs, deterministic CSV/PDF bytes, typed application failures, exact Product lookup ports, local reference lifecycle and Product-detail query ownership are implemented. No manually persisted List/cache or external synchronization path was introduced.

## Corrected claim classifications

1. **BULK price-per-unit — contradicted completion.** Nullable BULK package count is implemented, but Purchase presentation still requests Line total. It does not request price per unit or perform the frozen half-up derived-total flow. The stable architecture remains: BULK must not persist competing price truths. The UI correction is future work.

2. **Active-only nickname uniqueness — contradicted physical constraint.** People and PaymentMethods use `(accountId, normalizedNickname, active)` unique keys. This enforces one active nickname but also only one archived row per nickname. It does not implement arbitrary historical archived duplicates under an active-only uniqueness policy.

3. **Nullable Product codes — resolved compatibility boundary; NOT NULL claim contradicted.** Creation and migration produce codes, lookup uses normalized code, and migration backfills legacy rows. Nevertheless the authoritative handwritten columns remain nullable. Design accepts required codes at new-command/application boundaries without claiming database-level NOT NULL.

4. **Native PDF sharing — deferred; PDF generation implemented.** Stable DTO and PDF-byte generation exist. History writes a fixed temporary file and instructs manual sharing. No save destination/cancellation contract or native OS share adapter exists.

5. **Exact lookup presentation — partial.** Repository/application ports support exact code and exact normalized identity lookup. Catalogue presentation still performs in-memory substring filtering over code/name/brand instead of exposing the exact operations explicitly.

6. **Adaptive Product details — partial.** Catalogue tap/long-press reveals a local detail card and a Product-detail query port exists. A shared adaptive Product route/pane/sheet and desktop double-click convenience are absent.

## Preserved and deferred boundaries

Typed failures exist, but generic page catches mean the full user-facing failure contract is partial. History has checkbox/tap selection but lacks the requested double-click shortcut and select-all. Authentication, API/Neon, synchronization, Store redesign, SubmissionId, persisted drafts, Product merge/correction, registered Purchase mutation, native sharing, Analytics/Household behavior and production release remain deferred.

## Decision disposition

```text
accepted and implemented
    schema v3 optional local references and archive-aware historical labels
    nullable BULK package-count representation
    normalization v3 collision-preflight migration
    transient personal-cycle-v1 projections
    stable export DTO + deterministic CSV/PDF bytes
    exact lookup application/repository ports

partial
    typed failure presentation
    exact lookup presentation
    History selection conveniences
    adaptive Product details

contradicted
    completed BULK price-per-unit UI
    active-only nickname uniqueness as physically implemented
    Product-code NOT NULL storage claim

deferred
    native PDF sharing/save chooser
    corrective implementation for the contradictions
```


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.

# Event 20 — Cycle 09 Sprint 02 Current-UI Archive and Proposed Visual Language

## Observation boundary

This event archives Design evidence at `c67d573f1335ffd55c659a9ee795982ca72c2c32`.

Evidence classes are kept separate:

- screenshots 6–10: user-supplied current communication and interaction evidence;
- handwritten Flutter source: structural evidence for composition and implemented interaction;
- mockups 1–5: proposed visual and interaction intention only;
- user observations: current workflow gaps requiring reproduction and Main selection.

Nothing in this entry accepts the mockups as architecture, authorizes source work, or changes the current Design checkpoint.

## Current visual abstraction

The current client presents a sparse Material scaffold:

```text
MaterialApp with one dark-green seed
→ standard AppBar
→ narrow NavigationRail at desktop width
→ NavigationBar below 720 px
→ IndexedStack pages
→ mostly ListView / Column / Row / Wrap
→ standard TextField, DropdownButton, ListTile, Card and buttons
```

Screenshots 6–10 show a pale background, limited visual hierarchy, broad unused space, narrow navigation, plain list rows, minimally differentiated cards and weak separation between page title, task sections, data, feedback and actions. The visual system reads as a functioning scaffold rather than a coherent Markei product surface.

Source supports this reading: the theme declares only `colorSchemeSeed`; Home is a sequence of basic Cards/ListTiles; Lists and History use plain Cards/ListTiles; Product creation, Purchase entry and Settings are long vertical forms assembled from standard fields, rows and wraps. No shared Markei spacing, typography, elevation, surface, table, status-chip or action-hierarchy abstraction is evident.

Screenshots also preserve overflow warnings and constrained horizontal compositions. Rigid paired `Row` fields and dense navigation/page content create risks at narrow widths, larger text, localization and desktop window resizing. The single 720-pixel shell switch changes navigation placement but does not itself recompose page information hierarchy.

## Current interaction archive

### Navigation and page structure

The shell preserves mounted page state with `IndexedStack`. Desktop uses a narrow labelled rail; compact layouts use the bottom bar. The expanded destination count competes for navigation space and does not yet express primary, secondary, disabled or informational destinations as a coherent hierarchy.

### Purchase

Purchase owns a long scrolling form, standard selectors and staged-line ListTiles. Store selection precedes Product and reference controls structurally, but the UI does not expose the requested editable Purchase date/time (`hh:mm · dd/mm/yyyy`) after Store; registration uses `DateTime.now()`.

Person and Payment Method selectors show nicknames or “Not assigned.” Their immutable IDs are not communicated alongside nicknames.

Product entry mixes catalogue selection and new-Product creation in one dense surface. PACKAGED fields use paired rows. BULK removes package fields but still asks for Line total; price per unit/volume and derived-total feedback are absent.

Staged Items expose edit/remove controls, but the visual distinction between Product identity, Product details and editable Purchase Item values remains weak.

### Catalogue

Catalogue search filters the loaded list by substring across code, name and brand. Rows use tap and long-press to reveal an inline detail card. The current surface does not communicate an explicit selection mode, exact Product selection, or desktop double-click behavior. Product details and Product selection can therefore read as the same action even though their responsibilities differ.

### Lists

Lists exposes Storage, Shortage, Market and All through standard projection controls and Cards/ListTiles. The screenshot evidence reports that the expected Catalogue/Purchase relational information is not visibly materializing. The current row hierarchy is too thin to communicate Product code, Product/Brand, latest Purchase, amount, unit price, personal cycle, expected date, remaining time and derived status together. Sparse or unavailable data lacks a strong learning/status treatment.

### History

History has checkbox/tap selection, action buttons, plain Purchase rows and an inline detail region. Selection is more explicit here than in Catalogue, but feedback and action hierarchy remain weak: export/share/disabled mutation actions compete visually, and selected state is not elevated into a clear action mode. Desktop double-click is not a substitute for checkbox/tap/keyboard access.

### Settings

Settings communicates local-only Person and Payment Method records, archive state and shortage threshold. Rows show nickname/history label and Active/Archived, but do not consistently teach the ID-plus-nickname distinction required for durable historical references.

## Proposed visual abstraction from mockups 1–5

The mockups propose, but do not implement or canonize, a more recognisable Markei language:

- branded cream and white surfaces;
- dark-green primary actions/navigation;
- lavender secondary accents and selected/auxiliary surfaces;
- consistent navigation treatment across desktop and mobile;
- cards for grouped tasks and summaries;
- tables or table-like rows for dense relational data;
- status chips for Storage/Shortage/Market, Active/Archived, unavailable and disabled states;
- stronger typography, spacing and section rhythm;
- visible loading, empty, selected, success, warning, error and disabled states;
- accessible selection controls plus optional desktop shortcuts;
- coherent primary/secondary/destructive/inactive action hierarchy;
- responsive desktop panes/tables and mobile stacked cards/sheets.

This is a candidate component/token system, not accepted architecture.

## Candidate tokens and components for Main review

### Tokens

```text
surface.canvas        cream candidate
surface.primary       white candidate
surface.secondary     lavender candidate
action.primary        dark green candidate
text.primary          high-contrast near-black/green
text.secondary        muted neutral
status.storage        positive/available
status.shortage       warning
status.market         due/ended
status.unavailable    neutral learning state
spacing               named compact / regular / section / page rhythm
radius                field / card / panel hierarchy
elevation/border      restrained surface separation
```

Exact values, contrast, dark mode and platform theming are unresolved.

### Components

- branded adaptive application shell;
- page header with title, context and primary action;
- section card/panel;
- responsive form grid;
- labelled identity picker showing code/ID plus name;
- Product result row with separate Select and Details actions;
- dense desktop projection table with mobile Product card equivalent;
- status chip and unavailable/learning badge;
- selection action bar;
- feedback banner with recovery action;
- responsive detail pane/sheet/route;
- date/time field group;
- amount/unit and price-per-unit calculator group;
- ID-plus-nickname reference row;
- explicit empty/loading/error panels.

## Functional contracts that must drive the redesign

The redesign cannot be a skin over unresolved behavior.

1. **Purchase date/time:** the visual field requires one presentation value, locale-aware editing, validation and a clear conversion into the existing occurrence-time contract.
2. **Exact Product selection:** rows must distinguish “Select Product” from “View details”; exact code/identity operations require visible presentation and optional desktop double-click without removing tap/keyboard actions.
3. **Relational Lists:** the row/table contract must be fed by Catalogue + Purchase projections and expose unavailable states, not static placeholders.
4. **Person/Payment Method:** selectors and Settings rows must present stable ID/code plus nickname without making users edit internal identity.
5. **BULK pricing:** amount/unit and price-per-unit must derive line total under the accepted rounding contract; line total should not remain the only unexplained input.
6. **Product details:** adaptive pane/sheet/route should be shared across Catalogue and Purchase and remain distinct from Product selection.
7. **History actions:** selected state must produce an accessible action hierarchy for Analytics-disabled, CSV and PDF/manual/native share boundaries without implying Purchase mutation.

## Responsive risks

- nine destinations can overflow or become cognitively flat in rail/bar navigation;
- paired Row fields can overflow at phone width and larger text;
- desktop unused space may coexist with cramped form rows;
- relational Lists data cannot fit unchanged into both desktop and mobile;
- inline Product and Purchase detail panels can create excessively long pages;
- status/action chips can wrap unpredictably without priority rules;
- selection action bars require keyboard focus, screen-reader labels and stable mobile placement;
- cream/lavender candidates require contrast verification rather than aesthetic assumption;
- screenshots do not establish rotation, zoom, text scaling, localization or lifecycle behavior.

## Main decisions required before D/E/F

1. Freeze the navigation hierarchy: primary product destinations versus disabled/informational destinations.
2. Accept or revise the cream/white, dark-green and lavender token direction; define contrast and dark-mode boundary.
3. Select typography, spacing, radius, border/elevation and density scales.
4. Define desktop table versus mobile card representations for Lists and History.
5. Freeze Product row actions: Select, Details and optional double-click semantics.
6. Freeze date/time presentation, locale and occurrence-time conversion.
7. Freeze the visible ID-plus-nickname format and whether IDs are user codes or shortened immutable IDs.
8. Freeze BULK unit-price input, derived total and rounding feedback.
9. Decide adaptive Product details: route, sheet, pane or breakpoint combination.
10. Define selection-mode feedback and History action priority.
11. Define shared loading/empty/error/unavailable/success/warning components.
12. Set responsive breakpoints and minimum window/text-scale acceptance.
13. Decide whether Sprint 02 is one visual-system foundation plus page units or a broad simultaneous restyle.
14. Preserve mockups as target evidence only until D/E/F names exact components, paths, tests and stop conditions.

## Disposition

```text
archived observational evidence
    current sparse Material scaffold
    screenshot-visible composition and workflow gaps
    source-backed interaction patterns
    proposed mockup language
    responsive and accessibility risks

not promoted
    palette values
    component library
    navigation redesign
    page layouts
    functional contract changes
    source/schema/dependency work
```

# Event 21 — Cycle 09 Sprint 02 Permanent Design Promotion

Sequence: FLX-PRM-04
Evidence boundary: C/F/I, post-Codex J, target references 01–05, handwritten source/tests in `5ddff3c…1d81797`; generated Drift derived only.

## Claim transitions

| Claim | Prior state | Controlling evidence | Resulting state / owner |
| --- | --- | --- | --- |
| Local persistence | schema v3 | handwritten schema v4, migration fixture/reopen tests | implemented; Architecture |
| Person/Payment identity | opaque IDs; visible codes proposed | non-null `@/#` codes, Account counters, scoped unique keys | implemented; Architecture |
| Product codes | nullable-storage compatibility | v4 rebuild/backfill plus non-null/unique columns and immutable commands | implemented; Architecture |
| Purchase occurrence | implicit/current instant | exact local text parser → UTC command fact | implemented; Architecture |
| BULK pricing | contradicted completion | fixed-point same-unit calculator and read-only total UI | implemented; Architecture |
| Exact Product resolution | ports implemented, presentation partial | Purchase exact-code resolve/autofill | implemented narrowly; Architecture |
| Lists | rebuildable thin projection | Product-first joins retained; page/read composition still thin | partial/open |
| Compact navigation | planned | Home/Lists/Purchase/History/More mapping | implemented, responsive acceptance partial |
| Shared visual system | proposed | 44-line theme; three 57-line primitives unused by pages | partial/open |
| Home/Lists visual target | proposed | implementation diff/source and target references | not materialized |
| Catalogue/History composition | sparse baseline | standard ListTile composition persists | partial/open |
| Purchase composition | long-form baseline | functions added inside ~1,020-line page | functional increment; architecture debt open |
| History double-click | selection toggle contract | source focuses detail only | contradicted; Main decision required |
| Native PDF sharing | deferred | no dependency/adapter; temporary-file manual flow | deferred |
| Visual parity/accessibility | proposed/unvalidated | no target-comparison or manual accessibility evidence | open/unvalidated |

## Reconciliation

Source corrected stale schema-v3, nullable-Product-code and unimplemented-BULK statements without erasing their earlier observational history. J and source agree that green automated checks do not establish target-image parity. No Design claim promotes Android, Windows workflow, native-share, accessibility or release acceptance.

## Prospective next unit

Pending Main authority, Design recommends one bounded schema-free visual-convergence unit: expand tokens/primitives; adopt them page-by-page; recompose Home, relational Lists and Catalogue; split/recompose Purchase; recompose History and freeze double-click semantics; validate expanded/compact screenshots, Windows workflow and accessibility. No implementation is activated by this event.

---

# Event 22 — 2026-07-15 — Cycle 10 Recovered Local/Provider Boundary

## Context and decision

Cycle 10 materialized local synchronization, recovery, hosted-identity persistence and a provider-free authentication composition. Main at `75fbba66` accepted bounded local facts but contradicted C10-S03A hosted readiness. Design therefore preserves the offline-first port/adaptor direction; separates external identity, membership, InstallationId and DeviceId; separates direct migrator from pooled-intended runtime authority; and treats provider dashboards as preparation until real hosted proof is reconciled.

The required hosted invariant is that membership, enrollment and Device state are checked within the same transaction as each protected operation. The implementation did not establish that invariant route-wide, so `C10-S03A_LOCAL_HOSTED_AUTH_READY` is rejected.

## Alternatives considered

- Direct subject-to-Account/Device binding: rejected because it collapses authentication, membership and Device lifecycle.
- Local JWT/JWKS and loopback tests as hosted acceptance: rejected because no provider or deployed least-privilege path was exercised.
- Provider identifiers or credentials in permanent memory: rejected; sanitized roles and evidence boundaries suffice.

## PRC-01 classification and evidence

- Promote: forward-only migration 004 with migrations 001–003 unchanged; additive Drift v7; fixture-auth containment; distinct identity/membership/installation/Device concepts; fail-closed local hosted configuration.
- Promote with boundary: sanitized MCG-01 Neon development capability—PostgreSQL 18.4, disposable database, TLS, direct migrator, pooled-intended runtime, rollback, CRUD and DDL denial.
- Checkpoint only: MCG-02 Auth0/Render dashboard preparation and public native-client/no-secret boundary.
- Reject/contradicted: hosted readiness and route-wide transaction-time authorization.
- Retain in staging: provider behavior, production acceptance and Cycle 10 closure.

Evidence: A/B/C; controlling D/E/F; G/H/I; source, migration and tests at `d345f580`; Main reconciliation and recovered human evidence at `75fbba66`. Generated Drift is derived evidence.

## Consequences, rollback and status

Migration 004 and Drift v7 may remain inert while hosted composition is disabled; local facts and queues remain valid. Provider preparation may be abandoned without changing domain facts. Corrective implementation requires new Main D/E/F and reconciliation; historical migrations and the contradiction must not be erased.

Confidence is high for materialized local boundaries and medium-high for sanitized MCG-01 evidence. Provider behavior remains partial and unproved.

```text
C10-S03A_CONTRADICTED_STOP
MCG-02_HOSTED_PROOF_NOT_PERFORMED
```
---

# Event 23 — 2026-07-30 — Cycle 10 Coordination Architecture and Development-Scope Closure

## Registration boundary and provenance

This event registers the Cycle 10 Design progression after the earlier Event 22
stop. It is observational history, not an expansion of the proved scope.

Primary provenance:

- `documentation/REC_LEGACY.md`, Records 001–021 and Appendix I;
- `documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md`, mutable-prefix
  sections 2–5.4 and 8;
- protected J `Legacy_Progress`, especially the GCM02 ST08–ST10 entries,
  GCM03 S08–S10 and R03–R05 corrective lineage, the 2026-07-30 GCM03 final
  reconciliation, and the Cycle 10 final scope closure.

Evidence ceiling:

```text
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=CLOSED_TWO_DEVICE_DEVELOPMENT_SCOPE
MVP_SYNC_ACCEPTANCE=PASS_TWO_DEVICE_ONE_ACCOUNT_DEVELOPMENT_SCOPE
PRODUCTION_ACCEPTANCE=ABSENT
```

No equivalent terminal Design registration existed before this event. Event 22
remains the historical record of the earlier contradicted hosted-readiness
state and is superseded only for the current Cycle 10 terminal.

## Ordered decision progression

1. **Local authority retained; hosted authority bounded.** The local
   app-private SQLite database remained the autonomous owner of Product,
   Purchase, local Device sequence, event preparation, queue state, cursor
   progress and local projections. The hosted service was accepted as an
   authenticated, Account-scoped coordination channel for immutable
   submissions, ordered events and acknowledgements—not as Product authority,
   permanent analytics storage, general backup or a replacement for local
   ownership. Evidence: REC 009–012, 017 and 021; J sections 3 and 5.4.

2. **Identity responsibilities separated.** External authentication establishes
   a principal; membership authorizes that principal within an Account;
   Installation identifies app-local continuity; Device is the enrolled Sync
   actor that owns a monotonic sequence and hosted authorization state.
   Collapsing subject, Account, membership, Installation and Device was
   rejected. Evidence: REC 008–009 and 014–017; J section 3 and the S07/S08
   Legacy entries.

3. **Same-Device topology closed before reciprocal topology.** GCM02 first
   proved one enrolled Device across local client, hosted API/Render and
   provider transaction evidence. GCM03 then added a second enrolled Device
   under the same Account and separately proved Windows-to-Android and
   Android-to-Windows convergence. Readiness, enrollment, an empty queue or one
   successful Device were never treated as proof of reciprocal convergence.
   Evidence: REC 010–012, 013–017 and 021; J section 2.

4. **Natural Product identity became the reconciliation selector.** User-visible
   Product code remained a local display/lookup identity; local Product UUID
   remained the local persistence/reference identity; event identity remained
   the immutable idempotency and ordering identity. Exact versioned natural
   Product identity selects an existing compatible local Product during remote
   apply, and remote references map to that selected local UUID. The earlier
   assumption that different local codes/UUIDs necessarily imply different
   Products was superseded after the typed conflict in REC 019–020 and the
   R03–R05 corrective line. Evidence: REC 018–021; J R03–R05 entries.

5. **Append-only responsibilities remained distinct.** The local client creates
   one immutable event within the local Purchase transaction and exposes it
   through a durable queue. The hosted service accepts an idempotent submission
   and materializes Account-ordered Sync events. A retry reuses event/request
   identity; it does not register the Purchase again. Evidence: REC 011–012,
   019 and 021; J section 3.

6. **Transaction truth was partitioned from diagnostic containment.** Upload
   lease, trusted provider result persistence, downloaded-event local apply,
   cursor advance and acknowledgement are distinct causal boundaries.
   Diagnostic persistence observes those boundaries but cannot determine or
   roll back their truth. The R03/R04 design that used one cumulative mutation
   field was superseded by R05 separation of transaction-specific state.
   Evidence: REC 019–020; J post-Codex R03, R04 and R05 entries.

7. **Trusted response evidence cannot be erased by a later local terminal.**
   Once a provider response is authenticated and parsed, a later local apply or
   runner exception must retain that trusted-response fact and classify the
   local failure separately. The flat terminal interpretation contradicted by
   REC 020 was rejected. Evidence: REC 019–020; J R03/R04 entries.

8. **Acknowledgement follows durable local progress.** A Device acknowledgement
   may be sent only after downloaded events are durably applied and the local
   cursor is committed. A failed/rolled-back apply cannot advance the cursor or
   acknowledge the event. Evidence: REC 019–021; J section 3 and R03–R05
   entries.

9. **Diagnostic authority was consolidated.** Runtime diagnostic definitions
   belong to `contracts/shared_beta/diagnostics_v1/diagnostics.registry.json`;
   its schema/generation contract owns validity; the readable documentation is
   generated; REC owns sanitized assay chronology; J retains investigation
   history. The former J System Diagnosis catalogue is not a second maintained
   registry or causal engine. Evidence: REC Appendix I; J section 4.

10. **Development-scope closure was accepted without resilience promotion.**
    Reciprocal convergence, the natural-identity merge, drained queues and one
    no-op repeat per Device close the one-Account/two-Device development
    topology. They do not prove multiple-Account isolation, provider lifecycle,
    production deployment or recovery under uncertain acknowledgement.
    Evidence: REC 021; J sections 2, 3 and 8.

## Supersessions, rejected alternatives and deviations

- Event 22's `C10-S03A_CONTRADICTED_STOP` remains historically correct for
  its inspected head; later exact-binding and transaction evidence supersede it
  only at the accepted GCM02/GCM03 development boundary.
- Direct subject-to-Account/Device binding remains rejected because it erases
  membership and Device lifecycle.
- Hosted Product authority, permanent hosted analytics, general backup and
  local-ownership replacement remain rejected.
- Product code, local UUID and event UUID are not interchangeable keys;
  automatic fuzzy Product merge remains rejected.
- A flat aggregate terminal, diagnostic write or runner exception cannot
  overwrite a committed upload result or trusted download response.
- Acknowledgement before committed local apply/cursor progress remains
  rejected.
- Readiness, enrollment, queue emptiness and same-Device success remain
  insufficient substitutes for reciprocal convergence.
- Manual maintenance of REC, J or generated readable diagnostics as a second
  runtime registry remains rejected.
- The intended topology deviated materially when inbound Product apply treated
  natural equivalence as a conflict, when transaction-specific mutations were
  collapsed, and when a runner terminal obscured trusted-response evidence.
  R03–R05 corrected those deviations before REC 021 closure.

## Evidence-qualified invariants

Within the accepted development boundary:

- local Product and Purchase facts remain autonomous and offline-first;
- network submission follows the local commit;
- event/submission identities are immutable and retry-stable;
- Account cursor orders hosted events while Device sequence orders one
  Device's local creations;
- exact natural Product identity may reconcile different local code/UUID
  representations without rewriting historical observations;
- remote apply maps references to the selected local Product identity;
- local apply and cursor progress commit before acknowledgement;
- diagnostic persistence is contained from causal transaction truth;
- same-Device and reciprocal two-Device topologies are separate acceptance
  claims.

## Unresolved architectural boundaries

The following remain deferred and must not be inferred from Cycle 10 closure:

- multiple-Account isolation;
- membership disablement;
- Device revocation;
- outage, timeout and acknowledgement-uncertainty recovery;
- retention;
- snapshot and rebootstrap;
- production deployment and lifecycle acceptance;
- deferred GCM04;
- conditional R07 reassessment.

These are assigned to the later C12-PHASE02 boundary by J sections 2, 3 and 8.
No production or resilience terminal is registered here.

## Decision disposition

```text
accepted decision
    local Product/Purchase authority and bounded hosted coordination
    separated Account/membership/Installation/Device responsibilities
    natural Product identity reconciliation
    append-only event/submission responsibility
    transaction/diagnostic containment
    trusted provider response preservation
    acknowledgement after committed apply/cursor
    distinct same-Device and reciprocal two-Device topology
    single runtime diagnostic-registry authority

implemented topology
    GCM02 hosted same-Device development path
    GCM03 one-Account/two-Device reciprocal development path

superseded
    Event 22 current terminal
    code/UUID mismatch as automatic Product conflict
    cumulative transaction mutation field
    later local terminal erasing trusted-response evidence

rejected alternative
    hosted Product/analytics/backup authority
    collapsed identity roles
    fuzzy or code-only automatic Product merge
    acknowledgement before committed local progress
    second diagnostic registry

unresolved boundary
    GCM04, conditional R07 and all production/resilience families listed above
```

# Event 24 — 2026-07-30 — C11-PH01-S01 Responsive Foundation Materialization

## Decision boundary and provenance

This event is distinct from Cycle 10 Event 23. It records only
C11-PH01-S01 presentation architecture evidenced by
`DEV_STAGE/I_DSN_CODEX.md` at
`1c7df53c095f4e7c1d85f278ba16c21fd95b25e6` and reconciled by the
C11-PH01-S01 capsule in the mutable J prefix.

## Accepted and materialized decisions

- destination selection uses stable enum/ID identity, not positional indexes;
- selection persists across feature-gate and responsive-layout changes;
- compact, medium and wide shell policies use `<600`, `600–1023` and `>=1024`;
- application-level `IndexedStack` composition retains page state;
- theme tokens and shared primitives own presentation semantics only;
- Home and Lists consume the shared visual foundation;
- Lists table and card modes share one projection/search/sort state;
- `ProductListProjectionRepository` remains the Lists read boundary;
- Lists Retry is a local read retry and owns neither mutation nor Sync;
- Analytics and Audit are reserved destinations without PH02/PH03 behavior.

## Preserved boundaries and reversibility

Settings and Closure behavior did not change. Purchase, Catalogue, History,
business, Sync, diagnostics and recovery ownership did not move. The additions
are presentation-only and schema-free; they remain reversible without changing
domain identity, persistence or hosted protocol contracts.

## Deviations and deferred work

Natural-height responsive wrapping was selected over fixed-aspect tiles to
protect large-text behavior. Catalogue, History and Purchase convergence
remains unfinished. Analytics functionality remains PH02. Settings/Audit
completion and Closure relocation remain PH03.

## Evidence ceiling and disposition

The structure is implemented, focused/full-test validated and Windows/Android
build validated. Human Windows/Android visual acceptance, pixel parity,
golden-policy acceptance and real screen-reader behavior were not performed.

```text
C11_PH01_S01_PRESENTATION_TOPOLOGY=ACCEPTED_IMPLEMENTED_VALIDATED
HUMAN_PLATFORM_ACCEPTANCE=ABSENT
PH01_FIVE_PAGE_CONVERGENCE=INCOMPLETE
PH02_ANALYTICS=DEFERRED
PH03_AUDIT_SETTINGS_CLOSURE=DEFERRED
```

# Event 25 — 2026-07-31 — C11-PH01-R01 and C11-PH02 Analytics Materialization

## Decision boundary and provenance

This event absorbs the final Design evidence at implementation commit
`20e3d5f6c2f973d138e3b2680aa8adf96f17d0b6`, complete
`DEV_STAGE/I_DSN_CODEX.md`, and J reconciliation section 9 at
`0bfc02e8363d8119469a5e8627d8350fa97790b4`. It supersedes Event 24 only
where Event 24 deferred PH01 five-page convergence and PH02 Analytics. It does
not change Cycle 10, PH03, production, provider, Sync or diagnostic authority.

## Accepted and materialized decisions

- Analytics is deterministic, read-only, local and active-Account-scoped.
- `analytics_models.dart` owns evidence identity, rows/datasets, determinants,
  variables, conditions, evidence scopes, card identity/revision/configuration,
  compatibility keys and typed result envelopes.
- Persisted Purchase Item identity is the stable evidence-row identity.
  Purchase identity remains separate for History handoff and Purchase-total
  deduplication; Line total remains row-owned.
- `analytics_registry.dart` owns `local.sum@1`, `local.mean@1`,
  `local.difference@1` and `local.percentage@1`. Operation compatibility,
  contribution units, B-minus-A Difference, part-of-whole Percentage, checked
  integer/fixed-point arithmetic, zero-denominator and overflow outcomes are
  versioned domain semantics.
- The application layer owns the read-only evidence port, typed History launch
  context and session workspace. Cards, filters, selection, focus, ordering and
  results are session-local and unsynchronized.
- `LocalAnalyticsRepository` owns one complete Account-predicated joined read
  across Purchase Items, Purchases, Products, Stores, People and Payment
  Methods. The request invariant is one initial read, one additional read per
  Retry and zero reads for local filter/selection/execution/focus/reset/reorder
  transitions.
- Analytics page/widgets are presentation-only. One workspace/controller drives
  wide and compact projections.
- Composition supplies the adapter, registry and workspace. App composition owns
  destination selection, visibility and the typed History-to-Analytics context.
  History owns selected Purchase IDs and handoff only; it does not calculate.
- Analytics loading is visibility-gated so a retained hidden destination does
  not eagerly own SQLite work. The bounded tester-owned scrolling correction
  restores deterministic test lifecycle without weakening assertions.
- PH01 Purchase, Catalogue and History corrections are implemented and
  validated at the same automated/build ceiling as Analytics.

## Alternatives and rationale

- A complete joined read was selected over History reuse or per-row composition
  because it preserves a complete matrix, Account predicate and zero-N+1
  request boundary. Incremental evidence remains reversible behind the read
  port, but is deferred until it can preserve counts, focus and traceability.
- Session-local cards were selected over persistence because persistence would
  add schema, migration, version-lifecycle and Sync obligations without current
  evidence of need.
- Operation-specific typed semantics behind a versioned registry were selected
  over generic calculators because invalid combinations, contribution units,
  zero denominators and overflow require explicit outcomes.
- Independent compatibility-keyed values were selected over a composite
  multi-variable score because no accepted cross-variable meaning exists.
- Purchase-ID History handoff was selected over evidence-row IDs or a new
  filter model because History already owns stable Purchase selection and must
  not acquire Analytics detail or calculation authority.
- One shared workspace was selected over responsive-layout controllers because
  layout changes must preserve cards, filters, selection, focus and results.

## Reversibility, deviations and evidence ceiling

The evidence port permits a later read strategy without moving calculation into
infrastructure. Registry versions permit additive semantic evolution. The
session workspace and presentation projections are replaceable without schema
rollback. History handoff remains a narrow optional application context.

The visibility gate and bounded test helper are lifecycle corrections rather
than new product capabilities. No schema, migration, generated source,
dependency, API, Auth, Sync, provider or diagnostic source changed.

Named focused tests, the 258-test Flutter suite with four lab-gated skips,
`flutter analyze`, Windows release build, Android debug build, request-count
tests and ordinary/stress fixtures validate the implemented boundary. Screenshot
review, assistive technology, locale, real-device and human visual/comprehension
acceptance remain host-unvalidated. Fixture timings are evidence from one
Windows validation host, not universal performance guarantees.

## Decision disposition

~~~text
accepted
  local Account-scoped Analytics authority
  typed evidence and versioned operation ownership
  application workspace and History handoff boundaries
  one complete joined local read and request-count invariant
  session-local unsynchronized cards
  shared responsive state and presentation-only widgets
  visibility-gated Analytics loading

implemented and validated
  PH01-R01 presentation corrections
  PH02 Analytics at the automated/build ceiling
  lifecycle/test correction at the same ceiling

deferred
  persisted cards, incremental evidence, charts, forecasting and advanced statistics
  screenshot, assistive-technology, locale, real-device and human acceptance
  PH03 Audit/Settings/Closure disposition
  all unchanged Cycle 10 production/resilience boundaries
~~~

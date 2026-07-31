# 01_ARCHITECTURE.md

> Version: 0.4-cycle07-sprint02
> Status: Reconciled Canon
> Persistence Class: Canonical
> Knowledge Class: Design
> Authority: Design Chat [D], reconciled through Main Chat [M]
> Scope: Stable application, deployment, resource, identity, diagnostics, and lifecycle responsibility boundaries
> Reconciliation Sources: `DEV_STAGE/F_DSN_STAGE.md`, `DEV_STAGE/I_DSN_CODEX.md`, `DEV_STAGE/G_OPS_CODEX.md`, `[M]_STAGE/J_[M]_STAGE.md`

---

# 1. System Form

Markei is a local Python, PySide6, and SQLite desktop monolith. Packaging and installation surround the application as deployment concerns; they do not become business or persistence layers.

```text
Desktop UI
    ↓
ProductService
    ↓
Repository
    ↓
Database Manager
    ↓
SQLite
```

Canonical dependency rules remain:

1. Desktop presentation requests behavior from ProductService and does not execute SQL.
2. ProductService owns workflows, validation, calculations, settings interpretation, and application-facing projections.
3. Repository owns SQL, row mapping, persistence operations, and one SQLite connection/cursor per instance.
4. Database Manager owns resource and user-data paths, initialization, SQLite configuration, additive compatibility migration, reset, and connection primitives.
5. Domain models carry application data and do not execute persistence or orchestrate workflows.

The current concrete construction remains page-local. This is accepted implementation structure, not a mandate for dependency injection, a new composition root, or shared service/repository lifetime.

---

# 2. Desktop Composition and Shutdown

`app.main.main()` owns Qt application construction. `MainWindow` owns the current desktop shell, including page construction, tab composition, navigation, edit routing, refresh coordination, and final coordination of page-owned service closure.

```text
RegisterPage → ProductService → Repository → SQLite connection
ListsPage    → ProductService → Repository → SQLite connection
HistoryPage  → ProductService → Repository → SQLite connection
SettingsPage → ProductService → Repository → SQLite connection
```

Each service and repository retains its local close responsibility. `MainWindow.closeEvent()` remains the accepted idempotent final coordinator for all four page-owned services.

Sprint 02 installed close and immediate reopen evidence reached this same shutdown path successfully. No installed lifecycle gate required a broader lifetime or composition redesign.

---

# 3. Application and Persistence Boundaries

`ProductService` remains the broad application facade for receipt registration, product lifecycle, calculated state, inventory projections, history projections, settings, stores, and UI-consumable read models.

`Repository` remains the broad SQLite persistence facade for products, purchases, categories, stores, settings, SQL execution, row mapping, commits, and closure.

Repository mutation methods still commit individually. Receipt registration and purchase deletion/recalculation remain multi-commit workflows rather than one atomic business transaction. Workflow atomicity remains inherited Design debt.

The current additive compatibility behavior is not a numbered or general migration framework.

---

# 4. Deployment Boundaries

Cycle 06 now has technical evidence across these distinct states:

```text
Source tree
    main.py + app/ + schema resource

Frozen runtime
    one-folder PyInstaller distribution

Installer source
    Inno Setup definition consuming the frozen distribution

Compiled installer
    Markei-Setup-0.1.0-x64.exe

Installed program files
    per-user executable and runtime content

Writable user state
    retained database, transient SQLite companions, and diagnostics
```

A configured installer, compiled installer, installed application, validated installed lifecycle, and accepted beta remain different evidence states.

## 4.1 Launcher and application construction

```text
root main.py
    launcher adapter
    owns the outer startup-diagnostic boundary

app.main.main()
    owns Qt application construction and execution
```

Unhandled launcher-level startup exceptions are written to a per-user diagnostic log and surfaced visibly where Qt permits.

## 4.2 Packaging authority

```text
Markei.spec
    authoritative one-folder PyInstaller composition

scripts/build_windows.ps1
    operational invocation wrapper
```

The packaging layer owns collection of executable code, Python/Qt runtime components, approved read-only resources, and executable metadata. It does not own workflows, SQL semantics, migration meaning, or user-created data.

## 4.3 Installer authority

```text
installer/Markei.iss
    placement, identity, shortcuts, and uninstall registration

scripts/build_installer.ps1
    compiler discovery and installer-build invocation
```

Sprint 02 added per-user Inno Setup discovery to the wrapper. That correction is tooling behavior, not a new architectural boundary.

The installer consumes the frozen distribution. It does not redefine package composition or persistence semantics.

---

# 5. Resource, Defaults, and Writable-State Classification

| Item | Accepted classification |
| --- | --- |
| `app/database/schema.sql` | Bundled read-only, replaceable application resource |
| `app/database/seed.sql` | Development/test fixture; excluded from production |
| category `F` / `General` | Structural application default required by current Register behavior |
| store `1` / `Default Store` | Structural application default required by current Register behavior |
| `%LOCALAPPDATA%/Markei/market.sqlite` | Retained writable user data |
| `market.sqlite-wal`, `market.sqlite-shm` | Transient writable companions; never bundled |
| `%LOCALAPPDATA%/Markei/logs/startup.log` | Generated writable startup diagnostics |
| settings stored in SQLite | Retained user data |
| executable metadata and static assets | Replaceable application content |

Fresh production initialization remains schema-only with idempotent structural defaults. It contains no sample products or purchases.

The structural category and store are not demonstration data. They are required referential defaults for current Register behavior when the sample-bearing seed is absent.

---

# 6. Installed Program and User-State Boundary

Installed program files are replaceable deployment content under the per-user program directory. Writable user state remains under `%LOCALAPPDATA%/Markei`.

Sprint 02 technically validated:

```text
per-user installation
→ installed executable present
→ Start Menu shortcut launch
→ external database creation
→ installed workflow persistence
→ close and immediate reopen
→ same-version reinstall with retained data
→ uninstall with retained database
→ reinstall with retained-data recovery
```

The observed installation, shortcut, uninstall registration, user-state separation, and retained-data behavior match the accepted boundary.

The validation used the current ordinary Windows user with existing Markei data backed up and restored. It did not use a dedicated clean account.

---

# 7. Retention and Upgrade Boundary

Accepted primary-beta behavior:

```text
uninstall
    removes replaceable application files and shortcuts
    preserves %LOCALAPPDATA%/Markei by default

same-version reinstall
    retains stable installer identity
    replaces program files
    preserves compatible user data
    reopens the existing database

compatible beta upgrade
    retains stable installer identity
    replaces program files
    preserves user state
    applies current additive compatibility behavior
```

Same-version reinstall, uninstall preservation, and reinstall recovery are now technically validated in the reported environment.

A later compatible-version upgrade remains a separate transition unless directly exercised. Downgrade handling, rollback, incompatible-schema recovery, and a migration ledger remain outside Cycle 06.

---

# 8. Release Identity and Shortcut Contract

```text
Display name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Installer AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
Target: Windows x64 controlled beta
```

The AppId remains stable across compatible upgrades. Executable metadata, installer metadata, shortcut names, and artifact names form one coordinated release contract.

```text
Start Menu shortcut: required and technically validated
Desktop shortcut: optional installer task; not required for beta acceptance
```

The current Inno `x64` deprecation warning is non-blocking tooling debt, not an architecture failure.

---

# 9. Evidence Boundary

Current accepted technical classification:

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Technically validated boundaries include installer compilation, per-user placement, Start Menu launch, installed data path, service-backed principal workflow persistence, installed close/reopen, same-version reinstall, uninstall retention, and reinstall recovery.

Still outside technical acceptance:

- complete human-visible installer wizard observation;
- complete human-visible Register / Lists / History / Settings walkthrough;
- human-visible close/reopen confirmation;
- human-visible SmartScreen behavior;
- final Main/human beta acceptance.

Defender enabled and unsigned binaries were observed. Human-visible SmartScreen behavior remains unknown.

---

# 10. Accepted Current Boundaries

1. Markei remains a layered local desktop monolith.
2. Packaging and installation remain deployment concerns around the business architecture.
3. Root `main.py` owns launcher-level startup diagnostics.
4. `Markei.spec` remains the authoritative package definition.
5. Installer source owns placement, identity, shortcuts, and uninstall registration.
6. Production includes `schema.sql`, excludes `seed.sql`, and creates only structural defaults.
7. Installed program files and retained user state remain separate.
8. Per-user installation, Start Menu launch, installed close/reopen, same-version reinstall, uninstall preservation, and reinstall recovery are technically validated.
9. MainWindow final service-close coordination remains sufficient for the tested installed lifecycle.
10. Technical installed workflow evidence does not equal human visual UI acceptance.
11. Final beta acceptance and Cycle closure remain Main/human decisions.

---

# 11. Explicitly Unresolved or Deferred

The following remain outside this Design absorption:

- composition-root or dependency-injection redesign;
- shared-service or repository-lifetime redesign;
- ProductService or Repository decomposition;
- workflow transaction redesign;
- schema redesign or migration ledger;
- compatible-version upgrade evidence not yet directly exercised;
- typed view-model conversion or broad UI redesign;
- mobile, backend/API, synchronization, authentication, or cloud persistence;
- automatic update, signing, rollback, or one-file packaging;
- optional uninstall data-deletion UX;
- incompatible-version and downgrade strategy;
- unrelated Promotion or `pages.order` decisions.

Derived and checkpoint files must not introduce claims absent from this canon.

---

# 16. Accepted Cycle 07 Shared-Beta Planning Architecture

This section defines accepted stable planning boundaries for the future shared client. It does not replace the accepted Cycle 06 desktop architecture until parity and human/Main acceptance.

## 16.1 Client and dependency direction

Flutter/Dart is the accepted planning basis for one future Windows, Android, and iOS client.

```text
Flutter presentation
→ application/use cases
→ domain/contracts/versioned analytics
→ repository interfaces
→ local persistence/event queue/synchronization adapters
```

Dependencies point inward toward application and domain meaning. Presentation owns responsive rendering, navigation, input, accessibility, and formatting. Use cases coordinate workflows. Domain owns identity, aggregate, quantity, money, event, and analytical contracts. Infrastructure implements repository and synchronization boundaries.

Python is not embedded in the Flutter client. Python-to-Dart continuity uses language-neutral contracts, deterministic fixtures, expected behavior, and migration evidence.

## 16.2 Local-first persistence

Every client installation owns application-private local persistence and remains usable for the reduced workflow while offline.

A local Purchase registration atomically commits the Purchase aggregate, its Purchase Items, required local catalogue references, one pending synchronization event, and affected projections. Network operations occur after local commit.

Downloaded events and local cursor advancement commit together. Projections remain rebuildable from authoritative facts and versioned rules.

## 16.3 Catalogue and purchase model

The first shared beta owns an account-private reusable catalogue.

```text
Account
├── Products
├── Stores
└── Purchases
    └── one or more Purchase Items
        └── reference Product
```

Product identity distinguishes PACKAGED and BULK modes. Packaged identity uses normalized name, brand, package amount, and explicit dimension/unit. Bulk identity uses normalized name, brand, and BULK mode. Exact normalized equivalence may reuse; fuzzy similarity is advisory and never merges automatically.

Product identity fields remain immutable in the first beta. A changed identifying name, brand, mode, or package specification creates a distinct Product identity. Future successor/product-family relationships may connect identities without rewriting history.

Purchase is an atomic aggregate containing one or more Purchase Items. The first UI may guide one item, but the contract remains multi-item capable. Purchase Items preserve immutable commercial observations.

Quantity is dimensionally explicit across MASS/KG, VOLUME/L, and COUNT/UNIT. Mass and volume are never inferred from one another. Currency is explicit and monetary facts use integer minor units. Raw catalogue, purchase, and item observations are authoritative; prices, status, intervals, inflation/deflation, shrinkflation, forecasts, and presentation models are derived.

## 16.4 Versioned analytics

The Flutter client owns versioned Dart analytical behavior. Each reproducible algorithm has a stable identifier and version. Once used, a version does not change meaning; improved behavior receives a new version. Raw purchase facts are not rewritten when analytics evolve, and cached projections remain rebuildable.

## 16.5 Synchronization and cloud boundary

```text
Flutter client
→ authenticated custom synchronization API
→ Neon Postgres
```

Clients do not hold privileged Neon credentials and do not bypass the API.

The custom API owns authentication-token verification, immutable account resolution, account/device authorization, runtime event validation, idempotent append, device-sequence policy, account-scoped cursor allocation and download, protocol versions, server transactions, stable errors, and diagnostics.

TypeScript is favored for the API boundary. Neon is favored as managed Postgres persistence behind that API. These preferences do not accept an exact framework, host, migration tool, or physical schema.

The first synchronization slice is append-only. Event UUID identifies retries; device UUID plus monotonic sequence describes one installation's creation order; occurrence timestamp records business time; opaque account-scoped cursor describes accepted download order. Purchase events are atomic, batch uploads return per-event transactional results, and new devices bootstrap from cursor zero.

Verified email is a login requirement. Immutable internal account UUID—not email—owns data.

## 16.6 Protected transition

The accepted Python/PySide6 beta and original Cycle 06 database remain recoverable throughout the transition.

```text
preserve accepted desktop beta
→ define cross-language contracts and fixtures
→ build against fresh isolated Flutter data
→ evidence reduced workflow and projection parity
→ evidence synchronization and platform lifecycle
→ migrate only from a protected copy with deterministic mapping
→ retain rollback
→ retire/demote PySide6 only after human/Main acceptance
```

Direct destructive conversion or shared opening of the ordinary Cycle 06 database is outside the accepted transition boundary.

## 16.7 Explicit exclusions from canon

The following remain provisional, open, or empirical and are not canonical implementation choices:

- deterministic Product UUID derivation;
- exact normalization-v1 rules;
- exact cursor implementation;
- decimal scale, range, and serialization;
- fractional COUNT policy;
- RLS adoption;
- legacy ambiguity handling;
- Flutter persistence and secure-storage plugins;
- state management and navigation;
- authentication provider;
- TypeScript framework/runtime/host;
- physical SQLite/Postgres tables and migrations;
- repository directory topology;
- paging limits and parity threshold.

Editing/deletion, catalogue merges/aliases, global catalogue, household sharing, complex conflicts, realtime/background synchronization, public/app-store release, and PySide6 retirement remain deferred.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.


# 17. Sprint 03 Implemented Local Flutter Foundation

Cycle 07 Sprint 03 Unit 01 materialized the accepted additive transition without replacing the Python/PySide6 beta.

Stable implemented dependency direction:

```text
Flutter composition
→ application use case
→ Dart domain
→ repository boundary
→ Drift local adapter
```

The Dart domain imports no Flutter widget, Drift, HTTP, Python, or platform-plugin API. Widgets own neither SQL nor durable transactions. The new client uses a fresh application-private database and does not access the Cycle 06 database.

The implemented local model includes account-private Product and Store facts, Purchase aggregates with Purchase Items, immutable local synchronization-event preparation, pending-event state, synchronization metadata, and a migration ledger. Drift is the implemented local persistence choice for this foundation.

`LocalPurchaseRepository.registerPurchase` owns one local transaction:

```text
resolve/create Store and exact Products
+ validate all Purchase Items
+ insert Purchase and Items
+ allocate local event metadata
+ insert immutable purchase.registered event
+ enqueue pending event
= one atomic local commit
```

Invalid Item validation rolls back the aggregate, catalogue writes, event, and pending queue entry. Network work remains outside the transaction. Local facts and pending events survive close/reopen.

Implemented representations use explicit MASS/VOLUME/COUNT dimensions, canonical KG/L/UNIT units, fixed six-decimal microunits, rejection of fractional COUNT, ISO currency code, and integer minor units. A minimal identifier/version analytics registry selects calculations without rewriting raw facts.

Versioned JSON files under `contracts/shared_beta/v1/` are accepted as semantic fixtures and contract examples. They are not database tables, user data, or a complete wire-protocol specification.

The following are not stable implemented invariants and remain outside canon:

- monotonic device-sequence continuity, because repeated registration may reset the sequence;
- exact Unicode/locale-safe normalization;
- RFC UUID version/variant semantics or cross-language Product-ID equivalence;
- complete payload typing, nullability, ranges, unknown-field and compatibility rules;
- schema-upgrade and migration-recovery behavior;
- Store deduplication and branch/location identity;
- Windows, Android, or iOS runtime/lifecycle behavior;
- authentication, TypeScript API, Postgres/Neon, upload/download synchronization, cross-device convergence, legacy import, parity, or PySide6 retirement.

Generated platform projects establish topology only. They do not establish platform validation.


# 18. Sprint 04 Accepted Local Shared-Client Boundaries

Sprint 04 confirms and extends the accepted local-first Flutter architecture without replacing the protected Python/PySide6 beta.

## 18.1 Composition and dependency ownership

The shared-client local slice uses this stable direction:

```text
Flutter presentation
→ application commands and query ports
→ Dart domain contracts
→ local repository adapters
→ Drift-managed application-private SQLite
```

The composition root owns database construction and adapter wiring. Presentation owns navigation, input staging, display state, and formatting; it does not own SQL or durable transactions. Application ports express registration and read use cases. Domain code remains independent of Flutter widgets, Drift, Python, HTTP, and platform APIs. Infrastructure implements persistence and query ports.

## 18.2 Catalogue identity

A private Product has three distinct responsibilities:

1. an immutable opaque internal record ID used by relations and events;
2. a required user-designed Product code, preserved for display and normalized for account-scoped uniqueness;
3. versioned normalized identification facts used for exact catalogue matching.

New internal Product IDs are UUID v4 values. Existing migrated Product IDs remain unchanged and are treated as opaque internal IDs. User Product code is never a primary or foreign key. A future central-catalogue UUID remains absent until that catalogue and its versioned identification set are separately accepted.

Product display name and brand remain distinct from normalized identity facts. Normalization is versioned. Exact account-scoped equivalence may reuse a Product; fuzzy similarity is advisory and never merges automatically. PACKAGED/BULK and dimensional package facts remain part of exact identity.

## 18.3 Purchase and event transaction

Purchase remains an atomic aggregate containing one or more Purchase Items. Local registration owns one transaction that:

```text
resolves account-private Store and Product references
+ validates every Item and the Purchase aggregate
+ persists Purchase and Items
+ allocates the next device sequence
+ persists one immutable purchase.registered event
+ enqueues that event as pending
= one local commit
```

Device creation is insert-if-absent and must not reset an existing sequence. Account/device/sequence uniqueness protects local ordering. Network operations remain outside the local transaction. Local event preparation and a pending queue do not constitute synchronization.

## 18.4 Local schema and contract responsibility

Drift schema v2 is the implemented local persistence structure. Its accepted responsibilities include account-private catalogue and purchase facts, local Device state, immutable prepared events, pending-event state, synchronization metadata, and a migration ledger.

The v1→v2 migration preserves internal Product IDs and Purchase references, adds Product code/display responsibilities, backfills reviewable legacy codes, and records the migration. This is evidence for one controlled upgrade, not acceptance of a general migration framework or desktop import path.

JSON Schema Draft 7 under the versioned shared-beta contract surface owns structural validation. Readable JSON examples retain scenario legibility. Cross-field invariants and normalization semantics remain owned by Dart domain and fixture tests. Structural schema success does not prove cross-language semantic parity.

## 18.5 Platform and transition boundary

Windows build and startup smoke are validated for this local slice. Android remains blocked by absent tooling; iOS remains host-unvalidated. Generated platform projects alone do not establish platform acceptance. Manual UI, accessibility, and responsive-lifecycle acceptance remain separate evidence gates.

The Flutter database remains isolated from the ordinary Cycle 06 database. PySide6 remains a recoverable accepted beta, behavior reference, migration source, and rollback until parity and human/Main acceptance authorize retirement.

## 18.6 Boundaries not promoted

The following remain provisional, blocked, or deferred rather than canonical completed architecture:

- fixed local account and device placeholders as production identity;
- authentication and authorization;
- TypeScript API and Neon/Postgres implementation;
- actual upload/download synchronization and cursor convergence;
- central Product catalogue identity;
- general schema migration, downgrade, and corruption recovery;
- Store branch/location identity and deduplication;
- Product-code editing, aliases, retirement, and reuse;
- Purchase editing/deletion;
- Android/iOS validation and public release;
- PySide6 retirement.


# 19. Sprint 05 Accepted Android and Local Device Boundaries

## 19.1 Android host boundary

Android is a platform host for the shared Flutter client:

```text
Android application host
→ Flutter entrypoint and asynchronous composition
→ presentation
→ application commands/query ports
→ platform-independent Dart domain
→ local repository adapters
→ Drift application-private SQLite
```

Kotlin and Android configuration own package hosting, launch metadata, system integration, and build inputs. They do not own Product, Purchase, Event, Device sequence, analytics, repository transactions, or synchronization semantics.

The stable Android application ID is `com.gusigu.markei`; it owns installation/update identity and application-sandbox continuity. The visible label is `Markei`. Neither is an Account, Device, Product, Purchase, Event, or signing identity.

Compile/target SDK, NDK, Java, Gradle, emulator, and Android Studio versions are Operational build configuration. Controlled pinning does not become canonical domain architecture.

## 19.2 App-private Device identity

One app-private local database owns one Device UUID v4 for the current prototype installation and the sequence ledger attached to that Device row.

Stable rules:

- Device identity is created before event-producing commands are composed;
- it is persisted and reused across ordinary close/reopen;
- separate fresh databases receive distinct identities;
- it is not derived from hardware, platform name, application ID, Account, email, or cloud identity;
- it is not presentation-owned or user-editable;
- sequence allocation remains attached to its Device row and inside the Purchase transaction;
- uninstall/data-clear may remove Device identity with the local database;
- historical Device rows and their event ownership are not destructively rewritten.

The Account remains the provisional `local-account` placeholder. Correcting Device identity does not implement authentication or multi-account ownership.

## 19.3 Schema and historical ownership

Sprint 05 required no Drift schema migration. Existing schema v2 already models Device ID, Account ownership, next sequence, creation time, and event uniqueness by Account/Device/sequence. Architecture changes require schema changes only when persisted responsibilities or invariants cannot be represented safely by the existing schema.

Historical non-UUID Device rows remain valid historical persistence facts. They are not silently converted or selected as the prototype’s new Device, because conversion could detach prior sequence/event meaning from its original identifier.

## 19.4 Prototype selection versus future invariant

The implemented repository scans the first 20 Account Devices ordered by creation time and reuses the earliest UUID v4. This is accepted only as a bounded single-installation prototype heuristic; it is not canonical multi-device selection behavior.

Before synchronization or realistic multiple-Device history, the local model must explicitly identify the current installation’s Device:

```text
one local installation identity record
→ references exactly one Device row
→ bootstrap is idempotent under concurrency
→ sequence ledger belongs to that selected Device
→ historical Devices remain independently addressable
```

The physical table/constraint design and migration are not accepted yet. They require evidence about device registration, account transition, restore/reinstall, concurrent bootstrap, and synchronization semantics.

## 19.5 Functional scaffold and evidence boundary

`SafeArea` and the staged Purchase total are bounded functional-scaffold decisions. They improve inset safety and workflow observability without accepting a final design system, navigation model, state-management framework, accessibility treatment, or visual language.

Validated Android evidence is limited to debug APK build, one API 36 emulator launch/install, application-sandbox database observation, Device bootstrap, and human-confirmed Purchase registration. Phone-width widget tests validate the tested layout/workflow only.

Keyboard, Back, rotation, background/resume, larger text, full lifecycle recovery, physical devices, accessibility, production signing/release, and final visual quality remain partial, host-unvalidated, blocked, or deferred. A supplemental Android pass may close a bounded lifecycle/ergonomics checklist. Broad UI/UX formalization remains a separate future sprint.

## 19.6 Preserved transition

Windows Flutter build and Python regression evidence remain intact. The ordinary Cycle 06 database remains isolated and PySide6 remains recoverable. Android enablement does not authorize synchronization, authentication, cloud storage, import, iOS implementation, or PySide6 retirement.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


---

# 20. Intermid Cycle Accepted Staged-Item Edit Boundary

## 20.1 Presentation-local edit identity

A staged Purchase line has distinct presentation and domain-bearing responsibilities:

```text
line key
    presentation list/edit identity

ProductReference
    Product identity/reference carried by the staged Item

Product label
    presentation text associated with that retained reference

editable Item values
    package count, purchased quantity/unit, and line total
```

When a line enters edit mode, `PurchasePage` owns the line key, original `ProductReference`, and original Product label as one presentation-local edit state. Saving an edit rebuilds only the `PurchaseItemDraft` values from editable controls and reuses the retained reference and label. It must not reconstruct Product identity from visible Product fields, current dropdown selection, similarity results, or a replacement Product draft.

This responsibility applies polymorphically to `ExistingProductReference` and `NewProductReference`. Direct regression evidence currently covers the existing-Product variant. The new-Product variant is supported by the common `ProductReference` state and save path but lacks its own dedicated regression.

## 20.2 Edit-state lifecycle

Associated edit state is cleared coherently after:

- a successful staged-line save;
- removal of the line currently being edited;
- successful Purchase registration.

A failed registration retains the staged draft under the existing session-lifetime boundary. Product dropdown selection is not the owner of staged-line Product identity.

The correction is presentation-local and does not change application ports, domain identity types, local repository transaction ownership, Drift schema v2, migration behavior, composition, or navigation.

## 20.3 Evidence boundary

The existing-Product regression verifies that editing Item values and registering retains the original Product ID and does not create a duplicate Product. Recorded materialization evidence comprises 7 focused widget tests, 32 total Flutter tests, and clean Flutter analysis. This is local widget/in-memory behavior evidence, not platform, file-backed restart, migration, manual, release, or synchronization acceptance.

## 20.4 Separate unresolved decisions

The edit correction does not decide or imply:

- schema v3 contents or migration strategy;
- Store normalization, branch identity, aliases, or merge policy;
- durable registration-attempt identity or `SubmissionId`;
- installation–Device ownership and lifecycle;
- persisted Purchase drafts;
- query indexes, pagination, or analytics caches;
- backup/export/restore identity;
- authentication, API/Neon, upload/download, convergence, or synchronization.

These remain independent Design decisions with separate evidence, reversibility, and migration consequences.

---
<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline. This section is the promoted current Cycle 09 architecture.

# 21. Cycle 09 Sprint 02 Promoted Architecture

## 21.1 Dependency and evidence boundary

```text
adaptive Flutter shell/pages/components
→ application ports, read models, typed failures and pure calculations
→ independent Dart domain identity/quantity semantics
← local repository adapters
→ handwritten Drift schema v4 / app-private SQLite
```

This preserves offline-first inward dependency direction and the protected Python/PySide6 application/database. Widgets consume application models, not Drift rows. Handwritten schema/migrations control physical truth; generated Drift is derived evidence. The controlling implementation range is `5ddff3c…1d81797`; J records host/manual limits.

## 21.2 Schema v4 and identity

Schema v4 is implemented with tested v1/v2→v4 migration and reopen boundaries. People and Payment Methods retain opaque UUID PK/FK identity and gain immutable Account-scoped visible codes: `@001…` and `#001…`. `AccountPreferences` owns transactional next counters; allocation includes archived rows, never reuses a code, and Account-scoped uniqueness is physical.

Product visible codes are mandatory, normalized, Account-scoped unique and immutable at application/repository boundaries. V4 rebuilds the Product table with non-null display and normalized code columns; missing/blank legacy values receive deterministic reserved `legacy:` codes. Product UUID, visible code, exact normalized identity, similarity and operation idempotency remain distinct.

Person and Payment Method Purchase references remain optional; restrictive FKs and archive-safe labels preserve historical resolution. Active-only nickname uniqueness is no longer a physical database key; repository behavior owns the active collision rule.

## 21.3 Purchase occurrence and BULK pricing

Presentation accepts exact local `dd/mm/yyyy` and `HH:mm` text. The application parser validates the civil value and converts it to the one persisted UTC occurrence instant. No occurrence schema expansion was introduced; DST repeated-hour provenance remains outside this boundary.

For BULK, the user enters amount and price per the same selected unit (`kg`, `g`, `L`, `ml`, or `un`). Application fixed-point arithmetic derives the read-only line total in integer minor units with explicit half-up rounding. Persistence remains amount/unit plus one authoritative line total; no competing price-per-unit fact is stored. Null package count continues to mean not applicable.

## 21.4 Lookup, projections and interactions

Exact Product-code lookup flows presentation → application port → repository and may autofill immutable Product facts. It does not add a Purchase Item automatically. Catalogue substring search remains a browsing convenience, while exact resolution is explicit in Purchase.

Storage/Shortage/Market/All remain rebuildable `personal-cycle-v1` projections from a Product-first left-joined query. Products without history remain visible. The read model distinguishes insufficient observations, but the current Lists page still omits the target relational table/card/filter hierarchy; no List aggregate or cache is persisted.

Compact navigation now exposes Home, Lists, Purchase, History and More while the expanded rail remains. Catalogue tap selects and explicit View details opens the bounded detail surface. History retains checkbox/tap multi-selection and select-all, but desktop double-click focuses details instead of toggling selection; this contradicts the controlling selection contract and remains open. Shared adaptive Product details remain partial.

## 21.5 UI materialization state

`markei_theme.dart` is a small Material foundation, not a complete token system. `MarkeiCard`, `MarkeiStatePanel` and `MarkeiStatusChip` exist but pages do not consume them. Home and Lists were not materially rebuilt; Catalogue and History remain primarily standard list composition; Purchase has functional additions inside its former long form.

Target images 01–05 remain directional evidence. Visual parity, complete responsive composition and accessible state/action hierarchy are not achieved. Approximate current page sizes—Purchase 1,020 lines, Catalogue 377 and History 330—exceed the ordinary ~250-line modularity guidance and make a broad rewrite unsafe.

## 21.6 Export, validation and next bounded unit

Deterministic CSV/PDF bytes and temporary-file save behavior remain non-mutating. No native-share dependency or OS share adapter was adopted.

Automated evidence supports schema/migration and focused Flutter contracts. Android runtime, native sharing, complete manual accessibility, target-image parity, Windows workflow acceptance and release readiness remain unvalidated.

Pending Main authorization, the next schema-free Design unit is: expand tokens/primitives; make pages consume them; recompose Home, Lists and Catalogue; split/recompose Purchase; recompose History and resolve double-click; then compare expanded/compact screenshots and validate Windows/accessibility. This direction is prospective, not implementation authority.

---

<!-- TEMPORAL_MARKER:C10-RECOVERED-PROMOTION-2026-07-15 -->
# 22. Cycle 10 Local Synchronization and Provider Boundary

## 22.1 Durable topology

```text
Flutter presentation
→ application synchronization/authentication ports
→ domain facts and typed protocol contracts
← Drift and HTTP infrastructure adapters
→ Fastify authentication/authorization boundary
→ PostgreSQL runtime transactions
```

Flutter owns no PostgreSQL credential, signing key, Auth0 management credential or native-client secret. Fastify verifies an external principal before Account-scoped work; PostgreSQL owns persistence and constraints. Fixture authentication is confined to tests and local lab composition and is absent from the hosted entrypoint.

The provider-free implementation keeps external subject, Account membership, InstallationId and server DeviceId separate. Forward-only migration 004 adds external identities, memberships, Device enrollments, idempotent enrollment requests and audit state without modifying migrations 001–003. Drift schema v7 adds local hosted-identity/enrollment state while preserving facts, queues, cursors and recovery state.

## 22.2 Authority and evidence boundaries

Direct migrator access owns schema materialization and fixture provisioning. A separately constrained, pooled-intended runtime identity owns application transactions only. MCG-01 manually demonstrated this separation in a disposable Neon development environment, including TLS, rollback, runtime CRUD and runtime DDL denial. It did not prove migration 003/004 application, pooled RLS, deployment or production behavior.

JWT verification remains behind a server port. The local implementation pins RS256 and validates configured issuer, audience and key selection; Markei owns membership, Account selection, enrollment and revocation meaning. However, source reconciliation did not establish that membership, enrollment and Device authority are rechecked inside the same transaction as every protected sync/recovery operation. Hosted-readiness promotion is therefore rejected.

Auth0 and Render dashboard preparation is partial evidence only. Separate Android/Windows public Native Applications, a custom API/audience and a Render service form were prepared without an authorized native secret. No Render deployment, Neon migration, real login/token acceptance, enrollment or hosted synchronization proof occurred.

Manual provider observations become durable only through sanitized evidence, explicit exclusions, Main PRC-01 reconciliation and domain-owned promotion. Tenant/application identifiers, callbacks, fingerprints, hostnames, URLs, credentials and tokens stay outside permanent memory.

```text
C10-S03A_CONTRADICTED_STOP
MCG-02_HOSTED_PROOF_NOT_PERFORMED
```
## 22.3 Historical supersession marker

Section 22 and its terminal `C10-S03A_CONTRADICTED_STOP` are preserved as
the historical recovered stop state that preceded the later convergence
evidence. Section 23 supersedes that terminal for current Cycle 10 architecture,
but only within the accepted two-Device, one-Account development boundary.

This supersession does not accept production, multiple-Account isolation,
membership disablement, Device revocation, outage or acknowledgement-
uncertainty resilience, retention, snapshot/rebootstrap, GCM04 or R07. Those
boundaries remain unaccepted or deferred exactly as stated in section 23.9.

---

# 23. Cycle 10 Accepted Coordination and Convergence Architecture

Evidence boundary: `documentation/REC_LEGACY.md` Records 009–021 and
Appendix I; `documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md`
mutable-prefix sections 2–5.4 and 8; protected J `Legacy_Progress` GCM02,
GCM03 and R03–R05 lineage. The accepted terminal is development-only:

```text
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=CLOSED_TWO_DEVICE_DEVELOPMENT_SCOPE
MVP_SYNC_ACCEPTANCE=PASS_TWO_DEVICE_ONE_ACCOUNT_DEVELOPMENT_SCOPE
PRODUCTION_ACCEPTANCE=ABSENT
```

## 23.1 Local and hosted authority

Each client installation's app-private SQLite database is autonomous Product
and Purchase truth. It owns local catalogue identity, Purchase aggregates,
Device sequence allocation, immutable local event creation, queue state,
downloaded-event application, local cursor progress and rebuildable local
projections.

The hosted service is a bounded Account-scoped coordination channel. It owns
authentication/authorization enforcement, idempotent submission acceptance,
Account-ordered event materialization, download cursors and Device
acknowledgements. It is not:

- Product authority;
- a permanent analytics store;
- a general client backup;
- a replacement for local ownership.

Stable dependency direction:

```text
Flutter presentation
→ application commands and Sync/authentication ports
→ domain facts, identity and protocol contracts
← app-private Drift/SQLite and HTTP adapters
→ authenticated hosted API
→ constrained PostgreSQL runtime transactions
```

Presentation and diagnostics do not reconstruct transaction truth. The hosted
provider does not own local analytical interpretation.

## 23.2 Account, membership, Installation and Device

The identity roles remain distinct:

| Identity | Stable responsibility |
| --- | --- |
| External principal | proves authentication subject only |
| Account | owns the synchronization and data-sharing scope |
| Membership | authorizes a principal within an Account and carries membership lifecycle |
| Installation | preserves app-local installation continuity and the selected binding |
| Device | enrolled Sync actor authorized for one Account; owns one monotonic creation sequence and acknowledgement progress |

A Device is not derived from hardware identity, Product data, email or a UI
label. Authentication alone does not imply membership, enrollment or Device
authorization. Protected hosted operations depend on current Account,
membership and Device authorization, not merely on possession of a previously
accepted subject.

Evidence pointer: REC 008–009 and 014–017; J section 3 and the S07/S08
`Legacy_Progress` entries.

## 23.3 Product and protocol identity

Product identity has four non-interchangeable roles:

| Identity | Responsibility |
| --- | --- |
| Versioned natural Product identity | exact semantic reconciliation selector |
| User-visible Product code | local Account-scoped display and exact-lookup identity |
| Local Product UUID | local persistence and foreign-reference identity |
| Event/submission identity | immutable retry/idempotency and protocol-order identity |

During remote apply, exact compatible natural identity may select an existing
local Product even when sender and receiver use different local codes and
UUIDs. Remote Purchase references map to the selected local Product UUID.
Historical local identifiers and observations are not rewritten. Fuzzy
similarity remains advisory and cannot merge automatically.

Evidence pointer: REC 018–021; J R03–R05 corrective entries and section 3.

## 23.4 Append-only event and submission responsibility

Local Purchase registration owns one transaction that persists the Purchase
aggregate, required local references, one immutable `purchase.registered`
event, its Device sequence and pending queue entry. Network work occurs only
after that commit.

The hosted service accepts submissions idempotently and materializes immutable
Account-ordered Sync events. Retry reuses stable event/request identity and
must not create a second Purchase event. Device sequence orders local creation
by one Device; Account cursor orders hosted delivery. Neither is a count of UI
actions or diagnostic rows.

Evidence pointer: REC 010–012, 019 and 021; J sections 3 and 5.4.

## 23.5 Transaction partition and diagnostic containment

The following are distinct causal boundaries:

1. local event creation and enqueue;
2. upload lease;
3. trusted provider submission result persistence;
4. download response acceptance;
5. downloaded-event local apply;
6. local cursor commit;
7. Device acknowledgement;
8. diagnostic persistence and presentation.

A failure in diagnostic persistence cannot reverse or redefine an already
committed causal boundary. A trusted authenticated/parsed provider response
remains true when a later local apply, diagnostic write or runner terminal
fails. Each transaction records its own mutation/result state; one cumulative
field must not collapse independent transactions.

Evidence pointer: REC 019–020; J post-Codex R03, R04 and R05 entries.

## 23.6 Apply, cursor and acknowledgement ordering

Downloaded events and the resulting local cursor progress commit together.
Acknowledgement may be sent only after that durable local commit. If apply
rolls back, the cursor does not advance and acknowledgement does not begin.
Duplicate-equivalent local apply is an idempotent success classification only
when the required local fact and cursor outcome are durable.

```text
trusted download
→ reconcile/map local identities
→ apply local facts
→ commit local cursor progress
→ acknowledge Device progress
```

Evidence pointer: REC 019–021; J section 3 and R03–R05 entries.

## 23.7 Development convergence topology

Two topology claims remain separate:

- **GCM02:** one enrolled Device proved local/client, hosted API/Render and
  provider agreement for the same-Device path.
- **GCM03:** two enrolled Devices under one Account proved reciprocal
  Windows-to-Android and Android-to-Windows convergence, exact natural Product
  reconciliation, no observed duplicate Product/Purchase, drained queues and
  one idempotent no-op repeat per Device.

Hosted readiness, enrollment, an empty queue, one successful Device or a no-op
operation does not independently prove reciprocal convergence.

Evidence pointer: REC 009–012, 013–017 and 021; J sections 2 and 3.

## 23.8 Diagnostic ownership

Diagnostic ownership is singular and directional:

```text
contracts/shared_beta/diagnostics_v1/diagnostics.registry.json
→ schema/generation contract
→ documentation/ERR_DIAGNOSTICS.md readable projection

runtime evidence
→ sanitized REC_LEGACY.md chronology
→ Design/Operational/Didactic interpretation

J Legacy_Progress
→ historical investigation provenance only
```

REC, J history, generated documentation, Audit UI and permanent domain memory
must not become independent diagnostic registries or causal engines. Audit may
project runtime-owned evidence; Settings may configure behavior; Analytics may
interpret local/account-scoped Product facts. None may reconstruct Sync truth.

Evidence pointer: REC Appendix I; J section 4.

## 23.9 Explicit evidence ceiling and deferred boundaries

Cycle 10 accepts only the one-Account/two-Device development topology described
above. It does not accept:

- multiple-Account isolation;
- membership disablement;
- Device revocation;
- outage, timeout or acknowledgement-uncertainty recovery;
- retention;
- snapshot or rebootstrap;
- production deployment or lifecycle;
- GCM04;
- R07.

GCM04 and conditional R07 reassessment remain deferred to C12-PHASE02. Their
alternatives and reversibility remain open; no Cycle 10 result preselects a
production lifecycle or resilience design.

Evidence pointer: REC 021 and Appendix I; J sections 2, 3, 5.4 and 8.

# 24. C11-PH01-S01 Responsive Presentation Architecture

Evidence boundary: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`
at materialization head `1c7df53c095f4e7c1d85f278ba16c21fd95b25e6`
and the C11-PH01-S01 capsule in the mutable prefix of
`documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md`. The topology is
implemented, test-validated and Windows/Android build-validated. Human Windows
and Android visual acceptance, pixel parity and golden-policy acceptance are
absent.

## 24.1 Destination identity and retained composition

Navigation selection is owned by stable enum/ID destination identity rather
than positional array indexes. One destination registry supplies compact,
medium and wide navigation policies. Selection therefore survives responsive
layout changes and feature-gated destination insertion or removal.

Retained page state remains owned by application-level `IndexedStack`
composition with stable children. Navigation identity does not become domain
identity, and presentation layout does not own page data or business state.

## 24.2 Responsive shell policy

The accepted presentation layout classes are:

| Layout | Width | Shell policy |
| --- | --- | --- |
| Compact | `<600` | bottom navigation plus a More surface |
| Medium | `600–1023` | icon rail with tooltips |
| Wide | `>=1024` | extended labelled rail and bounded content canvas |

The shell owns layout-class resolution, destination presentation and responsive
content framing. It does not query repositories, translate provider state,
reconstruct Sync truth or alter domain/application commands.

## 24.3 Visual foundation ownership

Theme tokens and shared presentation primitives own presentation semantics:
color, typography, spacing, radius, breakpoints, content framing, cards,
headers, summary surfaces and visible loading/empty/error states. They are not
sources of Product, Purchase, Account, Sync, diagnostic or recovery truth.

Home consumes static application descriptors and navigation callbacks through
this foundation. Lists consumes the same foundation without moving its data
boundary into presentation.

## 24.4 Lists projection and retry boundary

`ProductListProjectionRepository` remains the Lists data boundary. One
projection result feeds page-local search and sort state; wide tables and
compact/medium cards are alternative presentations of the same filtered and
sorted projection.

Lists Retry repeats only the local read request. It owns no mutation, upload,
download, acknowledgement, recovery or Sync orchestration. Loading, read error,
first-use empty, filtered empty, insufficient-history and populated states are
presentation classifications over repository-owned facts.

## 24.5 Reserved and unchanged boundaries

Analytics and Audit destination identities are reserved without activating
C11-PH02 Analytics or C11-PH03 Audit behavior. Settings and Closure
implementations remain unchanged; Closure relocation or disposition remains
C11-PH03 work.

Purchase, Catalogue, History, business, Sync, diagnostics and recovery
responsibilities remain with their existing application/domain/infrastructure
owners. Catalogue, History and Purchase visual convergence is unfinished.
Analytics functionality is PH02; Settings/Audit completion and Closure
relocation are PH03.

## 24.6 Reversibility and evidence ceiling

The responsive shell, destination registry and shared presentation foundation
are schema-free presentation structures. They may be replaced without changing
domain identities, repository contracts, local persistence or hosted protocol
topology, provided stable destination semantics and retained page-state
behavior are preserved.

Accepted only:

- implemented presentation topology;
- named automated test evidence;
- Windows release and Android debug build evidence.

Not accepted:

- human Windows or Android visual quality;
- accessibility or real screen-reader behavior;
- pixel parity or a golden-test policy;
- completion of all five PH01 core pages;
- PH02/PH03 behavior;
- production, resilience, GCM04 or R07.

# 25. C11-PH01-R01 and C11-PH02 Local Analytics Architecture

Evidence boundary: implementation commit
`20e3d5f6c2f973d138e3b2680aa8adf96f17d0b6`, complete
`DEV_STAGE/I_DSN_CODEX.md`, J section 9 at
`0bfc02e8363d8119469a5e8627d8350fa97790b4`, and the named source/tests.
The topology is implemented and validated only at the automated/build ceiling.
Screenshot, assistive-technology, locale, real-device and human acceptance are
host-unvalidated.

## 25.1 Authority and dependency direction

Analytics interprets autonomous local Product and Purchase facts for the active
Account. Hosted coordination, Sync events, provider state, diagnostics and
external facts are not Analytics authority.

Stable dependency direction:

~~~text
Analytics presentation
→ application workspace + read port + typed launch context
→ Analytics domain models + versioned operation registry
← local Account-predicated joined repository adapter
← app-private SQLite Product/Purchase truth
~~~

Infrastructure maps persisted facts into domain evidence; it does not own
calculation semantics. Presentation renders state and callbacks; it neither
queries repositories nor calculates results.

## 25.2 Domain identity, evidence and result ownership

`analytics_models.dart` owns:

- `AnalyticsEvidenceRowId` as persisted `PurchaseItemId`;
- Account-scoped evidence rows and complete datasets;
- determinant, variable, condition and evidence-scope types;
- stable card identity, revision and configuration;
- compatibility keys, money/unit-price values and typed result envelopes;
- unavailable classifications for insufficient, incompatible,
  zero-denominator and overflow outcomes.

Evidence rows retain Purchase identity separately from row identity. Line total
belongs to one Purchase Item row. Purchase total belongs to the Purchase and is
deduplicated by distinct Purchase identity before aggregation. Result envelopes
retain the registry identifier/version, configuration, contributing evidence
IDs, eligible/total/excluded counts, UTC period and factual interpretation
inputs.

## 25.3 Versioned operation semantics

The registry is the single executor authority for:

| Definition | Accepted v1 boundary |
| --- | --- |
| `local.sum@1` | sums compatible quantity, Line total, Purchase total or item-row evidence count |
| `local.mean@1` | integer/fixed-point mean per contributing item row, or per distinct Purchase for Purchase total |
| `local.difference@1` | compatible aggregate for comparison B minus baseline A |
| `local.percentage@1` | part of a named containing whole in basis points |

Compatibility keys prevent implicit mixing of currencies, measurement kinds or
canonical units. Multi-variable cards return independent typed values; no
composite score is inferred. Checked integer operations produce typed overflow
outcomes rather than wrapping or switching to floating point. Percentage with a
zero denominator produces a typed unavailable result.

## 25.4 Application workspace and lifetime

The application layer owns `AnalyticsEvidenceRepository`,
`AnalyticsLaunchContext` and `AnalyticsWorkspaceController`. The workspace
owns the complete session dataset, UTC/field conditions, selected and focused
evidence, ordered card configurations, results, 100-row rendered pages and the
500-ID selected-scope cap.

Cards and configurations are session-local, not serialized, persisted or
synchronized. Editing preserves card identity and advances its revision;
reordering and removal mutate only session state. One controller supplies all
responsive projections so compact/wide changes do not fork calculation,
selection or result truth.

## 25.5 Joined local read and request invariant

`LocalAnalyticsRepository` owns one Account-predicated join across Purchase
Items, Purchases, Products, Stores, optional People and optional Payment
Methods. It materializes stable item evidence and derives unit price using
canonical fixed quantity only when quantity is positive.

The accepted request invariant is:

~~~text
initial visible Analytics load = 1 complete joined request
each explicit Retry            = +1 complete joined request
filter / selection / execute / focus / reset / reorder = +0 requests
~~~

This prevents N+1 reads and History's 50-row projection from becoming Analytics
authority. A later incremental strategy is deferred unless it preserves
complete counts, focus, traceability and the same application port boundary.

## 25.6 Composition, visibility and History handoff

`MarkeiComposition` supplies the local adapter, registry and session workspace.
`MarkeiApp` owns destination selection, visible-destination state and typed
History-to-Analytics launch context. Analytics loading begins only when the
retained destination becomes visible; hidden shell children do not eagerly own
local database work.

History owns selected `PurchaseId` values and invokes a typed handoff only.
The app switches destination and passes the active Account plus immutable
Purchase IDs. Analytics resolves item evidence and calculates later. History
does not import the registry, workspace or local Analytics adapter.

## 25.7 Presentation and unchanged boundaries

`AnalyticsPage` and `analytics_components.dart` own cards, matrix
presentation, disclosure, loading/error/empty states and callbacks only. Cards
remain above the supporting evidence matrix; wide and compact layouts project
the same workspace state and stable evidence identities.

PH01 Purchase, Catalogue and History corrections inherit the accepted shell,
theme and responsive system. No schema, migration, generated source,
dependency, API, Auth, Sync, provider or diagnostic boundary changed. Analytics
does not own fact repair, forecasting, recommendations, rankings, charts,
telemetry or external knowledge. PH03 retains Audit, Settings and Closure
disposition.

## 25.8 Evidence and acceptance ceiling

Accepted as implemented and validated within the named repository/host scope:

- focused Analytics, workspace, repository, handoff and presentation tests;
- full Flutter suite: 258 tests with four lab-gated skips;
- `flutter analyze`;
- Windows release and Android debug builds;
- ordinary 1,000/5,000 and stress 10,000/50,000 Purchase/Item fixtures;
- deterministic lifecycle correction and no remaining validation-owned
  Dart/Flutter/SQLite process observed.

Host-unvalidated and still required for human acceptance:

- screenshot-based rendered review;
- Narrator, TalkBack and other assistive-technology review;
- keyboard-only acceptance;
- locale behavior;
- real Windows and Android device review;
- human visual and comprehension acceptance.

These limits do not contradict the accepted responsibility topology, but they
prevent broader presentation, accessibility or device acceptance claims.

# 26. C11-PH03 Settings, Audit and Closure Architecture

Evidence boundary: implementation commit
\`0924e743931ea7aba2c9cc5d2e28063e737b2ff5\`, complete
\`DEV_STAGE/I_DSN_CODEX.md\`, J section 11 at
\`33dc1002b4a7b00fa67e863dfe98a43c97d66cee\`, and the named PH03 source and
tests. The topology is implemented and validated at the automated/build ceiling.
Bounded human UI verification is accepted for continuation; broader human and
platform evidence remains host-unvalidated.

## 26.1 Audit authority and dependency direction

Audit presents recent sanitized local activity history for one Account and
environment. It is not Purchase History, current Sync status, hosted
observability or causal authority.

~~~text
Audit page/widgets
→ page-session AuditController
→ AuditReadPort
→ DriftClosureDiagnosticsRepository
→ existing SyncAttempts + SyncDiagnosticEvents
→ generated diagnostic registry as read-only safe meaning
~~~

Presentation renders state and callbacks only. The controller owns local load
state and lifetime. The read port owns the bounded application request.
Infrastructure maps existing persisted facts. The generated registry supplies
safe diagnostic meaning without becoming a ledger or being regenerated.

## 26.2 Identity, ordering and paging invariants

Persisted Sync attempt ID is \`AuditAttemptId\`; persisted diagnostic event ID
is \`AuditEventId\`. Display order, registry code and correlation reference are
not identities.

Attempts order by UTC \`startedAt\` descending and persisted ID descending.
The exclusive composite cursor \`(startedAtUtc, attemptId)\` preserves stable
paging when timestamps are equal. Child events order deterministically within
their selected attempts.

Each page performs exactly:

~~~text
1 Account/environment-predicated attempt query
+ 1 child-event query constrained to selected attempt IDs
= 2 local queries
~~~

The default page size is 20 and the hard maximum is 50. Audit performs zero
network calls and zero writes. Retry repeats the same local read; it does not
trigger Sync, recovery or provider contact.

## 26.3 Scope and sanitization invariants

Account and environment are mandatory request predicates. Device attribution is
shown only when supported by persisted evidence; Audit does not infer the
current Device for records that lack it.

The projection exposes allowlisted typed fields and safe registry meaning.
Tokens, credentials, raw payloads, SQL, stack traces, private URLs, complete
hashes, raw exceptions and sensitive identifiers do not cross the presentation
boundary. An unknown registry code yields bounded unavailable meaning rather
than raw technical content or an invented cause.

## 26.4 Controller and responsive lifetime

One \`AuditController\` owns idle, loading, ready, empty, stale and unavailable
state for the page session. The first load is visibility-gated inside the
retained \`IndexedStack\`. A monotonically increasing generation suppresses
stale asynchronous completions; disposal invalidates pending completions.

Wide, medium and compact navigation reach the same Audit destination and
controller. Layout changes do not create another repository, controller or
historical truth. Local Retry is explicit and manual; Audit owns no timer,
stream, listener, background refresh or automatic recovery.

## 26.5 Settings capability boundaries

Settings retains the existing \`LocalReferenceRepository\` and
\`AccountPreferenceRepository\` responsibilities for Account-scoped People,
Payment Methods and shortage threshold. Persisted values are loaded before
editing; validation, save/archive refresh, local failures and duplicate-action
blocking remain Settings behavior.

Account and Sync/Device sections depend on capability-narrow
\`SettingsAccountSupportPort\` and \`SettingsSyncDeviceSupportPort\`.
Composition adapters may delegate to existing Auth, enrollment and Sync
behavior, but presentation does not own those contracts or reconstruct their
truth. Raw diagnostics, hosted probes, recovery, delete-history and provider
maintenance are not ordinary Settings capabilities.

## 26.6 Closure disposition

Closure is not an ordinary destination. It is absent from destination identity,
wide/medium navigation, compact More and the ordinary page map, independent of
the former feature flag.

Existing \`NativeClosurePage\`, \`NativeAuthClosureRunner\`, diagnostic tables,
registry and focused development tests may remain as unreachable
development/support infrastructure where already present. This retention does
not grant product visibility, Audit authority or new lifecycle meaning.

No Closure capability is silently duplicated:

| Capability class | Accepted owner/disposition |
| --- | --- |
| local preferences and references | Settings |
| current Account, Device and Sync readiness/actions already supported | Settings through narrow ports |
| recent sanitized attempt/event history | Audit |
| local Audit Retry | Audit controller/read port only |
| broad probes, raw diagnostics, recovery, delete-history, provider maintenance | outside ordinary UI; development-only where retained |
| Closure product destination | retired |
| former R07 causal/backend engine | deferred and not implemented |

## 26.7 Composition, rollback and unchanged boundaries

\`MarkeiComposition\` owns one Audit controller and the app-private database.
Its close path is idempotent, disposes the controller, and closes the database
once. Audit widgets and Settings widgets do not own infrastructure disposal.

The rollback boundary is implementation parent
\`256ee4dbbcb790419b816862ee42933a115ddd87\`. Reverting the single PH03
implementation commit restores the prior navigation and composition without a
schema, data, generated-source or dependency rollback.

PH03 changes no schema, migration, generated source, dependency, lockfile,
API/Auth/Sync/provider contract, diagnostic registry or Analytics behavior.
It does not authorize GCM04, R07, hosted Audit, provider observability,
multiple-Account work, Device revocation, retention or rebootstrap.

Minor UI polish is deferred to C12-PH01 without reopening these responsibilities
or dependency boundaries. Screenshot-set, assistive-technology, locale,
real-device, keyboard-only, learner-comprehension and human architecture
acceptance remain host-unvalidated.

# 27. C11-PH05 Export, Selection, Guide and Projection Architecture

Evidence boundary: implementation commit
`426235d8b67ac719e494b53cfb23a6c3b06fb489`, complete
`DEV_STAGE/I_DSN_CODEX.md`, J section 14 at
`e6ced7fe3945925bf5f314ee11c4538029e18d44`, and the named handwritten source
and tests. These rules are accepted as implemented at the automated/build
ceiling; the Guide deviation and Analytics defect below limit broader
acceptance.

## 27.1 Export dependency direction

~~~text
History / Analytics presentation
→ pure CSV/PDF builders
→ ExportDestinationPort
← composition-injected LocalExportDestination
→ one explicit collision-safe final file write
~~~

`ExportDestinationPort` is the single application boundary for export
destination effects. Builders own deterministic content and do not select
directories or write files. The adapter owns platform availability, safe
filename construction, collision avoidance and the final write. A successful
explicit export performs exactly one final write.

Windows Downloads uses the existing dependency boundary. Android public
Downloads is a typed unavailable outcome with zero writes. App-private or
temporary storage must not be represented as public Downloads. Shared-document,
native-sharing, MediaStore or document-provider work requires separate
platform authority.

## 27.2 History export and identity invariants

For a non-empty selected set, History export performs one set-based
Account-scoped joined Purchase read and one set-based joined Item read. It
performs zero database writes and zero network calls. Purchase identity controls
deduplication; Item identity controls contained line evidence.

History owns one stable `Set<PurchaseId>` for selected-for-action state.
Detail focus remains a separate optional `PurchaseId`. Final uncheck and clear
may produce the empty set; filters and refresh intersect selection with the
currently loaded Account-scoped result; sorting and breakpoint changes preserve
identity. Checkbox action never implies detail activation.

History hands only Account scope and immutable Purchase IDs to
`AnalyticsLaunchContext`. Analytics owns Item-evidence expansion and later
calculation. Navigation performs no calculation, persistence, export or
Purchase mutation.

## 27.3 Analytics ownership and preserved boundaries

One composition-owned `AnalyticsWorkspaceController` remains the session owner.
History does not create a second controller. Record fingerprinting,
fixed-point/rational arithmetic, the versioned operation registry, Chart/Table
projection parity and schema boundaries remain unchanged.

Human runtime evidence establishes a defective variable-integrity boundary:
selected variables or operation may not control the displayed result correctly.
Root cause is unresolved. The mandatory next investigation traces draft,
validation, immutable record, grouping, operation, Chart/Table, interpretation
and CSV/PDF without presuming which layer failed.

Purchase, Product and Purchase Item IDs remain internal identities even when
UUIDs are absent from presentation. The compact composer, unified Variables
control and two custom date fields are accepted correction direction, not
implemented architecture. No second controller, new persistence owner, schema
change or calculation-semantic change is accepted without evidence.

## 27.4 Guide, Audit and Settings ownership

Guide has one local presentation owner: immutable typed sections in
`guide_page.dart`, with page-local anchor keys, focus nodes, scroll state and
disposal. It owns no repository, database, network, provider or content-service
authority.

The committed Guide has eight sections but does not fully match E section 35:
Lists has no separate learner section, while getting-started,
local-data/export and Sync-limit responsibilities are redistributed. This is a
content-contract deviation within the single owner, not justification for
another owner or infrastructure.

Audit System, Readiness summary and Diagnostics cards depend only on the loaded
bounded local `AuditPageResult`. Projection adds zero reads, writes and network
calls and cannot infer provider-wide or causal truth.

Settings retains its page-local controller/state and the existing narrow
Account, reference, preference and Sync/Device ports. Support actions refresh
local status while the duplicate-action guard remains active. No new Settings
repository, lifecycle owner or provider contract is introduced.

## 27.5 Composition, unchanged contracts and rollback

Composition injects one `LocalExportDestination` and continues to own one
Analytics workspace. Page-local Guide and Settings resources dispose within
their existing presentation lifetimes. Audit continues to project its existing
bounded controller state.

PH05 changes no schema, migration, generated source, dependency, native platform
file, API/Auth/Sync/provider contract, diagnostic registry or persisted
identity. Reverting the PH05 implementation chain to
`b59b2ecdfb69ca98c431b9f36694f011332fbef3` restores prior behavior without
data conversion or contract rollback.

Provider, real-device, assistive-technology, keyboard-only, locale, learner-
comprehension and broad human acceptance remain host-unvalidated. Android
shared-document/native-sharing integration and the Analytics corrective
materialization remain deferred.

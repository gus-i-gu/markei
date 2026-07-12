# C_DESIGN — Cycle 06

> Status: Active functional Design stage  
> Knowledge state: Staged / non-canonical  
> Authority: Design Chat [D]  
> Repository: `gus-i-gu/markei`  
> Branch: `sketch-notebook-recovery`  
> Main reconciliation: `documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md`

## Main Synthesis Summary

Markei’s accepted architecture remains a local layered desktop monolith:

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

Cycle 06 should package and install this application without redesigning those boundaries. The branch already has a thin root launcher, a canonical Qt construction function, frozen-resource path handling, an external `%LOCALAPPDATA%/Markei/market.sqlite` database, additive compatibility updates, and Windows version metadata. The live database is already architecturally separate from replaceable program files.

What is missing is a recoverable current-branch release contract: no committed PyInstaller specification, installer definition, pinned build dependency set, or startup-diagnostic implementation was identified. Historical Cycle 05 build success is useful precedent, not Cycle 06 validation.

Four decisions must be reconciled before D/E/F: production seed policy, uninstall data retention, minimum application/installer identity, and the response to distributed shutdown ownership. Design recommends: schema plus structural defaults but no sample business seed; preserve user data on uninstall; use one accepted application name/version/publisher/stable installer identity across executable and installer; validate existing shutdown first and introduce only a bounded `MainWindow`-owned correction if closure fails.

The first materialization boundary should therefore be limited to release-source configuration and beta-critical lifecycle observability: version-controlled packaging and installer definitions, synchronized identity metadata, approved resource exclusions, startup diagnostics, and only evidence-triggered shutdown correction. No service/repository decomposition, migration framework, schema redesign, or UI redesign belongs in this stage.

## Current Accepted Boundary

The accepted runtime responsibility direction is unchanged. Desktop code owns Qt presentation and refresh coordination; `ProductService` owns workflows, validation, calculations, settings interpretation, and read models; `Repository` owns SQL, mapping, commits, and connection/cursor ownership; `app.core.database` owns resource paths, writable paths, initialization, SQLite configuration, additive compatibility work, and close/reset primitives.

`main.py` is a launcher adapter. `app.main.main()` is the canonical application-construction function: it creates `QApplication`, constructs and displays `MainWindow`, and enters the Qt event loop.

Packaging and installation are deployment layers, not new application layers. They may collect, identify, install, replace, and remove program files, but must not acquire ownership of workflows, SQL, database migration semantics, or user-created state.

### Boundary consequences for Main

The application layer remains responsible for locating bundled database resources at runtime and for creating writable directories and database state. The packaging specification is responsible only for ensuring those resources exist in the frozen layout expected by the application. The installer is responsible for placing frozen files, registering identity, and preserving the chosen separation between replaceable application content and retained user data.

A same-version reinstall should replace program files without recreating or overwriting an existing database. A newer compatible beta should replace program files, reopen the existing database, and apply only the current additive compatibility operations. An incompatible future database format is not solved in Cycle 06; the beta contract is limited to fresh installation and compatible upgrade/reinstall scenarios that can be directly tested.

The current page-local service/repository arrangement is an accepted implementation fact, not a preferred packaging architecture. Freezing the application does not move object-lifetime ownership into PyInstaller or the installer. If normal Qt object destruction already closes every repository, packaging needs no lifecycle restructuring. If it does not, the narrow correction belongs in the existing desktop composition boundary, not in persistence, packaging, or installer code.

For principal workflows, responsibility remains:
- Register: desktop input and feedback; service validation/workflow; repository persistence.
- Lists: service classification/read-model assembly; desktop rendering and mode selection.
- History: service grouping/analytics read models; desktop rendering and refresh.
- Settings: service interpretation and persistence coordination; desktop editing and feedback.
- MainWindow: page composition, navigation, dependent refresh, and candidate shutdown coordination.

Packaging acceptance must therefore prove that the installed runtime preserves these responsibilities rather than merely displaying a window.

## Essential Evidence Index

| ID | File or evidence | Why it matters |
| -- | ---------------- | -------------- |
| E1 | `documentation/sketch_notebook/06_SESSION_SCHEME.md` | Defines the single installable-Windows-beta milestone and acceptance boundary. |
| E2 | `documentation/sketch_notebook/design/01_ARCHITECTURE.md` | Canonical source for current dependency and resource/user-state boundaries. |
| E3 | `main.py` and `app/main.py` | Establish the launcher adapter and canonical Qt construction function. |
| E4 | `app/core/config.py` | Declares `APP_NAME = "Markei"` and `VERSION = "0.1.0"`. |
| E5 | `app/core/database.py` | Resolves frozen resources, creates `%LOCALAPPDATA%/Markei`, initializes the database, and applies additive compatibility updates. |
| E6 | `app/database/schema.sql` and `app/database/seed.sql` | Show required schema and the mixed structural/sample contents of the current seed. |
| E7 | `app/desktop/main_window.py` plus page composition evidence | Shows MainWindow creates four pages while lifecycle cleanup remains distributed. |
| E8 | `build/markei_version_info.txt` | Declares `Markei.exe` and version `0.1.0`, but does not establish a single identity source. |
| E9 | Recovery-branch path checks and bounded branch comparison | No current committed PyInstaller spec or installer definition was identified. |
| E10 | `operational/10_OPERATIONAL_STATE.md` and `04_TODO.md` | Preserve validation debt for shutdown, resources, seed, and installed data. |

Additional inspected files: `design/09_DESIGN_STATE.md`, `design/14_MODEL_OVERVIEW.md`, `design/03_DECISION_LOG.md`, `app/core/repository.py`, `app/desktop/ui/pages/register_page.py`, `requirements.txt`, and historical packaging evidence used only for classification.

## Package and User-State Boundary

Finding:  
The frozen runtime should contain executable code, required Python/Qt runtime components, `schema.sql`, approved icons, and executable metadata. The installer should deploy that runtime and register shortcuts/uninstall identity.

Status:  
inferred from accepted architecture and current implementation

Impact:  
materialization input

Evidence:  
E2, E3, E5, E8

Finding:  
`market.sqlite`, `market.sqlite-wal`, and `market.sqlite-shm` are generated writable state under `%LOCALAPPDATA%/Markei`, not package content. Logs should also live outside installed program files.

Status:  
observed for database state; recommended for logs

Impact:  
beta blocker if packaging includes or writes them under program files

Evidence:  
E5, E10

Finding:  
`schema.sql` is a bundled read-only resource. `seed.sql` is currently conditional at runtime but contains category, store, settings, and sample Rice product data, so its production classification is unresolved.

Status:  
observed / unresolved

Impact:  
decision required before D/E/F

Evidence:  
E5, E6

Compact classification:

| Item | Cycle 06 classification |
| --- | --- |
| `schema.sql` | Bundled read-only, replaceable application resource |
| `seed.sql` | Development/fixture resource unless explicitly approved for production |
| `market.sqlite` | Retained writable user data |
| `-wal`, `-shm` | Transient writable companions; never bundled |
| logs | Generated writable diagnostic state |
| settings | Retained user data when stored in SQLite |
| icons | Replaceable application content |
| version metadata | Replaceable release identity content |

Startup diagnostics belong at the outer application entrypoint. Packaging may choose console/windowed mode, but the application must make startup failure inspectable through a writable log and, where safe, a visible error.

## Beta-Blocking Design Questions

### Decision 1

Decision:  
What data initializes a fresh production database?

Options:  
A. Bundle and execute the current mixed `seed.sql`.  
B. Bundle `schema.sql`, exclude `seed.sql`, and create structural settings defaults through application initialization.  
C. Split structural defaults from sample fixtures before packaging.

Domain recommendation:  
B for the first beta. It matches current idempotent default-setting behavior and avoids shipping a named store and sample Rice product. C is acceptable only if Main finds the split necessary for implementation clarity.

Required owner:  
Main and Human, with Operational confirmation of resulting first-launch state.

Deadline:  
before D/E/F

### Decision 2

Decision:  
What happens to `%LOCALAPPDATA%/Markei` during uninstall?

Options:  
A. Preserve all user data.  
B. Preserve by default and offer explicit removal.  
C. Remove application and user data together.

Domain recommendation:  
A for the primary beta. It minimizes accidental loss and supports uninstall/reinstall recovery. Optional removal is a future UX and safety decision.

Required owner:  
Main and Human.

Deadline:  
before D/E/F

### Decision 3

Decision:  
What minimum identity contract must executable and installer share?

Options:  
A. Continue with duplicated, manually synchronized values.  
B. Accept one semantic version, display name, publisher, executable name, and stable installer `AppId` as a coordinated release contract.

Domain recommendation:  
B. Minimum candidate: display/product name `Markei`, executable `Markei.exe`, accepted beta version derived from one authoritative value, explicit publisher, and stable installer identity retained across upgrades.

Required owner:  
Main and Human; Design defines boundary, Operational materializes tool-specific fields.

Deadline:  
before D/E/F

### Decision 4

Decision:  
Does Cycle 06 centralize shutdown ownership now or validate the current distributed model first?

Options:  
A. Validate current page-owned cleanup; change nothing if all repositories close deterministically.  
B. Immediately introduce a bounded MainWindow-owned shutdown path.  
C. Redesign service/repository lifetime through a new composition root.

Domain recommendation:  
A, with B required only if validation shows missed closure, retained locks, cleanup exceptions, or failed immediate reopen. C is outside Cycle 06.

Required owner:  
Design/Main after Operational evidence.

Deadline:  
policy before D/E/F; final correction decision during materialization if evidence fails

## Recommended Decision Candidates

The Design position for Main reconciliation is:

1. **Seed:** production uses `schema.sql` plus structural defaults; current sample-bearing `seed.sql` is excluded.
2. **Retention:** uninstall removes program files and shortcuts while preserving `%LOCALAPPDATA%/Markei`.
3. **Identity:** executable and installer share one accepted name/version/publisher/stable installer identity contract.
4. **Lifecycle:** validate current shutdown first; authorize only a bounded MainWindow-owned correction if required.
5. **Entrypoint:** package the root `main.py` adapter, which delegates to `app.main.main()`.
6. **Release topology:** prefer the already precedented one-folder frozen runtime for the first beta unless Operational evidence identifies a blocker; topology is subordinate to correct resources and lifecycle behavior.

These are staged recommendations, not canonical acceptance.

## Validation-Only Questions

| Question | Evidence needed from Operational |
| --- | --- |
| Are all four repositories closed on normal Qt shutdown? | Instrumented close evidence, no cleanup exception, immediate database reopen, removable isolated data directory |
| Are required resources correctly frozen? | Artifact inspection showing `schema.sql` present and discoverable; seed/live DB/WAL/SHM absent according to policy |
| Does installed startup work outside the build directory? | Installed Start Menu or equivalent launch with no Python command and inspectable startup failure behavior |
| Is user data preserved? | Install → write → close → upgrade/reinstall/uninstall → relaunch checks against isolated `%LOCALAPPDATA%` |
| Are principal workflows intact? | Register write; Lists and History refresh/read; Settings persistence; close and reopen with retained data |
| Is the current additive compatibility path sufficient? | Existing compatible database opens repeatedly without duplicate defaults or overwritten settings |

Multi-commit workflow atomicity remains a known product risk, but transaction redesign is not automatically a packaging blocker. Operational should escalate only if ordinary beta workflows produce unacceptable partial state under realistic failure.

## Required Beta-Bounded Changes

Finding:  
A version-controlled PyInstaller specification or equivalent build definition and a version-controlled installer definition are not currently recoverable from the branch.

Status:  
blocked configuration gap

Impact:  
required beta blocker

Evidence:  
E9

Finding:  
Startup failure is not yet owned by an inspectable outer diagnostic boundary in the current entrypoint.

Status:  
observed

Impact:  
required beta blocker for a windowed installed application

Evidence:  
E3, E1

Recommended first materialization boundary:

```text
1. Add current-branch packaging source for the root entrypoint.
2. Add installer source with accepted identity and retention policy.
3. Bundle schema and approved static resources; exclude live/transient data.
4. Synchronize application and Windows metadata from the accepted identity contract.
5. Add outer startup diagnostics using a writable user-data log path.
6. Add shutdown code only if Operational validation demonstrates failure.
7. Add only the smallest release dependency/runbook support needed for reproducible building.
```

This boundary does not authorize permanent Design-memory updates until post-materialization evidence is reconciled.

## Explicit Deferrals

Deferred outside Cycle 06: mobile, backend/API, synchronization, authentication, cloud persistence, automatic updating, production signing unless controlled beta distribution proves it blocking, rollback framework, general migration framework, schema-version ledger, broad schema redesign, major ProductService or Repository decomposition, composition-root redesign, typed view-model conversion, navigation/UI redesign, Promotion completion, `pages.order` activation, and optional uninstall data-removal UX.

## Main Handoff

Main should reconcile four decisions: seed, uninstall retention, release identity, and shutdown response. Operational should supply exact build/toolchain and validation detail; Didactic should preserve distinctions among source, frozen, installed, replaceable resource, writable state, configured, and validated.

The first F/D materialization should remain one bounded release-enablement stage: recoverable packaging and installer sources, approved identity/resource policy, startup diagnostics, and evidence-triggered shutdown correction. Acceptance requires installed lifecycle evidence, not configuration or build success alone. No D/E/F content is produced here.

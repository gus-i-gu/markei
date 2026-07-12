# B_DIDACTIC — Cycle 06 Windows Primary Beta

> Status: Ephemeral functional staging
> Role: Didactic Chat [A]
> Branch: `sketch-notebook-recovery`
> Authority: Didactic analysis for Main reconciliation
> Knowledge state: Candidate and reinforcement analysis; not canonical Didactic memory
> Single milestone: Produce and validate a fully executable and installable Windows primary beta of Markei
> Authorized reconciliation surface: `documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md`

---

## 1. Stage Status and Authority

This stage observes Cycle 06 as learning.

It identifies reusable concepts, existing concept reinforcement, terminology, dependency order, maturity, learner-check questions, and misconception risks required to understand the Windows beta lifecycle.

This file does not:

- authorize implementation;
- choose packaging or installer tooling;
- decide production seed policy;
- decide uninstall data-retention policy;
- accept architecture changes;
- promote candidates into `02_KANBAN.md`;
- modify glossary, Concept Map, Lecture Register, source, packaging, installer, methodology, or Main continuity files.

The contents below are proposals for Main reconciliation with Operational and Design reports. A candidate remains non-canonical until separately accepted, staged, materialized, and reconciled.

---

## 2. Cycle 06 Learning Objective

The developer must be able to reason accurately about this complete lifecycle:

```text
Windows installer
→ ordinary user installation
→ launchable executable
→ no development Python command
→ bundled read-only resources resolved at runtime
→ writable user data outside installed program files
→ principal desktop workflows
→ clean close
→ immediate safe reopen
→ tested data preservation
→ accepted uninstall behavior
→ primary beta acceptance
```

The central learning objective is not “how to run PyInstaller” or “how to compile Inno Setup.” It is to understand why several distinct technical states must remain separate:

```text
source configuration
≠ generated package
≠ compiled installer
≠ installed application
≠ validated lifecycle
≠ accepted release
```

The Didactic domain should support correct interpretation of implementation and validation evidence without inflating Cycle 06 into mobile, backend, synchronization, authentication, cloud, or broad architecture work.

---

## 3. Sources and Exact Files Inspected

All GitHub repository inspections were explicitly performed against:

```text
sketch-notebook-recovery
```

### Main and domain recovery surfaces

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
documentation/sketch_notebook/operational/04_TODO.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
```

### Canonical and derived Didactic state used from the loaded initialization context

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md
```

These were used only to preserve concept identity, status, terminology ownership, and identifier occupancy.

### Entrypoint, runtime, packaging, and persistence evidence

```text
main.py
app/main.py
app/core/config.py
app/core/database.py
Markei.spec
requirements.txt
```

### Historical evidence consulted only for classification continuity

```text
commit fbeef65c53eb21c6a8357ec6e74bb67d60248c22
    Add desktop packaging operational model
```

The historical commit establishes prior vocabulary and precedent evidence. It is not contemporary recovery-branch build or installed-runtime validation.

### Missing or unresolved inspection surface

A current Inno Setup source file was not located through the bounded branch-pinned path inspection available to this chat. The current checkpoints report an Inno Setup configuration and an uncompiled installer lifecycle, but this stage does not treat that report as direct inspection of the installer source. Main/Operational should provide the exact current installer path during reconciliation if it exists on this branch.

No generated package, compiled installer, installed directory, or runtime log was inspected. This stage therefore distinguishes source configuration evidence from generated or installed evidence.

---

## 4. Current Didactic Baseline

The current canonical Didactic register contains seventeen occupied concepts:

```text
&&&01–&&&04
&&%01–&&%03
&%%01–&%%05
%%%01–%%%05
```

No canonical concept is Green through explicit human learning validation.

### Current Yellow baseline

```text
&&&01  Responsibility Boundary
&&&02  Raw Data Versus Derived Data
&&&03  Naming as Data Contract

&&%01  Package and Module Boundary
&&%02  Dataclass as Structured Data Carrier

&%%01  Application Service
&%%02  Repository Pattern and Persistence Adapter
&%%03  Presentation Adapter
&%%04  Database Row, Domain Model, and View Model

%%%01  SQLite Initialization Versus Migration
%%%03  SQLite PRAGMA and Connection Configuration
%%%04  Relational Schema and Referential Integrity
%%%05  Bundled Resource Versus Writable User Data
```

### Current Red baseline

```text
&&&04  Resource Ownership and Lifetime
&&%03  Context Manager and Deterministic Cleanup
&%%05  Statement Atomicity Versus Workflow Atomicity
%%%02  SQLite Connection and Cursor Ownership
```

### Cycle 06 checkpoint candidates already named but not canonically allocated

```text
source execution versus frozen execution
packaging versus installation
build-time dependency versus runtime dependency
successful build versus validated release
application composition root and shutdown ownership
workflow transaction boundary
migration ledger and version compatibility
```

The Concept Map is correctly useful as a recovery surface, but its milestone label remains tied to the recovery cycle rather than Cycle 06. It also contains historical wording that says the Lecture Register is empty even though observational history has since been populated. These are checkpoint-staleness conditions, not reasons to alter permanent files in this stage.

---

## 5. Existing Canonical Concepts Relevant to Cycle 06

### `&&&01` — Responsibility Boundary

Supports separation among:

```text
entrypoint ownership
packaging configuration
installer configuration
bundled resources
writable state
validation evidence
release acceptance
```

Cycle 06 should reinforce that different components and actors own different meanings. A build tool can generate an artifact without deciding whether the release is accepted. An installer can remove program files without owning the policy for deleting user data.

### `&&&02` — Raw Data Versus Derived Data

Already covers the broader distinction between source facts and interpretations. It can reinforce:

```text
observed command result
vs
release-status conclusion
```

However, it does not fully teach the ordered validation states between configuration, build, installation, and acceptance. That gap motivates a separate evidence-maturity candidate rather than expanding raw/derived data beyond its current responsibility.

### `&&&03` — Naming as Data Contract

Supports consistent evidence terms:

```text
configured
built
launched
installed
validated
accepted
blocked
```

The status vocabulary is operationally important because vague words such as “working,” “finished,” and “release-ready” collapse several distinct states.

### `&&&04` — Resource Ownership and Lifetime

Directly supports:

- ownership of database connections;
- ownership of application shutdown;
- lifetime of installed files versus user data;
- lifetime of generated artifacts;
- clean close versus forced process termination.

This concept remains Red. Cycle 06 should add installed-lifecycle examples without assuming that missing centralized ownership proves a leak.

### `&&%01` — Package and Module Boundary

Already explains Python source structure, but it does not mean “packaging into an executable.” The word `package` is overloaded:

```text
Python package
≠ distribution package
≠ installer package
```

Cycle 06 must explicitly preserve that vocabulary distinction.

### `&&%03` — Context Manager and Deterministic Cleanup

Supports clean shutdown and connection release. It requires reinforcement showing that:

```text
process ended
≠ every cleanup path was deterministic
```

A process can disappear after forced termination while still failing the intended close-and-reopen lifecycle.

### `&%%01` — Application Service

Relevant to validating principal workflows after installation. The executable is not accepted merely because its window appears; service-backed Register, Lists, History, and Settings behavior must remain usable.

### `&%%02` — Repository Pattern and Persistence Adapter

Supports the distinction between application behavior and persistence behavior inside the frozen or installed runtime. It also grounds why a bundled database resource must not be confused with the live user database.

### `&%%03` — Presentation Adapter

Supports installed UI smoke validation. It does not need a packaging-specific concept split. The new lesson is that successful startup should expose expected pages and observable errors rather than silently terminating.

### `&%%05` — Statement Atomicity Versus Workflow Atomicity

Already covers the required distinction between individual commits and complete use-case atomicity. It should be reinforced, not duplicated. Packaging does not repair multi-commit workflows; installed execution preserves the same transaction model unless implementation changes it.

### `%%%01` — SQLite Initialization Versus Migration

Already covers two of the three persistence lifecycle states. Cycle 06 should reinforce the additional distinction:

```text
schema initialization
≠ migration
≠ sample-data seeding
```

Seeding can remain a derived term or project-specific subtopic unless a later cycle establishes a broader reusable concept.

### `%%%02` — SQLite Connection and Cursor Ownership

Supports shutdown and reopen safety. It remains Red because direct Qt shutdown evidence is still required.

### `%%%05` — Bundled Resource Versus Writable User Data

This is a central Cycle 06 concept and already covers:

```text
schema.sql / seed.sql as bundled resources
vs
%LOCALAPPDATA%/Markei/market.sqlite as writable user state
```

It should be reinforced to include generated artifacts and installer behavior, but should not absorb the entire packaging and validation lifecycle.

---

## 6. Required Conceptual Distinctions

### 6.1 Source, frozen, and installed execution

```text
Source execution
    Python interpreter loads repository source and dependencies.

Frozen executable execution
    A generated executable/distribution loads collected Python runtime,
    modules, libraries, and resources without the user's development command.

Installed application execution
    The frozen runtime is launched from a location and registration state
    produced by an installer, with installed paths, shortcuts, metadata,
    upgrade identity, and uninstall behavior in effect.
```

A frozen executable copied from `dist/` is not automatically an installed application.

### 6.2 Configuration and artifact states

```text
Markei.spec
    packaging source configuration

PyInstaller output directory
    generated package artifact

Inno Setup source
    installer source configuration

compiled setup executable
    generated installer artifact

installed Markei directory and registrations
    installed application state
```

Source configuration expresses intent. Generated artifacts prove only that a transformation occurred. Installed state proves that the installer changed the target environment. Validation still requires observed behavior.

### 6.3 Dependency phases

```text
Build-time dependency
    required to generate the frozen runtime or installer

Runtime dependency
    required when the executable is running

Installer-time dependency
    required to compile or execute installation behavior
```

Examples:

- PyInstaller is normally a build-time dependency, not a dependency ordinary Markei users invoke.
- PySide6 code and Qt runtime components are runtime dependencies collected into the frozen distribution.
- Inno Setup compiler availability is an installer-build dependency.

### 6.4 Bundled resource, generated artifact, and writable state

```text
Bundled read-only resource
    versioned input shipped with the application, such as schema.sql

Generated artifact
    output created by packaging or installer compilation

Writable user state
    mutable data created during use, such as market.sqlite and WAL/SHM companions
```

The current `Markei.spec` collects both `schema.sql` and `seed.sql`. Current database code executes `seed.sql` whenever the bundled path exists. This makes production seed classification a real lifecycle boundary rather than a vocabulary detail.

### 6.5 Initialization, migration, and seeding

```text
Initialization
    creates a fresh database structure

Migration
    adapts an existing database toward the expected structure

Seeding
    inserts initial rows after or during initialization
```

A schema can initialize successfully while an unsuitable production seed still creates demonstration business data. Conversely, an empty business database can be correctly initialized.

### 6.6 Application files and user data

Application files are replaceable distribution content. User data is persistent mutable state whose retention policy must be explicit. Placing the database under `%LOCALAPPDATA%` supports separation, but does not prove upgrade, uninstall, reinstall, backup, or recovery behavior.

### 6.7 Command success, behavior validation, and release acceptance

```text
successful command
    a process returned success under stated conditions

validated behavior
    direct evidence demonstrates the claimed behavior

accepted release
    required behaviors and policies have been reconciled and approved
```

A successful build command proves neither installation nor user-data preservation.

### 6.8 Configuration intent and observed evidence

`Markei.spec` expresses that two SQL resources should be collected. Only artifact inspection and runtime tests can show that they were collected to the expected location and resolved successfully.

Similarly, installer directives can express shortcut, uninstall, or upgrade intent. Only execution of the installed lifecycle can validate their effects.

### 6.9 Application version, installer identity, and data compatibility

```text
Application version
    human- and program-visible software release value

Installer identity
    identity used to recognize the same installed product across installs/upgrades

Data compatibility
    ability of the running version to open and preserve an existing user database
```

The current source exposes `VERSION = "0.1.0"`, but this alone does not establish executable metadata, installer upgrade identity, or schema compatibility.

### 6.10 Uninstalling program files and deleting user data

An uninstaller can remove the installed executable and resources while intentionally retaining `%LOCALAPPDATA%/Markei`. Deleting user data is a separate policy and action. External placement makes retention possible; it does not decide or validate the policy.

### 6.11 Clean shutdown, process termination, and reopen safety

```text
clean shutdown
    application-owned cleanup paths complete normally

process termination
    operating-system process stops, whether cleanly or forcibly

reopen safety
    a new process can immediately reuse the intended user state without retained locks or corruption symptoms
```

These states overlap but are not interchangeable.

### 6.12 Statement and workflow atomicity

Already canonical under `&%%05`. Cycle 06 should retain it because packaging and installation do not change the transaction semantics of Register or deletion/recalculation workflows.

---

## 7. Reinforcement Candidates for Existing Concepts

### `&&&01` — Responsibility Boundary

**Cycle 06 evidence:** `main.py`, `app/main.py`, `Markei.spec`, database resource/data paths, Main/Operational checkpoints.

**New example:** packaging configuration owns artifact composition intent; installer configuration owns installation intent; runtime code owns resource resolution and user-state access; validation owns evidence; Main/human owns acceptance.

**Teaching value:** prevents one successful tool action from taking authority over the whole release lifecycle.

**Maturity:** remain Yellow.

### `&&&03` — Naming as Data Contract

**Cycle 06 evidence:** Cycle 06 status vocabulary in `06_SESSION_SCHEME.md` and the operational validation ladder.

**New example:** `configured`, `built`, `launched`, `installed`, `validated`, and `accepted` must not be used interchangeably.

**Maturity:** remain Yellow.

### `&&&04` — Resource Ownership and Lifetime

**Cycle 06 evidence:** four page-owned repository chains; external user database; generated package and installed program lifetimes; unresolved shutdown owner.

**New example:** program files may be replaced during upgrade while user data survives; database connections must end before immediate reopen and lifecycle cleanup checks.

**Maturity:** remain Red.

### `&&%01` — Package and Module Boundary

**Cycle 06 evidence:** Python package `app`, PyInstaller distribution package, installer package.

**New example:** the same word “package” can describe three different boundaries; learner explanations must qualify which one is meant.

**Maturity:** remain Yellow.

### `&&%03` — Context Manager and Deterministic Cleanup

**Cycle 06 evidence:** `app.main.main()` starts the Qt event loop; no directly inspected composition-level shutdown owner; operational checkpoint requires deterministic closure validation.

**New example:** a test that kills the process proves termination, not deterministic cleanup.

**Maturity:** remain Red.

### `&%%01` — Application Service

**Cycle 06 evidence:** principal installed workflows still depend on `ProductService` behavior after launch.

**New example:** an installed executable that displays a window but cannot register a purchase has passed startup, not beta workflow validation.

**Maturity:** remain Yellow.

### `&%%03` — Presentation Adapter

**Cycle 06 evidence:** `app/main.py` creates `QApplication` and `MainWindow`; Cycle 06 requires expected public pages and inspectable startup failure.

**New example:** visible MainWindow and page loading are presentation-level validation gates distinct from persistence and installer gates.

**Maturity:** remain Yellow.

### `&%%05` — Statement Atomicity Versus Workflow Atomicity

**Cycle 06 evidence:** operational checkpoint confirms repository-level commits and multi-step service workflows.

**New example:** freezing or installing Markei does not make receipt registration transactionally atomic; the same partial-state risk remains unless implementation changes.

**Maturity:** remain Red.

### `%%%01` — SQLite Initialization Versus Migration

**Cycle 06 evidence:** `connect()` initializes when absent and runs additive migration on connection; optional `seed.sql` execution remains separately controlled by resource presence.

**New example:** first installed launch may initialize, later versions may migrate, and seed inclusion may add initial rows. These are separate operations.

**Maturity:** remain Yellow.

### `%%%02` — SQLite Connection and Cursor Ownership

**Cycle 06 evidence:** clean close, immediate reopen, WAL/SHM handling, and uninstall/reinstall tests all depend on connection release.

**New example:** successful process exit is not sufficient evidence that all four page-owned connection chains closed through the intended path.

**Maturity:** remain Red.

### `%%%05` — Bundled Resource Versus Writable User Data

**Cycle 06 evidence:** `Markei.spec` collects SQL resources; `resource_base()` distinguishes frozen and source paths; `user_data_dir()` places the live database under `%LOCALAPPDATA%/Markei`.

**New example:** `schema.sql` may be replaced with the installed program, while `market.sqlite` should follow the accepted user-data lifecycle policy.

**Maturity:** remain Yellow.

---

## 8. New KANBAN Candidates

### Candidate `&&&05` — Evidence State and Validation Boundary

**Marker family:** Foundational Computer Science.

**Learner-oriented description:**

A technical claim must match the strongest evidence actually obtained. Configuration, command success, generated output, observed behavior, and human acceptance are different evidence states.

**Formal definition:**

An evidence state is the maturity level of a technical claim determined by the direct observations, validation conditions, and authority supporting it. A validation boundary is the limit beyond which existing evidence cannot justify a stronger claim.

**Technology-independent example:**

A factory drawing specifies how a device should be assembled. A completed device proves assembly occurred. A powered-on device proves startup. Reliability testing and product approval remain separate states.

**Python/Windows meaning:**

A successful packaging command can prove generation of files. Launching the executable can prove startup in one environment. Installing, reopening, upgrading, uninstalling, and preserving data each require separate evidence.

**Markei evidence:**

- `06_SESSION_SCHEME.md` defines `configured`, `built`, `launched`, `installed`, `validated`, and `accepted`.
- `Markei.spec` is source intent, not proof of package contents or launch behavior.
- Historical evidence reports a launched one-folder runtime but not a completed installed lifecycle.
- Current recovery-branch checkpoints explicitly require revalidation.

**Required concepts:** `&&&02`, `&&&03`.

**Related concepts:** `&&&01`, `&%%06`, `%%%06`.

**Proposed status:** Red.

**Reason it cannot be absorbed:** `&&&02` explains source facts versus derived interpretations, but it does not define the ordered maturity and claim limits among configured, built, launched, installed, validated, and accepted states.

---

### Candidate `&&%04` — Source, Frozen, and Installed Execution Context

**Marker family:** Python Language Concept.

**Learner-oriented description:**

The same Python application can run in materially different contexts. Source execution depends on a Python development environment. Frozen execution uses a generated executable and collected runtime. Installed execution adds installer-created paths, identity, shortcuts, upgrade behavior, and uninstall behavior.

**Formal definition:**

An execution context is the environment and artifact state from which a program process is created, including its entrypoint, dependency resolution, resource base, executable location, working directory assumptions, and installation registrations.

**Technology-independent example:**

A play can be rehearsed from scripts, performed from a traveling production kit, or staged permanently in a theater. The script and story are related, but venue, equipment, access paths, and lifecycle conditions differ.

**Python/Windows meaning:**

- source: `python main.py` or `python -m app.main`;
- frozen: a PyInstaller-produced `Markei.exe` and distribution directory;
- installed: that frozen runtime placed and registered by an installer and launched through the installed entrypoint.

**Markei evidence:**

- root `main.py` calls `app.main.main()`;
- `app/main.py` creates the Qt application, MainWindow, and event loop;
- `app/core/database.py` uses `sys.frozen`, `_MEIPASS`, and `sys.executable` fallback to resolve bundled resources;
- `Markei.spec` defines a one-folder `EXE` plus `COLLECT` result;
- Cycle 06 requires launch without a development Python command and from installed state.

**Required concepts:** `&&%01`, `%%%05`.

**Related concepts:** `&&&01`, `&&&04`, `&%%06`, `%%%06`.

**Proposed status:** Red.

**Reason it cannot be absorbed:** `&&%01` explains Python modules and packages, while `%%%05` explains resources versus writable data. Neither explains process creation and dependency/resource behavior across source, frozen, and installed contexts.

---

### Candidate `&%%06` — Packaging and Installation Artifact Lifecycle

**Marker family:** Target-File and Architecture Concept.

**Learner-oriented description:**

Packaging and installation are consecutive but different transformations. Packaging creates a runnable distribution from source and dependencies. Installation applies that distribution to a user environment and establishes launch, identity, upgrade, and uninstall behavior.

**Formal definition:**

The packaging and installation artifact lifecycle is the ordered transformation from version-controlled build configuration to generated runtime artifacts, generated installer artifacts, installed application state, lifecycle validation, and release acceptance.

**Technology-independent example:**

Printing and binding a book creates a distributable object. Stocking it in a library, registering it in the catalog, lending it, replacing an edition, and withdrawing it are deployment lifecycle operations rather than printing operations.

**Python/Windows meaning:**

```text
PyInstaller specification
→ one-folder distribution
→ Inno Setup source
→ compiled setup executable
→ installed program files and registrations
→ launch / upgrade / uninstall / reinstall evidence
```

**Markei evidence:**

- `Markei.spec` analyzes `main.py`, collects SQL resources, creates `Markei.exe`, and produces a `COLLECT` directory;
- Cycle 06 checkpoints report historical one-folder runtime success and incomplete installer compilation/lifecycle validation;
- ordinary user launch, shortcuts, installation target, data policy, version metadata, and uninstall behavior belong after packaging generation.

**Required concepts:** `&&&01`, `&&%04`, `%%%05`, `%%%06`.

**Related concepts:** `&&&05`, `&&&04`, `%%%01`.

**Proposed status:** Red.

**Reason it cannot be absorbed:** `%%%05` separates resources from writable data, but does not explain configuration, generated artifacts, installer compilation, installed state, upgrade, uninstall, or release acceptance as one reusable lifecycle.

---

### Candidate `%%%06` — Build-Time, Runtime, and Installer-Time Dependency

**Marker family:** Packages, Dependencies, and Tooling Concept.

**Learner-oriented description:**

A dependency can be needed to create an artifact, to run the application, or to create/apply an installer. These roles determine what must exist on the developer machine, what must be collected into the distribution, and what ordinary users must or must not install themselves.

**Formal definition:**

A dependency phase classifies a software component or tool by the lifecycle operation for which it is required: build-time generation, application runtime execution, installer compilation, or installer execution.

**Technology-independent example:**

A mold is required to manufacture a part, oil is required while the machine operates, and a crane may be required to install the machine. Each is necessary at a different lifecycle phase.

**Python/Windows meaning:**

- PyInstaller: runtime-package build dependency;
- PySide6 Python modules and Qt libraries: application runtime dependencies that must be collected;
- Inno Setup compiler: installer-build dependency;
- Python interpreter: source-execution dependency, but not an ordinary-user command in the accepted frozen/installed delivery.

**Markei evidence:**

- `requirements.txt` currently declares only `PySide6`, so build and installer tooling are not represented there;
- `Markei.spec` contains no hidden imports and relies on analysis/collection to discover runtime content;
- prior installer compilation was blocked by unavailable `ISCC.exe` according to checkpoint evidence;
- Cycle 06 explicitly requires no development Python command for the user.

**Required concepts:** `&&%01`, `&&%04`.

**Related concepts:** `&%%06`, `%%%05`, `&&&05`.

**Proposed status:** Red.

**Reason it cannot be absorbed:** `&&%01` explains code namespace boundaries, not lifecycle dependency phases. A runtime dependency can be collected from a Python package, while a build tool may never be shipped to the user.

---

## 9. Candidate Numbering and Drift Check

### Highest occupied identifiers

```text
Foundational Computer Science       &&&04
Python Language Concepts            &&%03
Target-File / Architecture          &%%05
Packages / Dependencies / SQLite    %%%05
```

### Provisional allocations

```text
&&&05  Evidence State and Validation Boundary
&&%04  Source, Frozen, and Installed Execution Context
&%%06  Packaging and Installation Artifact Lifecycle
%%%06  Build-Time, Runtime, and Installer-Time Dependency
```

These identifiers are provisional and occupied only within this stage proposal. They must not be treated as canonical until Main reconciliation and later Didactic materialization explicitly approve them.

### Drift conditions

1. `08_CONCEPT_MAP.md` identifies the same conceptual gaps as next concepts but allocates no IDs. No conflict exists, but the checkpoint will require refresh after any accepted promotion.
2. The Concept Map still labels the recovery milestone rather than Cycle 06.
3. The Concept Map says the Lecture Register is empty, while the loaded recovery context shows observational history now exists.
4. Historical KANBAN identifiers from pre-recovery material are not reused as authority. Current `02_KANBAN.md` occupancy governs numbering.
5. The Main reconciliation filename is `J_[M]_STAGE.md`; `J_MAIN_STAGE.md` references are routing drift.

---

## 10. Glossary Candidates and Terminology Rules

Glossary work must remain derived from accepted canon. The terms below are candidates only.

### Canonical term candidates

These should be derived only if their parent KANBAN candidates are promoted:

```text
Execution Context
    parent candidate: &&%04

Frozen Execution
    parent candidate: &&%04

Installed Execution
    parent candidate: &&%04

Packaging Lifecycle
    parent candidate: &%%06

Installation Lifecycle
    parent candidate: &%%06

Evidence State
    parent candidate: &&&05

Validation Boundary
    parent candidate: &&&05

Dependency Phase
    parent candidate: %%%06
```

### Derived project terminology

These may remain `KANBAN ID: None` where useful, but must point to accepted concepts:

```text
one-folder distribution
compiled installer
installed state
user-data retention policy
reopen safety
schema-only initialization
seed-free business state
application files
user-data directory
```

### Tool-specific terms

These should normally remain tooling vocabulary rather than concepts:

```text
PyInstaller
Analysis
EXE
COLLECT
sys.frozen
_MEIPASS
Inno Setup
ISCC.exe
AppId
DefaultDirName
OutputBaseFilename
```

### Terminology constraints

- Qualify “package” as Python package, runtime package, or installer package.
- Do not use “installed” for an executable launched directly from `dist/`.
- Do not use “validated” for inspected configuration alone.
- Do not use “preserved” merely because a path is external.
- Do not use “version compatibility” when only a display version exists.
- Do not use “clean shutdown” when only process termination was observed.

---

## 11. Learning Dependency Spine

```text
&&&01 Responsibility Boundary
↓
&&%01 Package and Module Boundary
↓
&&%04 Source, Frozen, and Installed Execution Context [candidate]
↓
%%%06 Build-Time, Runtime, and Installer-Time Dependency [candidate]
↓
&%%06 Packaging and Installation Artifact Lifecycle [candidate]
↓
%%%05 Bundled Resource Versus Writable User Data
↓
%%%01 SQLite Initialization Versus Migration
↓
&&&04 Resource Ownership and Lifetime
├──→ &&%03 Context Manager and Deterministic Cleanup
└──→ %%%02 SQLite Connection and Cursor Ownership
↓
&%%01 Application Service
├──→ &%%03 Presentation Adapter
└──→ &%%05 Statement Atomicity Versus Workflow Atomicity
↓
&&&05 Evidence State and Validation Boundary [candidate]
↓
validated installed lifecycle
↓
Main/human primary beta acceptance
```

The evidence-state concept is learned last in the dependency sequence but applied continuously as a discipline. It determines how strongly every earlier result may be described.

---

## 12. Markei Packaging and Installation Learning Spine

```text
main.py
    source entrypoint delegates to app.main.main()
↓
app/main.py
    QApplication + MainWindow + Qt event loop
↓
source execution
    python main.py / python -m app.main
↓
Markei.spec
    analyzes entrypoint
    collects Python/Qt runtime content
    declares SQL resources
    generates one-folder Markei distribution
↓
resource_base()
    source path or frozen resource base
↓
user_data_dir()
    %LOCALAPPDATA%/Markei
↓
connect()
    fresh initialization when absent
    additive migration when opened
↓
seed policy boundary
    resource presence currently controls optional execution
↓
installer configuration
    exact current source path requires Operational confirmation
↓
compiled installer
    not established by current branch source inspection
↓
ordinary user installation
    not established by current branch source inspection
↓
installed launch
↓
Register / Lists / History / Settings workflow validation
↓
clean close + immediate reopen
↓
upgrade / uninstall / reinstall data checks
↓
accepted uninstall data-retention policy
↓
Cycle 06 primary beta acceptance
```

---

## 13. Concept Maturity Classification

### Green

```text
None
```

No concept receives Green without explicit human learning validation.

### Yellow — existing concepts with established implementation grounding

```text
&&&01 Responsibility Boundary
&&&02 Raw Data Versus Derived Data
&&&03 Naming as Data Contract
&&%01 Package and Module Boundary
&&%02 Dataclass as Structured Data Carrier
&%%01 Application Service
&%%02 Repository Pattern and Persistence Adapter
&%%03 Presentation Adapter
&%%04 Database Row, Domain Model, and View Model
%%%01 SQLite Initialization Versus Migration
%%%03 SQLite PRAGMA and Connection Configuration
%%%04 Relational Schema and Referential Integrity
%%%05 Bundled Resource Versus Writable User Data
```

Cycle 06 examples should reinforce relevant Yellow concepts without changing status automatically.

### Red — existing unstable concepts

```text
&&&04 Resource Ownership and Lifetime
&&%03 Context Manager and Deterministic Cleanup
&%%05 Statement Atomicity Versus Workflow Atomicity
%%%02 SQLite Connection and Cursor Ownership
```

### Red — new candidates

```text
&&&05 Evidence State and Validation Boundary
&&%04 Source, Frozen, and Installed Execution Context
&%%06 Packaging and Installation Artifact Lifecycle
%%%06 Build-Time, Runtime, and Installer-Time Dependency
```

Red is appropriate because the candidates are newly classified, not yet taught or human-validated, and partly depend on current-branch generated/installed evidence that does not yet exist.

---

## 14. Learner Validation Questions

### Execution context

1. What changes when Markei moves from `python main.py` to a frozen executable?
2. Why is a frozen executable launched from `dist/` not necessarily an installed application?
3. Which path assumptions must work independently of the current working directory?
4. What does `sys.frozen` indicate, and what does it not prove?

### Dependency phase

5. Why should an ordinary Markei user not need PyInstaller?
6. Which PySide6/Qt components must still exist at runtime even without a system Python command?
7. Why can missing `ISCC.exe` block installer compilation without blocking source execution?
8. Where should build-tool dependencies be recorded separately from application runtime dependencies?

### Packaging and installation

9. What does `Markei.spec` prove by existing?
10. What additional evidence proves that the generated distribution contains and resolves `schema.sql`?
11. What additional state does installation create beyond copying an executable?
12. Why are Start Menu launch, upgrade identity, and uninstall behavior installer concerns rather than PyInstaller concerns?

### Resources and persistence

13. Why can `schema.sql` be bundled while `market.sqlite` should remain external?
14. What is the difference between initialization, migration, and seeding?
15. Why does `%LOCALAPPDATA%` placement support preservation without proving it?
16. What role do `market.sqlite-wal` and `market.sqlite-shm` play in cleanup and testing?

### Version and identity

17. Why does `VERSION = "0.1.0"` not automatically define executable metadata or installer upgrade identity?
18. How can two application versions share an installer identity yet have incompatible database expectations?
19. Which evidence demonstrates data compatibility rather than merely matching version strings?

### Validation and acceptance

20. What claim is justified by a successful PyInstaller command?
21. What stronger claim is justified by launching the generated executable?
22. What remains unproven until installation, close/reopen, upgrade, uninstall, and reinstall are exercised?
23. Who accepts the release after evidence exists?

### Shutdown and transactions

24. Why is a stopped process not sufficient proof of deterministic cleanup?
25. What evidence would demonstrate reopen safety?
26. Why does installation not change Markei's existing multi-commit workflow atomicity?
27. Why must missing shutdown ownership not be reported as a proven leak without runtime evidence?

---

## 15. Misconception and Vocabulary Risks

### Highest-risk misconceptions

1. **Treating a PyInstaller build as a release.** A build is one artifact-generation state.
2. **Calling a build directory an installation.** Installation adds target placement, registration, identity, shortcuts, upgrade, and uninstall behavior.
3. **Bundling the live database.** `market.sqlite`, WAL, and SHM are user state, not replaceable application resources.
4. **Assuming external placement proves preservation.** `%LOCALAPPDATA%` is a boundary, not lifecycle evidence.
5. **Assuming uninstall behavior from source directives.** Configuration intent requires execution evidence.
6. **Treating one successful launch as reproducibility.** One launch proves only the tested context.
7. **Confusing application version with installer identity.** Display metadata, upgrade recognition, and database compatibility are distinct.
8. **Treating seed presence as harmless.** Current code executes `seed.sql` whenever bundled, so resource policy affects first-user data.
9. **Treating process termination as clean shutdown.** Immediate reopen and released locks require separate evidence.
10. **Treating missing centralized shutdown ownership as proof of a leak.** It is an unresolved ownership model until behavior is observed.
11. **Treating historical main-branch packaging evidence as current-branch validation.** Historical evidence informs risk and procedure, not contemporary status.
12. **Assuming packaging changes transaction semantics.** Multi-commit workflow behavior remains unless source implementation changes.

### Vocabulary risks

```text
package
    must identify Python package, frozen distribution, or installer package

working
    should be replaced by the strongest precise evidence state

release-ready
    should be avoided until installed lifecycle gates pass

persistent
    must distinguish stored data from validated preservation policy

compatible
    must identify executable, installer-upgrade, or database compatibility
```

---

## 16. Explicit Didactic Deferrals

The following are outside this stage or remain human/Main/Design decisions:

- selection or replacement of packaging tools;
- exact Inno Setup directives;
- production seed inclusion;
- uninstall deletion or retention policy;
- application shutdown ownership;
- transaction-boundary redesign;
- migration-ledger architecture;
- code signing and certificate acquisition;
- SmartScreen or antivirus release hardening;
- automatic updating;
- rollback architecture;
- mobile, backend, synchronization, authentication, cloud, or remote identity;
- broad service/repository decomposition;
- canonical promotion of any proposed concept;
- Green maturity promotion.

Tool names remain examples unless repeated learning needs justify broader canonical concepts.

---

## 17. Proposed Post-Materialization Didactic Evidence

After Codex produces Cycle 06 `H_DDC_CODEX.md`, Didactic reconciliation should classify evidence without copying the report blindly.

### Candidate canonical evidence

- accepted distinction among source, frozen, and installed execution;
- accepted dependency-phase model;
- accepted artifact/installation lifecycle;
- accepted evidence-state vocabulary.

### Reinforcement evidence

- exact packaged resource path and contents;
- actual first-launch initialization and seed behavior;
- actual user-data directory behavior;
- deterministic close and immediate reopen evidence;
- transaction behavior under installed execution;
- version, installer identity, and compatibility observations.

### Derived glossary evidence

Only after parent concepts are accepted:

```text
frozen execution
installed execution
one-folder distribution
compiled installer
installation lifecycle
validation boundary
dependency phase
reopen safety
```

### Checkpoint evidence

A future `08_CONCEPT_MAP.md` refresh should:

- replace the recovery milestone with the current Cycle 06 state;
- list promoted concepts by accepted IDs;
- preserve no-Green status unless the human validates learning;
- distinguish configured, built, installed, and validated state;
- remove the stale statement that the Lecture Register is empty.

### Observational evidence

A future Lecture Register append may record:

- which distinctions were taught;
- learner answers or misconceptions;
- concepts reinforced;
- candidate concepts accepted, deferred, merged, or rejected;
- why artifact success did or did not justify release acceptance.

---

## 18. Handoff to Main Chat

Main Chat should reconcile this report with Operational and Design stages before preparing any E-stage materialization.

### Existing concepts reused

```text
&&&01 &&&02 &&&03 &&&04
&&%01 &&%03
&%%01 &%%02 &%%03 &%%05
%%%01 %%%02 %%%05
```

Other current concepts remain part of the baseline but do not require major Cycle 06 changes.

### Proposed new concepts

```text
4 candidates

&&&05  Evidence State and Validation Boundary
&&%04  Source, Frozen, and Installed Execution Context
&%%06  Packaging and Installation Artifact Lifecycle
%%%06  Build-Time, Runtime, and Installer-Time Dependency
```

### Main reconciliation questions

1. Should all four candidates be promoted later, or should evidence-state vocabulary remain derived from the packaging lifecycle candidate?
2. Does Design establish application version, installer identity, and data compatibility as one boundary or several distinct boundaries?
3. What is the exact current-branch installer source path?
4. Does current Operational inspection confirm that `seed.sql` remains collected by the package, and is that intended for Cycle 06?
5. Which installed lifecycle states are required before “primary beta accepted” may be used?
6. Which learner answers will count as explicit human validation for future Yellow or Green status changes?

### Stage conclusion

Cycle 06 does not primarily need more tool vocabulary. It needs a disciplined learning model connecting:

```text
execution context
→ dependency phase
→ artifact lifecycle
→ resource/user-state boundary
→ persistence lifecycle
→ shutdown and workflow behavior
→ evidence maturity
→ release acceptance
```

This stage is ready for Main reconciliation through:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

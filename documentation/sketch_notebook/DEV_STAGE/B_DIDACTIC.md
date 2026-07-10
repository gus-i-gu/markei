1. Recovered Learning Baseline

Accepted project baseline

Cycle 04 closed with Markei operating through:

Desktop UI
→ ProductService
→ Repository
→ SQLite

The application is currently a developer-run PySide6 desktop project. Its public surfaces are Register, Lists, History, and Settings. ProductService owns business interpretation and read-model assembly; Repository owns SQL retrieval and persistence; SQLite owns durable facts and schema evolution.

The current executable entry chain is:

main.py
→ app.main.main()
→ QApplication
→ MainWindow
→ Qt event loop

The root entrypoint delegates to app.main, while app/main.py imports PySide6, constructs QApplication, displays MainWindow, and starts the event loop.

Relevant existing learning state

The strongest existing foundations for Sprint 01 are:

&&&03 — Naming as Data Contract

&&&08 — Configuration State

&&&15 — Default Value as Fallback Contract

&&&16 — Validation Boundary

&&&18 — Adapter Boundary

&&&19 — Capability Versus Placeholder

&&%04 — Platform-Neutral Read-Model Shape

&%%12 — Service Contract Stability

%%%01 — SQLite Schema Evolution

The Cycle 04 checkpoint already teaches that platform preparation is not platform implementation and that presentation adapters should not own service behavior. Those distinctions transfer directly into packaging: packaging must preserve the current application boundaries rather than redefine them.

Didactic register drift

There is a repository-backed inconsistency between the Didactic checkpoint and canonical register:

Checkpoint references:
&&&15 through &&&19
&&%07 through &&%08
&%%13 through &%%14
%%%09

Visible canonical register currently ends at:
&&&14
&&%06
&%%12
%%%08

The checkpoint therefore records concepts that are absent from the current 02_KANBAN.md materialization. These identifiers must be treated as occupied. New proposals below begin at:

&&&20
&&%09
&%%15
%%%10

This is didactic-memory drift requiring later reconciliation, not permission to reuse missing numbers.

Sprint-direction reconciliation

06_SESSION_SCHEME.md and J_MAIN_STAGE.md still describe Cycle 05 primarily as mobile preparation. The current human direction supersedes that staged emphasis by splitting Cycle 05 into:

Sprint 01 — Windows desktop packaging and installation
Sprint 02 — mobile implementation preparation through a repository clone

Mobile, synchronization, backend, API, identity, and second-presentation-layer concepts therefore remain deferred during this analysis unless needed to clarify a packaging boundary.

2. Sprint 01 Conceptual Transformation

Running Markei from the repository and delivering Markei as an installed application are different execution environments.

Developer-run project

The current developer supplies much of the execution environment:

repository checkout
+ compatible Python interpreter
+ installed PySide6 dependency
+ source directory structure
+ development working directory
+ command such as python main.py
= running application

Python loads modules directly from source. The developer’s environment resolves imports and provides PySide6. Relative assumptions may appear to work because the current working directory resembles the repository root.

Packaged application

Packaging changes how that environment is supplied:

application source
+ Python runtime components
+ direct and transitive dependencies
+ required non-code resources
+ packaging configuration
= packaged application artifact

The result is commonly called a frozen application: Python source is transformed or collected into a distributable application whose user does not need to install or invoke the project’s development interpreter manually.

Packaging does not necessarily produce an installer. It first produces an application artifact, such as:

one-folder application
or
one-file executable

Installed desktop application

Installation adds a separate deployment step:

packaged application artifact
+ installer metadata and behavior
= installed desktop application

An installer may place files under an application installation directory, create shortcuts, register uninstall information, and establish a predictable launch path.

The installed program must then create or open its writable user state independently from its installed files:

installed program files
≠
writable user database

Markei already contains an initial implementation of this distinction. Bundled schema resources are discovered relative to a resource base, while the live SQLite database is directed to %LOCALAPPDATA%\Markei\market.sqlite.

Release artifact

A build becomes a release artifact only when its identity and validation evidence are established:

successful build
+ known version
+ preserved build configuration
+ validation in a clean user-like environment
+ integrity of bundled resources
+ persistence and upgrade checks
= reproducible release artifact

Markei currently declares VERSION = "0.1.0", but a version constant alone does not prove that the executable, installer, database compatibility, and release records share the same version identity.

The Sprint 01 transformation is therefore:

Developer supplies the runtime and repository context
↓
Build process supplies the runtime and packaged context
↓
Installer supplies the machine-level placement and launch context
↓
Application supplies first-launch initialization and user-data continuity
↓
Release process supplies version identity and validation evidence

3. Concept Classification

Concept

Classification

Existing reference or rationale

Source execution versus packaged execution

New canonical-concept candidate

Central transformation of Sprint 01; not represented by an existing concept

Interpreter and runtime bundling

New canonical-concept candidate

Required to understand why the user need not install or invoke Python

Dependency resolution

Existing but requires reinforcement

&%%12 covers service contracts, but not build dependency collection

Direct dependency

Glossary-only candidate

A supporting term under dependency closure

Transitive dependency

Glossary-only candidate

Necessary terminology, but not independently broad enough for canon

Build environment

New canonical-concept candidate

Required to explain platform-specific and repeatable artifact production

Build artifact

Glossary-only candidate

Derived from packaging/release concepts

Executable

Glossary-only candidate

Must be distinguished from installer, but does not require a full canonical lesson

Application bundle

Glossary-only candidate

Umbrella term for a one-folder or bundled application result

Installer

Glossary-only candidate

Derived deployment term under packaging-versus-installation

Packaging versus installation

New canonical-concept candidate

Critical process boundary with direct Sprint 01 consequences

One-file distribution

Glossary-only candidate

Distribution strategy subordinate to packaging topology

One-folder distribution

Glossary-only candidate

Distribution strategy subordinate to packaging topology

Frozen application

Glossary-only candidate

Standard term derived from packaged Python execution

Entrypoint

Existing but requires reinforcement

Root main.py and app/main.py already expose the concept, but it is not currently packaging-oriented

Resource discovery

New canonical-concept candidate

Required because schema and seed files must remain discoverable after freezing

Relative and absolute paths

Existing but requires reinforcement

Existing Python/path knowledge must be applied to frozen and installed contexts

Resource path versus user-data path

New canonical-concept candidate

Essential to protect writable database state

Development paths versus installed paths

Glossary-only candidate

Derived distinction under resource/data location boundary

Writable application data

Glossary-only candidate

Derived term under resource/data location boundary

Application configuration directory

Glossary-only candidate

Relevant only if later separated from the database; currently no distinct directory model is evidenced

First-launch initialization

Existing but requires reinforcement

connect() already initializes a missing database

Database migration in an installed application

Existing but requires reinforcement

%%%01 already covers schema evolution; installed lifecycle adds persistence and upgrade context

Idempotent migration

Glossary-only candidate

Existing behavior under SQLite schema evolution

Release versioning

New canonical-concept candidate

Needed to connect source version, artifact identity, installer identity, and upgrade rules

Deterministic build

Glossary-only candidate

A strict technical property that may not be immediately attainable

Reproducible build process

New canonical-concept candidate

Sprint needs repeatable build inputs and commands even if byte-identical determinism is deferred

Code signing

Glossary-only candidate

Conceptual release-hardening term; implementation may be deferred

Antivirus false positive

Glossary-only candidate

Release-risk terminology, not a stable Markei concept by itself

Upgrade compatibility

New canonical-concept candidate

User data and migrations must survive application replacement

Rollback

Glossary-only candidate

Derived release-recovery term

Portable application versus installed application

New canonical-concept candidate

Directly affects data paths, shortcuts, upgrade responsibility, and user expectations

Packaging configuration versus application behavior

Existing but requires reinforcement

Extends &&&18 Adapter Boundary, &&&19 Capability Versus Placeholder, and responsibility separation

Build-time dependency versus runtime dependency

New canonical-concept candidate

Required to reason about tools used to produce Markei versus components Markei needs when launched

Successful build versus validated release

New canonical-concept candidate

Prevents treating artifact creation as completion

Installer design details

Not required

Didactic Chat must distinguish the installer without designing it

Packaging-tool selection

Not required

Tool choice belongs to later operational/design synthesis

Synchronization

Deferred to Sprint 02

Explicitly outside Sprint 01

Backend/API architecture

Deferred to Sprint 02

Explicitly outside Sprint 01

Authentication and accounts

Deferred to Sprint 02

Explicitly outside Sprint 01

Mobile framework packaging

Deferred to Sprint 02

No active Sprint 01 evidence

Cross-device persistence

Deferred to Sprint 02

Installed local persistence is active; cross-device persistence is not

Mobile application stores

Deferred to Sprint 02

Not part of Windows desktop installation

4. Learning Dependency Sequence

The shortest coherent sequence is:

1. Existing application entrypoint and execution chain
↓
2. Source execution versus frozen execution
↓
3. Direct, transitive, build-time, and runtime dependencies
↓
4. Build environment and reproducible build inputs
↓
5. Packaging versus installation
↓
6. One-folder, one-file, portable, and installed distributions
↓
7. Bundled-resource discovery
↓
8. Resource paths versus writable user-data paths
↓
9. First-launch initialization and installed-database migration
↓
10. Release versioning and upgrade compatibility
↓
11. Successful build versus validated release
↓
12. Optional release hardening: signing, antivirus reputation, rollback

1. Entrypoint and execution chain

The learner must first know what the build is expected to launch. Markei has two related entrypoint files:

main.py
app/main.py

Without a clear entrypoint, packaging options and import failures cannot be interpreted correctly.

2. Source execution versus frozen execution

This explains why repository paths, import behavior, interpreter availability, and resource lookup can change after packaging.

3. Dependency categories

Before collecting dependencies, the learner must distinguish:

direct dependency
transitive dependency
build-time dependency
runtime dependency

Otherwise, the packaging tool itself may be confused with application runtime content.

4. Build environment

A build is produced inside an environment containing a particular operating system, Python version, dependency set, and packaging configuration. This must be understood before reproducibility can be discussed.

5. Packaging versus installation

The learner can now distinguish production of runnable application files from placement of those files into a user-facing Windows installation.

6. Distribution topology

One-file and one-folder are packaging topologies. Portable and installed are deployment modes. These dimensions overlap but are not synonyms.

7. Resource discovery

Once source files no longer live in their ordinary repository positions, non-code files such as schema.sql and seed.sql require explicit inclusion and runtime discovery.

8. User-data separation

Only after bundled resources are understood can the learner safely distinguish read-only or replaceable program resources from persistent writable user state.

9. Initialization and migration

First launch creates missing state; later launches and upgrades migrate existing state. These are separate lifecycle events and must preserve user information.

10. Version and compatibility

An application version becomes meaningful when it identifies the built artifact and informs compatibility decisions between software and persisted data.

11. Release validation

The artifact must be tested in the environment it is intended to serve, not only in the build environment.

12. Hardening

Code signing, antivirus reputation, rollback packaging, and stronger reproducibility matter after the core lifecycle is understandable. Introducing them earlier would overload the minimum model.

5. Critical Distinctions

Packaging is not installation

Packaging
= producing runnable application files

Installation
= placing and registering those files for ordinary user launch

An application can be packaged but distributed portably without an installer.

Executable is not installer

Executable
= launches the application

Installer
= deploys the application

An installer may contain or unpack one or more executables, resources, libraries, and metadata.

Bundled resources are not writable user data

Bundled resources
= application-supplied files required for operation
= replaceable during upgrade
= should generally be treated as read-only

Writable user data
= state created or modified by the user
= must survive restart and ordinary upgrade
= must live in a user-writable location

For Markei:

schema.sql and seed.sql
→ bundled resources

market.sqlite
→ writable user data

The database module already models this separation through RESOURCE_DATABASE_DIR and USER_DATABASE_DIR.

Application code is not build configuration

Application code
= defines Markei’s runtime behavior

Build configuration
= tells a packaging process how to collect and transform Markei

Build configuration may identify the entrypoint, application name, icon, non-code resources, hidden imports, output topology, and version metadata. It should not become the owner of ProductService, repository, database, or UI behavior.

Development database is not installed-user database

A database inside or near the source repository is developer state. An installed-user database is persistent per-user application state.

Markei currently directs its active database to:

%LOCALAPPDATA%\Markei\market.sqlite

This is appropriate conceptual preparation for installed execution. The bundled schema remains separate and is used to initialize a missing user database.

Build-time dependency is not runtime dependency

Build-time dependency
= needed to produce an artifact

Runtime dependency
= needed when the produced application executes

A packaging tool is usually a build-time dependency. PySide6 contributes runtime libraries that must be available to the packaged application. The current requirements.txt lists only PySide6, so the complete build environment is not yet declared there.

Portable distribution is not installed distribution

Portable distribution
= user extracts or copies application files and launches them directly

Installed distribution
= installer owns placement, shortcuts, uninstall registration, and upgrade path

Portable does not mean that user data should be stored beside the executable. That is a separate design choice.

Successful build is not validated release

Successful build
= packaging process completed

Validated release
= artifact launches and behaves correctly in a clean user-like environment

A validated Markei release must confirm at minimum:

application launch without a development Python command;

Qt platform/plugin availability;

bundled schema discovery;

first-launch database creation;

writable database persistence;

reopening existing data;

migration execution against an existing database;

principal UI workflow availability;

artifact and version identity.

6. Markei Grounding

Active concept

Concrete Markei grounding

Entrypoint

Root main.py imports and calls app.main.main(). app/main.py creates QApplication, MainWindow, and the Qt event loop.

Source versus packaged execution

app/main.py currently contains a source-execution path adjustment through sys.path.insert(...), which deserves review under frozen execution without assuming it is wrong.

Runtime dependency

PySide6 is imported directly by app/main.py and is the sole declared requirement.

Frozen execution context

resource_base() checks sys.frozen and optionally uses sys._MEIPASS, showing that packaging-aware runtime logic has already begun.

Bundled resource discovery

SCHEMA_PATH and SEED_PATH derive from resource_base() / "app" / "database", so packaging must include those files in the corresponding logical resource structure.

Writable user data

user_data_dir() selects %LOCALAPPDATA%\Markei, and DATABASE_PATH uses that directory rather than the installation directory.

First-launch initialization

connect() detects a missing database and invokes initialize().

Initialization resource

initialize() creates the user directory, opens the database, executes schema.sql, optionally executes seed.sql, and commits.

User-data preservation

Existing databases are preserved unless recreate=True; normal initialization reconnects rather than deleting the file.

Installed database migration

Every normal connect() call invokes migrate(), which uses idempotent checks and INSERT OR IGNORE defaults.

Release versioning

app/core/config.py declares APP_NAME = "Markei" and VERSION = "0.1.0". Sprint 01 must teach that these values need alignment with artifact and installer metadata.

Packaging configuration versus behavior

Packaging may collect app, PySide6 components, and SQL resources, but it must not absorb service, repository, or database responsibility.

Upgrade compatibility

Existing user databases may contain earlier schema versions. The migration system is therefore part of release compatibility, not merely developer setup.

Reproducibility

The repository currently declares PySide6 without a version constraint and does not expose packaging-tool or build-environment declarations through the inspected dependency file. This does not prove builds are irreproducible, but it means repeatability is not established by that file.

Successful build versus validated release

Existing Cycle 04 validation was developer/service/offscreen oriented. Sprint 01 needs artifact-level launch, resource, persistence, and upgrade evidence rather than assuming previous source validation transfers automatically.

This grounding identifies learning evidence. It does not choose a packaging tool, installer technology, output topology, signing provider, or implementation patch.

7. KANBAN Proposals

&&&20 — Packaged Application Lifecycle

Why it deserves canonical treatment

This is the central Sprint 01 model connecting source execution, packaging, distribution, installation, launch, persistence, upgrade, and release validation. Without it, the learner may treat executable generation as the entire desktop-delivery problem.

Prerequisite concepts

&&&03 — Naming as Data Contract

&&&18 — Adapter Boundary

&&&19 — Capability Versus Placeholder

Related concepts

proposed &&&21

proposed &&&22

proposed &&&23

proposed &&%09

proposed &%%15

Recommended initial status

Red.

Motivating Sprint 01 evidence

Markei currently runs through source entrypoints and a developer-provided environment. Human direction requires transition through packaged application, executable, installed application, persistent user data, and reproducible release artifact.

&&&21 — Packaging Versus Installation

Why it deserves canonical treatment

The distinction prevents executable generation, installer creation, application placement, shortcut creation, uninstall registration, and upgrade behavior from being treated as one operation.

Prerequisite concepts

proposed &&&20

Related concepts

executable

installer

application bundle

portable distribution

installed distribution

Recommended initial status

Red.

Motivating Sprint 01 evidence

Sprint 01 explicitly requires both executable preparation and intuitive desktop installation. These are connected but independently validatable outputs.

&&&22 — Resource State Versus User State

Why it deserves canonical treatment

This distinction protects persistent data by separating application-supplied resources from user-created writable state. It is broadly reusable and directly determines whether upgrades can replace application files without destroying user data.

Prerequisite concepts

&&&02 — Raw Data Versus Derived Data

&&&08 — Configuration State

proposed &&&20

Related concepts

%%%01 — SQLite Schema Evolution

proposed &&%09

proposed &%%15

Recommended initial status

Yellow.

Motivating Sprint 01 evidence

Markei already separates bundled schema.sql and optional seed.sql from %LOCALAPPDATA%\Markei\market.sqlite.

&&&23 — Build-Time Versus Runtime Dependency

Why it deserves canonical treatment

The distinction is required to understand which components produce Markei and which components must be present inside or beside the packaged application when a user launches it.

Prerequisite concepts

proposed &&&20

Related concepts

direct dependency

transitive dependency

build environment

dependency closure

proposed &&&24

Recommended initial status

Red.

Motivating Sprint 01 evidence

PySide6 is an application runtime dependency, while the eventual packaging system will be a build dependency. The current dependency declaration contains only unpinned PySide6.

&&&24 — Reproducible Build Process

Why it deserves canonical treatment

Sprint 01 requires a release artifact that can be regenerated from known inputs. The concept is broader than one tool and remains valuable across future desktop and mobile release work.

Prerequisite concepts

proposed &&&23

proposed &&&20

Related concepts

build environment

dependency pinning

deterministic build

packaging configuration

release versioning

Recommended initial status

Red.

Motivating Sprint 01 evidence

The inspected repository declares application version and PySide6 dependency but does not yet establish a repository-backed, versioned packaging environment or repeatable artifact procedure.

&&&25 — Successful Build Versus Validated Release

Why it deserves canonical treatment

This distinction prevents a packaging command’s success from being mistaken for evidence that the application can be installed, launched, initialized, upgraded, and used by an ordinary Windows user.

Prerequisite concepts

&&&16 — Validation Boundary

proposed &&&20

proposed &&&21

Related concepts

release artifact

clean-environment validation

antivirus false positive

code signing

rollback

Recommended initial status

Red.

Motivating Sprint 01 evidence

Previous application validation concerns source/service behavior. Sprint 01 introduces artifact-specific failure modes involving bundled resources, Qt runtime components, writable paths, installation, and clean-machine launch.

&&&26 — Release Version and Compatibility Contract

Why it deserves canonical treatment

A release version must connect application identity, packaged artifact identity, installer identity, database compatibility, and upgrade expectations. It is more than a display string.

Prerequisite concepts

&&&03 — Naming as Data Contract

proposed &&&20

proposed &&&22

Related concepts

%%%01 — SQLite Schema Evolution

semantic version

migration

rollback

upgrade compatibility

Recommended initial status

Red.

Motivating Sprint 01 evidence

Markei declares version 0.1.0, maintains existing SQLite databases, and applies migrations during connection. These facts create an implicit compatibility contract that packaging must make visible and testable.

&&%09 — Frozen Python Execution Context

Why it deserves canonical treatment

This is the Python-specific model explaining sys.frozen, temporary extraction/resource locations, packaged import behavior, and differences between __file__, sys.executable, the working directory, and a resource base.

Prerequisite concepts

proposed &&&20

relative and absolute path understanding

Related concepts

proposed &&&22

resource discovery

entrypoint

application bundle

Recommended initial status

Yellow.

Motivating Sprint 01 evidence

resource_base() already tests sys.frozen and references sys._MEIPASS, so frozen execution is present in implementation evidence rather than merely theoretical.

&%%15 — Markei Installed Data Lifecycle

Why it deserves canonical treatment

This Markei-specific concept unifies first-launch database creation, existing-data preservation, schema migration, user-data location, upgrade compatibility, and recovery expectations.

Prerequisite concepts

%%%01 — SQLite Schema Evolution

proposed &&&22

proposed &&&26

Related concepts

first-launch initialization

application data directory

idempotent migration

rollback

backup

Recommended initial status

Yellow.

Motivating Sprint 01 evidence

Markei creates %LOCALAPPDATA%\Markei, initializes market.sqlite from bundled SQL resources, preserves an existing database by default, and migrates it during ordinary connection.

No %%%10 tool-specific concept is proposed yet. A packaging technology should not become canonical merely because it is eventually selected. Tool-specific canonical treatment should wait until implementation evidence reveals reusable behavior that cannot be adequately derived from the foundational and Python-specific concepts above.

8. Glossary Proposals

Term

KANBAN ID

Type

Proposed treatment

Source execution

&&&20

Derived terminology

Running modules from repository source through a separately installed interpreter

Packaged execution

&&&20

Derived terminology

Running an application from collected or frozen distribution files

Frozen application

&&%09

Python-specific derived terminology

Python application distributed with collected runtime components rather than ordinary source invocation

Entrypoint

None

Derived terminology

Initial callable or module selected to start the application

Dependency closure

&&&23

Derived terminology

Complete direct and transitive dependency set required for a build or runtime

Direct dependency

&&&23

Derived terminology

Dependency declared or imported directly by the project

Transitive dependency

&&&23

Derived terminology

Dependency required through another dependency

Build-time dependency

&&&23

Derived terminology

Component required to produce an artifact

Runtime dependency

&&&23

Derived terminology

Component required when the packaged application executes

Build environment

&&&24

Derived terminology

Operating system, interpreter, libraries, tools, and configuration used to produce an artifact

Build artifact

&&&20

Derived terminology

Output created by the build process

Application bundle

&&&20

Derived terminology

Collected application executable, libraries, and resources

Executable

&&&21

Derived terminology

File or launcher that starts the application

Installer

&&&21

Derived terminology

Deployment program or package that places and registers the application

One-file distribution

&&&21

Derived terminology

Packaged topology presented as one launchable file

One-folder distribution

&&&21

Derived terminology

Packaged topology containing an executable and adjacent support files

Portable application

&&&21

Derived terminology

Application launched directly from copied or extracted files without ordinary installation registration

Installed application

&&&21

Derived terminology

Application deployed through an installation lifecycle

Bundled resource

&&&22

Derived terminology

Application-supplied non-user file required at runtime

Writable user data

&&&22

Derived terminology

Persistent state created or changed during use

Resource base

&&%09

Project/Python terminology

Runtime base used to locate bundled application resources

User-data directory

&&&22

Derived terminology

Per-user writable location for persistent application state

First-launch initialization

&%%15

Project-derived terminology

Creation of missing user-state structures during the first ordinary launch

Idempotent migration

%%%01

Derived terminology

Migration safe to evaluate repeatedly without duplicating or corrupting state

Release artifact

&&&25

Derived terminology

Versioned and validated artifact intended for distribution

Clean-environment validation

&&&25

Derived terminology

Validation performed without relying on the developer’s existing repository or interpreter setup

Reproducible build process

&&&24

Derived terminology

Documented build procedure that regenerates equivalent functional artifacts from controlled inputs

Deterministic build

&&&24

Derived terminology

Stronger condition in which identical inputs produce byte-identical output

Code signing

None

Derived terminology

Cryptographic publisher identity and integrity mechanism for distributed code

Antivirus false positive

None

Derived terminology

Benign artifact incorrectly classified as malicious or suspicious

Upgrade compatibility

&&&26

Derived terminology

Ability of a newer release to operate safely with existing installed state

Rollback

&&&26

Derived terminology

Controlled return to an earlier compatible release or state

Packaging configuration

&&&24

Project-derived terminology

Build instructions describing artifact collection without defining application behavior

Markei installed data lifecycle

&%%15

Project abstraction

Creation, opening, migration, persistence, and protection of the installed user database

schema.sql, seed.sql, %LOCALAPPDATA%\Markei, and market.sqlite should appear as project usage examples rather than independent glossary truth.

9. Concept Map Update Proposal

Current Milestone

Cycle 05 — Sprint 01
Windows Desktop Packaging and Installation Readiness

Current learning transformation:

source entrypoint
→ frozen Python execution
→ dependency collection
→ packaged application
→ portable or installed distribution
→ bundled-resource discovery
→ writable user database
→ first-launch initialization / migration
→ versioned and validated release artifact

Stable Concepts

None fully Green.

Active Concepts

&&&03 — Naming as Data Contract
&&&08 — Configuration State
&&&15 — Default Value as Fallback Contract
&&&16 — Validation Boundary
&&&18 — Adapter Boundary
&&&19 — Capability Versus Placeholder
&&%04 — Platform-Neutral Read-Model Shape
&%%12 — Service Contract Stability
%%%01 — SQLite Schema Evolution

Proposed:
&&&20 — Packaged Application Lifecycle
&&&21 — Packaging Versus Installation
&&&22 — Resource State Versus User State
&&&23 — Build-Time Versus Runtime Dependency
&&&24 — Reproducible Build Process
&&&25 — Successful Build Versus Validated Release
&&&26 — Release Version and Compatibility Contract
&&%09 — Frozen Python Execution Context
&%%15 — Markei Installed Data Lifecycle

Unstable Concepts

&&&18 — Adapter Boundary
&&&19 — Capability Versus Placeholder
&&&20 — Packaged Application Lifecycle
&&&21 — Packaging Versus Installation
&&&23 — Build-Time Versus Runtime Dependency
&&&24 — Reproducible Build Process
&&&25 — Successful Build Versus Validated Release
&&&26 — Release Version and Compatibility Contract

&&&22, &&%09, and &%%15 may begin at Yellow because current implementation already supplies concrete resource-path, user-data-path, initialization, and migration evidence. The remaining proposed concepts should begin Red until artifact-level evidence exists.

Next Concepts

Trace main.py → app.main.main() as the packaged entrypoint.

Explain how frozen execution differs from repository execution.

Classify direct, transitive, build-time, and runtime dependencies.

Trace schema.sql from bundled resource to first-launch database creation.

Trace market.sqlite from %LOCALAPPDATA% through connection and migration.

Distinguish package artifact, portable distribution, executable, installer, and installed application.

Connect VERSION to artifact identity and database compatibility.

Validate the distinction between successful build and validated release.

Introduce signing and antivirus reputation only after the unsigned artifact lifecycle is understood.

Dependency Spine

&&&03 Naming as Data Contract
↓
Entrypoint reinforcement
↓
&&&20 Packaged Application Lifecycle
├──→ &&&23 Build-Time Versus Runtime Dependency
│    ↓
│    &&&24 Reproducible Build Process
│
├──→ &&&21 Packaging Versus Installation
│
└──→ &&%09 Frozen Python Execution Context
     ↓
     &&&22 Resource State Versus User State
     ↓
     %%%01 SQLite Schema Evolution
     ↓
     &%%15 Markei Installed Data Lifecycle
     ↓
     &&&26 Release Version and Compatibility Contract
     ↓
     &&&25 Successful Build Versus Validated Release

Project Learning Spine

main.py
↓
app/main.py
↓
PySide6 and runtime dependencies
↓
frozen executable context
↓
bundled app/database/schema.sql
↓
%LOCALAPPDATA%\Markei\market.sqlite
↓
initialize()
↓
migrate()
↓
versioned packaged artifact
↓
portable or installed distribution
↓
clean-environment release validation

Session Delta

Cycle 05 was re-scoped by human direction.

Sprint 01 now owns Windows desktop packaging and installation learning.
Sprint 02 retains mobile preparation.

The Didactic checkpoint contains identifiers not present in the current
canonical KANBAN materialization. Those identifiers remain occupied, and
new numbering begins after the highest checkpointed number.

10. Didactic Risks and Deferrals

Conceptual overload

Packaging vocabulary can expand rapidly into build systems, installer databases, Windows internals, code-signing infrastructure, CI/CD, update servers, and operating-system security. Sprint 01 should preserve a minimum spine:

entrypoint
→ frozen execution
→ dependencies
→ artifact
→ resources/data
→ installation
→ persistence/migration
→ version/validation

Code signing, antivirus reputation, rollback automation, and strict deterministic builds should remain secondary until the ordinary unsigned release lifecycle is understood.

Premature mobile expansion

The existing forward checkpoint and Main stage contain extensive mobile preparation material. That content should not leak into Sprint 01 through terms such as cross-platform persistence, synchronization, account identity, API versioning, mobile stores, or shared backend deployment.

Local installed-user persistence is active. Cross-device persistence is not.

Misleading terminology

The following substitutions must be avoided:

EXE = installer
one-file = installed
portable = stores data beside executable
packaged = validated
version constant = release versioning system
bundled database = user database
build succeeded = release succeeded
resource path = current working directory

Canonical-register drift

The checkpoint-to-KANBAN numbering discrepancy must be reconciled before any KANBAN materialization. Reusing apparently absent identifiers would create duplicated semantic ownership.

Tool-driven promotion

A selected packaging or installer product should not automatically receive a canonical concept. Canonical promotion should depend on reusable learning evidence, not tool presence.

Evidence still required

Repository evidence is still needed to determine:

the complete dependency graph, including transitive Qt components;

whether additional non-code resources exist beyond SQL files;

whether icons, metadata, translations, or Qt plugins require explicit collection;

whether sys.path.insert(...) is needed, harmless, or problematic in the frozen artifact;

whether resource lookup behaves identically in one-file and one-folder modes;

how the chosen artifact exposes application version metadata;

whether installed upgrades preserve %LOCALAPPDATA%\Markei\market.sqlite;

whether migration failure has a safe recovery path;

whether the artifact launches on a clean Windows environment;

whether antivirus products flag the resulting artifact;

whether rollback means application rollback only or application-plus-database rollback.

These are evidence gaps, not permission for Didactic Chat to design the installer.

Deferred subjects

Sprint 02:
- mobile framework
- mobile UI
- API/backend
- synchronization
- accounts and authentication
- cross-device identifiers
- desktop/mobile coexistence architecture
- mobile distribution

Later release hardening:
- production signing certificate acquisition
- automated update channel
- formal rollback mechanism
- byte-identical deterministic builds
- CI release pipeline

11. Didactic Stage Draft

# B_DIDACTIC.md

> Status: Functional didactic staging
> Cycle: 05
> Sprint: 01
> Domain: Didactic
> Authority: Didactic Chat analysis for Main synthesis
> Persistence class: Non-canonical functional stage
> Scope: Minimum learning model for Markei Windows packaging, installation, persistence, and release validation

---

## 1. Human Direction

Cycle 05 is divided into:

```text
Sprint 01
Quick, intuitive Windows desktop installation and executable preparation.

Sprint 02
Repository-clone preparation for the shortest responsible route to mobile implementation.

This stage concerns Sprint 01 only.

API, backend, synchronization, accounts, authentication, mobile framework selection, and cross-device persistence remain deferred unless required to clarify a packaging boundary.

2. Recovered Baseline

Current application boundary:

Desktop UI
→ ProductService
→ Repository
→ SQLite

Current source entry chain:

main.py
→ app.main.main()
→ QApplication
→ MainWindow
→ Qt event loop

Current dependency declaration:

PySide6

Current packaging-relevant persistence behavior:

bundled resource base
→ app/database/schema.sql
→ optional app/database/seed.sql

user-data base
→ %LOCALAPPDATA%\Markei
→ market.sqlite

connect() initializes a missing user database and applies idempotent migrations to an existing database.

Current application metadata includes:

APP_NAME = "Markei"
VERSION = "0.1.0"

3. Reconciliation Finding

The Didactic checkpoint references identifiers not present in the visible canonical KANBAN register.

Checkpoint maxima:

&&&19
&&%08
&%%14
%%%09

Visible canonical-register maxima:

&&&14
&&%06
&%%12
%%%08

Treat all checkpointed identifiers as occupied.

New proposals begin at:

&&&20
&&%09
&%%15
%%%10

This is didactic drift requiring later Main reconciliation and materialization review.

4. Sprint 01 Learning Transformation

developer-run Python project
→ frozen or collected application
→ distributable executable/application bundle
→ portable or installed Windows distribution
→ writable per-user state
→ versioned and validated release artifact

Developer-run execution relies on a separately installed interpreter, source tree, dependency environment, and development launch command.

Packaged execution supplies collected runtime components, dependencies, entrypoint, and bundled resources.

Installation is separate from packaging. It places and registers a packaged application for ordinary user launch.

Installed application files must remain separate from persistent user data.

A successful packaging command is not sufficient evidence of a valid release.

5. Critical Distinctions

packaging
is not
installation

executable
is not
installer

bundled schema/resource
is not
writable user database

application behavior
is not
build configuration

repository/development database
is not
installed-user database

build-time dependency
is not
runtime dependency

portable distribution
is not
installed distribution

successful build
is not
validated release

6. Proposed Canonical Concepts

&&&20 — Packaged Application Lifecycle

Purpose:

Define the complete learning path from source execution through packaging, distribution, installation, persistent state, upgrade, and release validation.

Prerequisites:

&&&03
&&&18
&&&19

Initial status:

Red

&&&21 — Packaging Versus Installation

Purpose:

Separate artifact production from machine-level deployment and registration.

Prerequisites:

&&&20

Initial status:

Red

&&&22 — Resource State Versus User State

Purpose:

Separate replaceable bundled application resources from persistent writable user data.

Prerequisites:

&&&02
&&&08
&&&20

Initial status:

Yellow

Markei evidence:

schema.sql / seed.sql
versus
%LOCALAPPDATA%\Markei\market.sqlite

&&&23 — Build-Time Versus Runtime Dependency

Purpose:

Separate tools that produce Markei from components required when packaged Markei executes.

Prerequisites:

&&&20

Initial status:

Red

&&&24 — Reproducible Build Process

Purpose:

Explain how controlled build inputs, dependency versions, environment, configuration, and commands permit equivalent artifacts to be regenerated.

Prerequisites:

&&&20
&&&23

Initial status:

Red

&&&25 — Successful Build Versus Validated Release

Purpose:

Require clean-environment launch, resource, persistence, migration, and workflow evidence beyond packaging-command completion.

Prerequisites:

&&&16
&&&20
&&&21

Initial status:

Red

&&&26 — Release Version and Compatibility Contract

Purpose:

Connect source version, artifact version, installer version, persisted-data compatibility, migration, upgrade, and rollback expectations.

Prerequisites:

&&&03
&&&20
&&&22

Initial status:

Red

&&%09 — Frozen Python Execution Context

Purpose:

Explain Python behavior under frozen execution, including sys.frozen, sys._MEIPASS, sys.executable, __file__, working-directory independence, import collection, and bundled-resource discovery.

Prerequisites:

&&&20
relative/absolute path understanding

Initial status:

Yellow

Markei evidence:

if getattr(sys, "frozen", False):
    ...

&%%15 — Markei Installed Data Lifecycle

Purpose:

Unify per-user database location, first-launch creation, existing-data preservation, migration, upgrade compatibility, and recovery expectations.

Prerequisites:

%%%01
&&&22
&&&26

Initial status:

Yellow

7. Glossary Candidates

Derived from the proposed canonical concepts:

source execution
packaged execution
frozen application
entrypoint
direct dependency
transitive dependency
dependency closure
build-time dependency
runtime dependency
build environment
build artifact
application bundle
executable
installer
one-file distribution
one-folder distribution
portable application
installed application
bundled resource
resource base
writable user data
user-data directory
first-launch initialization
idempotent migration
release artifact
clean-environment validation
reproducible build process
deterministic build
upgrade compatibility
rollback
packaging configuration

Glossary-only release-hardening terms:

code signing
antivirus false positive
publisher reputation

No packaging tool should receive canonical treatment merely because it is selected.

8. Learning Dependency Spine

entrypoint
↓
source execution versus frozen execution
↓
direct / transitive dependencies
↓
build-time / runtime dependency
↓
build environment
↓
reproducible build process
↓
packaging versus installation
↓
portable / installed distribution
↓
bundled-resource discovery
↓
resource state versus user state
↓
first-launch initialization
↓
installed database migration
↓
release version and compatibility
↓
successful build versus validated release
↓
optional signing / antivirus / rollback hardening

9. Markei Learning Spine

main.py
↓
app/main.py
↓
QApplication / MainWindow
↓
PySide6 runtime collection
↓
frozen execution context
↓
resource_base()
↓
schema.sql and seed.sql
↓
user_data_dir()
↓
%LOCALAPPDATA%\Markei\market.sqlite
↓
initialize()
↓
migrate()
↓
VERSION
↓
packaged artifact
↓
portable or installed delivery
↓
clean-environment validation

10. Proposed Concept-Map Checkpoint

Current milestone:

Cycle 05 — Sprint 01
Windows Desktop Packaging and Installation Readiness

Stable concepts:

None fully Green.

Active existing concepts:

&&&03
&&&08
&&&15
&&&16
&&&18
&&&19
&&%04
&%%12
%%%01

Active proposed concepts:

&&&20
&&&21
&&&22
&&&23
&&&24
&&&25
&&&26
&&%09
&%%15

Next learning work:

Trace the packaged entrypoint.

Explain frozen execution.

Classify dependency categories.

Trace bundled schema discovery.

Trace installed-user database creation and migration.

Separate executable, bundle, portable distribution, installer, and installed application.

Connect version identity to database compatibility.

Define artifact-level release validation.

11. Risks and Deferrals

Risks:

treating executable and installer as synonyms;

storing user data inside replaceable application files;

assuming the working directory is the repository root;

confusing packaging-tool behavior with application behavior;

treating successful artifact creation as release validation;

overloading the sprint with signing, CI, update servers, or strict deterministic-build requirements;

reusing KANBAN numbers absent from the canonical register but present in the checkpoint;

promoting a packaging product instead of the reusable concept it demonstrates.

Implementation evidence still required:

complete dependency closure;

Qt plugin/resource collection behavior;

complete non-code resource inventory;

one-file versus one-folder resource behavior;

clean Windows launch;

first-launch database creation;

existing database reopening;

migration under packaged execution;

upgrade preservation;

release metadata consistency;

antivirus behavior;

rollback boundary.

Deferred to Sprint 02:

mobile framework
mobile UI
backend/API
synchronization
accounts/authentication
cross-device persistence
mobile distribution

Deferred release hardening:

production code-signing acquisition
automated updater
formal rollback automation
byte-identical deterministic builds
CI release publishing

12. Stage Status

This document is functional Didactic staging.

It does not:

promote concepts into 02_KANBAN.md;

update 07_GLOSSARY.md;

update 08_CONCEPT_MAP.md;

select a packaging tool;

design an installer;

authorize source changes;

begin Sprint 02;

establish that a release artifact has been built or validated.

Main Chat should reconcile this stage with Operational and Design evidence before preparing any didactic materialization instructions.


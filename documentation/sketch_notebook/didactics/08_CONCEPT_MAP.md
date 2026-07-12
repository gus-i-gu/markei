# 08_CONCEPT_MAP.md

> Domain: Didactic
> Status: Cycle 06 checkpoint
> Authority: Didactic Chat [A]
> Canon source: `02_KANBAN.md`
> Derivative source: `07_GLOSSARY.md`
> Evidence sources: `DEV_STAGE/E_DDC_STAGE.md`, `DEV_STAGE/H_DDC_CODEX.md`, `DEV_STAGE/G_OPS_CODEX.md`, and `[M]_STAGE/J_[M]_STAGE.md`
> Current milestone: Cycle 06 — fully executable and installable Windows primary beta

---

## Current Milestone

Markei's current learning focus is the distinction between release configuration, generated artifacts, execution contexts, lifecycle validation, and acceptance.

Current project evidence:

```text
configured: yes
built: yes
launched: yes — frozen isolated launch and reopen
installed: blocked
validated: partial
accepted: no
```

The frozen runtime is built and partially validated. Installer source exists, but installer compilation is blocked by missing `ISCC.exe`; installed workflows and lifecycle behavior remain unvalidated.

---

## Maturity State

### Green

None. Repository evidence and passing tests demonstrate implementation state, not learner mastery.

### Yellow — current relevant concepts

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

### Red — active learning areas

```text
&&&04  Resource Ownership and Lifetime
&&&05  Evidence State and Validation Boundary

&&%03  Context Manager and Deterministic Cleanup
&&%04  Source, Frozen, and Installed Execution Context

&%%05  Statement Atomicity Versus Workflow Atomicity
&%%06  Packaging and Installation Artifact Lifecycle

%%%02  SQLite Connection and Cursor Ownership
%%%06  Build-Time, Runtime, and Installer-Time Dependency
```

The four Cycle 06 additions remain Red. Existing Red cleanup and atomicity concepts retain their maturity.

---

## Dependency Spine

```text
&&&01 Responsibility Boundary
├──→ &&&03 Naming as Data Contract
│    └──→ &&&05 Evidence State and Validation Boundary
│         ├──→ &&%04 Source, Frozen, and Installed Execution Context
│         │    ├──→ &%%06 Packaging and Installation Artifact Lifecycle
│         │    │    └──→ %%%06 Build-Time, Runtime, and Installer-Time Dependency
│         │    └──→ %%%05 Bundled Resource Versus Writable User Data
│         └──→ &&&04 Resource Ownership and Lifetime
│              ├──→ &&%03 Context Manager and Deterministic Cleanup
│              └──→ %%%02 SQLite Connection and Cursor Ownership
│
├──→ &&%01 Package and Module Boundary
│    ├──→ &%%01 Application Service
│    │    ├──→ &%%02 Repository Pattern and Persistence Adapter
│    │    │    ├──→ %%%01 SQLite Initialization Versus Migration
│    │    │    ├──→ %%%03 SQLite PRAGMA and Connection Configuration
│    │    │    └──→ &%%05 Statement Atomicity Versus Workflow Atomicity
│    │    └──→ &%%04 Database Row, Domain Model, and View Model
│    └──→ &%%03 Presentation Adapter
│
└──→ &&&02 Raw Data Versus Derived Data
     └──→ &%%04 Database Row, Domain Model, and View Model
```

Compact Cycle 06 route:

```text
&&&01 / &&&03
→ &&&05
→ &&%04
→ &%%06
→ %%%06
```

---

## Project Learning Spine

```text
source
→ packaging configuration (`Markei.spec`)
→ frozen distribution (`dist/Markei`)
→ frozen launch — evidenced
→ installer configuration (`installer/Markei.iss`)
→ compiled installer — blocked
→ installed execution — blocked
→ lifecycle validation — pending
→ Main/human acceptance — pending
```

The application runtime beneath those release stages remains:

```text
Desktop presentation
→ ProductService
→ Repository
→ database lifecycle manager
→ SQLite
```

The release context changes resource collection, dependency availability, launch path, installed placement, diagnostics, and evidence requirements; it does not create a different business architecture.

---

## Critical Distinctions

```text
configuration ≠ generated artifact
artifact creation ≠ successful launch
frozen launch ≠ installed launch
external data placement ≠ validated retention
installer source ≠ compiled installer
validation under one context ≠ validation under every context
implementation success ≠ learner mastery
validation ≠ Main/human acceptance
```

Cycle 06 shutdown evidence illustrates the validation boundary: the initial focused close probe failed, a bounded `MainWindow` correction was introduced, and source/frozen shutdown and immediate reopen then passed. Installed shutdown remains outside the demonstrated boundary.

---

## Resource and User-State Spine

```text
schema.sql
    bundled production resource

seed.sql
    development/test fixture; excluded from primary beta package

market.sqlite
    retained writable user state under %LOCALAPPDATA%/Markei

*.sqlite-wal / *.sqlite-shm
    transient writable SQLite companions

startup.log
    generated writable diagnostics
```

This classification teaches ownership and location. Uninstall retention is configured but not yet validated through an installed lifecycle.

---

## Installed-Lifecycle Blocker

The next project state cannot be learned as completed until evidence exists for:

```text
provide Inno Setup / ISCC.exe
→ compile installer
→ inspect installer artifact
→ clean install
→ Start Menu launch
→ Register / Lists / History / Settings workflows
→ close and immediate reopen
→ persistence verification
→ upgrade or compatible reinstall
→ uninstall with accepted retention behavior
→ reinstall and retained-data recovery
→ SmartScreen / antivirus observations
→ human acceptance
```

Until then:

```text
installed: blocked
accepted: no
```

---

## Immediate Next Learning Evidence

1. Observe the difference between installer configuration and the compiled installer artifact.
2. Trace the installed launch path without a development Python command or repository checkout.
3. Compare application files under the install directory with writable state under `%LOCALAPPDATA%/Markei`.
4. Capture persistence evidence across close/reopen, upgrade, uninstall, and reinstall.
5. Record Windows reputation/security observations separately from application correctness.
6. Revisit the four Red Cycle 06 concepts after installed lifecycle evidence, without automatic Green promotion.

---

## Recovery Route

```text
1. Read this checkpoint.
2. Read 07_GLOSSARY for concise terminology.
3. Read targeted 02_KANBAN entries for complete concept structure.
4. Read 13_LECTURE_REGISTER when chronology or learning evolution matters.
5. Read E/H/G/J only when evidence classification or drift requires it.
6. Inspect the exact implementation files only when permanent memory is insufficient.
```

---

## Session Delta

Cycle 06 added four canonical Red concepts, derived release terminology, and a current project learning spine. The checkpoint now reflects contemporary recovery-branch evidence rather than the stale Cycle 05 packaging milestone. No concept became Green, no installed lifecycle was inferred, and no acceptance was claimed.
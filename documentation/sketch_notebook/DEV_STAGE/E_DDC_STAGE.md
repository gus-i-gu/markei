# DEV_STAGE/E_DDC_STAGE.md

> Status: Active Main materialization stage
> Authority: Main Chat
> Persistence class: Materialization stage material
> Cycle: 05
> Sprint: 01 — Windows Desktop Installation
> Domain: Didactic evidence materialization
> Scope: Evidence capture for packaged execution, installation, persistent user state, and release validation
> Codex report target: `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`

---

# Cycle 05 Sprint 01 Didactic Materialization Stage

## 1. Purpose

This file is direct evidence-reporting authority for Codex.

While implementing D_OPS_STAGE.md under the architectural guardrails of F_DSN_STAGE.md, capture implementation-backed learning evidence for later Didactic Chat reconciliation.

Codex reports evidence. Codex does not decide semantic promotion.

## 2. Mandatory Context Bootstrap

Read first:

```text
AGENTS.md
```

Then load into active context in exactly this order:

```text
documentation/sketch_notebook/INDEX.md
↓
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
↓
documentation/sketch_notebook/methodology/FLUX.md
↓
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
↓
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
```

Keep the combined context active throughout implementation and evidence reporting.

Then read:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

D/E/F are direct materialization authority. A/B/C are supporting inputs only.

## 3. Recovery Economy

Use the least expensive sufficient source:

```text
AGENTS.md
→ INDEX.md
→ methodology bootstrap
→ E plus coordinated D/F instructions
→ implementation evidence produced by the task
→ H report
```

Do not read the complete KANBAN, glossary, concept history, or other permanent didactic files unless a staged ambiguity cannot be resolved from B_DIDACTIC.md and the checkpoint route.

Do not duplicate long code or repeat D/F operational detail inside H.

## 4. Strict Notebook Write Boundary

Codex must not modify:

```text
documentation/sketch_notebook/methodology/
documentation/sketch_notebook/operational/
documentation/sketch_notebook/didactics/
documentation/sketch_notebook/design/
documentation/sketch_notebook/[M]_STAGE/
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

The didactic report write authorized by this stage is:

```text
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
```

G and I are authorized by their corresponding stages.

Do not promote concepts or edit permanent didactic memory.

## 5. Didactic Invariants

Preserve these distinctions in implementation evidence:

```text
source execution ≠ packaged execution
packaging ≠ installation
executable ≠ installer
build-time dependency ≠ runtime dependency
bundled resource ≠ writable user data
schema initialization ≠ sample-data seeding
empty database ≠ broken database
development fixture ≠ production default
successful build ≠ validated release
portable application ≠ installed application
desktop packaging ≠ mobile implementation
```

Do not infer learning maturity from a successful build.

## 6. Concept Candidates to Observe

Use identifiers from B_DIDACTIC.md only as staged references:

```text
&&&20 — Packaged Application Lifecycle
&&&21 — Packaging Versus Installation
&&&22 — Resource State Versus User State
&&&23 — Build-Time Versus Runtime Dependency
&&&24 — Reproducible Build Process
&&&25 — Successful Build Versus Validated Release
&&&26 — Release Version and Compatibility Contract
&&%09 — Frozen Python Execution Context
&%%15 — Markei Installed Data Lifecycle
```

Report numbering drift if observed. Do not materialize these entries into permanent files and do not assign final Green/Yellow/Red status.

## 7. Required Learning Evidence

### 7.1 Entrypoint

Report:

- the PyInstaller entrypoint;
- root-to-application delegation;
- whether source and packaged execution share the same startup function;
- whether source-only path manipulation remains necessary.

### 7.2 Frozen Python execution

Report observed behavior involving:

```text
sys.frozen
_MEIPASS
sys.executable
__file__
current working directory
source resource lookup
packaged resource lookup
```

Do not generalize beyond observed implementation evidence.

### 7.3 Dependencies

Separate:

```text
application runtime dependencies
build-only dependencies
transitive packaged components
external installer tooling
```

Record declaration locations, version constraints, and Qt components requiring explicit collection.

### 7.4 Packaging and installation

Report separately:

```text
PyInstaller input and output
Inno Setup input and output
installed application state
```

Identify which tool owns each transition.

### 7.5 Resource state

Classify implementation evidence for:

```text
schema.sql
sample seed or development fixture
icons
version metadata
Qt plugins
installed runtime files
```

### 7.6 User state

Report:

- where `market.sqlite` is created;
- which component creates it;
- whether the installer touches it;
- persistence across restart, upgrade, uninstall, and reinstall;
- observed SQLite sidecars;
- documented backup guidance.

### 7.7 Initialization versus seeding

Report:

- how schema creation occurs;
- how production avoids sample business rows;
- how mandatory settings are created;
- whether initialization succeeds without production seed data;
- whether sample data remains only as an explicit fixture.

### 7.8 Empty state

Report observed behavior of Register, Lists, History, and Settings under zero products, purchases, stores, and user-created categories.

For each correction identify:

1. failed assumption;
2. narrow implementation change;
3. resulting behavior.

### 7.9 Release version

Report how version information reaches runtime, executable metadata, installer metadata, and artifact naming. Identify duplicated version truth.

### 7.10 Validation layers

Separate:

```text
build completion
runtime launch
seed-free first launch
first-data persistence
installer launch
upgrade
uninstall and reinstall
failure-path behavior
clean-profile or clean-machine behavior
```

Do not merge these into one success statement.

## 8. Existing Concepts to Reinforce

Where implementation evidence supports them, report reinforcement of:

- Naming as Data Contract;
- Configuration State;
- Default Value as Fallback Contract;
- Validation Boundary;
- Adapter Boundary;
- Capability Versus Placeholder;
- SQLite Schema Evolution;
- Service Contract Stability;
- Platform-Neutral Read-Model Shape.

Do not assign final status.

## 9. Tool-Specific Knowledge Policy

PyInstaller and Inno Setup are project tooling and implementation evidence. They do not automatically become canonical concepts.

Use tool behavior only to evidence reusable concepts:

```text
PyInstaller resource collection
→ packaged-resource discovery

Inno Setup uninstall policy
→ installation lifecycle

Qt plugin collection
→ runtime dependency closure
```

## 10. Explicit Deferrals

```text
mobile framework
mobile UI
backend/API
authentication
synchronization
cross-device persistence
mobile stores
MSIX
Microsoft Store
automatic updater
production signing-certificate acquisition
remote crash reporting
strict byte-identical deterministic builds
full CI release publishing
```

One-file execution remains a deferred alternative.

## 11. H_DDC_CODEX.md Report Contract

Write:

```text
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
```

Required sections:

1. Bootstrap and stage files read.
2. Implementation events observed.
3. Concept candidates by proposed identifier.
4. Existing concepts reinforced.
5. Entrypoint evidence.
6. Source versus frozen execution evidence.
7. Build-time versus runtime dependency evidence.
8. Packaging versus installation evidence.
9. Executable versus installer evidence.
10. Bundled-resource evidence.
11. Writable-user-state evidence.
12. Schema initialization versus seeding evidence.
13. Empty-database evidence.
14. Installed SQLite lifecycle evidence.
15. Release-version evidence.
16. Successful build versus validated release evidence.
17. Tool-specific observations.
18. Concept-numbering or notebook drift observed.
19. Concepts not ready for canon.
20. Deferred concepts.
21. Remaining didactic risks.
22. Suggested Didactic Chat follow-up.

Keep the report compact, factual, and evidence-oriented. Do not reproduce complete source files.

## 12. Completion Boundary

Complete after enough implementation evidence exists for Didactic Chat to evaluate how Markei changed from a source-run project into an installable application without confusing application state, build state, installation state, and user state.

Do not promote concepts. Do not update permanent didactic memory. Do not begin Sprint 02.

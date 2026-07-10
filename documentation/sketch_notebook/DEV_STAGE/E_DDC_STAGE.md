# DEV_STAGE/E_DDC_STAGE.md

> Status: Active Main materialization stage
> Authority: Main Chat
> Persistence class: Materialization stage material
> Cycle: 05
> Sprint: 01 — Windows Desktop Installation
> Scope: Didactic evidence capture for packaged execution, installation, persistent user state, and release validation

---

# Cycle 05 Sprint 01 Didactic Materialization Stage

## 1. Purpose

This stage instructs Codex to capture implementation-backed learning evidence while materializing the Windows installation path.

Codex must report into:

```text
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
```

Codex must not promote concepts or edit permanent didactic memory.

## 2. Mandatory Bootstrap

Load into active context, in exactly this order:

```text
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/FLUX.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
```

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

Use only `documentation/sketch_notebook/` as the notebook root.

## 3. Didactic Boundary

Codex reports evidence. Codex must not:

- declare concepts canonical;
- assign final learning status;
- repair or reuse KANBAN numbers;
- rewrite the glossary or concept map;
- promote a packaging tool into canonical truth;
- infer learning maturity from a successful build.

## 4. Distinctions to Preserve

Report evidence that keeps these distinctions explicit:

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

## 5. Concept Candidates to Observe

Use identifiers from `B_DIDACTIC.md` only as stage references:

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

Report numbering drift. Do not materialize these entries into permanent didactic files.

## 6. Required Learning Evidence

### Entrypoint

Report:

- the PyInstaller entrypoint;
- root-to-application delegation;
- whether source and packaged execution share the same startup function;
- whether source-only path manipulation remains necessary.

### Frozen Python execution

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

### Dependencies

Separate and report:

```text
application runtime dependencies
build-only dependencies
transitive packaged components
external installer tooling
```

Record declaration locations, version constraints, and Qt components requiring explicit collection.

### Packaging and installation

Report separately:

```text
PyInstaller input and output
Inno Setup input and output
installed application state
```

Identify which tool owns each transition.

### Resource state

Classify:

```text
schema.sql
seed or development fixture
icons
version metadata
Qt plugins
installed runtime files
```

### User state

Report:

- where `market.sqlite` is created;
- which component creates it;
- whether the installer touches it;
- persistence across restart, upgrade, uninstall, and reinstall;
- observed SQLite sidecars;
- documented backup guidance.

### Initialization versus seeding

Report:

- how schema creation occurs;
- how production avoids sample business rows;
- how mandatory settings are created;
- whether initialization succeeds without production `seed.sql`;
- whether sample data remains only as an explicit fixture.

### Empty state

Report observed behavior of Register, Lists, History, and Settings under zero products, purchases, stores, and user-created categories.

For every correction identify:

1. the failed assumption;
2. the narrow implementation change;
3. the resulting behavior.

### Release version

Report how version information reaches runtime, executable metadata, installer metadata, and artifact naming. Identify duplicated version truth.

### Validation layers

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

Do not merge them into a single success claim.

## 7. Existing Concepts to Reinforce

Where evidence supports them, report reinforcement of:

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

## 8. Tool-Specific Knowledge Policy

PyInstaller and Inno Setup are project tooling and implementation evidence. They do not automatically become canonical concepts.

Use tool behavior to demonstrate reusable concepts, for example:

```text
PyInstaller resource collection
→ packaged-resource discovery evidence

Inno Setup uninstall policy
→ installation-lifecycle evidence

Qt plugin collection
→ runtime dependency-closure evidence
```

## 9. Explicit Deferrals

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

## 10. H_DDC_CODEX.md Report Shape

After materialization write:

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

Keep the report compact and evidence-oriented. Do not reproduce complete source files.

## 11. Completion Boundary

Complete after sufficient evidence exists for Didactic Chat to evaluate how Markei changed from a source-run project into an installable application without confusing application state, build state, installation state, and user state.

Do not promote concepts or begin Sprint 02.

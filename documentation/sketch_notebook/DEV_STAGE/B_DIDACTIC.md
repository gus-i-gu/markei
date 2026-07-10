# Didactic Checkpoint Recovery Retrospective

> Status: Ephemeral functional staging
> Role: Didactic Chat [A]
> Branch: `sketch-notebook-recovery`
> Scope: Main-branch commit retrospective through the Cycle 05 naming transition, reconciled against current didactic canon
> Knowledge state: Historical evidence and checkpoint preparation; not canonical knowledge
> Permanent target: `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md`

---

## 1. Purpose

This stage temporarily preserves the commit retrospective required to rebuild the Didactic checkpoint after canonical and derivative repopulation.

The retrospective is bounded around the transition from closed Cycle 04 into the competing Cycle 05 directions. It does not reproduce every historical commit or restore the former checkpoint verbatim.

```text
current 02_KANBAN canon
+ current repository recovery baseline
+ main-branch commit sequence through Cycle 05
= compact current checkpoint
```

Commit history explains how the current learning state emerged. It does not override current canon.

---

## 2. Retrospective Boundary

```text
Cycle 04 domain reconciliation and global closure
↓
post-Cycle 04 recovery scheme
↓
Cycle 05 mobile-preparation synthesis
↓
Cycle 05 mobile-development planning session
↓
cycle 5.0 outburst mode
↓
Cycle 05 Sprint 01 packaging reconciliation
↓
desktop packaging operational model
```

Relevant commits:

```text
1e07b48  Reconcile Cycle 04 didactic checkpoint
c84e850  Close Cycle 04 global project state
bd4b4cd  Prepare post-Cycle 04 recovery scheme
e9cf0f0  Stage Cycle 05 mobile preparation synthesis
a4f7732  Prepare Cycle 05 mobile development planning session
c51938b  cycle 5.0 outburst mode
11a931f  Reconcile Cycle 05 Sprint 01 operational checkpoint
bc4d3a5  Reconcile Cycle 05 Sprint 01 operational TODO
b29aec0  Reconcile Cycle 05 Sprint 01 didactic checkpoint
d4a1448  Append Cycle 05 Sprint 01 operational evidence
fbeef65  Add desktop packaging operational model
```

This range exposes the last closed baseline, the failed intended cycle, the pivot, the packaging evidence, and the unresolved completion boundary.

---

## 3. Closed Baseline Before the Failed Cycle

Cycle 04 closed with:

```text
Desktop UI
→ ProductService
→ Repository
→ SQLite
```

The project had service-owned business interpretation, generic repository persistence, platform-neutral semantic values, consolidated Lists views, History analytics, Settings validation, and separation between UI labels and persisted meanings.

The forward state still carried human verification gaps around Settings interaction, store editing and refresh, first-weekday period-end correctness, and broad desktop regression evidence.

---

## 4. Failed Preceding Cycle: Mobile Preparation

The first Cycle 05 direction was preparation for full mobile implementation. Its declared exit conditions required decisions about mobile product scope, reusable core boundaries, typed contracts, dependency construction, persistence and synchronization, backend/API responsibility, identity and security, mobile framework, migration, automated validation, and phased implementation.

The planning documents prohibited broad mobile coding before those dependencies were reconciled.

That cycle did not reach its declared exit conditions. Before product scope, data ownership, synchronization, backend, identity, framework, and migration decisions were resolved, the lineage pivoted into `cycle 5.0 outburst mode` and then a Windows desktop packaging sprint.

The first Cycle 05 direction is checkpointed as:

```text
historically significant
+ useful for exposing missing decisions
+ incomplete
+ superseded as active implementation direction
```

It must not be represented as completed mobile preparation, implemented mobile architecture, or accepted target design.

Its principal lesson is capability versus readiness: a planning document and reusable service boundary do not prove that a second platform is ready to build.

---

## 5. Cycle 05 Pivot: Desktop Packaging

The pivot changed the active learning topic from mobile architecture preparation to Windows packaging and installation.

```text
source application
→ PyInstaller one-folder frozen runtime
→ bundled schema resource
→ per-user writable SQLite state
→ first-launch initialization and migration
→ Inno Setup installer configuration
→ installed-lifecycle validation pending
```

Verified evidence included a generated and launched frozen runtime, working-directory-independent schema discovery, schema-only first launch, seed-free production business state, `%LOCALAPPDATA%/Markei` writable data, resource/data separation, pinned dependencies, and construction of the four public pages.

Configured but incomplete were Inno Setup compilation, installed Start Menu launch, upgrade preservation, uninstall/reinstall lifecycle, SmartScreen and antivirus observation, signing, and rollback. The immediate blocker was unavailable `ISCC.exe`.

The sprint produced a validated frozen runtime, not a fully validated installed release.

---

## 6. Conflict Against Current Canon

The current `02_KANBAN.md` is a fresh recovery canon. Historical identifiers from the former checkpoint are not imported unless represented in current canon.

### Canon reinforced by the retrospective

```text
&&&01 Responsibility Boundary
&&&02 Raw Data Versus Derived Data
&&&03 Naming as Data Contract
&&&04 Resource Ownership and Lifetime
&&%01 Package and Module Boundary
&&%03 Context Manager and Deterministic Cleanup
&%%01 Application Service
&%%02 Repository Pattern and Persistence Adapter
&%%03 Presentation Adapter
&%%04 Database Row, Domain Model, and View Model
&%%05 Statement Atomicity Versus Workflow Atomicity
%%%01 SQLite Initialization Versus Migration
%%%02 SQLite Connection and Cursor Ownership
%%%03 SQLite PRAGMA and Connection Configuration
%%%05 Bundled Resource Versus Writable User Data
```

Packaging-specific historical lessons—frozen execution, packaging versus installation, build-time versus runtime dependencies, reproducible builds, version compatibility, and successful build versus validated release—remain historical or next-concept material pending explicit promotion under the refreshed numbering system.

### Unresolved questions

- application-level shutdown ownership;
- deterministic closure of four page-owned chains;
- workflow transaction boundaries;
- breadth of ProductService and Repository;
- completeness of abstract contracts;
- dictionary versus typed view models;
- migration versioning;
- promotions-table status;
- `pages.order` drift;
- production seed policy;
- installer lifecycle validation;
- mobile product and architecture direction.

---

## 7. Checkpoint Reconstruction Decision

```text
The notebook recovered the contemporary layered desktop system,
repopulated Didactic canon and glossary,
and reconstructed learning state after a failed mobile-preparation cycle
followed by a partially completed desktop-packaging pivot.
```

No concept becomes Green solely from code or packaging evidence. Yellow marks strongly evidenced concepts still requiring reinforcement. Red marks ownership, cleanup, and transaction concepts tied to unresolved behavior or decisions.

### Proposed checkpoint state

Stable concepts: none confirmed Green through explicit human learning validation.

Active concepts:

```text
&&&01 &&&02 &&&03
&&%01 &&%02
&%%01 &%%02 &%%03 &%%04
%%%01 %%%03 %%%04 %%%05
```

Unstable concepts:

```text
&&&04
&&%03
&%%05
%%%02
```

Next concepts:

- packaged execution versus source execution;
- packaging versus installation;
- build dependency versus runtime dependency;
- successful build versus validated release;
- application composition root and shutdown ownership;
- workflow transaction boundary;
- explicit migration/version compatibility;
- second-platform readiness versus implementation.

These are checkpoint recommendations, not canonical concepts.

---

## 8. Stage Exit

This retrospective is ready to compress into `08_CONCEPT_MAP.md`.

After checkpoint materialization, this DEV_STAGE content remains ephemeral evidence. `13_LECTURE_REGISTER.md` remains empty until explicit observational registration. The failed Cycle 05 mobile-preparation attempt may later become the first observational metadata entry once checkpoint completion is accepted.

---

## 9. Appended Methodological Learning Note — Why Cycle 05 Failed

Cycle 05 did not fail because no useful work occurred. It failed as a **controlled learning and coordination cycle** because its declared question, completion criteria, and active execution direction stopped referring to the same object.

The cycle began with a broad but explicit learning objective:

```text
understand and order the prerequisites for mobile implementation
```

That objective required unresolved product, architecture, persistence, synchronization, identity, migration, contract, and validation decisions to be made visible and reconciled before implementation. The planning artifacts correctly identified those dependencies, but the methodology did not preserve them as enforced stop conditions when the active direction changed.

The decisive breakdown was therefore:

```text
planned objective
≠ active sprint objective
≠ closure evidence
```

### 9.1 Scope changed without formal cycle redefinition

The project moved from mobile-preparation reasoning to desktop packaging execution. That pivot may have been locally valuable, but it was not first represented as a formally closed, suspended, or superseded mobile cycle followed by a newly named packaging cycle.

As a result, the label `Cycle 05` accumulated two incompatible meanings:

```text
Cycle 05 as mobile-readiness preparation
Cycle 05 as Windows packaging and installation
```

The shared name obscured the fact that the first objective remained incomplete while the second objective had different dependencies and evidence requirements.

### 9.2 Exit criteria were documented but not operationally binding

The mobile-preparation stage defined meaningful exit criteria. However, those criteria functioned as descriptive planning rather than as gates that prevented unrelated materialization from being interpreted as cycle progress.

Methodologically, an exit condition is useful only when later reconciliation asks:

```text
Was the condition satisfied?
Was it explicitly deferred?
Was the cycle cancelled or replaced?
```

Cycle 05 instead advanced through a pivot without recording one of those outcomes at the moment of transition.

### 9.3 Knowledge states were allowed to blur

The cycle mixed several maturity states:

- questions that had only been identified;
- proposed architecture that had not been accepted;
- packaging configuration that existed;
- frozen-runtime behavior that had been validated;
- installer lifecycle behavior that remained blocked.

Without strict state labels at the cycle level, “planned,” “configured,” “implemented,” and “validated” could appear as one stream of progress. The later packaging checkpoint repaired this distinction, but only after the cycle identity had already drifted.

### 9.4 Local success displaced global reconciliation

The packaging sprint produced concrete evidence quickly. That made it easier for immediate executable progress to dominate the broader unresolved mobile-preparation program.

This illustrates a methodological asymmetry:

```text
implementation success is visible immediately
unresolved coordination debt is visible only through reconciliation
```

When reconciliation is delayed, a successful local artifact can create the impression that the governing cycle is succeeding even though its original strategic exit conditions remain unmet.

### 9.5 The notebook captured activity better than transition meaning

The historical files recorded substantial analysis and implementation detail, but the transition itself lacked a compact authoritative statement such as:

```text
Mobile-preparation Cycle 05 is suspended as incomplete.
A separate Windows Packaging Sprint begins.
Its completion does not satisfy mobile-preparation exit criteria.
```

The absence of that statement allowed later checkpoints and identifiers to inherit mixed context. The recovery process had to reconstruct the distinction retrospectively from commits instead of reading it directly from a deliberate transition record.

### 9.6 Overall conceptual lesson

The central learning is that a development cycle is not defined only by chronological commits or a shared number. It is defined by the coherence of:

```text
objective
→ prerequisite decisions
→ authorized scope
→ evidence model
→ exit conditions
→ closure statement
```

When one of these changes materially, the cycle must be explicitly re-scoped, suspended, or closed. Otherwise, useful work can still occur while the cycle itself fails as a unit of project knowledge.

For future Sketch Notebook operation, a major pivot should require a small transition reconciliation containing:

1. the previous objective and its completion status;
2. unresolved items carried forward;
3. the reason for the pivot;
4. the new objective and evidence class;
5. whether the new work supersedes, suspends, or merely interrupts the former cycle;
6. separate exit criteria and naming when the semantic object has changed.

This note is observational and methodological. It does not redefine the current didactic canon. It is staged for later inclusion alongside the first recovery metadata in `13_LECTURE_REGISTER.md`.
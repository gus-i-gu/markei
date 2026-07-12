# E_DDC_STAGE — Cycle 06 Windows Primary Beta

> Status: Main-approved Didactic materialization stage
> Authority: Main Chat [M]
> Branch: `sketch-notebook-recovery`
> Source: `[M]_STAGE/J_[M]_STAGE.md`
> Codex report target: `DEV_STAGE/H_DDC_CODEX.md`

## 1. Objective

Materialize only the Didactic knowledge required to understand the first bounded Cycle 06 packaging and installation unit.

Do not create a broad release-engineering curriculum. Do not promote any concept to Green. Do not treat PyInstaller, Inno Setup, PowerShell, or Windows installer syntax as standalone foundational concepts.

## 2. Authorized Didactic Changes

Update the permanent Didactic files only as explicitly defined here:

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md
```

Preserve all existing identifiers and content unless a minimal correction is required for consistency.

## 3. New Canonical Candidates to Materialize

Add these four concepts using the full canonical KANBAN structure required by `CHAT_PROTOCOL.md`.

### `&&&05` — Evidence State and Validation Boundary

Core distinction:

```text
configured
≠ built
≠ launched
≠ installed
≠ validated
≠ accepted
```

The concept must explain that evidence maturity changes what can truthfully be claimed. A configuration describes intended behavior; a build proves artifact production; a launch proves one execution; installation proves deployment; validation proves specified behavior under defined conditions; acceptance is an authorized project decision based on sufficient evidence.

Required concepts:

```text
&&&01 Responsibility Boundary
&&&02 Raw Data Versus Derived Data
&&&03 Naming as Data Contract
```

Status:

```text
Red
```

Markei evidence must reference Cycle 06's distinction between existing packaging configuration and the unproven installed beta lifecycle.

### `&&%04` — Source, Frozen, and Installed Execution Context

Explain the three contexts:

```text
source execution
    Python interpreter runs repository modules/resources

frozen execution
    packaged executable runs collected code/resources

installed execution
    installer-placed frozen runtime runs through registered launch paths
```

Clarify working-directory, resource-resolution, dependency, and writable-state differences without implying three different business architectures.

Required concepts:

```text
&&&01 Responsibility Boundary
&&%01 Package and Module Boundary
%%%05 Bundled Resource Versus Writable User Data
```

Status:

```text
Red
```

### `&%%06` — Packaging and Installation Artifact Lifecycle

Explain this lifecycle:

```text
source configuration
→ generated frozen distribution
→ installer configuration
→ compiled installer
→ installed application
→ upgrade/uninstall/reinstall lifecycle
```

Emphasize that each arrow produces a different artifact or state and requires different evidence.

Required concepts:

```text
&&&01 Responsibility Boundary
&&&04 Resource Ownership and Lifetime
&&%04 Source, Frozen, and Installed Execution Context
%%%05 Bundled Resource Versus Writable User Data
```

Status:

```text
Red
```

### `%%%06` — Build-Time, Runtime, and Installer-Time Dependency

Define:

```text
build-time dependency
    required to produce the frozen artifact

runtime dependency
    required inside or alongside the running application

installer-time dependency
    required to compile or execute installation tooling
```

Use PyInstaller, collected PySide6/Qt components, and Inno Setup only as Markei implementation examples.

Required concepts:

```text
&&%01 Package and Module Boundary
&&%04 Source, Frozen, and Installed Execution Context
&%%06 Packaging and Installation Artifact Lifecycle
```

Status:

```text
Red
```

## 4. Existing Concepts to Reinforce

Add concise Cycle 06 project examples without changing maturity unless existing file rules require a normal update.

### `&&&01` Responsibility Boundary

Reinforce separation among application behavior, packaging collection, installer placement, validation evidence, and release acceptance.

### `&&&03` Naming as Data Contract

Reinforce the exact status vocabulary:

```text
configured
built
launched
installed
validated
accepted
blocked
unknown
```

### `&&&04`, `&&%03`, `%%%02`

Reinforce that deterministic cleanup and connection ownership are tested through close/reopen behavior. Missing centralized ownership is a risk/question, not proof of a leak.

### `%%%01` SQLite Initialization Versus Migration

Add seeding as a distinct project operation:

```text
initialization creates required structure
migration adapts existing state
seeding inserts initial rows
```

Do not create a separate seeding concept in this materialization.

### `%%%05` Bundled Resource Versus Writable User Data

Reinforce:

```text
schema.sql = bundled read-only resource
seed.sql = development/test fixture for this beta
market.sqlite = retained writable user state
WAL/SHM = transient writable companions
startup.log = generated writable diagnostics
```

External placement supports preservation but does not prove lifecycle preservation.

### `&%%05` Statement Atomicity Versus Workflow Atomicity

Retain the existing multi-commit risk as inherited validation debt. Do not present it as a packaging concept or as a proven beta failure.

## 5. Glossary Updates

Derive concise glossary entries for the four new canonical concepts.

Glossary entries must include the canonical KANBAN ID and must not introduce independent policy decisions.

Add or refine retrieval terms only when useful, including:

```text
frozen application
installed application
packaging artifact
installer artifact
validation boundary
build-time dependency
runtime dependency
installer-time dependency
```

Tool names may appear under Project Usage but must not become glossary truth independent from the concept.

## 6. Concept Map Refresh

Refresh `08_CONCEPT_MAP.md` to Cycle 06.

Required content:

```text
Current Milestone:
    Cycle 06 — fully executable and installable Windows primary beta

Stable Concepts:
    none Green unless already explicitly human-validated

Active/Yellow:
    existing responsibility, persistence, ownership, and cleanup concepts

Unstable/Red:
    &&&05
    &&%04
    &%%06
    %%%06
    relevant existing Red cleanup/atomicity concepts
```

Include a compact dependency spine:

```text
&&&01 / &&&03
→ &&&05
→ &&%04
→ &%%06
→ %%%06
```

Include the project learning spine:

```text
main.py source entrypoint
→ Markei.spec
→ one-folder distribution
→ installer source
→ compiled installer
→ installed launch
→ external user data
→ lifecycle validation
→ Main/human acceptance
```

Correct stale statements about the current milestone and Lecture Register state.

## 7. Lecture Register Entry

Append one observational entry for Cycle 06 staging.

Record:

- A/B/C functional analysis was reconciled by Main;
- four concepts were materialized as Red;
- existing concepts were reinforced;
- no concept became Green;
- installed lifecycle evidence remained pending at staging time;
- tool-specific evidence did not become standalone concepts.

Do not record future Codex execution as completed.

## 8. Consistency Requirements

Before writing:

- verify the highest occupied ID in each family;
- confirm the four staged IDs are still unoccupied;
- preserve numbering even if another file is stale;
- ensure glossary and Concept Map IDs match KANBAN exactly;
- avoid duplicating an existing concept under a new name;
- keep status Red for all four new concepts;
- do not encode seed, uninstall, identity, or shutdown policy as Didactic authority.

## 9. Prohibited Changes

Do not:

- promote any concept to Green;
- create concepts named PyInstaller, Inno Setup, PowerShell, or Windows Installer;
- create a separate seeding concept;
- rewrite unrelated KANBAN concepts;
- add mobile/backend/synchronization/authentication concepts;
- claim a build, installer, or release was validated before G evidence and human review;
- modify application or packaging source.

## 10. `H_DDC_CODEX.md` Report Contract

Report:

1. exact Didactic files modified;
2. concepts added with IDs and statuses;
3. existing concepts reinforced;
4. glossary entries added/refined;
5. Concept Map milestone and dependency spine changes;
6. Lecture Register entry appended;
7. numbering checks performed;
8. any conflict or duplicate discovered;
9. confirmation that no concept became Green;
10. confirmation that no source or non-Didactic file was modified through E.

The report is observational evidence, not canonical Didactic truth by itself.

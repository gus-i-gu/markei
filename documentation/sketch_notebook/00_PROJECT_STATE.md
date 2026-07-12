# 00_PROJECT_STATE.md

> Version: Cycle 07 Sprint 01 reconciliation 0.4
> Status: Active Global State Canon-Checkpoint
> Persistence Class: Canon-Checkpoint
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Branch: `cycle-07-mobile-preparation`
> Baseline: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Reconciliation source: `[M]_STAGE/J_[M]_STAGE.md`
> Scope: Concise accepted global state and low-cost recovery entrypoint

---

# 1. Global State

Cycle 06 is accepted and closed at the controlled Windows primary-beta boundary.

Cycle 07 is active as a mobile-development preparation and architecture-discovery cycle in the isolated `markei-mobile` clone and `cycle-07-mobile-preparation` branch.

Current state:

```text
Cycle 06 desktop beta: accepted and protected
Cycle 07 Sprint 01 investigation: complete
domain permanent-memory reconciliation: complete
mobile framework: not selected
mobile prototype: not implemented
implementation authorization: none
D/E/F: postponed
```

---

# 2. Accepted Desktop Baseline

Markei remains a local Python desktop application using PySide6 and SQLite.

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

The accepted Windows boundary includes:

- one-folder PyInstaller runtime;
- per-user Inno Setup installer;
- Start Menu launch;
- external writable state under `%LOCALAPPDATA%/Markei`;
- schema-only production packaging;
- structural category/store defaults without sample purchases;
- retained data across same-version reinstall, uninstall, and reinstall recovery.

The accepted desktop implementation must not be destabilized by mobile investigation.

---

# 3. Cycle 07 Portability Knowledge

Sprint 01 established:

```text
reusable behavior
≠
portable application
```

Likely reusable knowledge includes domain models and vocabulary, validation and calculation rules, purchase/inventory workflow meanings, schema semantics, structural defaults, and deterministic desktop behavior as a fixture source.

Current mobile-relevant coupling includes:

- concrete Repository construction inside ProductService;
- immediate SQLite lifecycle ownership;
- Windows/desktop path and resource assumptions;
- presentation-shaped service projections;
- incomplete abstract contracts;
- per-method commits across multi-step workflows;
- desktop widget/page lifecycle ownership.

No mobile runtime, package, device workflow, sandbox persistence, semantic-parity suite, or iOS build has been validated.

---

# 4. Current Approach Direction

Reconciled approach status:

```text
Approach C
    contract-first native/cross-platform client
    primary strategic direction
    favored by human/Main
    framework not selected
    not empirically accepted

Approach A
    shared Python core with Python-native mobile UI
    bounded Android falsification challenger
    not authorized

Approach B
    web/hybrid mobile client
    viable secondary route

Approach D
    service-backed client
    deferred without demonstrated synchronization requirements
```

Operational and Design are not treated as contradictory. Operational identifies the cheapest direct-reuse experiment; Design identifies the stronger maintained-product architecture.

Development cost includes learning, setup, rewriting, native toolchains, testing, lifecycle, semantic parity, distribution, debugging, accessibility, and long-term maintenance—not only initial code volume.

---

# 5. Persistence and Scope Boundary

The default mobile direction remains:

```text
offline-first
single-device
fresh mobile-local sandbox data
no backend
no authentication
no synchronization
no ordinary desktop database access
```

A future prototype must preserve one bounded workflow, mobile-local path isolation, atomic behavior, close/reopen persistence, and semantic agreement with deterministic fixtures.

---

# 6. Current Domain State

## Operational

The Operational checkpoint records Cycle 07 investigation completion, development-cost boundaries, future validation gates, and the Python-native challenger’s stop conditions.

```text
operational/10_OPERATIONAL_STATE.md
```

## Didactic

The Didactic checkpoint records portability distinctions and candidate concepts without automatic KANBAN promotion or maturity change.

```text
didactics/08_CONCEPT_MAP.md
```

## Design

The Design checkpoint records the contract-first strategic preference, the preserved challenger, platform/lifecycle ownership, and explicit non-acceptance of a framework or implementation.

```text
design/09_DESIGN_STATE.md
```

---

# 7. Next Knowledge Work

Before implementation, specify:

1. language-neutral behavior scenarios;
2. typed inputs and stable outputs/status codes;
3. deterministic golden fixtures;
4. validation and persistence effects;
5. one atomic registration workflow;
6. mobile-local data-isolation invariant;
7. lifecycle persistence gates;
8. semantic-parity rules;
9. stop conditions for any Python-native challenger;
10. criteria for selecting a maintained mobile framework.

D/E/F remain postponed until human/Main direction selects one bounded empirical task.

---

# 8. Global Recovery Route

```text
1. Read this file for current accepted global state.
2. Read 06_SESSION_SCHEME.md for the next-session boundary.
3. Read the relevant domain checkpoint.
4. Read J_[M]_STAGE.md for cross-domain rationale.
5. Read A/B/C or observational history only when exact evidence or chronology is needed.
6. Inspect source only when notebook memory is insufficient or implementation truth is directly required.
```

# 09_DESIGN_STATE.md

> Version: 0.4-cycle07-sprint01
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat [D]
> Scope: Low-cost recovery surface for Cycle 07 mobile portability and architecture-discovery state
> Sources: `00_PROJECT_STATE.md`, `06_SESSION_SCHEME.md`, `DEV_STAGE/A_OPERATIONAL.md`, `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/C_DESIGN.md`, `[M]_STAGE/J_[M]_STAGE.md`, `design/03_DECISION_LOG.md`

---

# Current Cycle State

Cycle 06 is accepted and closed for the controlled Windows primary-beta boundary. Its installed desktop architecture remains protected and was not reopened by Cycle 07.

Cycle 07 Sprint 01 investigation is complete. It mapped portability and coupling without changing application code, selecting a framework, initializing mobile tooling, opening a database, or accessing ordinary desktop user data.

Current mode:

```text
documentation-first permanent-memory reconciliation
implementation authorization: none
D/E/F: postponed
```

---

# Accepted Desktop Baseline

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

The accepted Windows packaging, installation, external user-state, structural-default, and shutdown boundaries remain unchanged. For exact accepted architecture, read `design/01_ARCHITECTURE.md`.

---

# Portable-Core Findings

Likely reusable:

- domain dataclasses and vocabulary;
- validation, date, quantity, status, and purchase-cycle rules;
- workflow meanings and invariants;
- structural-default semantics;
- schema facts and relationships as semantic reference;
- repository/service responsibilities as design concepts;
- deterministic desktop behavior as a fixture source.

Likely reusable does not mean proven inside a mobile runtime.

Current coupling:

- `ProductService` constructs the concrete `Repository`;
- repository construction opens SQLite lifecycle behavior immediately;
- database paths and packaged resources are desktop/Windows-shaped;
- Python ABCs are language-bound and incomplete as cross-language contracts;
- service projections include desktop labels, formatting, grouping, and page-order choices;
- repository methods commit independently across multi-step workflows;
- desktop pages own service construction while MainWindow coordinates final closure.

Mobile presentation, application lifecycle, sandbox persistence, migrations, transaction ownership, accessibility, native integration, and suspend/resume behavior require explicit mobile ownership.

---

# Current Approach Direction

## Approach C — favored strategic candidate

A native or cross-platform mobile client governed by language-neutral contracts and deterministic fixtures is the current favored strategic direction.

Its initial cost is higher because behavior must be specified and partly reimplemented. That cost may buy conventional Android/iOS tooling, explicit lifecycle and persistence ownership, platform-appropriate UI, accessibility and native integration, testable semantic parity, clearer maintenance boundaries, and a future synchronization seam that does not require a backend now.

No framework, persistence library, schema-sharing policy, repository topology, or implementation structure has been selected.

## Approach A — bounded challenger

A time-boxed Python-native Android experiment remains the bounded challenger and potentially cheapest falsification test for direct source reuse.

It may minimize immediate rewriting, but can shift cost into packaging, runtime compatibility, lifecycle handling, resource/database paths, native integration, accessibility, debugging, and a distinct iOS/macOS/Xcode path. Android success would not establish iOS parity or long-term architectural acceptance.

Approach A is preserved as useful contrary evidence, not promoted as the strategic direction.

## Other approaches

Approach B remains a viable secondary web/hybrid route but does not directly execute the current Python core without a bridge, rewrite, or service.

Approach D remains deferred because no demonstrated requirement demands accounts, multi-device state, household collaboration, cloud hosting, or synchronization.

---

# Human/Main Preference

Human/Main currently favors Approach C as the strategic direction.

This preference:

- is stronger than a neutral list of alternatives;
- guides documentation toward contract/fixture specification and explicit mobile ownership;
- is weaker than framework or architecture acceptance;
- does not authorize implementation;
- does not erase Approach A as a bounded challenger;
- remains revisable when empirical evidence arrives.

---

# Evidence Required Before Acceptance

1. Language-neutral commands, results, invariants, error cases, and deterministic fixtures.
2. Fixture coverage for first purchase, repeat purchase, status transition, invalid input, structural defaults, atomic registration, and close/reopen persistence.
3. Android evidence for sandbox initialization, write/read, suspend/resume, termination/relaunch, and ordinary-desktop-data isolation.
4. A separate macOS/Xcode iOS feasibility and parity gate.
5. Selected-framework evidence for packaging, debugging, accessibility, navigation, native integration, migrations, and maintenance.
6. A measured comparison between fixture-driven reimplementation cost and a strictly bounded direct-reuse experiment.
7. Main/human reconciliation and acceptance.

---

# Prototype Boundary if Later Authorized

Default assumptions remain:

```text
offline-first
single-device
fresh mobile-local data
no backend
no authentication
no synchronization
no ordinary desktop database access
```

A later minimal slice may launch, initialize an isolated local store, register one product/purchase through a defined use case, persist atomically, terminate/relaunch, and display the saved state. This is a candidate boundary only, not current implementation authority.

---

# Explicit Deferrals

- application or source-code changes;
- D/E/F materialization;
- framework and permanent repository-topology selection;
- composition-root or dependency-injection refactoring;
- production contract files or new source structure;
- backend, authentication, synchronization, hosting, and household sharing;
- desktop/mobile database exchange;
- complete migration strategy and store distribution;
- full feature parity;
- modification of the accepted desktop architecture.

---

# Recovery Route

```text
Current Design state
    → this file

Alternative chronology and cost rationale
    → design/03_DECISION_LOG.md

Compact accepted desktop map
    → design/14_MODEL_OVERVIEW.md

Exact accepted desktop architecture
    → design/01_ARCHITECTURE.md

Current cross-domain synthesis
    → [M]_STAGE/J_[M]_STAGE.md
```

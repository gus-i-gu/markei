# J_[M]_STAGE — Cycle 07 Sprint 01 Knowledge Reconciliation and Next-Step Staging

> Status: Active Main reconciliation / documentation-first continuation
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Branch: `cycle-07-mobile-preparation`
> Baseline branch: `sketch-notebook-recovery`
> Baseline commit: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Knowledge state: Reconciled Main staging; implementation authorization postponed
> Source reports: `DEV_STAGE/A_OPERATIONAL.md`, `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/C_DESIGN.md`
> Active cycle: Cycle 07 mobile-development preparation and architecture discovery

---

# 1. Main Synthesis Summary

Cycle 07 Sprint 01 completed the bounded portability investigation without modifying application code, initializing a mobile framework, installing toolchains, opening databases, or touching ordinary desktop user data.

The three functional reports agree that:

```text
Markei contains reusable behavior
≠
Markei is a portable mobile application as currently constructed
```

The likely reusable portion is concentrated in Python domain models, validation, date/status calculations, workflow meanings, schema semantics, and structural defaults. The current executable composition is not mobile-portable because service construction, repository creation, database-path resolution, resource loading, SQLite lifecycle, presentation projections, and shutdown ownership remain shaped by the desktop implementation.

The accepted investigation boundary remains:

```text
offline-first
single-device
fresh mobile-local data
no backend
no authentication
no synchronization
no ordinary desktop database access
```

Approach D, a service-backed client, has no demonstrated product requirement and remains deferred.

The evidence does not yet justify a final framework selection or D/E/F materialization. Main therefore postpones D/E/F. The next phase is documentation and specification refinement through A/B/C and J, followed by a later human/Main decision on whether a prototype is necessary and which uncertainty it should test.

---

# 2. Cycle and Baseline Integrity

Cycle 06 remains accepted and closed at the controlled Windows primary-beta boundary.

Cycle 07 began from:

```text
repository: gus-i-gu/markei
branch: cycle-07-mobile-preparation
baseline: f6414fbe7394453387067a5a34ca6cc7621bbed3
```

The isolated `markei-mobile` working copy and Cycle 07 branch preserve the accepted desktop baseline.

The three inherited domain checkpoints still contain pre-acceptance Cycle 06 language. This remains classified as checkpoint drift:

```text
Main-root continuity
    owns accepted Cycle 06 closure and Cycle 07 direction

domain checkpoints
    remain useful for domain detail
    but require later refresh
```

Nothing in Sprint 01 reopens Cycle 06.

GitHub remains the canonical Sketch Notebook host. Notion remains only a possible future projection or recovery layer; no authority or migration is active.

---

# 3. Reconciled Portability Map

## 3.1 Platform-neutral and likely reusable

Current evidence supports likely reuse of:

- Python domain dataclasses and core vocabulary;
- validation and calculation rules;
- purchase-duration and expected-date behavior;
- status classification meanings;
- structural-default semantics;
- schema facts and relationships as a semantic reference;
- repository and service responsibilities as design concepts;
- existing deterministic desktop behavior as a source for fixtures.

Likely reusable does not mean proven inside a mobile runtime.

## 3.2 Platform-neutral but coupled by construction

Current evidence identifies these coupled surfaces:

- `ProductService` constructs a concrete `Repository`;
- repository construction opens concrete SQLite lifecycle behavior;
- abstract contracts do not cover every method actually used;
- database and resource paths are resolved through desktop/Windows-shaped assumptions;
- service projections contain labels, formatting, grouping, and page-order choices;
- transaction boundaries remain split across independently committed repository methods.

These surfaces are candidates for later seams or specifications. Sprint 01 does not authorize refactoring them.

## 3.3 Desktop-specific

Desktop-specific ownership remains in:

- PySide6 application creation and event-loop ownership;
- `app/desktop/` pages, widgets, dialogs, and navigation;
- page-owned service construction;
- MainWindow shutdown coordination;
- Windows/PyInstaller packaging and diagnostic surfaces;
- installed Windows path and lifecycle behavior.

These surfaces should be preserved as the accepted desktop implementation rather than treated as mobile assets.

## 3.4 Persistence-specific

SQLite schema semantics remain credible for an offline mobile prototype, but the following are not yet portable evidence:

- mobile sandbox path resolution;
- packaged schema-resource access;
- connection behavior within a chosen mobile runtime;
- WAL/file-lock behavior;
- suspend/resume and process-termination behavior;
- migrations and transaction ownership;
- uninstall, backup, and restore behavior;
- parity between desktop and mobile stores.

A mobile prototype must own a fresh sandboxed database. It must not open, copy, or mutate the ordinary desktop database.

## 3.5 Unknown until tested

No report establishes:

- a functioning mobile runtime;
- a selected UI framework;
- Android build or device launch;
- iOS build or device launch;
- packaged SQLite compatibility;
- lifecycle persistence across mobile termination/relaunch;
- mobile accessibility or performance;
- store distribution;
- semantic parity across two runtime implementations;
- safe cross-device synchronization.

These remain experiment candidates, not accepted facts.

---

# 4. Approach Reconciliation

## 4.1 Approach A — Shared Python core with Python-native mobile UI

Operational identifies Approach A as the lowest-cost Android falsification experiment because it maximizes direct Python reuse and can quickly test whether the existing core survives mobile packaging.

Its primary uncertainties are:

- Android packaging through an additional Linux/WSL, SDK/NDK, JDK, emulator/device, and framework toolchain;
- iOS dependence on macOS/Xcode and a separate packaging path;
- mobile lifecycle and SQLite compatibility;
- accessibility, navigation, and platform integration;
- whether required construction/path seams stay genuinely bounded.

Main classification:

```text
best short falsification challenger
not accepted long-term architecture
```

## 4.2 Approach B — Web/hybrid mobile presentation

Approach B may fit existing web familiarity and rapid UI work, but it cannot directly execute the current Python core in an ordinary hybrid client. It therefore requires:

- ported business behavior;
- a local bridge/runtime;
- or a service boundary.

It also needs a durable local relational-store strategy rather than treating browser preference storage as Markei’s ledger.

Main classification:

```text
viable secondary candidate
not currently the smallest evidence path
```

## 4.3 Approach C — Native/cross-platform client with explicit contracts and fixtures

Design recommends Approach C as the primary architectural candidate because it gives mobile presentation, lifecycle, local persistence, navigation, and platform integration explicit ownership.

This route reuses semantics rather than necessarily reusing Python runtime code. It requires language-neutral contracts and deterministic fixtures to control drift between desktop and mobile implementations.

Its cost is a second implementation and stronger fixture/contract discipline.

Main classification:

```text
primary strategic architecture candidate
framework not selected
implementation not authorized
```

## 4.4 Approach D — Service-backed client

No accepted requirement currently demands accounts, multi-device state, household collaboration, or cloud synchronization. A backend would add hosting, authentication, privacy, network failure, API compatibility, offline queues, conflict resolution, and operational support without removing the need for mobile-local persistence.

Main classification:

```text
deferred unless a demonstrated requirement activates it
```

---

# 5. Main Decision Boundary

Main does not treat the difference between Operational and Design as a contradiction.

They answer different questions:

```text
Operational:
What is the cheapest experiment that can falsify direct Python reuse?

Design:
What architecture is strongest if mobile becomes a maintained product?
```

The current reconciled position is:

```text
Approach C
    primary strategic candidate

Approach A
    bounded challenger / falsification spike

Approach B
    viable secondary route

Approach D
    deferred
```

Before any prototype authorization, the project should specify the behavior to preserve independently of framework choice.

---

# 6. Contract and Fixture Direction

The next useful artifact is conceptual specification, not application code.

Candidate behavior scenarios include:

1. first purchase for a new product;
2. repeat purchase and duration recalculation;
3. Storage/Shortage/Market status transition;
4. invalid receipt rejection;
5. structural category/store defaults;
6. close/reopen persistence;
7. one atomic registration workflow;
8. mobile-local path isolation.

A later contract/fixture design should describe:

- typed input facts;
- stable output facts and status codes;
- validation failures;
- date and quantity semantics;
- expected persistence effects;
- deterministic example values;
- invariants across desktop and mobile;
- presentation-owned labels and formatting excluded from the contract.

Current Python abstract classes and UI-facing dictionaries are evidence sources, not automatically the final cross-platform contract.

No new shared-specification directory or file is authorized by this J revision. Any new notebook or implementation file still requires explicit Main/human authorization and routing review.

---

# 7. D/E/F Postponement

The following files are intentionally not prepared:

```text
DEV_STAGE/D_OPS_STAGE.md
DEV_STAGE/E_DDC_STAGE.md
DEV_STAGE/F_DSN_STAGE.md
```

Reason:

```text
no implementation is currently requested
+
framework selection remains open
+
contract/fixture boundary remains underspecified
+
documentation reconciliation can reduce uncertainty first
```

Existing D/E/F content, if present from an earlier cycle, must not be interpreted as Cycle 07 authorization.

D/E/F may be activated later only after Main/human direction selects a bounded materialization unit.

---

# 8. Documentation-First Next Phase

The next phase should use A/B/C as renewable staging surfaces and J as the cross-domain gathering and reconciliation surface.

## 8.1 Operational continuation through A

Operational may refine `A_OPERATIONAL.md` with a compact documentation delta covering:

- host and toolchain inventory questions;
- evidence needed to compare one A-family and one C-family toolchain;
- Android-accessible versus macOS/iOS-only gates;
- reproducible prototype validation matrix;
- mobile-local path and ordinary-desktop-data isolation checks;
- lifecycle and persistence failure taxonomy;
- criteria for stopping a failed spike;
- exact unknowns that require execution rather than further reading.

Operational should not install tools or execute the prototype during this documentation phase.

## 8.2 Didactic continuation through B

Didactic may refine `B_DIDACTIC.md` with:

- explicit KANBAN candidates;
- dependency order for platform boundary, composition root, dependency injection, DTO/contract, golden fixture, local persistence, transaction boundary, offline-first, synchronization, and lifecycle ownership;
- learner-facing distinctions between reuse of code, behavior, schema, and vocabulary;
- maturity-preserving questions for the human learner;
- glossary candidates derived only from accepted or staged concepts;
- a compact learning checkpoint for the later prototype.

No maturity promotion or permanent KANBAN update should occur without the Didactic protocol and explicit learner evidence.

## 8.3 Design continuation through C

Design may refine `C_DESIGN.md` with:

- a technology-neutral use-case boundary;
- candidate command/result contract shapes;
- fixture ownership and semantic-parity rules;
- mobile composition-root and lifecycle ownership;
- local transaction boundary;
- schema reuse versus semantic-schema equivalence;
- repository topology options without selecting a permanent split;
- comparison criteria for candidate C-family frameworks;
- explicit conditions under which the A-family challenger should be attempted or rejected.

Design should not create implementation contracts or reorganize source code during this phase.

## 8.4 Main continuation through J

Main should gather subsequent A/B/C deltas into this J file by:

1. identifying agreements;
2. preserving genuine domain tensions;
3. classifying facts, assumptions, unknowns, and deferrals;
4. pruning duplicate cross-domain wording;
5. deciding whether additional documentation can answer the next question;
6. identifying when an empirical experiment becomes necessary;
7. selecting at most one bounded D/E/F materialization unit when authorized.

J remains staging. It does not replace permanent domain memory or Main-root continuity.

---

# 9. Permanent Documentation Reconciliation Candidates

After one documentation refinement round, functional chats may propose—not automatically perform—updates to permanent domain memory.

## Operational candidates

```text
operational/10_OPERATIONAL_STATE.md
    refresh Cycle 06 closure and Cycle 07 investigation state

operational/04_TODO.md
    express evidence gaps and future experiment gates

operational/12_OPERATIONAL_MODEL.md
    add stable mobile-investigation validation rules only if sufficiently general

operational/11_OPERATIONAL_RECORD.md
    append Sprint 01 investigation chronology
```

## Didactic candidates

```text
didactics/08_CONCEPT_MAP.md
    refresh current Cycle 07 learning boundary

didactics/02_KANBAN.md
    add concepts only after classification and learner protocol

didactics/07_GLOSSARY.md
    derive terms from accepted KANBAN concepts

didactics/13_LECTURE_REGISTER.md
    record the portability investigation and learner evidence
```

## Design candidates

```text
design/09_DESIGN_STATE.md
    refresh current portable-core and mobile-boundary state

design/14_MODEL_OVERVIEW.md
    derive a compact platform-boundary overview

design/01_ARCHITECTURE.md
    update only after an architecture decision becomes accepted

design/03_DECISION_LOG.md
    record alternatives, deferrals, and later accepted decisions
```

Permanent updates must follow `FLUX.md` and `PROMOTION_RULES.md`. A/B/C content must be classified rather than copied wholesale.

---

# 10. Proposed Next Steps

Recommended immediate sequence:

```text
1. Human/Main reviews this reconciliation.
2. A/B/C perform one documentation-refinement round if desired.
3. Main gathers the deltas in J.
4. Functional chats classify permanent-domain update candidates.
5. Domain checkpoints are refreshed to remove Cycle 06 closure drift.
6. Main decides whether documentation is sufficient.
7. If empirical evidence is required, select one bounded experiment.
8. Only then prepare D/E/F.
```

The most useful next decision question is:

> Should the project first formalize language-neutral behavior contracts and fixtures, or first run a time-boxed Python-native Android falsification spike to test whether direct core reuse is viable?

Main currently recommends contract/fixture specification first because it benefits every approach and reduces the risk that a framework spike tests only packaging while leaving semantic portability undefined.

---

# 11. Scope Guard

This J revision does not authorize:

- application or source-code modification;
- framework initialization;
- tool installation;
- Android or iOS build execution;
- database migration or ordinary-user-data access;
- backend, authentication, synchronization, or hosting;
- permanent repository split;
- new Sketch Notebook files;
- methodology modification;
- D/E/F materialization;
- automatic permanent-domain promotion.

---

# 12. Recovery Route

```text
Accepted global state
    00_PROJECT_STATE.md

Cycle 07 boundary
    06_SESSION_SCHEME.md

Current Main reconciliation
    this file

Operational evidence
    DEV_STAGE/A_OPERATIONAL.md

Didactic evidence
    DEV_STAGE/B_DIDACTIC.md

Design evidence
    DEV_STAGE/C_DESIGN.md

Permanent domain state
    domain checkpoints, after authorized reconciliation
```

Current status:

```text
Sprint 01 investigation: complete
A/B/C reports: received and reconciled
primary strategic candidate: Approach C
bounded challenger: Approach A
backend: deferred
implementation authorization: none
D/E/F: postponed
next mode: documentation-first refinement and domain-memory reconciliation
```


---

# 13. Permanent-Domain Absorption Result

Operational, Didactic, and Design completed the authorized permanent-memory reconciliation pass.

Materialized domain updates:

```text
Operational
    operational/10_OPERATIONAL_STATE.md
    operational/04_TODO.md
    operational/11_OPERATIONAL_RECORD.md

Didactic
    didactics/08_CONCEPT_MAP.md
    didactics/13_LECTURE_REGISTER.md

Design
    design/09_DESIGN_STATE.md
    design/03_DECISION_LOG.md
```

Main classification:

- checkpoints now reflect Cycle 06 closure and active Cycle 07 investigation;
- observational files preserve both the Python-native challenger and contract-first strategic pathway;
- the human/Main preference for the Design pathway is recorded as provisional planning direction;
- development cost is described across learning, setup, rewriting, toolchains, testing, lifecycle, semantic parity, distribution, and maintenance;
- no Didactic maturity changed;
- no framework, permanent repository topology, backend, or implementation architecture was accepted;
- no application, methodology, D/E/F, or Codex-report files were modified;
- no further J synthesis is required before the Main-root continuity refresh.

Current reconciled position:

```text
primary strategic direction
    contract-first native/cross-platform client

bounded challenger
    time-boxed Python-native Android falsification experiment

next required knowledge
    language-neutral behavior scenarios
    deterministic fixtures
    explicit validation and stop criteria

implementation authorization
    none

D/E/F
    postponed
```

The next cycle step remains documentation/specification work. Main should activate D/E/F only when the human requests an empirical prototype and one bounded uncertainty has been selected.

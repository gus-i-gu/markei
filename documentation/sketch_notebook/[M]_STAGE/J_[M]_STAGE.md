# J_[M]_STAGE — Cycle 07 Sprint 01 Initialization and Domain Handoff

> Status: Active Main staging
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Branch: `cycle-07-mobile-preparation`
> Baseline branch: `sketch-notebook-recovery`
> Baseline commit: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Knowledge state: Reconciled Main staging
> Closed milestone: Fully executable and installable Windows primary beta
> Active cycle: Cycle 07 mobile-development preparation and architecture discovery

---

# 1. Cycle 06 Closure Decision

Main accepts Cycle 06 as complete for the controlled Windows primary-beta boundary.

Final evidence classification:

```text
configured: validated
built: validated
launched: validated — frozen and installed
installed: validated — per-user lifecycle
validated: accepted for controlled beta
accepted: yes by Main/human direction
```

This is not a claim of production maturity, signed public distribution, app-store readiness, or complete reputation testing.

---

# 2. Accepted Release Outcome

Cycle 06 produced:

```text
Markei-Setup-0.1.0-x64.exe
→ wizard-based per-user installation
→ Start Menu launch
→ no development Python command required
→ external retained SQLite user data
→ installed technical workflow evidence
→ close and immediate reopen
→ same-version reinstall with retained data
→ uninstall with retained data
→ reinstall and retained-data recovery
```

Installer evidence:

```text
dist/installer/Markei-Setup-0.1.0-x64.exe
SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
```

Accepted bounded corrections:

```text
per-user ISCC.exe discovery
structural category F / General
structural store 1 / Default Store
MainWindow final page-service shutdown coordination
```

No sample products or purchases are shipped.

---

# 3. Preserved Evidence Limits

Cycle closure retains these qualifications:

- automated/service-backed workflow evidence is not a complete manual visual UI walkthrough;
- dedicated-account isolation was not separately evidenced;
- binaries are unsigned;
- human-visible SmartScreen behavior remains unknown;
- same-version reinstall passed, while a true future-version upgrade remains untested;
- generated installer artifact/version-control policy remains release-hygiene work;
- workflow atomicity and broader migration strategy remain inherited debt.

These items do not block the accepted controlled beta but must not be silently described as validated.

---

# 4. Domain Reconciliation Result

Operational, Didactic, and Design permanent memory agree on:

```text
compiled installer exists
installed lifecycle technically validated
accepted application boundaries preserved
structural defaults distinct from sample seed data
human-visible and reputation observations bounded
no broad redesign introduced
```

Didactic maturity remains unchanged by software success; no concept became Green.

The three domain checkpoints still describe the immediate pre-acceptance state and say Cycle 06 is pending acceptance. This is inherited checkpoint drift relative to the newer Main-root continuity files. For Cycle 07 initialization:

```text
00_PROJECT_STATE.md + 05_SESSION_LOG.md + 06_SESSION_SCHEME.md
    own accepted global closure and Cycle 07 direction

domain checkpoints
    remain valid for domain detail
    but their pending-acceptance language is stale
```

Functional chats must acknowledge this drift and must not reopen Cycle 06.

---

# 5. Verified Cycle 07 Isolation Baseline

The human developer created and verified an isolated sibling clone:

```text
local workspace: markei-mobile
remote: https://github.com/gus-i-gu/markei.git
branch: cycle-07-mobile-preparation
upstream: origin/cycle-07-mobile-preparation
working tree: clean
HEAD: f6414fbe7394453387067a5a34ca6cc7621bbed3
origin/sketch-notebook-recovery:
      f6414fbe7394453387067a5a34ca6cc7621bbed3
```

Therefore:

```text
Cycle 07 experimental HEAD
=
accepted Cycle 06 closure commit
```

The desktop baseline remains available through the separate `markei` working copy and `sketch-notebook-recovery` branch.

Notion remains a possible future projection or recovery layer. GitHub remains the canonical Sketch Notebook host; no Notion authority or migration is active.

---

# 6. Cycle 07 Single Milestone

> Select and evidence a primary mobile-development approach for Markei through an isolated clone, bounded architecture comparison, and one minimal vertical-slice prototype.

Required route:

```text
verified isolated baseline
→ bounded portability inventory
→ mobile approach comparison
→ persistence and synchronization assumptions
→ A/B/C functional reports
→ Main reconciliation in J
→ one selected prototype boundary
→ D/E/F authorization
→ Codex materialization
→ G/H/I evidence
→ domain reconciliation
→ Main acceptance or precise blocker
```

Cycle 07 must not begin with a full rewrite or production backend.

---

# 7. Sprint 01 Main Synthesis Summary

Sprint 01 is investigation-only.

Its goal is:

> Establish the current portability map, compare viable mobile approaches under common criteria, and recommend the smallest meaningful prototype boundary without modifying application code.

No application, notebook-domain, methodology, packaging, or database materialization is authorized by Sprint 01 A/B/C assignments.

Minimum implementation inspection:

```text
app/core/models.py
app/core/contracts.py
app/core/services.py
app/core/repository.py
app/core/database.py
app/core/config.py
app/desktop/
app/mobile/
app/main.py
main.py
app/database/schema.sql
```

Additional files may be read only when a named dependency or uncertainty makes them necessary.

Required portability classification:

```text
platform-neutral and likely reusable
platform-neutral but coupled by construction/imports
desktop-specific
persistence-specific
presentation-specific
unknown until tested
```

Required approach families:

```text
A. shared Python core + Python-native mobile UI
B. web/hybrid mobile presentation
C. native/cross-platform client with explicit shared contracts
D. service-backed mobile client only if demonstrated requirements justify it
```

Shared evaluation criteria:

```text
reuse of current domain behavior
mobile UX suitability
offline capability
persistence safety
Android feasibility
iOS feasibility
tooling reproducibility
build/distribution complexity
testing strategy
maintenance cost
future synchronization compatibility
developer learning cost
```

Default investigation assumption:

```text
offline-first local prototype
+
no backend unless demonstrated requirements demand it
+
no access to the ordinary desktop database
```

---

# 8. Functional Domain Assignments

## 8.1 Operational [O]

Operational owns:

- isolated-clone reproducibility and baseline evidence;
- toolchain and environment feasibility;
- build/run/emulator/device prerequisites;
- mobile storage behavior and lifecycle validation;
- operational failure states and approach costs;
- commands needed for a later prototype;
- recommendation grounded in reproducible evidence.

Operational writes only:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
```

## 8.2 Didactic [A]

Didactic owns:

- shared language versus shared runtime;
- platform-neutral code versus portable application;
- local persistence versus synchronization;
- offline-first, client, service, contract, and platform-boundary concepts;
- learner dependency ordering;
- KANBAN candidates without automatic maturity promotion;
- a compact learning handoff for the selected prototype.

Didactic writes only:

```text
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
```

## 8.3 Design [D]

Design owns:

- platform and reusable-core boundaries;
- desktop-only coupling;
- presentation, persistence, lifecycle, and synchronization ownership;
- repository-topology alternatives;
- contract and fixture strategy;
- comparison of mobile architecture candidates;
- recommended vertical-slice boundary and explicit deferrals.

Design writes only:

```text
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

---

# 9. Functional Report Contract

Each report must:

1. begin with `Main Synthesis Summary`;
2. identify inspected files and evidence;
3. acknowledge the Cycle 06 checkpoint drift without reopening the closed cycle;
4. classify relevant implementation surfaces;
5. compare approaches from its own domain responsibility;
6. distinguish observations, assumptions, blockers, and recommendations;
7. recommend or constrain the smallest vertical slice;
8. finish with a concise handoff to Main;
9. stay within the word limits in `06_SESSION_SCHEME.md`;
10. avoid modifying application code or permanent domain memory.

Target limits:

```text
A_OPERATIONAL.md  1,500–2,200 words
B_DIDACTIC.md     1,000–1,500 words
C_DESIGN.md       1,500–2,200 words
```

Parallel reasoning is permitted, but the reports must remain independent domain interpretations rather than copied cross-domain text.

---

# 10. Sprint 01 Stop Conditions

Functional chats must stop and report instead of implementing if:

- the checked-out branch is not `cycle-07-mobile-preparation`;
- HEAD does not descend from the recorded Cycle 06 baseline;
- application modification appears necessary to answer the investigation;
- a tool installation or external account action would be required;
- ordinary desktop user data could be touched;
- methodology modification appears necessary;
- evidence is insufficient to distinguish observation from assumption;
- a proposed approach implicitly requires production backend, authentication, synchronization, or broad schema redesign.

---

# 11. Main Recovery and Next Action

```text
Accepted global state
    00_PROJECT_STATE.md

Cycle 07 boundary
    06_SESSION_SCHEME.md

Current Main staging
    this file

Functional reports
    DEV_STAGE/A_OPERATIONAL.md
    DEV_STAGE/B_DIDACTIC.md
    DEV_STAGE/C_DESIGN.md
```

The next Main action is to receive and reconcile A/B/C. Only after that reconciliation may Main select one minimal prototype boundary and prepare D/E/F materialization instructions.

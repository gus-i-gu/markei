# 03_DECISION_LOG.md

> Version: 0.3-cycle06-sprint02
> Status: Active Observational Record
> Persistence Class: Observational History
> Knowledge Class: Design History
> Authority: Design Chat [D]
> Scope: Chronological Design-domain decisions, reconciliation events, materializations, corrections, and deferred boundaries
> Current Coverage: Recovery repopulation through Cycle 06 Sprint 02 installed-lifecycle evidence

---

# 1. Purpose and Reading Rule

This file records what happened in the Design domain and why. It is append-oriented observational history; it does not independently define current architecture.

For current truth, read:

```text
Canonical architecture
    design/01_ARCHITECTURE.md

Derived architecture map
    design/14_MODEL_OVERVIEW.md

Current checkpoint
    design/09_DESIGN_STATE.md
```

Earlier events remain historical even when later events revise current architecture.

---

# 2. Recovery Repopulation Record

## Event 01 — Methodology boot and empty-domain detection

The recovery began after permanent Design files had been intentionally pruned. Domain Symmetry assigned:

```text
C_DESIGN.md          functional reasoning
01_ARCHITECTURE.md   canonical knowledge
14_MODEL_OVERVIEW.md derived knowledge
09_DESIGN_STATE.md   checkpoint
03_DECISION_LOG.md   observational history
```

Application source was evidence, not automatic canon.

## Event 02 — Initial structural review

Repository inspection recovered the application direction:

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

MainWindow was identified as desktop composer and coordinator; ProductService as application facade; Repository as persistence facade; and Database Manager as lifecycle owner.

Functional staging commits:

```text
0c7143e13cd27e1b6a20506cadf045631e2eeeae
    Stage initial design recovery review

3f40e25109ede1501541fa8eefce84465dcb47bd
    Consolidate design structural recovery
```

## Event 03 — Lifecycle and transaction constraints clarified

All four public pages were confirmed to create separate ProductService → Repository → SQLite connection chains. Cleanup capability existed locally, while application-wide shutdown ownership was distributed and implicit.

Receipt registration and purchase deletion/recalculation were confirmed as multi-commit workflows. This was recorded as current implementation property, not accepted future target architecture.

## Event 04 — Main-stage routing correction

The initial lookup used obsolete path:

```text
[M]_STAGE/J_MAIN_STAGE.md
```

The human-corrected authoritative path was:

```text
[M]_STAGE/J_[M]_STAGE.md
```

A concurrent content-SHA conflict was also handled by re-reading before writing. These events established that exact stage paths and current blob SHAs are part of reconciliation safety.

Corrective staging commit:

```text
65199e4e3d02541fc4f25f9f677e307c40447973
    Stage initial design canon candidate
```

## Event 05 — Canonical, derived, and checkpoint repopulation

Main reconciliation authorized stable current architecture while excluding unresolved future targets.

Permanent Design materialization:

| Commit | Result |
| --- | --- |
| `4431a25c8365e0c847c4c97b2775a90eda21ea0b` | Canonical architecture repopulated |
| `b019063163e45dc72ffb04a9010483a035e858e2` | Derived model overview repopulated |
| `32a6834ef845280ed372c518ddcf1edb1e4e2112` | Design checkpoint rebuilt |

Temporary retrospective staging:

```text
ec9a1b6dc5d5252e1031e0890a468ecc38321b55
    Stage design checkpoint retrospective
```

The failed Cycle 05 precedent was classified as cycle-control and knowledge-routing overload, not proof that the layered application architecture had failed.

## Event 06 — Recovery decisions and deliberate non-decisions

Recovery established:

1. functional stages remain temporary reasoning surfaces;
2. Main reconciliation filters what may enter permanent memory;
3. canon stores accepted stable architecture;
4. the overview reorganizes canon without independent truth;
5. the checkpoint stores current state and active tensions;
6. this log stores chronology and rationale.

The recovery deliberately left open shared versus page-local services, shutdown ownership, workflow atomicity, ProductService/Repository decomposition, complete contracts, typed projections, migration versioning, Promotion status, `pages.order`, and Product's long-term hybrid role.

---

# 3. Event 07 — Cycle 06 Primary-Beta Design Reconciliation

## Context

Cycle 06 established one milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

Functional A/B/C reports were reconciled in `J_[M]_STAGE.md`. Main authorized one bounded release-enablement unit without broad application redesign.

## Policy decisions accepted before materialization

### Schema-only production initialization

Decision:

```text
production package includes schema.sql
production package excludes sample-bearing seed.sql
fresh production data contains structural/default settings only
no sample store, category, product, purchase, or business fixture ships
```

Rationale: bundled sample data would blur application resources, development fixtures, and user-owned state.

### Preserve-user-data uninstall policy

Decision:

```text
uninstall removes replaceable program files and shortcuts
uninstall preserves %LOCALAPPDATA%/Markei by default
```

Rationale: the database and settings are user-owned writable state, not installer-owned replaceable content. Optional data-deletion UX was deferred.

### Coordinated release identity

Decision:

```text
Display name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Stable AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
Target: Windows x64 controlled beta
```

Rationale: executable, package, installer, shortcuts, and compatible upgrades require one stable identity contract.

### Authoritative PyInstaller specification

Decision:

```text
Markei.spec
    authoritative package composition

scripts/build_windows.ps1
    invocation wrapper only
```

Rationale: duplicated command flags and spec contents had created two drifting package definitions.

### Shortcut policy

Decision:

```text
Start Menu shortcut required
desktop shortcut optional installer task
```

Rationale: Start Menu launch is part of ordinary installed use; desktop placement remains user choice.

### Validation-first shutdown policy

Decision:

```text
validate distributed cleanup first
add only a bounded close coordinator if direct evidence fails
```

Rationale: distributed lifecycle ownership was a structural concern, not yet proof of a leak or retained lock.

---

# 4. Event 08 — Cycle 06 Sprint 01 Materialization Evidence

## Source boundaries materialized

Codex materialized:

- root `main.py` as launcher and outer startup-diagnostic boundary;
- `app.main.main()` unchanged as Qt application construction;
- `Markei.spec` as authoritative one-folder package definition;
- `scripts/build_windows.ps1` as the invocation wrapper;
- `installer/Markei.iss` as placement, identity, shortcuts, and uninstall-registration source;
- `scripts/build_installer.ps1` as compiler-discovery and compile wrapper;
- external startup logs under `%LOCALAPPDATA%/Markei/logs`;
- schema-only production packaging and exclusion of writable/transient state.

## Frozen evidence

Operational evidence recorded:

```text
configured: yes
built: yes
launched: yes — frozen isolated launch and reopen
validated: partial
```

Source/static checks, five standard-library release tests, frozen build, resource inspection, schema-only first launch, startup-log creation, and frozen reopen passed.

## Observed shutdown failure and bounded correction

The validate-first probe showed the isolated SQLite file remained open after `MainWindow.close()`. Codex added `MainWindow.closeEvent()` and `close_page_services()` to idempotently close Register, Lists, History, and Settings services.

Rerun evidence showed all four repositories closed and the isolated database directory became removable.

Design classification:

```text
MainWindow coordinates final closure
local service/repository close ownership remains intact
not a composition-root redesign
not dependency injection
```

## Installer blocker

`installer/Markei.iss` and `scripts/build_installer.ps1` were configured, but `ISCC.exe` was unavailable.

```text
installer source: configured
compiled installer: blocked
installed execution: blocked
installed lifecycle: unvalidated
beta acceptance: no
```

---

# 5. Event 09 — Sprint 01 Main Post-Codex Reconciliation

Main reviewed G/H/I and critical implementation files in commit:

```text
f402c9394d3401ef8c2df5696d052b18358758dc
    Reconcile Cycle 06 Codex materialization evidence
```

Main accepted the bounded unit as technically successful but insufficient to close Cycle 06.

Accepted Design absorption:

- deployment states remain distinct;
- launcher-owned startup diagnostics are stable;
- `schema.sql` is production resource and `seed.sql` is fixture-only;
- retained user data remains external;
- release identity and stable AppId form one contract;
- MainWindow final service-close coordination is accepted;
- packaging and installer layers do not own workflows or persistence semantics.

Preserved evidence boundary:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

---

# 6. Event 10 — Sprint 02 Installer Toolchain and Structural Defaults

## Installer compiler discovery

Inno Setup 6.7.3 was installed in a per-user location. The original wrapper did not discover that path.

Bounded correction:

```text
scripts/build_installer.ps1
→ add %LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe candidate
```

Design classification: tooling correction only. Packaging authority and installer authority remained unchanged.

## Structural production defaults

The fresh installed Register-equivalent workflow failed with a foreign-key error because the seed-free database lacked current Register defaults.

Bounded correction:

```text
category F / General
store 1 / Default Store
```

These rows were classified as idempotent structural application defaults, not sample business data. Production continued to exclude `seed.sql` and to create zero sample products and purchases.

This refined the earlier schema-only policy without reversing it:

```text
schema.sql
+ structural defaults required by current application invariants
+ zero sample business records
```

---

# 7. Event 11 — Sprint 02 Compiled Installer and Installed Lifecycle

## Artifact and build evidence

The installer compiled successfully:

```text
dist/installer/Markei-Setup-0.1.0-x64.exe
SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
size 34,448,651 bytes
```

The Inno `x64` deprecation warning was recorded as non-blocking tooling debt.

## Installed boundary evidence

The following transitions passed technically:

```text
per-user install
→ installed executable under %LOCALAPPDATA%/Programs/Markei
→ Start Menu shortcut launch
→ external database creation
→ service-backed Register / Lists / History / Settings evidence
→ close and immediate reopen
→ same-version reinstall with preserved data
→ uninstall with retained database
→ reinstall with retained-data recovery
```

Observed installed behavior matched the accepted separation between replaceable program files and `%LOCALAPPDATA%/Markei` user state.

The installed shutdown path used the existing MainWindow close coordination successfully. No broad architecture correction was required.

## Validation environment

The lifecycle used the current ordinary Windows user. Existing Markei data was backed up before testing and restored afterward. Dedicated-account isolation was not evidenced.

## SmartScreen and signing

Defender was enabled and the executable/installer were unsigned. No SmartScreen prompt appeared during silent/programmatic execution.

Design classification:

```text
human-visible SmartScreen behavior: unknown
not an application correctness failure
```

---

# 8. Event 12 — Sprint 02 Main Post-Codex Reconciliation

Main reconciled Sprint 02 G/H/I and implementation evidence in the active `J_[M]_STAGE.md`.

Accepted evidence state:

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Main preserved the distinction:

```text
installed technical workflow path: validated
human-visible UI workflow acceptance: pending
```

Still pending:

- human-visible installer wizard observation;
- human-visible Register / Lists / History / Settings walkthrough;
- human-visible close/reopen confirmation;
- human-visible SmartScreen/security observation;
- final Main/human acceptance;
- artifact-versioning policy resolution.

Main also identified a report/repository contradiction: G described the installer artifact as generated but uncommitted, while branch evidence showed it added. Design records the contradiction but does not decide artifact retention policy.

---

# 9. Explicit Deferrals Preserved

Cycle 06 did not introduce or authorize:

- composition-root or dependency-injection redesign;
- ProductService/Repository decomposition;
- transaction redesign;
- schema redesign or migration ledger;
- mobile, backend/API, synchronization, authentication, or cloud persistence;
- automatic update, signing, rollback framework, or one-file packaging;
- optional uninstall data-deletion UX;
- broad UI/navigation redesign.

Workflow atomicity and broader migration strategy remain inherited Design debt.

---

# 10. Current Observational Result

```text
compiled installer evidenced
installed per-user lifecycle technically validated
structural defaults classified
program/user-state separation observed
same-version reinstall passed
uninstall retention passed
reinstall recovery passed
MainWindow shutdown coordination sufficient in tested installed lifecycle
human-visible acceptance still pending
beta not accepted
Cycle 06 not closed
```

The next append should record human-visible acceptance results, SmartScreen/security observations, artifact-policy resolution, or a bounded failure discovered during those final gates.
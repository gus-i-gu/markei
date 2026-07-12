# 09_DESIGN_STATE.md

> Version: 0.3-cycle06-sprint02
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat [D]
> Scope: Low-cost recovery surface for current Cycle 06 Design state
> Sources: `01_ARCHITECTURE.md`, `14_MODEL_OVERVIEW.md`, `DEV_STAGE/G_OPS_CODEX.md`, `DEV_STAGE/I_DSN_CODEX.md`, `[M]_STAGE/J_[M]_STAGE.md`

---

# Current Milestone

Cycle 06 still has one milestone:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

Sprint 02 crossed the compiled-installer and automated installed-lifecycle boundary. The beta is not yet accepted or globally closed.

---

# Current Architecture

```text
Desktop UI
    ↓
ProductService
    ↓
Repository
    ↓
Database Manager
    ↓
SQLite
```

Packaging and installation remain deployment concerns. No broad business, persistence, transaction, schema, service, repository, or composition redesign occurred.

---

# Current Evidence State

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Technically validated:

- Inno Setup 6.7.3 available through per-user installation;
- installer compiler discovery corrected;
- frozen runtime rebuilt;
- installer compiled and inspected;
- per-user installation completed;
- installed executable and Start Menu shortcut present;
- Start Menu shortcut launched the installed executable;
- external database initialized;
- service-backed Register / Lists / History / Settings evidence passed;
- installed close and immediate reopen passed;
- same-version reinstall preserved data;
- uninstall preserved `%LOCALAPPDATA%/Markei`;
- reinstall recovered retained data.

---

# Accepted Sprint 02 Boundary Delta

## Tooling

`scripts/build_installer.ps1` now discovers the per-user Inno Setup path. This is a tooling correction, not an architectural change.

## Structural defaults

Fresh production initialization now creates idempotently:

```text
category F / General
store 1 / Default Store
```

These are structural defaults required by current Register foreign-key behavior. They are not sample business data. Production still excludes `seed.sql` and creates zero sample products and purchases.

## Installed boundary

Observed technical behavior matched the accepted split:

```text
%LOCALAPPDATA%/Programs/Markei
    replaceable program files
    Markei.exe
    uninstall registration
    Start Menu shortcut

%LOCALAPPDATA%/Markei
    market.sqlite
    transient WAL/SHM
    logs
```

## Shutdown

Installed normal closure reached the existing `MainWindow.closeEvent()` path and supported immediate reopen. No broader lifecycle redesign was required.

---

# Artifact Evidence

```text
Installer:
    dist/installer/Markei-Setup-0.1.0-x64.exe
    SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
    size 34,448,651 bytes

Frozen executable:
    SHA256 E13E276139E5F680D91A9816FC79776EB9837CA901C2DEBCF6B9CFAF8594A282
```

The installer artifact is present on the branch despite G describing it as generated but uncommitted. Artifact-versioning policy remains for Main/Operational reconciliation and is not decided by Design.

The Inno `x64` deprecation warning is non-blocking tooling debt.

---

# Remaining Validation Limits

```text
human-visible installer wizard observation
human-visible Register / Lists / History / Settings walkthrough
human-visible close/reopen confirmation
human-visible SmartScreen behavior
human acceptance of the controlled beta
artifact-versioning policy resolution
```

Technical workflow evidence used the installed user database and ProductService path, but it was not a complete human visual UI walkthrough.

Validation used the current ordinary Windows user with existing Markei data backed up and restored. Dedicated-account isolation was not evidenced.

Defender enabled and `NotSigned` status were observed. No SmartScreen prompt appeared during silent/programmatic execution; human-visible SmartScreen behavior remains unknown.

---

# Current Open Risks and Debt

1. Human-visible UI acceptance remains pending.
2. Human-visible SmartScreen/security interaction remains unknown.
3. Artifact-versioning policy remains unresolved outside Design ownership.
4. A true compatible-version upgrade was not exercised; same-version reinstall passed.
5. Workflow atomicity remains inherited Design debt.
6. Broader migration strategy remains unresolved and was not required by installed gates.

---

# Explicit Deferrals

Outside this Design update:

- composition-root or dependency-injection redesign;
- ProductService/Repository decomposition;
- workflow transaction redesign;
- schema redesign or migration ledger;
- mobile, backend/API, synchronization, authentication, and cloud persistence;
- auto-update, signing, rollback, and one-file packaging;
- optional uninstall data-deletion UX;
- broad UI/navigation redesign.

---

# Recovery Route

```text
Rapid current state
    → this file

Compact architecture map
    → design/14_MODEL_OVERVIEW.md

Exact accepted architecture
    → design/01_ARCHITECTURE.md

Chronology and rationale
    → design/03_DECISION_LOG.md
```

The next Design checkpoint update should follow human-visible acceptance evidence or a bounded failure discovered during those remaining gates.
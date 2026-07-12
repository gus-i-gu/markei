# 10_OPERATIONAL_STATE.md

> Version: Cycle 06 checkpoint 0.4
> Status: Active operational checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Operational
> Branch: `sketch-notebook-recovery`
> Canonical source: `operational/12_OPERATIONAL_MODEL.md`
> Active work source: `operational/04_TODO.md`

---

# 1. Current Cycle 06 State

Cycle 06 Sprint 02 crossed the installer and installed-runtime boundary.

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Markei is technically release-candidate ready for controlled beta review, but the beta is not accepted or closed. Human-visible UI walkthrough, interactive installer/security observation, and final Main/human acceptance remain pending.

# 2. Validated Current-Branch Evidence

The following gates have current evidence:

- Inno Setup 6.7.3 installed per user and discovered by `scripts/build_installer.ps1`;
- source compilation and five standard-library release tests;
- rebuilt one-folder frozen runtime;
- compiled installer artifact;
- per-user installation under `%LOCALAPPDATA%\Programs\Markei`;
- Start Menu shortcut creation and installed executable launch;
- external database creation under `%LOCALAPPDATA%\Markei`;
- structural defaults `F / General` and `1 / Default Store`;
- zero sample products and purchases on fresh production initialization;
- Register-equivalent ProductService persistence;
- expected Lists, History, and Settings projection evidence;
- installed close and immediate reopen;
- same-version reinstall with retained data;
- uninstall with retained database;
- reinstall with retained-data recovery.

Artifact evidence:

```text
frozen executable
    dist\Markei\Markei.exe
    SHA256 E13E276139E5F680D91A9816FC79776EB9837CA901C2DEBCF6B9CFAF8594A282

installer
    dist\installer\Markei-Setup-0.1.0-x64.exe
    SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
    size 34,448,651 bytes
```

# 3. Evidence Boundaries

Automated lifecycle validation used the current ordinary Windows user. Existing Markei data was backed up and restored. This evidences ordinary per-user install semantics, but not dedicated clean-account isolation.

Register, Lists, History, and Settings were technically validated through the installed database and the same ProductService path used by the application. A complete human-visible UI walkthrough remains pending.

Defender was enabled and the binaries were unsigned. No SmartScreen prompt was observed during silent/programmatic execution. Human-visible SmartScreen behavior remains `unknown`.

# 4. Bounded Sprint 02 Corrections

Two direct failures produced bounded corrections:

```text
ISCC.exe not discovered
→ add per-user Inno Setup path to build_installer.ps1
→ installer compile passed

fresh production Register foreign-key failure
→ add idempotent structural category/store defaults
→ tests, build, workflow, and lifecycle rerun passed
```

The Inno Setup `x64` deprecation warning is non-blocking maintenance debt.

# 5. Artifact Repository Drift

The current branch contains:

```text
dist/installer/Markei-Setup-0.1.0-x64.exe
```

G incorrectly describes this artifact as generated but uncommitted. Operational policy is that generated release binaries should be delivered through an approved release/artifact channel rather than retained as ordinary source files. Removal and ignore-rule materialization require a separate authorized cleanup; this documentation pass leaves the artifact unchanged.

# 6. Remaining Gates

```text
interactive installer wizard observation
→ human-visible Register / Lists / History / Settings walkthrough
→ human-visible normal close and immediate reopen
→ human-visible SmartScreen / antivirus observation
→ human acceptance for controlled beta use
→ Main closure
```

A dedicated-account rerun is not automatically blocking unless current-user backup/restore evidence is later judged ambiguous.

Workflow atomicity remains inherited Operational debt and was not changed.

# 7. Recovery Route

```text
1. Read this checkpoint.
2. Read 04_TODO.md for remaining human and cleanup work.
3. Read 12_OPERATIONAL_MODEL.md for stable rules and artifact policy.
4. Read 11_OPERATIONAL_RECORD.md for Sprint 01/02 chronology and hashes.
5. Read J_[M]_STAGE.md or G_OPS_CODEX.md only for reconciliation detail.
6. Inspect source only when these surfaces are insufficient or drift is suspected.
```

Refresh this checkpoint when human acceptance, SmartScreen observation, artifact cleanup, or Cycle 06 closure changes state.
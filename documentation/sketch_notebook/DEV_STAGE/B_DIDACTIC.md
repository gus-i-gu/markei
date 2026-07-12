# B_DIDACTIC — Cycle 06 Sprint 02

> Status: Ephemeral functional stage
> Role: Didactic Chat [A]
> Branch: `sketch-notebook-recovery`
> Authority: Sprint 02 learning delta for Main reconciliation; not permanent Didactic memory
> Milestone: Fully executable and installable Windows primary beta

## Main Synthesis Summary

Sprint 02 does not require a new release-engineering concept family. The four canonical Red concepts created after Sprint 01 already cover the remaining learning problem:

```text
&&&05  Evidence State and Validation Boundary
&&%04  Source, Frozen, and Installed Execution Context
&%%06  Packaging and Installation Artifact Lifecycle
%%%06  Build-Time, Runtime, and Installer-Time Dependency
```

The required delta is reinforcement through installed-lifecycle evidence. Sprint 01 established configuration, frozen artifact generation, frozen launch, schema-only first launch, startup diagnostics, and corrected source/frozen shutdown behavior. Sprint 02 must cross the still-unproven boundaries from installer configuration to compiled installer, from frozen launch to installed launch, and from configured data retention to observed preservation across reinstall, uninstall, and recovery.

No genuinely new canonical concept is justified before those gates run. SmartScreen and antivirus observations can be taught as environmental or reputation evidence inside `&&&05`, rather than as proof for or against application correctness. The existing resource and ownership concepts remain sufficient for explaining installed file placement, external `%LOCALAPPDATA%/Markei` state, and close/reopen behavior.

Main should therefore authorize a reinforcement-only Didactic delta in the later E stage: preserve all four concepts as Red, add installed-lifecycle examples only after matching evidence exists, and use learner checks to prevent status inflation. No concept may become Green automatically because an installer compiles or an installed workflow passes.

## Inherited Learning State

Current evidence state:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

The canonical register already teaches that evidence from one lifecycle stage cannot prove a later one. The Concept Map accurately records the project learning spine through installer configuration, with compiled installer and installed execution still blocked.

Relevant existing concepts:

- `&&&05` owns evidence-state vocabulary and validation boundaries.
- `&&%04` owns source, frozen, and installed execution contexts.
- `&%%06` owns the sequence of configuration, generated artifacts, installed state, and lifecycle evidence.
- `%%%06` owns build-time, runtime, and installer-time prerequisites.
- `%%%05` owns bundled resources versus writable user data.
- `&&&04`, `&&%03`, and `%%%02` own resource lifetime, deterministic cleanup, and connection ownership.
- `&&&03` reinforces precise status naming.

No Green concept exists through explicit learner validation.

## Essential Evidence Index

| ID | File or evidence | Didactic relevance |
|---|---|---|
| E1 | `[M]_STAGE/J_[M]_STAGE.md` | Authorizes the Sprint 02 delta and defines the remaining installed-lifecycle boundaries. |
| E2 | `didactics/02_KANBAN.md` | Confirms the four required concepts already exist as canonical Red entries. |
| E3 | `didactics/07_GLOSSARY.md` | Provides the derived vocabulary for installer artifact, installed application, dependencies, and validation boundary. |
| E4 | `didactics/08_CONCEPT_MAP.md` | Records the current learning spine and the blocked installed state. |
| E5 | `DEV_STAGE/G_OPS_CODEX.md` | Supplies Sprint 01 evidence: frozen build/launch passed; installer compilation was blocked. |
| E6 | `installer/Markei.iss` | Demonstrates installer configuration, per-user placement, shortcuts, and configured retention behavior. |
| E7 | `scripts/build_installer.ps1` | Demonstrates the installer-time dependency and compiler-discovery boundary. |

## Existing Concepts to Reinforce

### `&&&05` — Evidence State and Validation Boundary

Sprint 02 should provide the clearest project example yet of evidence progression:

```text
installer configured
→ installer compiled
→ application installed
→ installed workflows observed
→ lifecycle validated
→ Main/human acceptance
```

Each arrow requires new evidence. A successful `ISCC.exe` command would prove installer artifact generation, not installation, workflow correctness, retention, or acceptance. A SmartScreen warning would prove a Windows reputation/security observation, not an application defect.

### `&&%04` — Source, Frozen, and Installed Execution Context

Installed execution must be observed through the installer-created path, ideally the Start Menu shortcut, without Python or a source checkout. It remains the same business application, but its placement, launch route, resource resolution, dependencies, permissions, and uninstall registration differ from source and frozen-directory execution.

### `&%%06` — Packaging and Installation Artifact Lifecycle

Sprint 02 should reinforce the distinction:

```text
installer/Markei.iss
    installer configuration

dist/installer/Markei-Setup-0.1.0-x64.exe
    compiled installer artifact

%LOCALAPPDATA%/Programs/Markei
    installed application files

%LOCALAPPDATA%/Markei
    retained writable user state
```

The exact compiled path is anticipated by configuration but remains unproven until compilation succeeds.

### `%%%06` — Build-Time, Runtime, and Installer-Time Dependency

`ISCC.exe` remains an installer-time prerequisite. Its absence blocked only the installer transformation; it did not invalidate the built frozen application. Sprint 02 should show how providing the missing tool advances the artifact lifecycle without turning that tool into a runtime dependency of installed Markei.

### Existing resource and cleanup concepts

`%%%05` should be reinforced with direct comparison between replaceable installed files and retained user state. `&&&04`, `&&%03`, and `%%%02` should receive installed close/reopen evidence only if the installed application demonstrates the same deterministic cleanup already proven in source/frozen contexts.

## New Candidate Need Assessment

No new canonical concept is currently required.

The following proposed topics are adequately represented by existing canon:

- SmartScreen or antivirus reputation behavior → `&&&05`;
- installed file placement versus user-state placement → `%%%05` plus `&&%04`;
- shortcut-created launch paths → `&&%04` and `&%%06`;
- reinstall, upgrade, uninstall, and recovery evidence → `&%%06`;
- compiler discovery and missing `ISCC.exe` → `%%%06`;
- human acceptance versus technical validation → `&&&05`.

A new concept should be considered only if Sprint 02 exposes a reusable distinction that cannot be expressed through these existing boundaries. Tool-specific syntax or wizard behavior is not sufficient.

## Installed-Lifecycle Distinctions

Main reconciliation should preserve these distinctions:

```text
installer configuration ≠ compiled installer artifact
frozen launch ≠ installed launch
installed launch ≠ installed workflow validation
external data placement ≠ observed preservation
no uninstall deletion rule ≠ validated retention
reinstall success ≠ upgrade compatibility
SmartScreen warning ≠ application malfunction
antivirus observation ≠ release acceptance
technical validation ≠ learner mastery
technical validation ≠ Main/human acceptance
```

Configured retention means the installer source does not intentionally remove `%LOCALAPPDATA%/Markei`. Observed preservation requires data to exist before uninstall, remain afterward, and reopen correctly after reinstall.

## Learner Validation Questions

1. What exact artifact or state does the successful command prove, and what later states remain unproven?
2. How can one demonstrate that Markei launched as an installed application rather than from `dist/Markei`?
3. Which files should be replaceable program files, and which should survive uninstall under the accepted policy?
4. What evidence would distinguish configured retention from observed preservation?
5. Why does a Start Menu shortcut matter to the installed-execution claim?
6. If SmartScreen displays a warning but Markei installs and runs correctly, which evidence category does the warning belong to?
7. If installed close/reopen fails while frozen close/reopen passed, where is the new validation boundary?
8. Why does a compiled installer not establish workflow, upgrade, uninstall, or recovery correctness?
9. Which dependency is needed to compile the installer, and why is it not necessarily needed by the installed application?
10. Who may declare the beta accepted after technical gates pass?

## Maturity Constraints

All four Cycle 06 concepts remain Red during this functional stage.

Possible later movement from Red to Yellow may be considered only after:

- installer compilation and artifact inspection are evidenced;
- installed launch is distinguished from frozen launch;
- installed workflows and close/reopen are observed;
- retention is tested through uninstall and reinstall;
- the learner can answer the validation questions accurately.

Even then, maturity change requires Didactic evaluation and explicit learner evidence. Passing commands, tests, or human acceptance of the software does not automatically demonstrate conceptual mastery. Green promotion is not authorized.

## Main Handoff

Didactic recommends a reinforcement-only Sprint 02 materialization. No new KANBAN identifier is needed, and no Didactic decision blocks installer work.

The later E-stage delta should prepare concise post-evidence updates for the four existing Red concepts, glossary examples, Concept Map status, and Lecture Register chronology. Those updates must remain conditional on matching G/H/I evidence and Main reconciliation.

Main should preserve the following learning acceptance rule:

```text
compiled installer
+ installed execution
+ lifecycle evidence
+ human software acceptance
≠ automatic learner mastery
```

The Didactic domain is ready to interpret Sprint 02 evidence without expanding the concept inventory or reopening Sprint 01 canon.

# A_OPERATIONAL — Cycle 06

> Status: Complete compressed functional stage
> Role: Operational Chat [O]
> Branch: `sketch-notebook-recovery`
> Authority: analysis for Main reconciliation only
> Main stage: `documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md`

## Main Synthesis Summary

Markei already has the core source/frozen boundary required for a Windows beta: a PyInstaller one-folder configuration, a PowerShell build script, external writable data under `%LOCALAPPDATA%/Markei`, frozen-resource resolution, a version-resource file, and four public desktop surfaces. However, the recovery branch is only **configured**. No contemporary Cycle 06 evidence proves that the executable was built, launched outside the build context, installed, exercised, closed, reopened, upgraded, uninstalled, or reinstalled.

Five issues must be reconciled before D/E/F. First, `Markei.spec` and `scripts/build_windows.ps1` duplicate packaging authority and both bundle `seed.sql`; the seed contains defaults plus a real store and example Rice product. Second, the Windows version file exists but is not connected to the spec, and no icon is configured. Third, dependency versions and a supported builder Python are not fixed. Fourth, inspected entrypoints lack a top-level persistent startup-diagnostic boundary. Fifth, the exact current installer definition was not located; historical Cycle 05 claims therefore remain historical evidence, not current configuration proof.

The application creates four page-owned service/repository/SQLite chains. Local close capability exists, but deterministic application-wide shutdown and immediate database reopen remain unvalidated. Multi-step receipt and deletion workflows also commit in parts; this is a confirmed structure but not yet a proven beta failure.

Main must obtain decisions on production seed content, uninstall data retention, beta identity, shortcuts, and whether shutdown or transaction risks require implementation changes before beta. The recommended first materialization boundary is narrow: establish one authoritative build configuration, implement accepted seed and identity decisions, add startup diagnostics and installer configuration, then add only the focused validation assets needed to prove source, frozen, installed, workflow, and lifecycle gates.

## Current Operational Baseline

Runtime:

```text
main.py → app.main.main() → MainWindow
→ Register / Lists / History / Settings
→ ProductService → Repository → SQLite
```

The live database is configured at `%LOCALAPPDATA%/Markei/market.sqlite`; `schema.sql` and optional `seed.sql` are loaded from repository resources in source mode and from the PyInstaller resource base in frozen mode.

Current evidence status:

```text
source/frozen path separation     configured
PyInstaller one-folder build      configured
current frozen artifact           unknown
installer definition              unknown
installed lifecycle               unvalidated
Cycle 06 beta                     not accepted
```

Four pages each construct a `ProductService`, `Repository`, connection, and cursor. Repository and service close methods exist; one composition-level shutdown owner is not established. Repository mutations commit individually, so complete receipt and deletion/recalculation workflows are not atomic.

## Essential Evidence Index

| ID | File or evidence | Why it matters |
| -- | -- | -- |
| E1 | `Markei.spec` | Defines `main.py` one-folder packaging; includes schema and seed, uses console and UPX, but no version or icon. |
| E2 | `scripts/build_windows.ps1` | Defines the repository build command and independently repeats resource inclusion. |
| E3 | `app/core/database.py` | Owns frozen-resource lookup, external user-data path, automatic optional seed execution, migration, and reset. |
| E4 | `app/database/seed.sql` | Contains settings plus category, store, and example Rice business data. |
| E5 | `build/markei_version_info.txt` and `app/core/config.py` | Define version `0.1.0`, but executable integration is absent from E1. |
| E6 | `app/main.py` and `main.py` | Define startup; no inspected persistent top-level exception diagnostic exists. |
| E7 | `app/desktop/main_window.py`, page constructors, Repository/Service close APIs | Establish four public surfaces and distributed connection ownership. |
| E8 | Operational checkpoints and Cycle 06 scheme | Preserve historical frozen-build evidence as non-contemporary and require full installed lifecycle validation. |

Additional inspected files: `requirements.txt`, `requirements-dev.txt`, `app/core/repository.py`, `app/core/services.py`, `app/desktop/ui/pages/register_page.py`, `00_PROJECT_STATE.md`, `06_SESSION_SCHEME.md`, `operational/10_OPERATIONAL_STATE.md`, `operational/04_TODO.md`, and `operational/12_OPERATIONAL_MODEL.md`.

## Build and Installation Gaps

Finding:
The branch has two packaging-control surfaces that can drift: E1 and E2 both define the entrypoint and bundled SQL resources.

Status:
observed

Impact:
materialization input

Evidence:
E1, E2

Finding:
Both packaging surfaces include `seed.sql`, and initialization executes it whenever present. The configured beta would therefore create example business data unless policy or implementation changes.

Status:
observed

Impact:
beta blocker

Evidence:
E1, E2, E3, E4

Finding:
Version metadata exists but is not attached to E1; no icon is configured. The spec defaults to a console executable and enables UPX without contemporary validation.

Status:
observed

Impact:
materialization input

Evidence:
E1, E5

Finding:
`requirements.txt` and `requirements-dev.txt` declare PySide6 and PyInstaller without versions, and no supported builder Python version is encoded.

Status:
observed

Impact:
materialization input

Evidence:
additional dependency files

Finding:
The exact contemporary `.iss` installer file and installer compile script were not located through bounded branch-qualified inspection. Historical claims cannot establish current installer configuration.

Status:
unresolved

Impact:
beta blocker

Evidence:
E8

Finding:
The source/frozen resource and writable-data split is already implemented, but generated resource inclusion, Qt plugin collection, working-directory independence, and data exclusion remain unvalidated.

Status:
observed

Impact:
validation input

Evidence:
E1, E2, E3

Immediately required repository commands are limited to:

```powershell
python -m compileall app main.py
.\scripts\build_windows.ps1
```

Detailed clean-build, artifact-inspection, and installer commands belong in D_OPS_STAGE after the authoritative packaging and installer files are selected.

## Required Validation Gates

| Gate | Required evidence | Current status |
| ---- | ----------------- | -------------- |
| Source integrity | imports compile; isolated DB initializes/migrates; four public pages launch | unvalidated in Cycle 06 |
| Frozen runtime | clean one-folder build; launch outside repository/build working directory; schema and Qt plugins found; approved seed behavior; external DB; no live DB/WAL/SHM bundled | configured, unvalidated |
| Installer compilation | exact installer source and compiler recorded; installer builds with approved identity and file set | blocked by unresolved topology/toolchain |
| Clean installation | install in ordinary per-user environment; launch from installed entrypoint without Python/source checkout | unvalidated |
| Installed workflow | Register write; Lists and History refresh; Settings/store workflow; normal close and persistence | unvalidated |
| Lifecycle | immediate reopen; no release-blocking DB lock; accepted upgrade/uninstall/reinstall and retained-data behavior | unvalidated |
| Release evidence | matching A/B/C, J, D/E/F, G/H/I and recorded human validation | pending |

## Operational Risks

Finding:
Application composition distributes four long-lived SQLite ownership chains. Local close methods exist, but normal Qt closure has not proven that all four close deterministically.

Status:
unresolved

Impact:
beta blocker if immediate reopen or file cleanup fails; otherwise validation input

Evidence:
E7, E8

Finding:
Receipt registration and deletion/recalculation span multiple committed mutations, allowing partial durable state after injected failure.

Status:
observed

Impact:
validation input; beta blocker only if Main/Design/Human reject demonstrated failure behavior

Evidence:
E7, E8

Finding:
Startup failures can occur before MainWindow appears, but inspected entrypoints expose no persistent log or actionable top-level dialog.

Status:
observed

Impact:
materialization input

Evidence:
E6

Finding:
Unpinned build dependencies, duplicate packaging definitions, stale output, missing Qt plugins, or UPX behavior can produce a builder-specific artifact that is not reproducible.

Status:
inferred

Impact:
materialization and validation input

Evidence:
E1, E2

Finding:
External database placement supports preservation but does not prove upgrade, uninstall, or reinstall behavior.

Status:
observed

Impact:
beta blocker until lifecycle evidence exists

Evidence:
E3, E8

## Decisions Required

Decision:
What belongs in production first-launch data?

Options:
A. Exclude `seed.sql` and let schema/migration create only required defaults.
B. Split production defaults from demo/development data and package only the production resource.
C. Retain the current seed, explicitly accepting category, store, settings, and Rice data.

Domain recommendation:
B, or A if migration already owns all mandatory defaults; do not ship example business data implicitly.

Required owner:
Human / Design / Main

Deadline:
before D/E/F

Decision:
What happens to `%LOCALAPPDATA%/Markei` during uninstall?

Options:
A. Preserve by default.
B. Preserve by default with an explicit optional removal choice.
C. Remove automatically.

Domain recommendation:
B for controlled beta, provided installer behavior is testable; otherwise A is operationally safer.

Required owner:
Human / Design / Main

Deadline:
before D/E/F

Decision:
What is the accepted beta identity?

Options:
A. Retain `Markei`, version `0.1.0`, executable `Markei.exe`, and define publisher/installer/AppId.
B. Approve a different beta version or naming set.

Domain recommendation:
Use one approved identity source propagated to application, executable, and installer.

Required owner:
Human / Main / Design

Deadline:
before D/E/F

Decision:
Which packaging surface is authoritative?

Options:
A. `Markei.spec`, with the PowerShell script invoking it.
B. Command-line arguments in the PowerShell script, with generated spec treated as output.

Domain recommendation:
A, because version, icon, datas, console mode, and later hooks need one reviewable source.

Required owner:
Main, informed by Operational evidence

Deadline:
before D/E/F

Decision:
Does the installer create a desktop shortcut?

Options:
A. Start Menu only.
B. Start Menu plus optional desktop shortcut.
C. Both unconditionally.

Domain recommendation:
B.

Required owner:
Human / Design / Main

Deadline:
before D/E/F

Decision:
Must shutdown ownership or workflow transactions change before beta?

Options:
A. Validate current behavior first and patch only demonstrated release blockers.
B. Require composition-owned shutdown and/or workflow transactions before artifact validation.

Domain recommendation:
A; current structure establishes risk, not failure.

Required owner:
Main / Design / Human, based on Operational evidence

Deadline:
before beta acceptance; implementation decision before D/E/F only if preemptive correction is chosen

## Recommended First Materialization Boundary

The first D_OPS_STAGE should be limited to:

1. make `Markei.spec` the single packaging source and make the build script invoke it;
2. implement the accepted production seed decision;
3. attach approved version metadata and icon, produce diagnostic-console and final-windowed modes, and disable UPX unless explicitly validated;
4. pin or otherwise record the supported Python, PySide6, and PyInstaller build environment;
5. add persistent startup exception diagnostics;
6. locate/repair or create the bounded Inno Setup definition and compile script with accepted identity, shortcuts, and retention behavior;
7. add focused tests or probes for resource discovery, external DB placement, package exclusions, shutdown/immediate reopen, and installed lifecycle evidence.

Do not combine this boundary with broad application refactoring. Build and installation validation should follow in later execution steps but remain part of the same Cycle 06 milestone.

## Explicit Deferrals

Deferred outside Cycle 06:
mobile, backend/API, synchronization, authentication, cloud persistence, broad service/repository decomposition, unrelated UI redesign, broad schema redesign, complete migration-framework replacement, one-file packaging, automatic updates, rollback infrastructure, and production signing unless controlled-beta execution is blocked without it.

## Main Handoff

Main can proceed to J reconciliation once Didactic and Design stages are available. The Operational position is: Markei has a credible source/frozen data boundary and useful packaging inputs, but no current accepted release artifact. D/E/F must first resolve seed, retention, identity, shortcut, packaging-authority, installer-topology, and risk-treatment decisions. The smallest sound implementation stage should repair and unify packaging/installer configuration and diagnostics, then require evidence through source, frozen, installer, installed workflow, immediate-reopen, and lifecycle gates. No status beyond **configured** is currently justified.

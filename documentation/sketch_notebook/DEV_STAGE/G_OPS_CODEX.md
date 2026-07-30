# G_OPS_CODEX - C10-GCM03-S09-R06-CR01

Sequence: FLX-ORD-01
Role: Codex operational evidence
Round or unit: C10-GCM03-S09-R06-CR01
Branch: grm-guarded-provisioning-20260727
Baseline / inspected HEAD: ece4375f228c5564e86f845fa65bd0f88b9ca829
Authority: D_OPS_STAGE.md, E_DDC_STAGE.md, F_DSN_STAGE.md
Writable surfaces: documentation/G_SCRIPTS.md and G/H/I reports only
Evidence boundary: Windows generated-state preparation and procedure readiness only

## Incident-To-Correction Mapping

- Incident: `flutter clean` did not leave generated state clean; the procedure continued into `flutter pub get`; stale or recreated `auth0_flutter` generated plugin state collided with pub regeneration.
- Correction: `GS-FLUTTER-WIN` now inspects bounded Markei/Flutter/Dart process ownership, refuses to terminate anything, requires `flutter clean` success, verifies exact generated-state postconditions, removes only enumerated generated paths under `clients/markei_flutter` when no relevant owner is active, verifies absence again before `flutter pub get`, and checks package/plugin regeneration after `pub get`.
- Non-correction: no dependency, CMake, Auth0-coordinate, R06 identity, application, Sync, provider, database, R07, Android, or Windows Debug change was made.

## Files Changed

- documentation/G_SCRIPTS.md
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

## Commands Run And Results

- `git fetch origin grm-guarded-provisioning-20260727` -> passed.
- `git switch grm-guarded-provisioning-20260727` -> already on branch, up to date.
- `git rev-parse HEAD` -> `ece4375f228c5564e86f845fa65bd0f88b9ca829`.
- `git rev-list --left-right --count HEAD...origin/grm-guarded-provisioning-20260727` -> `0 0`.
- `git merge-base --is-ancestor e5168f6d2063b359ba773c107b73420bb29d43e8 ece4375f228c5564e86f845fa65bd0f88b9ca829` -> passed.
- Required AGENTS/INDEX/D/E/F reads -> completed.
- Extracted `GS-FLUTTER-WIN` from `documentation/G_SCRIPTS.md` using the same heading/fence pattern as `documentation/I_SCRIPTS.ps1`; `[scriptblock]::Create(...)` parse validation -> passed, extracted length 13346.
- Static termination inspection of extracted block for `Stop-Process`, `taskkill`, `kill` -> 0 matches.
- Static gate-order inspection -> `Remove-BoundedGeneratedState` and `Assert-GeneratedTargetsAbsent -Stage "before flutter pub get"` occur before the actual `flutter pub get` command.
- Static containment/removal inspection -> exact relative generated targets `.dart_tool`, `windows\flutter\ephemeral`, and `build\windows` are present; containment guard rejects rooted paths, wildcards, and `..`; removal uses `Remove-Item -LiteralPath`.
- Static plugin-regeneration inspection -> package config, `auth0_flutter`, plugin symlink, Windows CMake file, generated plugins file, and one-target count checks are present.
- Static R06 tail inspection -> `MARKEI_SOURCE_REVISION`, `MARKEI_SOURCE_TREE_SHA256`, artifact `Get-FileHash`, callback registration, and exact executable launch remain present.

## Skipped Actions

- Did not execute `GS-FLUTTER-WIN`, `flutter clean`, `flutter pub get`, Windows build, callback registration, or application launch.
- Did not run a disposable clean-state exercise because executing the procedure would continue into build/callback/launch unless further harnessing was introduced outside scope.
- Did not stop or terminate any process.
- Did not run Sync, Retry, Recovery, Query, Enroll, new Purchase, provider mutation, database repair/reset/clear, preserved-client installation, preserved-client launch, full Flutter regression, Android build, GRIMOIRE, SQLite, Neon, Render, Auth0, or hosted-provider suites.

## Residual Human Checkpoint

After Main reconciliation, rerun only the corrected `GS-FLUTTER-WIN` procedure from the pushed CR01 commit. The procedure should either stop with bounded operator instructions for active owners or pass cleanup/pub-get/build and record the Windows artifact and visible source identity.

## Terminals

C10_GCM03_S09_R06_CR01=IMPLEMENTED_VALIDATED
WINDOWS_GENERATED_STATE_PREFLIGHT=PASS
CLEANUP_POSTCONDITION_VERIFICATION=PASS
AUTOMATIC_PROCESS_TERMINATION=NO
PUB_GET_GATED_BY_VERIFIED_CLEANUP=PASS
PLUGIN_REGENERATION_VERIFICATION=PASS
R06_IDENTITY_CHAIN_PRESERVED=PASS
WINDOWS_BUILD_PROCEDURE_READY_FOR_HUMAN_RERUN=YES
WINDOWS_BUILD_REACHED_BY_CODEX=NO
SYNC_SOURCE_CHANGED=NO
PRESERVED_CLIENT_STATE_TOUCHED=NO
LIVE_SYNC_EXECUTED=NO
PROVIDER_MUTATION=NONE
R07_IMPLEMENTATION=HELD
NEXT_HUMAN_CHECK=RERUN_GS_FLUTTER_WIN_ONLY

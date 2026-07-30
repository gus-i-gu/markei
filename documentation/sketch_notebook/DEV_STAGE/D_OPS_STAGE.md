# D_OPS_STAGE - C10-GCM03-S09-R06-CR02

Sequence: FLX-ORD-01
Role: Main operational materialization stage
Round or unit: C10-GCM03-S09-R06-CR02
Branch: grm-guarded-provisioning-20260727
Required starting HEAD: 5fef8a51ccb61dff00e773b3c8759062560d27da
Authority: Human-supervised Main Chat
Scope: Windows procedure attribution and generated-plugin manifest correction only

## 1. Purpose

Correct two false guards introduced by CR01 in the canonical
`GS-FLUTTER-WIN` procedure:

1. name-only process detection classifies every `dart.exe` process as an owner
   of this Flutter client;
2. plugin verification checks
   `windows\flutter\ephemeral\generated_plugins.cmake`, while the repository
   Windows scaffold and Flutter-generated manifest use
   `windows\flutter\generated_plugins.cmake`.

This round does not diagnose or change application, dependency, Auth0, CMake,
Sync, provider, or database behavior.

## 2. Established Evidence

The human CR01 reruns established:

- a plain Dart PID was enough to stop pre-clean without repository, command
  line, file-lock, or client-path attribution;
- after that PID was manually stopped, `flutter clean` completed;
- bounded generated-state cleanup completed;
- `flutter pub get` completed with `Got dependencies!`;
- `.dart_tool/package_config.json`, the `auth0_flutter` package entry, the
  Windows plugin symlink, and its `windows/CMakeLists.txt` passed the existing
  checks;
- the procedure then failed only at
  `Windows generated_plugins.cmake was not regenerated`;
- repository inspection proves
  `clients/markei_flutter/windows/flutter/generated_plugins.cmake` exists and
  contains one `auth0_flutter` plugin entry;
- the repository has no
  `clients/markei_flutter/windows/flutter/ephemeral/generated_plugins.cmake`.

Therefore:

```text
WINDOWS_TOOLCHAIN=AVAILABLE
DEPENDENCY_RESOLUTION=PASS
PLUGIN_SYMLINK_REGENERATION=PASS
GENERATED_PLUGIN_MANIFEST_ASSERTION=FALSE_PATH
PROCESS_OWNERSHIP_ASSERTION=UNATTRIBUTED
WINDOWS_COMPILATION=NOT_REACHED
```

## 3. Writable Scope

Implementation:

- `documentation/G_SCRIPTS.md`

Reports to replace:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

An existing directly relevant procedure-test file may change only if it already
provides a focused extraction or PowerShell validation surface. Do not create a
new test framework for this round.

## 4. Required Correction

### 4.1 Process attribution

Replace name-only ownership classification with evidence-backed attribution.

The procedure must:

- inspect process ID, process name, executable path, and command line through a
  read-only Windows process query where available;
- classify a process as a definite relevant owner only when evidence connects
  it to Markei, this repository/client path, the Markei Windows build output,
  or a Flutter run/build command operating on this client;
- classify Dart/Flutter analysis or language-server activity as non-owning
  unless separate evidence connects it to a relevant build/run or target lock;
- never claim that process ownership was detected from process name alone;
- never terminate a process automatically;
- avoid printing secrets or full raw command lines; diagnostics must show only
  bounded fields needed for attribution;
- preserve fail-closed behavior when a definite relevant owner is found;
- if process metadata is unavailable or ambiguous, rely on actual cleanup and
  cleanup-postcondition failure as the blocking evidence rather than declaring
  ownership pre-emptively;
- on cleanup failure, report bounded candidate process diagnostics and instruct
  the operator to inspect or close the relevant activity manually.

The procedure must not require closing VS Code merely because its Dart analysis
server exists.

### 4.2 Generated-plugin verification

Correct the generated manifest contract:

- verify the manifest at
  `windows\flutter\generated_plugins.cmake`;
- verify that it is a file;
- verify exactly one `auth0_flutter` entry using a bounded parse;
- keep the plugin symlink check at
  `windows\flutter\ephemeral\.plugin_symlinks\auth0_flutter`;
- keep the plugin CMake check under that symlink;
- do not move, recreate manually, or edit generated native files;
- do not add the non-ephemeral manifest to the bounded deletion set;
- do not treat a missing nonexistent ephemeral manifest as a Flutter failure.

If the corrected manifest is missing or incoherent after `flutter pub get`,
stop with a message that names the correct path and does not claim compilation
was attempted.

### 4.3 Preserved CR01/R06 behavior

Preserve:

- exact-path containment for `.dart_tool`,
  `windows\flutter\ephemeral`, and `build\windows`;
- `flutter clean` exit-code check;
- cleanup postcondition checks;
- `flutter pub get` gating;
- no automatic process termination;
- R06 source identity resolution and definitions;
- analysis, tests, Windows Release build, artifact hashing, callback
  registration, exact-executable launch, and visible-identity instructions.

## 5. Prohibited Scope

Do not modify:

- Flutter/Dart application source or behavior;
- `pubspec.yaml`, `pubspec.lock`, dependency constraints, or packages;
- native CMake files, generated plugin files, plugin source, vcpkg, or
  cpprestsdk;
- `documentation/I_SCRIPTS.ps1`, unless a dispatcher defect is proved; if
  proved, stop and report rather than expanding scope;
- Android procedures or Windows Debug procedures;
- Sync, Product, inbound apply, cursor, acknowledgement, diagnostics, Settings,
  Audit, SQLite, migrations, hosted API, Render, Neon, Auth0, or enrollment;
- A/B/C, J, `REC_DIAGNOSTICS.md`, permanent memory, methodology, GRM, DB_MGMT,
  or NS coordinates;
- R07 or `ALT_DEV.md`.

Do not execute:

- Sync, Retry, Recovery, Query, Enroll, or new Purchase;
- provider mutation or database repair/reset/clear;
- preserved-client installation or live application launch;
- automatic process termination;
- `flutter upgrade`, dependency upgrade, pub-cache purge, or broad recursive
  deletion.

## 6. Validation

Codex must:

1. Extract `GS-FLUTTER-WIN` through the existing dispatcher-compatible heading
   and fence contract.
2. Parse the extracted PowerShell body successfully.
3. Prove no automatic process termination command exists.
4. Prove name alone cannot classify `dart` or `flutter` as a definite owner.
5. Prove analysis/language-server activity is not a definite owner without
   additional attributable evidence.
6. Prove diagnostics do not emit raw command lines or coordinate values.
7. Prove cleanup and postcondition gates remain before `flutter pub get`.
8. Prove the plugin symlink uses the ephemeral path.
9. Prove `generated_plugins.cmake` uses the non-ephemeral
   `windows\flutter\generated_plugins.cmake` path.
10. Prove the manifest contains exactly one `auth0_flutter` entry.
11. Prove the three bounded cleanup targets remain exact and unchanged.
12. Prove the R06 identity/build/artifact/callback/launch tail remains present.
13. If safe on Codex's disposable host, run a focused clean/pub-get
    regeneration exercise without installing, launching, logging in, or
    touching a preserved client. If unavailable, mark it skipped explicitly.
14. Run `git diff --check`.
15. Confirm the complete changed-path set is authorized.

## 7. Reporting Terminals

G/H/I must include:

```text
C10_GCM03_S09_R06_CR02
CR01_PROCESS_ATTRIBUTION
NAME_ONLY_DART_OWNERSHIP
ANALYSIS_SERVER_FALSE_POSITIVE
GENERATED_PLUGIN_MANIFEST_PATH
PLUGIN_SYMLINK_PATH
PUB_GET_GATED_BY_VERIFIED_CLEANUP
AUTOMATIC_PROCESS_TERMINATION
R06_IDENTITY_CHAIN_PRESERVED
WINDOWS_BUILD_REACHED_BY_CODEX
WINDOWS_BUILD_PROCEDURE_READY_FOR_HUMAN_RERUN
SYNC_SOURCE_CHANGED
PRESERVED_CLIENT_STATE_TOUCHED
LIVE_SYNC_EXECUTED
PROVIDER_MUTATION
R07_IMPLEMENTATION
NEXT_HUMAN_CHECK
```

## 8. Publication

If implementation and focused validation succeed:

- commit only authorized paths;
- make the implementation commit a direct child of the CR02 staging commit;
- push by non-forced fast-forward to
  `grm-guarded-provisioning-20260727`;
- do not create another branch or pull request;
- verify the remote branch equals the implementation commit.

If attribution cannot be made safe without broad process termination or
unbounded inspection, report:

```text
C10_GCM03_S09_R06_CR02=BLOCKED
```

and do not improvise.

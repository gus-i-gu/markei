# D_OPS_STAGE — C10-GCM03-S09-R06-CR01 Windows cleanup hardening

## Active authority

Authority state: ACTIVE — CODEX CORRECTIVE IMPLEMENTATION AUTHORIZED AFTER PUBLICATION

Sequence: FLX-ORD-01

Primary unit: C10-GCM03-S09-R06-CR01

Repository: gus-i-gu/markei

Existing branch: grm-guarded-provisioning-20260727

Required pre-stage head: e5168f6d2063b359ba773c107b73420bb29d43e8

Required Codex starting head: the published CR01 D/E/F staging commit pinned by Main in the seeding prompt.

D controls executable scope and terminals. E constrains evidence meaning. F controls architecture and responsibility. R06 source implementation remains accepted. A/B/C support reports, J, R07/UI design, installed clients, preserved SQLite databases, diagnostic history, Render, Neon, Auth0, and provider state are read-only and out of scope.

## 1. Incident classification

The preserved-client Windows procedure stopped before compilation:

~~~text
flutter clean could not remove .dart_tool completely
→ the procedure continued
→ flutter pub get encountered the existing auth0_flutter plugin symlink
→ PathExistsException / errno 183
→ Windows build was not reached
~~~

This evidence does not establish a CMake, cpprestsdk, dependency, Auth0-coordinate, R06 source-identity, application, or Sync failure. The missing Chrome installation is irrelevant to the Windows desktop target.

The defect is procedural: GS-FLUTTER-WIN checks the flutter clean exit code and removes windows/flutter/ephemeral, but it does not prove that all cleanup postconditions required by pub get are satisfied before continuing.

## 2. Objective

Harden only GS-FLUTTER-WIN so generated Flutter state is handled deterministically and the procedure fails closed on incomplete cleanup or a relevant active-process/lock condition.

The correction must preserve the complete R06 identity/build chain and must not broaden into R07, UI restructuring, Sync behavior, dependency changes, or preserved-state operations.

## 3. Required procedure behavior

Modify the canonical GS-FLUTTER-WIN PowerShell block in documentation/G_SCRIPTS.md.

Before cleanup:

1. Inspect for an active Markei executable and relevant Flutter/Dart build or run processes that can own or recreate the target generated paths.
2. Do not terminate any process automatically.
3. If a relevant owner is present or ownership cannot be bounded safely, stop with concise instructions to close Markei, active Flutter run/build terminals, and relevant VS Code debug/build activity, then rerun.
4. Do not treat unrelated Chrome availability as a Windows-build prerequisite.

Cleanup and verification:

1. Run flutter clean and require a successful exit code.
2. Independently verify cleanup postconditions; do not trust the exit code alone.
3. The verified target set must cover the generated state implicated in this incident, including .dart_tool and windows/flutter/ephemeral, plus any additional exact Flutter-generated path that the existing procedure already relies on being absent.
4. If a safe generated target remains and no relevant owner is active, remove only that exact generated target with literal-path handling.
5. Verify every targeted path is absent after removal.
6. If removal fails, a target reappears, or ownership is ambiguous, stop before flutter pub get and identify the bounded path without printing secrets or broad environment data.
7. Never delete source, pubspec.yaml, pubspec.lock, application data, SQLite files, Auth0 configuration, user documents, or a directory outside clients/markei_flutter.
8. Do not use a broad wildcard, repository-root recursive deletion, forceful process termination, reboot, dependency upgrade, cache-wide purge, or package repair as a substitute.

Dependency regeneration:

1. Run flutter pub get only after cleanup postconditions pass.
2. Require a successful exit code.
3. Verify package configuration exists and the Windows generated plugin state was recreated coherently.
4. Verify the auth0_flutter plugin entry resolves as one coherent generated link/directory rather than accepting a stale collision.
5. Stop before analyze/build if regeneration is incomplete or ambiguous.

Continuation:

After regeneration passes, preserve the existing order and behavior for:

- flutter analyze;
- flutter test;
- Windows Release build with the common R06 identity definitions;
- exact executable existence, byte size, and SHA-256;
- Auth0 callback registration for that exact executable;
- launch of that exact executable;
- visible source revision and source-tree SHA-256 instructions.

Launching the rebuilt application remains part of the operator procedure but Codex must not launch or install against the user's preserved client while implementing CR01.

## 4. Writable scope

Implementation:

~~~text
documentation/G_SCRIPTS.md
~~~

Existing focused procedure-test files may change only if a directly relevant test surface already exists and can validate extraction or static fail-closed invariants without creating a new framework. Otherwise validate through extraction and bounded source inspection.

Reports to replace:

~~~text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
~~~

A required path outside this list is a stop condition.

documentation/I_SCRIPTS.ps1 remains the authoritative extractor/dispatcher and must not change unless Codex proves that the correction cannot be extracted correctly without a dispatcher defect. If such a defect is found, stop and report it rather than expanding scope.

## 5. Prohibited scope

Do not modify:

- Flutter/Dart application source or tests unrelated to an existing procedure-test surface;
- dependencies, pubspec.yaml, pubspec.lock, native plugin configuration, CMake, vcpkg, or cpprestsdk;
- GS-FLUTTER-AND, GS-FLUTTER-DBW, GS-FLUTTER-DBA, or another procedure except a shared local helper already inside the GS-FLUTTER-WIN block;
- Sync coordinator, Product resolver, applier, cursor, acknowledgement, diagnostics, Audit, Settings, database, API, hosted provider, authentication, or enrollment behavior;
- A/B/C, J, REC_DIAGNOSTICS.md, permanent memory, methodology, GRM, NS coordinates, or R07/UI staging.

Do not run:

~~~text
Sync
Retry
Recovery
Query
Enroll
new Purchase
provider mutation
database repair/reset/clear
installation or launch against preserved clients
automatic process termination
~~~

## 6. Focused validation

Run the smallest sufficient CR01 suite:

1. extract GS-FLUTTER-WIN through the existing documented extractor path;
2. PowerShell parse/syntax validation of the extracted block;
3. static inspection proving process handling never terminates automatically;
4. static inspection proving flutter pub get is unreachable until verified cleanup postconditions pass;
5. static inspection proving cleanup targets are exact, generated, and contained by the Flutter client root;
6. static inspection proving the existing R06 identity definitions, artifact hashing, callback registration, and exact-executable launch remain present;
7. if safely reproducible on a disposable Codex checkout, exercise the clean-state path without any preserved client, login, installation, launch, or live operation;
8. git diff --check and exact changed-path inspection.

Do not rerun the full Flutter suite, Android build, provider, SQLite, Render, Neon, Auth0, GRIMOIRE, or preserved-state suite. Do not manufacture the user's lock incident by interfering with preserved processes.

## 7. Required reports and terminals

G must record the incident-to-correction mapping, exact changed paths, validation commands/results, skipped actions, and residual human checkpoint.

H must preserve the evidence ceilings from E.

I must confirm the architecture boundaries from F.

All three reports must state:

~~~text
C10_GCM03_S09_R06_CR01=IMPLEMENTED_VALIDATED | PARTIAL | BLOCKED
WINDOWS_GENERATED_STATE_PREFLIGHT=PASS | FAIL
CLEANUP_POSTCONDITION_VERIFICATION=PASS | FAIL
AUTOMATIC_PROCESS_TERMINATION=NO
PUB_GET_GATED_BY_VERIFIED_CLEANUP=PASS | FAIL
PLUGIN_REGENERATION_VERIFICATION=PASS | FAIL
R06_IDENTITY_CHAIN_PRESERVED=PASS | FAIL
WINDOWS_BUILD_PROCEDURE_READY_FOR_HUMAN_RERUN=YES | NO
WINDOWS_BUILD_REACHED_BY_CODEX=YES | NO
SYNC_SOURCE_CHANGED=NO
PRESERVED_CLIENT_STATE_TOUCHED=NO
LIVE_SYNC_EXECUTED=NO
PROVIDER_MUTATION=NONE
R07_IMPLEMENTATION=HELD
NEXT_HUMAN_CHECK=RERUN_GS_FLUTTER_WIN_ONLY
~~~

If Codex cannot validate a safe bounded cleanup contract, classify CR01 as BLOCKED and do not improvise broad deletion or process control.

## 8. Publication

If implementation and focused validation succeed:

1. replace G/H/I;
2. confirm every changed path is authorized;
3. create one intentional CR01 implementation commit whose direct parent is this published staging commit;
4. push by non-forced fast-forward to grm-guarded-provisioning-20260727;
5. do not create a branch or pull request;
6. verify the remote branch equals the implementation commit.

CR01 does not authorize Sync. After Main reconciles the correction, the next human action is to rerun only the corrected GS-FLUTTER-WIN procedure. Android provenance verification and the serialized Sync assay remain held until the Windows build and visible identity checkpoint pass.

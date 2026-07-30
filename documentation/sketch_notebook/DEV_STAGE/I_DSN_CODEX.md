# I_DSN_CODEX - C10-GCM03-S09-R06-CR01

Sequence: FLX-ORD-01
Role: Codex design evidence
Round or unit: C10-GCM03-S09-R06-CR01
Branch: grm-guarded-provisioning-20260727
Baseline / inspected HEAD: ece4375f228c5564e86f845fa65bd0f88b9ca829
Authority: D executable; E evidence ceilings; F architecture ownership
Evidence boundary: Windows procedure architecture only

## Architecture Confirmation

`GS-FLUTTER-WIN` now follows the staged preparation state machine:

```text
operator-owned process state
-> relevant-owner preflight
-> flutter clean
-> generated-state postcondition check
-> bounded exact-path cleanup
-> second absence proof
-> flutter pub get
-> package/plugin regeneration proof
-> existing R06 analyze/test/build/artifact/callback/launch tail
```

## Responsibility Boundaries

- Human operator owns closing active Markei, Flutter, Dart, or VS Code build/debug activity.
- `GS-FLUTTER-WIN` observes bounded owners and stops; it does not terminate processes.
- `flutter clean` remains the ordinary cleanup request.
- `GS-FLUTTER-WIN` owns independent cleanup postconditions and exact generated-target containment.
- `flutter pub get` remains the package/plugin generator and runs only after clean-state proof.
- `GS-FLUTTER-WIN` verifies package config and one coherent `auth0_flutter` Windows generated target before analysis/build.
- Existing R06 identity definitions, artifact hashing, callback registration, and exact executable launch are preserved.

## Frozen Boundaries

- No Flutter/Dart application behavior changed.
- No dependencies, `pubspec.yaml`, `pubspec.lock`, native plugin configuration, CMake, vcpkg, cpprestsdk, Android procedure, Windows Debug procedure, Sync, Product, applier, cursor, acknowledgement, diagnostics, Settings, Audit, SQLite, hosted API, Render, Neon, Auth0, enrollment, provider state, methodology, permanent memory, A/B/C, J, REC_DIAGNOSTICS, GRM, NS coordinates, or R07 implementation changed.

## Residual Design Risk

- Static validation and parsing prove the fail-closed procedure shape, not the user's preserved-machine execution result. The next design evidence must come from a human rerun of corrected `GS-FLUTTER-WIN`.

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

# I_DSN_CODEX - C10-GCM03-S09-R06

Sequence: FLX-ORD-01
Role: Codex design evidence
Round or unit: C10-GCM03-S09-R06
Branch: grm-guarded-provisioning-20260727
Baseline / inspected HEAD: 832c433896d9ba425e14891d9cbed9b58dcd8057
Authority: D executable; E evidence ceilings; F architecture ownership
Evidence boundary: shared build provenance architecture only

## Architecture Materialized

```text
clean Git HEAD and tree
  -> clients/markei_flutter/tool/resolve_markei_source_identity.ps1
  -> MARKEI_SOURCE_REVISION / MARKEI_SOURCE_TREE_SHA256
  -> BuildProvenance.current
  -> main.dart boot resolution
  -> MarkeiApp immutable transport
  -> NativeClosurePage presentation
```

## Responsibility Confirmation

- Git revision/tree resolution and source digest calculation belong to the shared helper.
- Compile-time transport belongs to the documented Flutter procedures.
- Identity validation and sanitization belong to `BuildProvenance`.
- Boot initialization belongs to `main.dart`.
- Application transport belongs to `MarkeiApp`.
- Closure presentation belongs to `NativeClosurePage`.
- APK and Windows executable SHA-256 values remain external artifact evidence.
- Sync, Product reconciliation, applier, cursor, acknowledgement, recorder, provider, database, and Auth0 behavior were not changed.

## Files Not Touched

- No Sync coordinator, Sync use case, Product resolver, inbound applier, cursor, acknowledgement, recorder, port, SQLite schema, Drift migration/generated code, hosted API, Render, Neon, Auth0 behavior, enrollment, Account/Device binding, dependency, `pubspec.lock`, methodology, permanent memory, J, REC_DIAGNOSTICS, or NS coordinate file was modified.

## Platform Design Evidence

- `GS-FLUTTER-WIN` uses the shared helper and injects `MARKEI_SOURCE_REVISION` plus `MARKEI_SOURCE_TREE_SHA256`.
- `GS-FLUTTER-DBW` uses the shared helper and writes the same fields to the ignored debug define file.
- `GS-FLUTTER-AND` uses the shared helper and injects the same fields for Android Debug.
- Closure displays `Source revision #<12>` and `Source tree SHA-256 <64>` from one supplied immutable identity.

## Unresolved Design Risk

- `GS-FLUTTER-DBA` remains on older provenance wording because it was outside D's R06 target list. If Android VS Code debug provenance must also be brought into the shared identity chain, Main should stage that as a separate authorized round.

## Terminals

C10_GCM03_S09_R06=IMPLEMENTED_VALIDATED
COMMON_BOOT_IDENTITY=PASS
FULL_SOURCE_REVISION_VALIDATION=PASS
COMMON_SOURCE_TREE_SHA256=PASS
ANDROID_IDENTITY_INJECTION=PASS
WINDOWS_RELEASE_IDENTITY_INJECTION=PASS
WINDOWS_DEBUG_IDENTITY_INJECTION=PASS
CLOSURE_COMMON_PRESENTATION=PASS
WINDOWS_ARTIFACT_SHA256_REPORT=PASS
ANDROID_ARTIFACT_SHA256_REPORT=PASS
SYNC_SOURCE_CHANGED=NO
PRESERVED_CLIENT_STATE_TOUCHED=NO
LIVE_SYNC_EXECUTED=NO
PROVIDER_MUTATION=NONE
NEXT_HUMAN_CHECK=TWO_PLATFORM_VISIBLE_IDENTITY_ONLY

# I_DSN_CODEX - C10-GCM03-ST04-R1 design report

Sequence: FLX-ORD-01
Role: Codex design evidence
Round or unit: C10-GCM03-ST04-R1
Branch: grm-guarded-provisioning-20260727
Baseline / inspected HEAD: db17f47f3bb7a032afbd8892754dff971ae20b56
Authority: F_DSN_STAGE.md within synchronized D/E/F
Evidence boundary: shared Flutter presentation, local public build provenance, GRM build/install procedure hardening; no protocol/provider architecture expansion

## Shared Composition Map

```text
MarkeiApp
  nativeClosureSurfaceEnabled
  -> NativeClosurePage
       -> BuildProvenance.current
       -> NativeAuthClosureRunner
       -> shared diagnostics/action/evidence cards
```

Current source keeps one Closure page. Android differences remain in package identity, native Auth0 configuration, callback mechanics, and target installation mechanics, not in Closure diagnostic meaning.

## Provenance Responsibility Boundary

```text
GS-FLUTTER-AND
  derives short HEAD
  passes MARKEI_BUILD_PROVENANCE

BuildProvenance
  validates 7-12 lowercase hex
  otherwise returns unavailable

NativeClosurePage
  renders nativeClosure.buildProvenance
```

The provenance value is not persisted, not transported, not sent to hosted APIs, and not used as Account, Device, authorization, or protocol identity.

## Diagnosed PROV Class

```text
ANDROID_PARITY_ROOT_CLASS=PROV_05
```

Design reason: repository inspection and tests prove the shared page; Git history proves the screenshot labels belong to an older page; this host cannot prove the live installed Android package identity or rendered runtime surface. Therefore the correction is artifact-lineage evidence hardening, not an Android page fork.

## Boundary Preservation

No changes were made to:

- `NativeAuthClosureRunner` action semantics;
- Auth0 adapter behavior;
- enrollment command or binding storage;
- hosted connection policy;
- ordinary Sync coordinator;
- Retry or failed/notApplied recovery;
- local queue/sequence allocation;
- diagnostics persistence shape;
- API routes, schemas, migrations, RLS, provider state, or deployment.

## Validation

- Compact and wide/shared behavior validated by focused and full Flutter tests.
- Android debug APK build passed locally with public provenance define.
- PowerShell `GS-FLUTTER-AND` body parses.
- Changed-content sensitive scan passed.
- Live Android acceptance remains later human evidence.

## Terminals

```text
CLOSURE_IMPLEMENTATION=ONE_SHARED_PAGE
ANDROID_ONLY_PAGE_FORK=ABSENT
BUILD_PROVENANCE_BOUNDARY=LOCAL_PUBLIC_METADATA
PROVENANCE_PERSISTENCE=ABSENT
PROVENANCE_TRANSPORT=ABSENT
COMPACT_WIDE_CONTRACT=SHARED
AUTH_ENROLL_SYNC_BOUNDARIES=UNCHANGED
SCHEMA_API_PROVIDER_EXPANSION=ABSENT
ANDROID_RUNTIME_ACCEPTANCE=HELD_FOR_HUMAN_RETEST
GCM03_ST05_AND_LATER=HELD
```

No permanent design memory was edited.

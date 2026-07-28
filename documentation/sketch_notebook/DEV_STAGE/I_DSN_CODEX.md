# I_DSN_CODEX — Procedure-local provenance ownership correction

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Codex design evidence
> Unit: `C10-GCM03-ST04-R1-C1`
> Branch: `grm-guarded-provisioning-20260727`
> Baseline / inspected HEAD:
> `231a76281d0016ee47dd719d3ddc24d422b18c35`
> Authority: F within synchronized D/E/F plus explicit human GRM-set audit
> Evidence boundary: procedure-local responsibility and static interface
> alignment; no Flutter, persistence, protocol, provider, or runtime change

## Corrected responsibility map

```text
GRM-FLUTTER-AND
  stable human invocation

I_SCRIPTS.ps1
  selected-heading lookup
  one-fence extraction
  strict-mode execution

GS-FLUTTER-AND
  resolved repository/client containment
  active branch and inspected HEAD
  short provenance derivation
  public-coordinate loading
  branch/ancestry/dirty guards
  Android target/build/install/launch

BuildProvenance
  compile-time validation and safe display

NativeClosurePage
  shared visible public projection
```

The Android procedure now owns its complete producer-consumer graph.
`GS-FLUTTER-WIN` is byte-identical to its `db17f47` body and owns no Android
lineage preparation.

## Interface reconciliation

The audit found one coherent public pipeline:

```text
NS coordinate keys
→ GS-FLUTTER-AND PowerShell variables
→ Dart defines / Gradle property bridge
→ NativeAuthConfiguration / BuildProvenance
→ NativeClosurePage
```

No adapter or alias was added. Existing names already agree across the
boundaries. The only surrounding drift was branch metadata in the catalogue
header and human target guard, which was aligned with the existing
machine-readable coordinates.

`NS_COORDINATES.md` is now explicitly included in the Android dirty-input
guard because it participates in the build. This preserves the provenance
boundary: the inspected source/coordinate set must be clean before a human
artifact can claim lineage.

## Preserved architecture

Unchanged:

- one shared `NativeClosurePage`;
- build-provenance validation and display;
- package `com.gusigu.markei`;
- native authentication configuration;
- enrollment, hosted readiness, Sync, Retry, and recovery;
- Drift/local persistence;
- API transport and provider state;
- schema, migrations, RLS, and deployment;
- application-data-preserving install semantics.

Formal Windows PowerShell parsing and strict-mode execution are
host-unvalidated because this host has no PowerShell runtime. This blocks
runtime acceptance but does not create a new architecture decision.

No permanent design memory was edited.

```text
DISPATCH_SCOPE=ONE_SELECTED_GS_FENCE
WINDOWS_ANDROID_VARIABLE_LEAK=REMOVED
ANDROID_PROVENANCE_OWNERSHIP=PROCEDURE_LOCAL
GRM_SOURCE_INTERFACE=ALIGNED_STATIC
FLUTTER_PROVENANCE_MODEL=UNCHANGED
AUTH_ENROLL_SYNC_BOUNDARIES=UNCHANGED
SCHEMA_API_PROVIDER_EXPANSION=ABSENT
ANDROID_RUNTIME_ACCEPTANCE=HELD_FOR_HUMAN_RETEST
GCM03_ST05_AND_LATER=HELD
```

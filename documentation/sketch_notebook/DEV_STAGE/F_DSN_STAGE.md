# F_DSN_STAGE — Procedure-local provenance ownership correction

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Design materialization stage
> Unit: `C10-GCM03-ST04-R1-C1`
> Branch: `grm-guarded-provisioning-20260727`
> Required ancestry:
> `231a76281d0016ee47dd719d3ddc24d422b18c35`
> Authority: **ACTIVE WITHIN D**
> Evidence boundary: GRM procedure-local responsibility; no Flutter,
> persistence, protocol or provider architecture change

## 1. Controlling design correction

`I_SCRIPTS.ps1` creates an independent scriptblock from one selected
`GS-*` PowerShell fence. Therefore:

```text
GS-FLUTTER-WIN scope
  cannot provide variables to
GS-FLUTTER-AND scope
```

Each procedure owns its own complete producer-consumer graph.

## 2. Correct responsibility map

```text
GRM-FLUTTER-AND
  stable human invocation

I_SCRIPTS.ps1
  exact heading/fence extraction
  strict-mode execution

GS-FLUTTER-AND
  repository/client containment
  branch and full HEAD inspection
  short provenance derivation
  branch/ancestry/dirty guards
  coordinate loading
  Android target/build/install/launch

BuildProvenance
  compile-time validation and safe display

NativeClosurePage
  visible public projection only
```

`GS-FLUTTER-WIN` must not own Android-unit lineage preparation. Its accidental
block is removed, restoring its previous responsibility.

## 3. Preserved boundaries

This correction must not change:

- one shared `NativeClosurePage`;
- compile-time provenance format;
- package/application identity;
- authentication, enrollment or Sync components;
- Drift/local persistence;
- API or provider transport;
- schema, migrations or RLS;
- Windows Closure behavior;
- application-data preservation.

The correction is a procedure-local wiring repair, not a Flutter or protocol
redesign.

## 4. Validation architecture

Validate the selected fence as the dispatcher sees it:

```text
Markdown heading
→ exact PowerShell fence extraction
→ AST syntax
→ procedure-local producer/consumer assertions
→ strict-mode non-mutating prefix
```

This closes the validation gap that allowed a syntactically valid but
non-executable fence to be reported as hardened.

## 5. I report

Replace `I_DSN_CODEX.md` and include:

- corrected fence-scope responsibility;
- restoration of Windows procedure ownership;
- Android procedure-local provenance graph;
- proof of no Flutter/protocol/persistence/provider expansion;
- held live Android acceptance.

Required terminals:

```text
DISPATCH_SCOPE=ONE_SELECTED_GS_FENCE
WINDOWS_ANDROID_VARIABLE_LEAK=REMOVED_OR_BLOCKED
ANDROID_PROVENANCE_OWNERSHIP=PROCEDURE_LOCAL_OR_BLOCKED
FLUTTER_PROVENANCE_MODEL=UNCHANGED
AUTH_ENROLL_SYNC_BOUNDARIES=UNCHANGED
SCHEMA_API_PROVIDER_EXPANSION=ABSENT
ANDROID_RUNTIME_ACCEPTANCE=HELD_FOR_HUMAN_RETEST
GCM03_ST05_AND_LATER=HELD
```

Do not edit permanent design memory.

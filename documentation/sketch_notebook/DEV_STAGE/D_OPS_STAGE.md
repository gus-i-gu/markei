# D_OPS_STAGE — Android GRM provenance-variable cascade correction

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Operational materialization stage
> Unit: `C10-GCM03-ST04-R1-C1`
> Branch: `grm-guarded-provisioning-20260727`
> Required ancestry:
> `231a76281d0016ee47dd719d3ddc24d422b18c35`
> Authority: **ACTIVE — BOUNDED CORRECTION AUTHORIZED**
> Evidence boundary: repository/source inspection and non-mutating static
> validation of the GRM dispatcher cascade; no Android runtime, authentication,
> enrollment, Sync, Retry, recovery, provider action, deployment, commit or push

## 1. Reconciled prior result

The prior unit `C10-GCM03-ST04-R1` remains accepted for:

```text
one shared NativeClosurePage
compact/wide widget coverage
public sanitized build-provenance projection
Flutter focused and full tests
Flutter analysis
local debug APK build with an explicit provenance define
absence of protocol, persistence, schema and provider expansion
```

The following prior terminal is contradicted and superseded:

```text
ANDROID_GRM_PROVENANCE=HARDENED
```

It becomes:

```text
ANDROID_GRM_PROVENANCE=BLOCKED_VARIABLE_CASCADE
```

`ST04=READY_FOR_HUMAN_RETEST` is withdrawn until this correction is
materialized, validated, reviewed, committed and published.

## 2. Exact defect

Commit `231a762` intended to add these producers to `GS-FLUTTER-AND`:

```text
$ResolvedClientRoot
$Branch
$InspectedHead
$BuildProvenance
```

The patch matched the earlier, similar `$ClientRoot` anchor inside
`GS-FLUTTER-WIN`. The current cascade is therefore split:

```text
GS-FLUTTER-WIN
  owns the new producers, prints and containment check
  does not consume Android build provenance

GS-FLUTTER-AND
  consumes $Branch in the branch guard
  consumes $BuildProvenance in the Dart define and operator output
  never initializes either variable
```

`I_SCRIPTS.ps1` executes the extracted fence under `Set-StrictMode -Version
Latest`. The first `$Branch` read therefore terminates `GRM-FLUTTER-AND`.
Without that read, `$BuildProvenance` would fail later.

The previous `GS-FLUTTER-AND` parse result remains only syntax evidence.
PowerShell parsing does not prove runtime variable initialization.

## 3. Required correction

Modify only the relevant blocks in `documentation/G_SCRIPTS.md`.

### 3.1 Restore Windows scope

Remove from `GS-FLUTTER-WIN` only the block introduced accidentally by
`231a762`:

```text
$ResolvedClientRoot containment projection
$Branch
$InspectedHead
$BuildProvenance
the four new repository/client/branch/HEAD Write-Host lines
```

The resulting `GS-FLUTTER-WIN` body must be byte-equivalent to its `db17f47`
version unless line-ending normalization prevents byte comparison. Do not
change Windows Closure behavior, arguments, coordinates, output or validation.

### 3.2 Complete the Android producer-consumer chain

In `GS-FLUTTER-AND`, immediately after the existing repository/client-root
existence checks and before the first `$Branch` or `$BuildProvenance` use:

1. resolve and prove that the Flutter client directory is inside the resolved
   repository directory;
2. derive the non-empty active branch;
3. derive and validate the full lowercase 40-hex inspected HEAD;
4. derive and validate a 7–12 lowercase-hex short HEAD;
5. assign that short value to `$BuildProvenance`;
6. print repository root, resolved client root, active branch and full inspected
   HEAD;
7. keep coordinate values undisclosed.

Use a Windows PowerShell 5.1-compatible parent-directory walk for containment.
Do not use a raw string-prefix comparison, because sibling paths may share the
same prefix.

The completed order must be:

```text
repository root
→ client root existence
→ resolved containment proof
→ branch assignment
→ full HEAD assignment
→ short build-provenance assignment
→ public coordinate loading
→ expected-branch guard
→ required-ancestry guard
→ dirty-overlap guard
→ Flutter/device/build/install/launch path
```

The required ancestry guard may compare against `$InspectedHead` rather than
reading moving `HEAD` again.

### 3.3 Preserve the accepted Android behavior

Do not change:

- the five public Closure coordinate names;
- the Closure-surface Dart define;
- package `com.gusigu.markei`;
- selected-target rules;
- application-data-preserving `adb install -r`;
- APK path/size/SHA-256 reporting;
- package evidence and launch;
- Auth0 Gradle environment restoration;
- human verification and no-mutation stop text.

Do not edit `I_SCRIPTS.ps1` unless inspection proves a distinct dispatcher
defect. The current defect is inside the extracted `GS-FLUTTER-AND` body.

## 4. Validation

Run and report:

1. exact `GS-FLUTTER-WIN` body comparison against `db17f47`;
2. extraction of exactly one `GS-FLUTTER-AND` PowerShell fence through the same
   heading/fence patterns used by `I_SCRIPTS.ps1`;
3. Windows PowerShell 5.1 AST parse of the corrected Android fence;
4. structural data-flow assertions proving:

   ```text
   $Branch assignment occurs before every $Branch read
   $InspectedHead assignment occurs before its use
   $BuildProvenance assignment occurs before every $BuildProvenance read
   each producer occurs exactly once in GS-FLUTTER-AND
   none of the Android-unit producers remain in GS-FLUTTER-WIN
   ```

5. a non-mutating prefix assay, with Git/Flutter/device/build/install/launch
   calls mocked or truncated before `flutter doctor`, proving strict-mode
   evaluation reaches the expected-branch guard with all four values assigned;
6. `git diff --check`;
7. changed-content sensitive-pattern scan.

Do not run the full live Android procedure during Codex validation. Do not
start an AVD, install, launch, authenticate, enroll or Sync.

## 5. Writable and prohibited scope

Writable:

```text
documentation/G_SCRIPTS.md
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Prohibited:

- Flutter/Dart source and tests;
- `GRM.md`, `I_SCRIPTS.ps1`, `NS_COORDINATES.md` unless a distinct,
  evidence-backed contradiction requires Main restaging;
- J, REC_DIAGNOSTICS, A/B/C, permanent memory and methodology;
- API/server, schema, migration, provider or deployment files;
- Windows behavior changes;
- authentication, enrollment, Sync, Retry, recovery or provider actions;
- commit, push, deploy or PR creation.

Stop if the correction cannot remain within the one catalogue file plus G/H/I.

## 6. G report

Replace `G_OPS_CODEX.md` with the correction evidence. Include:

- exact defect and strict-mode failure order;
- exact removed Windows block and inserted Android block;
- validation commands and results;
- unavailable live evidence;
- clean/dirty inventory;
- no-action statement.

Required terminals:

```text
PRIOR_FLUTTER_SOURCE_RESULT=RETAINED
PRIOR_ANDROID_GRM_TERMINAL=SUPERSEDED
WINDOWS_PROCEDURE=RESTORED_TO_DB17F47
ANDROID_VARIABLE_CASCADE=CORRECTED_OR_BLOCKED
ANDROID_FENCE_PARSE=PASS_OR_BLOCKED
ANDROID_STATIC_DATA_FLOW=PASS_OR_BLOCKED
ANDROID_STRICT_MODE_PREFIX=PASS_OR_BLOCKED
LIVE_ANDROID_RETEST=NOT_RUN
AUTH_ENROLL_SYNC_PROVIDER_ACTION=ABSENT
ST04=READY_FOR_HUMAN_RETEST_OR_BLOCKED
GCM03_ST05_AND_LATER=HELD
```

# D_OPS_STAGE — Android Closure parity and provenance repair

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Operational materialization stage
> Unit: `C10-GCM03-ST04-R1`
> Branch: `grm-guarded-provisioning-20260727`
> Required remote ancestry:
> `ec96f93d71efd261adc2b3b75a17453130e437a0`
> Local equivalent tree may be based on:
> `035352e58c8fb6bc887724f8f6f7607c8d455b93`
> Authority: **ACTIVE — DIAGNOSTIC-FIRST CONDITIONAL MATERIALIZATION
> AUTHORIZED**
> Evidence boundary: repository/source inspection, local automated validation,
> and non-mutating build-provenance work only; no live authentication,
> enrollment, Sync, Retry, recovery, provider mutation, deployment, or
> production claim

## 1. Controlling state

GCM02 is closed at hosted same-Device development scope. GCM03 entered with
one preserved Windows candidate member:

```text
event = purchase.registered
Windows Device sequence = 2
Windows next local sequence = 3
pending/uploading/failed/unknown = 1/0/0/0
```

Human-observed GCM03 progress:

```text
ST01 repository alignment = PASS
ST02 host/provider read-only baseline = PASS
ST03 Android build/install/launch = PASS as observed
ST04 Android Closure evidence surface = BLOCKED
```

The Android screenshot showed the legacy minimal Closure surface with the old
`Status`, `Query`, and basic action layout. The current repository source
instead composes the same `NativeClosurePage` on supported native platforms
and contains the consolidated `Diagnostics` surface already validated on
Windows.

This is a provenance/parity contradiction. It is not evidence that Android
authentication, enrollment, or two-Device convergence passed or failed.

Current gate:

```text
GCM03_ST04=BLOCKED_ANDROID_CLOSURE_ARTIFACT_PARITY
GCM03_ST05_AND_LATER=HELD
ANDROID_ENROLLMENT=NOT_AUTHORIZED
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
```

## 2. Objective

Establish and repair the exact relationship:

```text
published source
→ Android build inputs
→ generated APK
→ installed package
→ launched activity
→ rendered shared Closure surface
```

The final outcome must make an Android operator able to prove that the visible
Closure page came from the intended repository revision and exposes the same
evidence contract as Windows.

Do not implement a second Android-specific copy of the Windows Closure page.
Diagnose lineage first. Materialize only the smallest correction justified by
the diagnosis.

## 3. Required recovery and inspection

Before editing:

1. read root `AGENTS.md`;
2. read `documentation/sketch_notebook/INDEX.md`;
3. follow the complete methodology boot route;
4. read synchronized D/E/F completely;
5. inspect J's current GCM02 closure and GCM03 TODO prefix;
6. verify branch, HEAD, required ancestry, worktree state, and remotes;
7. stop on branch divergence, missing ancestry, or dirty overlap with writable
   files.

Inspect at minimum:

```text
clients/markei_flutter/lib/app/markei_app.dart
clients/markei_flutter/lib/app/markei_composition.dart
clients/markei_flutter/lib/app/pages/native_closure_page.dart
clients/markei_flutter/lib/infrastructure/auth/native_auth_config.dart
clients/markei_flutter/android/app/build.gradle.kts
clients/markei_flutter/android/app/src/main/AndroidManifest.xml
clients/markei_flutter/pubspec.yaml
clients/markei_flutter/test/app/native_closure_surface_test.dart
clients/markei_flutter/test/app/native_closure_diagnostics_test.dart
clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart
documentation/GRM.md
documentation/G_SCRIPTS.md
documentation/I_SCRIPTS.ps1
documentation/NS_COORDINATES.md
```

Use Git history to locate the introduction of the consolidated Diagnostics
surface and compare the screenshot's visible labels with historical source.
The current scan identifies `ad1f228` as the relevant Diagnostics
consolidation commit; verify rather than assume that conclusion.

Search for:

- any platform branch that substitutes another Closure widget on Android;
- duplicate or historical Closure page implementations;
- build flavors, package/application ID alternatives, or entrypoints;
- conditional imports or target-platform presentation branches;
- script paths capable of building a different checkout/client root;
- package/activity selection ambiguity;
- artifact installation behavior and whether application data are preserved;
- any current non-secret build identity visible in the client.

## 4. Diagnostic classification

Classify the contradiction into exactly one controlling result:

```text
PROV-01 wrong checkout or source baseline
PROV-02 stale/generated APK or install replacement failure
PROV-03 wrong package, activity, target, or launched application
PROV-04 actual Android composition or responsive-layout divergence
PROV-05 evidence insufficient / host-unvalidated
```

Record:

```text
observed fact
repository fact
test-proven fact
inference
unavailable live evidence
controlling classification
```

Do not claim that Codex reproduced the user's Android result unless an actual
Android target was available and the exact observation was made. A passing
widget test proves source behavior, not installation provenance.

## 5. Required materialization outcome

### 5.1 Shared Closure parity

The repository must retain one shared `NativeClosurePage` contract. At compact
Android dimensions it must expose:

```text
nativeClosure.page
nativeClosure.Diagnostics
nativeClosure.Check hosted connection
nativeClosure.Sync
```

It must not expose the removed top-level controls:

```text
nativeClosure.Status
nativeClosure.Query
nativeClosure.Refresh diagnostics
```

The Android-sized projection must retain:

- current action result and expandable sanitized technical details;
- Sync overview;
- local queue counts;
- Next Device sequence;
- recent Closure attempts;
- grouped diagnostic lifecycle;
- Devices;
- actionable events;
- separate authentication, enrollment, readiness, Sync, Retry, inspection,
  recovery, logout, and history-clear boundaries already present in source.

If current shared source already satisfies this contract, do not rewrite or
fork it merely to generate a source diff.

### 5.2 Non-secret build provenance

Add a small, shared build-provenance projection so a human can distinguish
the intended rebuilt artifact from an obsolete installed client.

Acceptable contract:

```text
compile-time public define: MARKEI_BUILD_PROVENANCE
value: reviewed short Git commit fingerprint, 7–12 lowercase hex characters
fallback: unavailable
visible label in Closure diagnostics: Build provenance #<fingerprint>
stable widget key: nativeClosure.buildProvenance
```

The value is public metadata. It must never contain a token, credential,
connection string, complete Device/Account identifier, branch URL, filesystem
path, or dirty diff contents.

Prefer a tiny immutable configuration/value object or a direct compile-time
constant over a new service layer. The page may project it; widgets must not
run Git or shell commands.

### 5.3 Android GRM provenance hardening

Update `GS-FLUTTER-AND` and its GRM description only as needed to:

1. resolve the repository root once and prove the client path belongs to it;
2. print the branch and full inspected HEAD before building;
3. print and validate the active branch/ancestry needed by this unit, or stop
   with an explicit provenance error; do not permanently hard-code this
   transient branch into a procedure intended for later reusable branches;
4. reject dirty overlap in Flutter source, Android project files, and the live
   Android build procedure while preserving unrelated/user work;
5. pass the reviewed short HEAD through
   `MARKEI_BUILD_PROVENANCE`;
6. continue passing the existing five public Closure coordinates;
7. run clean, dependency resolution, analysis, tests, and debug APK build;
8. print the generated APK path, byte length, and SHA-256;
9. launch/install only the selected supported Android target and current
   package `com.gusigu.markei`;
10. print sufficient non-secret package/activity evidence to correlate the
    launched application with that target;
11. preserve application data: no uninstall, `pm clear`, database deletion,
    emulator reset, or storage wipe;
12. stop after launch with explicit instructions to verify the visible build
    provenance and consolidated Diagnostics surface.

Do not print coordinate values. Keep the existing readiness booleans and safe
redaction behavior.

If exact installed-APK hashing cannot be proved portably, state the limitation
truthfully. Do not represent the local generated APK hash as proof of the
installed package by itself.

### 5.4 Conditional actual source repair

If and only if repository inspection or reproducible tests prove an Android
composition/layout divergence, repair the shared composition or responsive
layout. The fix must also preserve Windows behavior.

Prohibited response to PROV-01, PROV-02, PROV-03, or PROV-05:

```text
copy NativeClosurePage into an Android-only file
hide the legacy artifact mismatch with alternate labels
change authentication/enrollment behavior
clear or recreate local state
```

## 6. State preservation

This materialization must not:

- allocate a local Device sequence;
- change queue membership or status;
- change Last successful Sync;
- sign in or out;
- enroll/query/revoke a Device;
- call hosted readiness;
- invoke ordinary Sync, Retry, or failed/notApplied recovery;
- access or mutate Render, Auth0, Neon, or the user database;
- modify migrations, API contracts, server source, or deployment;
- consume or expose the pending Windows sequence-2 member.

No new live assay is authorized. A human-operated Android rerun occurs only
after the patch is reviewed, committed, published, and separately instructed.

## 7. Tests and validation

Add or update tests proving:

1. the shared page is used by the app composition;
2. Android/compact dimensions expose consolidated Diagnostics;
3. removed top-level Status/Query/Refresh controls remain absent;
4. all evidence cards needed by ST04 remain reachable at compact dimensions;
5. build provenance renders with its stable key;
6. missing provenance fails safely as `unavailable`;
7. malformed or overlong provenance does not become unsafe UI metadata;
8. provenance rendering performs no state or network action;
9. Windows/wide Closure behavior remains intact;
10. no authentication, queue, sequence, Sync, persistence, schema, or API
    contract changed.

Run at minimum:

```text
dart format <changed Dart files>
flutter test test/app/native_closure_surface_test.dart
flutter test test/app/native_closure_diagnostics_test.dart
flutter test test/infrastructure/native_auth_composition_test.dart
flutter test
flutter analyze
git diff --check
```

Validate PowerShell syntax/dispatch for changed GRM procedures using the
repository's existing non-mutating validation path. Do not execute
`GS-FLUTTER-AND` against a live device merely to satisfy Codex validation.

Run the existing changed-content sensitive-pattern scan. Report every skipped
or unavailable platform check.

## 8. Writable and prohibited scope

Writable:

- directly relevant shared Flutter Closure/composition/configuration source;
- directly relevant Flutter tests;
- `documentation/GRM.md`;
- the `GS-FLUTTER-AND` block in `documentation/G_SCRIPTS.md`;
- `documentation/I_SCRIPTS.ps1` only if dispatcher alignment is directly
  required;
- G/H/I replacement reports.

Prohibited:

- J, REC_DIAGNOSTICS, A/B/C, methodology, permanent domain memory;
- `NS_COORDINATES.md` values;
- API/server source and tests;
- schemas, migrations, provider scripts, Render/Auth0/Neon configuration;
- Windows build behavior except shared non-secret provenance compatibility;
- unrelated UI redesign, formatting, cleanup, or refactor;
- protected Python/PySide artifacts;
- commits, pushes, releases, deployments, enrollment, or Sync.

Stop if a required fix would exceed this boundary or if D/E/F disagree.

## 9. G report

Replace `G_OPS_CODEX.md` with:

- exact baseline/ancestry/worktree inspection;
- screenshot-to-history label correlation;
- PROV-01…PROV-05 classification and evidence class;
- files inspected and changed;
- shared-page parity result;
- build-provenance implementation;
- Android GRM hardening;
- validation commands and exact outcomes;
- unavailable live Android evidence;
- state/provider non-action statement;
- residual operator steps and risks.

Terminal markers:

```text
ST01=PASSED_PRIOR_HUMAN_SCOPE
ST02=PASSED_PRIOR_READ_ONLY_SCOPE
ST03=PASSED_HUMAN_OBSERVED_BUILD_LAUNCH_SCOPE
ST04=BLOCKED_PENDING_HUMAN_RETEST
ANDROID_PARITY_ROOT_CLASS=PROV_01_02_03_04_05
SHARED_CLOSURE_PAGE=CONFIRMED_OR_REPAIRED_OR_BLOCKED
ANDROID_COMPACT_DIAGNOSTICS=TEST_PASS_OR_BLOCKED
BUILD_PROVENANCE=IMPLEMENTED_OR_BLOCKED
ANDROID_GRM_PROVENANCE=HARDENED_OR_BLOCKED
APPLICATION_DATA_PRESERVATION=PASS
LIVE_ANDROID_RETEST=NOT_RUN
AUTH_ENROLL_SYNC_PROVIDER_ACTION=ABSENT
GCM03_ST05_AND_LATER=HELD
```

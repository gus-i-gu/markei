# G_OPS_CODEX — Android GRM variable-cascade correction evidence

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Codex materialization evidence
> Unit: `C10-GCM03-ST04-R1-C1`
> Branch: `grm-guarded-provisioning-20260727`
> Baseline / inspected HEAD:
> `231a76281d0016ee47dd719d3ddc24d422b18c35`
> Authority: synchronized D/E/F plus explicit human direction to audit and
> correct the recently changed GRM set against source and variable names
> Evidence boundary: repository inspection and non-mutating static validation;
> no Windows PowerShell host, Android runtime, authentication, enrollment,
> Sync, Retry, recovery, provider action, deployment, commit or push

## 1. Diagnosis

The defect reported by Main is confirmed.

Commit `231a762` placed these Android provenance producers inside the
independently dispatched `GS-FLUTTER-WIN` fence:

```text
$ResolvedClientRoot
$Branch
$InspectedHead
$BuildProvenance
```

`GS-FLUTTER-AND` retained the consumers of `$Branch` and
`$BuildProvenance`. Because `I_SCRIPTS.ps1` extracts only the selected
`GS-*` fence and executes it under `Set-StrictMode -Version Latest`, the
Android procedure would terminate at its first undefined `$Branch` read and
would later fail independently at `$BuildProvenance`.

The wider human-authorized GRM audit found two additional naming drifts:

- the `G_SCRIPTS.md` catalogue header still named
  `cycle10-intermid-grimoire`;
- the machine-readable `RenderDeployBranch` was current, but the
  `NS_COORDINATES.md` human target guard still named the retired branch.

No distinct dispatcher, Flutter-source, Gradle, package, or public-variable
name defect was found.

## 2. Materialization

### `documentation/G_SCRIPTS.md`

- restored the `GS-FLUTTER-WIN` PowerShell body exactly to its `db17f47`
  version;
- moved all Android lineage producers into `GS-FLUTTER-AND` before their
  first consumers;
- resolved repository and client directories through the filesystem provider;
- proved containment through a Windows PowerShell 5.1-compatible parent walk;
- derived one lowercase 40-hex `$InspectedHead`;
- derived `$BuildProvenance` from that same inspected HEAD rather than a
  second moving `HEAD` read;
- used `$InspectedHead` in the required-ancestry guard;
- changed the build working directory to `$ResolvedClientRoot`;
- added `NS_COORDINATES.md` to the dirty build-input guard;
- aligned the catalogue branch header with the current branch.

### `documentation/NS_COORDINATES.md`

- aligned the human `RenderDeployBranch` target guard with the existing
  machine-readable branch coordinate.

### Inspected and unchanged

- `documentation/GRM.md`: invocation and Android provenance description
  already match the corrected procedure;
- `documentation/I_SCRIPTS.ps1`: exact one-fence dispatch and strict-mode
  execution remain correct;
- Flutter source and Gradle: all public names and package identity already
  match the procedure.

No file was created or deleted.

## 3. Static alignment evidence

The Android procedure, Flutter source, and Gradle agree on:

```text
MARKEI_NATIVE_CLOSURE_SURFACE
MARKEI_BUILD_PROVENANCE
MARKEI_AUTH0_DOMAIN
MARKEI_AUTH0_AUDIENCE
MARKEI_AUTH0_ANDROID_CLIENT_ID
MARKEI_HOSTED_HTTPS_ORIGIN
ORG_GRADLE_PROJECT_MARKEI_AUTH0_DOMAIN
com.gusigu.markei
```

The Android procedure consumes six uniquely present coordinate keys:

```text
Auth0TenantDomain
Auth0Audience
Auth0AndroidClientId
RenderPublicOrigin
AndroidAvdName
RepositoryBranch
```

The full static catalogue audit checked:

```text
unique GS headings: 31
GRM procedure invocations: 30
GRM table mappings: 29
unique colon-key coordinates: 61
catalogue coordinate consumers: 19
dispatcher coordinate consumers: 13
```

Every checked GRM invocation resolves to an existing catalogue heading, every
consumed coordinate exists exactly once, and all active branch surfaces agree.

## 4. Validation

Passed:

- required ancestry `ec96f93` is an ancestor of inspected HEAD;
- `GS-FLUTTER-WIN` body is byte-identical to `db17f47`;
- dispatcher-equivalent extraction finds exactly one
  `GS-FLUTTER-AND` section and exactly one PowerShell fence;
- each of `$ResolvedClientRoot`, `$Branch`, `$InspectedHead`, and
  `$BuildProvenance` has exactly one Android producer before all consumers;
- none of those producers remains in `GS-FLUTTER-WIN`;
- required initialization/guard/build order is structurally correct;
- containment uses a parent walk and no raw string-prefix check;
- source, Gradle, coordinate, branch, and package names align;
- `git diff --check`;
- changed-content sensitive-pattern scan;
- Markdown-fence balance.

Unavailable on this host:

- Windows PowerShell 5.1 AST parse;
- strict-mode mocked prefix execution;
- live `GRM-FLUTTER-AND` execution;
- Android build/install/launch and visible-provenance comparison.

Neither `powershell.exe` nor `pwsh` is installed on this Linux host. Syntax
and strict-mode runtime acceptance therefore remain host-unvalidated; the
static correction is not represented as a passed Windows execution.

## 5. State and residual boundary

Worktree changes now contain:

- four preserved pre-existing Main reconciliation/staging edits:
  D/E/F and J;
- this correction in `G_SCRIPTS.md` and `NS_COORDINATES.md`;
- replacement G/H/I evidence.

The live Android procedure was not run. The Windows pending
`purchase.registered` sequence-2 member was not accessed or changed.

```text
PRIOR_FLUTTER_SOURCE_RESULT=RETAINED
PRIOR_ANDROID_GRM_TERMINAL=SUPERSEDED
WINDOWS_PROCEDURE=RESTORED_TO_DB17F47
ANDROID_VARIABLE_CASCADE=CORRECTED
ANDROID_FENCE_EXTRACTION=PASS
ANDROID_FENCE_PARSE=BLOCKED_HOST_NO_POWERSHELL
ANDROID_STATIC_DATA_FLOW=PASS
ANDROID_STRICT_MODE_PREFIX=BLOCKED_HOST_NO_POWERSHELL
GRM_SOURCE_VARIABLE_ALIGNMENT=PASS_STATIC
LIVE_ANDROID_RETEST=NOT_RUN
AUTH_ENROLL_SYNC_PROVIDER_ACTION=ABSENT
ST04=BLOCKED_PENDING_WINDOWS_POWERSHELL_VALIDATION_AND_HUMAN_RETEST
GCM03_ST05_AND_LATER=HELD
```

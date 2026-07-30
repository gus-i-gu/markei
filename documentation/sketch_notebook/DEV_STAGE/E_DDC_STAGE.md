# E_DDC_STAGE - C10-GCM03-S09-R06-CR02

Sequence: FLX-ORD-01
Role: Main didactic/evidence stage
Round or unit: C10-GCM03-S09-R06-CR02
Branch: grm-guarded-provisioning-20260727
Required starting HEAD: 5fef8a51ccb61dff00e773b3c8759062560d27da
Authority: Human-supervised Main Chat
Evidence boundary: Windows procedure correction only

## 1. Incident Classification

The new evidence does not show project-wide drift, sabotage, dependency
incompatibility, or a Windows build failure.

It shows two assertions that are stronger than their evidence:

```text
dart process name
!= proof of Markei/client/file-lock ownership

windows/flutter/ephemeral/generated_plugins.cmake
!= the repository's Windows generated-plugin manifest path
```

The correct repository contract is:

```text
Generated plugin manifest:
clients/markei_flutter/windows/flutter/generated_plugins.cmake

Generated plugin symlink:
clients/markei_flutter/windows/flutter/ephemeral/
  .plugin_symlinks/auth0_flutter
```

The word `ephemeral` applies to the plugin symlink and other generated native
state, not to the location of `generated_plugins.cmake`.

## 2. Evidence Ceiling

The human log proves:

- Flutter 3.44.6 and the Windows toolchain were available;
- `flutter clean` and bounded cleanup completed in the displayed rerun;
- dependency resolution completed;
- the procedure reached the manifest assertion;
- compilation was not reached.

Repository inspection proves:

- the non-ephemeral manifest exists at the Windows scaffold path;
- it contains one `auth0_flutter` plugin entry;
- no ephemeral manifest exists in the repository;
- CR01 uses the wrong manifest path;
- CR01 selects owners from process names alone.

This does not prove:

- a Windows Release build succeeds from the CR02 commit;
- the produced executable has final CR02 identity;
- the preserved Windows client launches or retains data;
- Auth0 callback behavior;
- Sync, convergence, cursor, acknowledgement, or provider correctness.

## 3. Required Vocabulary

Use:

- `process candidate` for a name match without attribution;
- `definite relevant owner` only when path/command/client evidence exists;
- `cleanup postcondition failure` for actual remaining generated state;
- `generated-plugin manifest` for
  `windows/flutter/generated_plugins.cmake`;
- `generated plugin symlink` for the `ephemeral/.plugin_symlinks` target.

Do not state:

- `ownership detected` from name alone;
- `Windows build failed` when compilation was not reached;
- `manifest was not regenerated` while checking a nonexistent/wrong path;
- `dependency drift` merely because newer incompatible versions are listed;
- `Chrome failure` as a Windows desktop blocker.

## 4. Dependency and Tooling Interpretation

The package output:

```text
Got dependencies!
25 packages have newer versions incompatible with dependency constraints.
```

means the lock/constraint resolution succeeded. The newer-version notice is
informational and does not authorize an upgrade.

The missing Chrome executable affects Chrome web development, not the Windows
desktop build target used here.

The mojibake sequence `ÔÇó` is console encoding of Flutter's bullet separator
and is not evidence of source or binary corruption.

## 5. Promotion Rules

CR02 source inspection may promote only:

```text
PROCESS_ATTRIBUTION_CONTRACT=CORRECTED
GENERATED_PLUGIN_MANIFEST_PATH=CORRECTED
PROCEDURE_READY_FOR_HUMAN_RERUN=YES
```

Only an actual subsequent Windows build from the pushed CR02 implementation
commit may promote:

```text
WINDOWS_RELEASE_BUILD=PASS
WINDOWS_ARTIFACT_IDENTITY=RECORDED
```

Only visible preserved-client observation may promote retained state or visible
identity. Live Sync remains separately authorized.

## 6. Frozen Claims

- R06 source identity semantics remain unchanged.
- CR01's bounded cleanup intent remains valid.
- CR01's name-only process attribution and manifest-path assertion are not
  accepted.
- No dependency or native plugin change is justified.
- R07 remains held and discussion-only.
- `ERR-*` and MKS runtime semantics are outside this round.

## 7. Required G/H/I Evidence

Reports must distinguish:

- observed human output;
- repository-backed source evidence;
- static correction validation;
- any disposable-host execution;
- skipped preserved-client actions;
- remaining human checkpoint.

Reports must not upgrade static validation into a build or runtime claim.

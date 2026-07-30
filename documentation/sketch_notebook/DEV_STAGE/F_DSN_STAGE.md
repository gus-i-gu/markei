# F_DSN_STAGE — Architecture for C10-GCM03-S09-R06

## Envelope

Sequence: FLX-ORD-01

Role: Main architecture constraint

Round or unit: C10-GCM03-S09-R06

Branch: `grm-guarded-provisioning-20260727`

Baseline / inspected HEAD: `c321675325cc4d7358b96c1e125f2aa2c5e84e7f`

Authority: D controls execution; E controls evidence; F controls ownership.

## 1. Architectural objective

Create one source identity chain:

```text
clean Git HEAD and tree
  -> shared deterministic identity resolver
  -> compile-time Flutter definitions
  -> one immutable shared Dart identity
  -> boot initialization
  -> one Closure presentation
```

Android and Windows are consumers of this chain. They do not own independent
provenance semantics.

## 2. Responsibility map

| Responsibility | Owner | Constraint |
|---|---|---|
| Git revision/tree resolution | shared build identity helper | no platform-specific algorithm |
| Source-tree SHA-256 derivation | shared build identity helper | domain-separated deterministic input |
| Public build-definition transport | canonical GS Flutter procedures | same names and values |
| Identity validation/sanitization | shared Dart identity value | no external I/O |
| Boot initialization | `main.dart` | exactly once before `runApp` |
| Application transport | MarkeiApp/shared composition boundary | immutable value |
| Closure display | NativeClosurePage | presentation only |
| APK artifact SHA-256 | Android build procedure | external artifact record |
| Windows executable SHA-256 | Windows build procedure | external artifact record |
| Sync/domain/runtime truth | existing R02–R05 owners | frozen |

## 3. Identity model

Conceptually:

```text
BuildIdentity
  fullRevision
  displayRevision
  sourceTreeSha256
  status
  safe labels
```

The class name may remain `BuildProvenance` to minimize churn. There must be one
canonical instance and one validation rule.

The full revision and source-tree digest are atomic as a presentation packet.
If one is invalid, the packet is unavailable. Do not present a valid-looking
digest paired with an unavailable revision or vice versa.

## 4. Why the source digest is common

Platform artifacts cannot share a SHA-256:

```text
same Flutter source
  -> Android toolchain -> APK bytes -> Android artifact SHA-256
  -> Windows toolchain -> EXE/native bundle bytes -> Windows artifact SHA-256
```

The common digest therefore belongs before platform compilation:

```text
Git tree object
  -> domain-separated SHA-256
  -> common source-tree identity
```

Artifact hashes remain useful for proving which local package/executable was
built or launched, but they are leaves of the chain rather than the common
root.

## 5. Boot lifecycle

Required production path:

```text
WidgetsFlutterBinding.ensureInitialized
  -> resolve immutable compile-time BuildIdentity.current
  -> create application composition
  -> run MarkeiApp with that exact identity
  -> pass identity to NativeClosurePage
```

Navigation to Closure must not recompute Git state, inspect files, contact a
provider, query SQLite, or select a platform implementation.

Compile-time values make identity available offline and before authentication,
enrollment, or Sync.

## 6. Build procedure architecture

`documentation/G_SCRIPTS.md` remains the canonical executable-procedure source.

One shared helper owns Git revision/tree/digest derivation. Android, Windows
Release, and Windows Debug consume its result.

Required flow:

```text
assert repository and clean relevant tree
  -> resolve HEAD and HEAD tree
  -> derive source SHA-256 once
  -> validate values
  -> inject both compile-time definitions
  -> build platform artifact
  -> record platform artifact identity
```

The helper may return an object or an ignored JSON define file. It must not
persist secrets or platform/runtime identifiers. Generated identity files must
be local, ignored, and reproducible.

## 7. Compatibility

Preserve:

- existing Closure surface enablement;
- existing Auth0/public-coordinate compile-time definitions;
- Android target selection and data-preserving install;
- Flutter SDK/package resolution guards added at `c321675`;
- Windows Auth0 callback registration;
- Debug/Release callback restoration and Release-hash preservation;
- existing test injection of an explicit identity;
- safe unavailability behavior.

The former 7–12-character `MARKEI_BUILD_PROVENANCE` may be accepted by isolated
tests during migration. Production builds must carry the full revision and
source-tree SHA-256.

## 8. Security boundary

Allowed visible identity:

- full revision internally;
- 12-character revision abbreviation visibly;
- full 64-character source-tree SHA-256 visibly;
- artifact path/size/hash in local terminal evidence.

Never include:

- token, password, connection string, Auth0 subject;
- Account, identity, Device, operation, correlation, or event UUID;
- local repository path inside the app identity;
- Git remote URL, username, machine name, or environment variables;
- source file contents, SQLite values, provider facts, or exception messages.

Raw malformed input is discarded, not reflected.

## 9. Sync freeze

R06 has no dependency arrow into the Sync subsystem:

```text
Build identity -> Closure presentation

Sync coordinator / Product resolver / applier / provider contracts
  = unchanged
```

Any required modification to a Sync, database, hosted, Product, or provider
path is a stop condition and must be reported instead of implemented.

## 10. Focused human terminal after R06

After Codex and Main reconciliation:

1. pull the exact R06 implementation commit;
2. build/install or launch Android and Windows through the corrected canonical
   procedures while preserving app data;
3. open Closure on each;
4. compare only:
   - source revision;
   - source-tree SHA-256;
   - preserved visible History/Closure presence;
   - absence of automatic operation;
5. record each platform artifact SHA-256 separately;
6. freeze the candidate if the common fields match.

No broad GRIMOIRE, SQLite, Neon, Render, Auth0, or provider replay is required
for this R06 terminal.

## 11. Completion boundary

R06 completes:

- one cross-platform source identity;
- one boot-initialized shared Dart value;
- one common Closure presentation;
- platform artifact attribution;
- focused deterministic and package evidence;
- G/H/I replacement and one scoped implementation commit.

R06 does not complete:

- live Sync;
- convergence;
- acknowledgement;
- no-op replay;
- GCM03;
- MVP acceptance.

After visible two-platform identity passes, the architecture requires movement
forward to the serialized Sync assay. Provenance must then serve as a freeze
mechanism, not as a reason for further incidental correction.

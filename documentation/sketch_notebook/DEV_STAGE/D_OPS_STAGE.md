# D_OPS_STAGE — C10-GCM03-S09-R06 shared source identity

## Active authority

Authority state: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED AFTER PUBLICATION

Sequence: FLX-ORD-01

Primary unit: C10-GCM03-S09-R06

Repository: `gus-i-gu/markei`

Existing branch: `grm-guarded-provisioning-20260727`

Required pre-stage head: `c321675325cc4d7358b96c1e125f2aa2c5e84e7f`

Required Codex starting head: the published R06 D/E/F staging commit, pinned by
Main in the seeding prompt.

D controls executable scope and terminals. E constrains evidence meaning. F
controls architecture and responsibility. J, REC_DIAGNOSTICS.md, installed
clients, preserved SQLite databases, diagnostic history, Render, Neon, Auth0,
and provider state are read-only and out of scope.

## 1. Objective

Complete the existing shared Flutter provenance design so Android and Windows
derive, embed, initialize, and display the same source identity:

1. exact Git source revision;
2. deterministic SHA-256 source-tree fingerprint;
3. one platform-neutral Dart identity object initialized at application boot;
4. one always-visible Closure presentation on either platform;
5. separate external artifact SHA-256 values for the APK and Windows
   executable.

This is an evidence-chain correction. It must not change Sync behavior.

The 12-character source revision remains a display abbreviation only. The
identity model must retain the exact full revision. The source-tree SHA-256 is
the common cross-platform value. APK and Windows executable SHA-256 values are
expected to differ and must not be compared as if they were source identity.

## 2. Accepted entry state

The branch already contains:

- `clients/markei_flutter/lib/app/build_provenance.dart`;
- a platform-neutral `BuildProvenance.current` based on
  `MARKEI_BUILD_PROVENANCE`;
- Closure rendering through
  `clients/markei_flutter/lib/app/pages/native_closure_page.dart`;
- safe 7–12 lowercase-hex validation;
- Android `GS-FLUTTER-AND` derivation and injection of a short Git HEAD;
- Android artifact path, size, SHA-256, data-preserving installation, and
  visible-provenance instruction.

The remaining defect is bounded:

- Windows Release and Debug procedures do not inject provenance;
- no shared source-tree SHA-256 exists;
- the identity is resolved lazily by Closure rather than explicitly at app
  boot;
- Android and Windows cannot present one identical source identity packet;
- Windows Release does not report its executable size and SHA-256.

R02–R05 are accepted as the corrective Sync baseline. Do not reopen them.

## 3. Required source identity contract

Implement one immutable platform-neutral Dart value, by extending or replacing
the existing `BuildProvenance` class without creating competing truth.

It must expose:

```text
full source revision: exactly 40 lowercase hexadecimal characters
display revision: first 12 characters of the validated full revision
source-tree SHA-256: exactly 64 lowercase hexadecimal characters
availability/validity state
safe Closure labels
```

Use compile-time Flutter definitions with stable names. Preferred names:

```text
MARKEI_SOURCE_REVISION
MARKEI_SOURCE_TREE_SHA256
```

`MARKEI_BUILD_PROVENANCE` may remain temporarily as a backwards-compatible
input only if one canonical identity result is produced. New builds must use
the full revision input and must not depend only on a caller-supplied short
string.

Invalid, partial, uppercase, path-like, secret-like, or malformed inputs must
produce an unavailable/invalid identity without echoing the unsafe raw value.

## 4. Deterministic source-tree SHA-256

Define and document one deterministic algorithm shared by every Markei Flutter
build procedure:

```text
head = git rev-parse HEAD
tree = git rev-parse HEAD^{tree}
material = UTF8("markei-source-tree-v1\n" + tree + "\n")
sourceTreeSha256 = SHA256(material), lowercase hexadecimal
```

The Git tree object identifies the complete committed source tree. The
domain-separated SHA-256 makes the displayed digest stable for the same HEAD
tree on Android and Windows without hashing platform artifacts.

Both procedures must use the same helper or one single owned implementation of
this algorithm. Do not duplicate slightly different algorithms in the Android
and Windows blocks.

Require a clean relevant worktree before deriving identity. If the tree or
revision cannot be resolved and validated, fail before build.

## 5. Boot and Closure integration

Resolve the immutable current identity once in `main()` after Flutter binding
initialization and before application composition/run.

Pass that exact value through the shared Flutter application boundary to the
Closure page. Constructor defaults may remain for isolated tests, but
production boot must not rely on Closure's first navigation to initialize
identity.

Closure must always show, when the Closure surface is enabled:

```text
Source revision #<12 lowercase hex>
Source tree SHA-256 <64 lowercase hex>
```

If either required source field is invalid or missing, show one bounded
unavailable/invalid state and do not display partial identity as complete.

No platform branching, `Platform.isAndroid`, `Platform.isWindows`, method
channel, filesystem read, network call, provider query, or database read is
allowed in the Dart identity model.

## 6. Build-procedure integration

Update the canonical procedure source in:

```text
documentation/G_SCRIPTS.md
```

The existing extractor remains authoritative:

```text
documentation/I_SCRIPTS.ps1
```

Do not hand-edit generated/extracted procedure copies.

### Android

`GS-FLUTTER-AND` must:

- derive the common identity using the shared helper;
- inject the full revision and source-tree SHA-256;
- preserve current Flutter SDK/package resolution guards;
- preserve data-preserving installation;
- preserve the APK artifact path, size, and SHA-256 report;
- require the two visible source identity fields after launch.

### Windows Release

`GS-FLUTTER-WIN` must:

- derive and inject the same common identity;
- build the Release artifact from that identity;
- report exact executable path, byte size, and artifact SHA-256;
- register and launch that exact executable;
- require the two visible source identity fields after launch.

### Windows Debug

`GS-FLUTTER-DBW` must put the same common identity into its ignored
`--dart-define-from-file` configuration and retain the Release/Debug callback
and Release-hash preservation guards.

Every identity-bearing ignored local file must remain ignored and contain only
public source identity plus already-reviewed public coordinates. Never include
tokens, subjects, Account/Device IDs, connection strings, secrets, or local
paths.

## 7. Writable scope

Production:

```text
clients/markei_flutter/lib/main.dart
clients/markei_flutter/lib/app/build_provenance.dart
clients/markei_flutter/lib/app/markei_app.dart
clients/markei_flutter/lib/app/pages/native_closure_page.dart
```

One shared source-identity helper may be added under:

```text
clients/markei_flutter/tool/
```

only if it is consumed by Android and Windows procedure paths and has a direct
determinism test or self-check.

Procedures:

```text
documentation/G_SCRIPTS.md
```

Focused tests:

```text
clients/markei_flutter/test/app/native_closure_diagnostics_test.dart
clients/markei_flutter/test/app/native_closure_surface_test.dart
clients/markei_flutter/test/app/markei_app_test.dart
```

Only tests directly affected by the constructor/identity contract may change.

Reports to replace:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

A required path outside this list is a stop condition.

## 8. Prohibited scope

Do not modify:

- Sync coordinator, use cases, ports, recorder, Product resolver, applier, or
  repository logic;
- database schema, migrations, SQLite files, generated Drift code, fixtures,
  or preserved app data;
- hosted API, protocol v3, Render, Neon, Auth0, enrollment, Account/Device
  binding, or provider configuration;
- dependencies or `pubspec.lock`;
- J, REC_DIAGNOSTICS.md, permanent memory, methodology, NS coordinates, GRM
  interface names, or unrelated scripts;
- application behavior beyond build identity transport/presentation.

Do not run:

```text
Sync
Retry
Recovery
Query
Enroll
new Purchase
provider mutation
database repair/reset/clear
installation against the user's preserved clients
```

Codex may build local disposable artifacts. It must not install or launch them
against the user's preserved Windows or Android state.

## 9. Focused validation

Run only the smallest sufficient R06 suite:

1. format changed Dart files;
2. `flutter analyze`;
3. focused identity/parser and Closure widget tests;
4. focused MarkeiApp boot-to-Closure propagation test;
5. deterministic helper self-check: two resolutions of the same clean HEAD
   yield the same revision/tree digest;
6. source inspection proving Android, Windows Release, and Windows Debug consume
   the same identity algorithm and define names;
7. Windows Release build with explicit R06 identity definitions when the host
   supports it;
8. Android Debug APK build with the same definitions when the host supports it;
9. artifact path/size/SHA-256 inspection for every built platform;
10. `git diff --check` and changed-path inspection.

Do not rerun the complete GRIMOIRE, SQLite, Neon, Render, Auth0, provider, full
Flutter regression, hosted lab, or preserved-state suite. A host-unavailable
platform build must be reported as host-unvalidated, not silently inferred.

## 10. Required terminals

G/H/I must state:

```text
C10_GCM03_S09_R06=IMPLEMENTED_VALIDATED | PARTIAL | BLOCKED
COMMON_BOOT_IDENTITY=PASS | FAIL
FULL_SOURCE_REVISION_VALIDATION=PASS | FAIL
COMMON_SOURCE_TREE_SHA256=PASS | FAIL
ANDROID_IDENTITY_INJECTION=PASS | FAIL
WINDOWS_RELEASE_IDENTITY_INJECTION=PASS | FAIL
WINDOWS_DEBUG_IDENTITY_INJECTION=PASS | FAIL
CLOSURE_COMMON_PRESENTATION=PASS | FAIL
WINDOWS_ARTIFACT_SHA256_REPORT=PASS | FAIL
ANDROID_ARTIFACT_SHA256_REPORT=PASS | FAIL
SYNC_SOURCE_CHANGED=NO
PRESERVED_CLIENT_STATE_TOUCHED=NO
LIVE_SYNC_EXECUTED=NO
PROVIDER_MUTATION=NONE
NEXT_HUMAN_CHECK=TWO_PLATFORM_VISIBLE_IDENTITY_ONLY
```

## 11. Publication

If implementation and required validation succeed:

1. replace G/H/I;
2. confirm every changed path is authorized;
3. create one intentional implementation commit whose direct parent is this
   published R06 staging commit;
4. push by non-forced fast-forward to
   `grm-guarded-provisioning-20260727`;
5. do not create a branch or PR;
6. verify the remote branch equals the implementation commit.

R06 does not prove Sync. After Main reconciles R06, the only next human evidence
is the focused two-platform visible-identity comparison. If both clients show
the same source revision and source-tree SHA-256 while preserving their
existing state, freeze source and proceed to the separately authorized
serialized Sync check without another broad preparation loop.

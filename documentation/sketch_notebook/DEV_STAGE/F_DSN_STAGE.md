# F_DSN_STAGE — Shared Closure composition and artifact-lineage boundary

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Design materialization stage
> Unit: `C10-GCM03-ST04-R1`
> Branch: `grm-guarded-provisioning-20260727`
> Required remote ancestry:
> `ec96f93d71efd261adc2b3b75a17453130e437a0`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED WITHIN D**
> Evidence boundary: shared Flutter presentation and local build provenance;
> no protocol/provider architecture expansion

## 1. Controlling design decision

Preserve one Closure surface:

```text
MarkeiApp
└─ NativeClosurePage
   ├─ shared diagnostics projection
   ├─ shared action boundaries
   └─ responsive layout only
```

Android and Windows may differ in authentication adapter configuration,
package identity, callback mechanics, and responsive dimensions. They must not
own duplicated Closure page implementations or divergent diagnostic meaning.

The screenshot/source contradiction is first an artifact-lineage problem.
An Android-only mirror would create semantic duplication and conceal the
actual provenance failure.

## 2. Responsibility map

```text
Git/build procedure
  derives reviewed public short source fingerprint
  passes it as a compile-time define

immutable client configuration
  validates/sanitizes the public fingerprint
  exposes a closed value or unavailable

NativeClosurePage
  renders the fingerprint
  owns no Git, shell, package-manager, or provider behavior

GS-FLUTTER-AND
  selects target
  validates source/build inputs
  builds one APK
  launches/installs the intended package
  reports non-secret provenance evidence

authentication/enrollment/Sync components
  remain unchanged
```

Do not persist build provenance in Drift. Do not send it to the hosted API.
Do not use it as Account/Device identity or authorization input.

## 3. Provenance model

Use the smallest coherent representation:

```text
BuildProvenance
  sourceFingerprint: short public closed value | unavailable
```

Constraints:

- immutable;
- deterministic from compile-time input;
- 7–12 lowercase hexadecimal characters when available;
- never accepts arbitrary long text for direct rendering;
- no filesystem or process dependency inside Flutter;
- no provider transport or persistence dependency;
- shared across platforms.

The display is diagnostic metadata, not a cryptographic attestation. The local
APK SHA-256 and target package evidence remain separate operational evidence.

## 4. Responsive parity contract

The Closure page may use scrolling, wrapping, stacking, or compact cards on
Android. Responsive code must not:

- substitute a legacy page;
- remove Diagnostics or evidence sections;
- merge Diagnostics, readiness, and Sync;
- hide queue/sequence state needed by ST04;
- alter runner composition;
- introduce a platform-only action;
- change action guards or protocol semantics.

Add explicit compact-dimension coverage because existing Closure tests
primarily use wide synthetic views. Test reachability, not simultaneous
on-screen visibility.

## 5. Diagnostic decision tree

```text
current source and compact tests already pass
  → classify artifact/build/launch provenance
  → harden provenance; do not fork page

compact test reproduces missing/legacy surface
  → repair shared responsive composition
  → prove wide behavior remains intact

different entrypoint/page/package is selected
  → repair build/launch selection
  → keep shared page unchanged

live target unavailable
  → report host-unvalidated
  → materialize only repository-proven hardening
  → require later human rerun
```

## 6. Preserved boundaries

Do not modify:

- `NativeAuthClosureRunner` action semantics;
- Auth0 platform adapter behavior;
- enrollment command or binding storage;
- hosted connection policy;
- ordinary Sync coordinator;
- Retry or failed/notApplied recovery;
- local queue/sequence allocation;
- diagnostics persistence shape;
- API routes, request identity, schemas, migrations, RLS, or provider state;
- package ID `com.gusigu.markei` unless a proven contradiction makes the unit
  impossible, in which case stop rather than broadening scope.

No Android data clear, reinstall-with-uninstall, AVD reset, or new Device
identity is part of the implementation.

## 7. Design validation

Prove:

1. one shared page/composition path;
2. one shared build-provenance value path;
3. compact and wide projections use the same action/evidence contract;
4. platform differences remain in configuration/adapters, not Closure meaning;
5. no provenance value reaches persistence or transport;
6. no protocol or provider boundary changes;
7. live Android acceptance remains a later human evidence gate.

## 8. I report

Replace `I_DSN_CODEX.md` with:

- final shared composition map;
- provenance responsibility map;
- diagnosed PROV class;
- source or build-script correction;
- compact/wide validation;
- proof of no protocol/persistence/provider expansion;
- host-unvalidated Android limitations;
- exact later human acceptance boundary.

Terminal markers:

```text
CLOSURE_IMPLEMENTATION=ONE_SHARED_PAGE_OR_BLOCKED
ANDROID_ONLY_PAGE_FORK=ABSENT
BUILD_PROVENANCE_BOUNDARY=LOCAL_PUBLIC_METADATA_OR_BLOCKED
PROVENANCE_PERSISTENCE=ABSENT
PROVENANCE_TRANSPORT=ABSENT
COMPACT_WIDE_CONTRACT=SHARED_OR_BLOCKED
AUTH_ENROLL_SYNC_BOUNDARIES=UNCHANGED
SCHEMA_API_PROVIDER_EXPANSION=ABSENT
ANDROID_RUNTIME_ACCEPTANCE=HELD_FOR_HUMAN_RETEST
GCM03_ST05_AND_LATER=HELD
```

Do not edit permanent design memory.

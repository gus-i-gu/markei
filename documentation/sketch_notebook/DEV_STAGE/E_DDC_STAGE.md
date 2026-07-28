# E_DDC_STAGE — Android Closure parity evidence and operator meaning

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Didactic materialization stage
> Unit: `C10-GCM03-ST04-R1`
> Branch: `grm-guarded-provisioning-20260727`
> Required remote ancestry:
> `ec96f93d71efd261adc2b3b75a17453130e437a0`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED WITHIN D**
> Evidence boundary: source, tests, and public artifact-provenance projection;
> no Android runtime acceptance or provider claim

## 1. Meaning of the interruption

The Android screenshot creates this contradiction:

```text
current source contract = consolidated Diagnostics Closure
visible Android artifact = legacy basic Closure
```

Teach the correct conclusion:

```text
successful build command ≠ proved installed artifact lineage
visible Closure destination ≠ current Closure revision
authenticated label ≠ complete ST04 or ST05 evidence
source parity test ≠ Android runtime acceptance
legacy Android surface ≠ need for an Android-only UI fork
```

ST04 is blocked because its evidence surface is insufficient. Authentication
is neither rejected nor accepted for GCM03 from this screenshot alone.

## 2. Shared operator vocabulary

Windows and Android must use the same meanings:

- `Diagnostics`: read-only local authentication/binding/queue/sequence and
  diagnostic evidence projection;
- `Check hosted connection`: separate hosted readiness request;
- `Sync`: separate stateful synchronization protocol;
- `Build provenance`: public short source fingerprint compiled into the
  visible client;
- generated APK hash: identity of the local build output;
- installed package evidence: identity/location/version evidence from the
  selected Android target;
- runtime acceptance: human observation of the expected surface on that
  installed target.

Do not call any of these evidence classes equivalent.

## 3. Required visible evidence

The shared Closure page must expose:

```text
Build provenance #<short fingerprint>
```

with key:

```text
nativeClosure.buildProvenance
```

Fallback:

```text
Build provenance unavailable
```

The fingerprint is intentionally short and public. It identifies source
lineage for human comparison; it is not a credential, Device identifier,
provider proof, release signature, or security guarantee.

The page must retain the already accepted distinctions among:

- current action result;
- sanitized technical details;
- Sync overview;
- local queue and Next Device sequence;
- Devices;
- actionable events;
- recent operation summaries and raw diagnostic history.

Compact Android layout may stack or scroll these sections. It must not remove
their meaning.

## 4. Diagnostic reporting language

Codex must label conclusions by evidence class:

```text
repository-proven
test-validated
human-observed
inferred
host-unvalidated
```

Examples:

- the shared page contains one Diagnostics button: repository-proven;
- a compact widget test finds it: test-validated;
- the rebuilt emulator visibly shows the expected fingerprint: later
  human-observed evidence;
- the old APK likely came from a pre-consolidation revision: inference unless
  artifact evidence proves it.

Do not use `fixed on Android` until a later human rerun confirms the installed
artifact and visible page. The Codex terminal is at most
`READY_FOR_HUMAN_RETEST`.

## 5. Tests

Tests must prove:

- the same Diagnostics vocabulary at Android/compact and Windows/wide sizes;
- old top-level Status/Query/Refresh vocabulary is absent;
- build provenance is visible, short, sanitized, and stable;
- missing/malformed provenance remains explicit and safe;
- evidence cards remain reachable through scrolling on compact layout;
- provenance inspection cannot invoke authentication, readiness, enrollment,
  Sync, Retry, recovery, or queue mutation.

## 6. H report

Replace `H_DDC_CODEX.md` with:

- the contradiction and its corrected interpretation;
- final operator vocabulary;
- source/test/runtime evidence distinctions;
- visible provenance behavior;
- compact-layout comprehension evidence;
- remaining human acceptance requirement.

Terminal markers:

```text
BUILD_SUCCESS_NOT_INSTALL_PROOF=VISIBLE
SOURCE_TEST_NOT_RUNTIME_ACCEPTANCE=VISIBLE
AUTH_LABEL_NOT_ST04_ACCEPTANCE=VISIBLE
SHARED_CLOSURE_MEANING=PASS_OR_BLOCKED
BUILD_PROVENANCE_MEANING=VISIBLE_OR_BLOCKED
COMPACT_EVIDENCE_REACHABILITY=TEST_PASS_OR_BLOCKED
LEGACY_CONTROLS=ABSENT_OR_BLOCKED
ANDROID_RUNTIME_ACCEPTANCE=HELD_FOR_HUMAN_RETEST
GCM03_ST05=HELD
```

Do not edit permanent didactic memory.

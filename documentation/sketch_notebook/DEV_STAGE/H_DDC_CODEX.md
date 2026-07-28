# H_DDC_CODEX - C10-GCM03-ST04-R1 didactic report

Sequence: FLX-ORD-01
Role: Codex didactic evidence
Round or unit: C10-GCM03-ST04-R1
Branch: grm-guarded-provisioning-20260727
Baseline / inspected HEAD: db17f47f3bb7a032afbd8892754dff971ae20b56
Authority: E_DDC_STAGE.md within synchronized D/E/F
Evidence boundary: source, tests, build-provenance projection, and local build only; no Android runtime acceptance or provider claim

## Corrected Meaning

The interruption means:

- successful build command is not installed-artifact proof;
- visible Closure destination is not proof of current Closure revision;
- authenticated label is not ST04 or ST05 acceptance;
- source/widget parity is not Android runtime acceptance;
- legacy Android surface does not justify an Android-only UI fork.

The historical source at `301ea19` contained the screenshot vocabulary: `Status`, `Query`, and `Refresh diagnostics`. Commit `ad1f228` consolidated that surface into `Diagnostics`. Current source and tests now preserve the consolidated vocabulary.

## Operator Vocabulary

- `Diagnostics`: local read-only evidence projection.
- `Check hosted connection`: separate hosted readiness request.
- `Sync`: separate stateful synchronization protocol.
- `Build provenance`: public short source fingerprint compiled into the visible client.
- generated APK hash: local output-file identity only.
- installed package evidence: target-side package/path/version evidence.
- runtime acceptance: later human observation of the expected installed surface.

These evidence classes are not interchangeable.

## Test Evidence

- Compact Android-dimension widget test proves `nativeClosure.Diagnostics`, `nativeClosure.Check hosted connection`, `nativeClosure.Sync`, `nativeClosure.buildProvenance`, queue/sequence, recent attempts, grouped lifecycle, Devices, and actionable events are reachable through scrolling.
- Legacy `nativeClosure.Status`, `nativeClosure.Query`, and `nativeClosure.Refresh diagnostics` remain absent.
- Provenance accepts `db17f47`, rejects uppercase/overlong/path-like/token-like input, and falls back to `Build provenance unavailable`.
- Provenance rendering caused no authentication, readiness, enrollment, Sync, Retry, recovery, or queue mutation in the test fixture.

## Remaining Human Acceptance

Codex did not claim Android runtime acceptance. The next evidence must be human-operated: run the hardened Android procedure, inspect the visible fingerprint and consolidated Diagnostics surface on the installed target, and return that evidence for Main reconciliation.

## Terminals

```text
BUILD_SUCCESS_NOT_INSTALL_PROOF=VISIBLE
SOURCE_TEST_NOT_RUNTIME_ACCEPTANCE=VISIBLE
AUTH_LABEL_NOT_ST04_ACCEPTANCE=VISIBLE
SHARED_CLOSURE_MEANING=PASS
BUILD_PROVENANCE_MEANING=VISIBLE
COMPACT_EVIDENCE_REACHABILITY=TEST_PASS
LEGACY_CONTROLS=ABSENT
ANDROID_RUNTIME_ACCEPTANCE=HELD_FOR_HUMAN_RETEST
GCM03_ST05=HELD
```

No permanent didactic memory was edited.

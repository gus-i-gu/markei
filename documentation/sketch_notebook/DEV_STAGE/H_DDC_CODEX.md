# H_DDC_CODEX - C10-GCM03-S09-R06

Sequence: FLX-ORD-01
Role: Codex didactic evidence
Round or unit: C10-GCM03-S09-R06
Branch: grm-guarded-provisioning-20260727
Baseline / inspected HEAD: 832c433896d9ba425e14891d9cbed9b58dcd8057
Authority: D executable; E evidence ceilings; F architecture ownership
Evidence boundary: provenance concept only; no Sync learning claim

## Evidence Claims

- Implemented: one common source identity is distinct from platform artifact identity.
- Implemented: full source revision is the canonical internal value; 12 characters are display only.
- Implemented: source-tree SHA-256 is calculated from `UTF8("markei-source-tree-v1\n" + gitTreeObjectId + "\n")`.
- Implemented: invalid or incomplete identity fails closed without echoing malformed raw input.
- Implemented: Closure is presentation-only for provenance and receives the identity from `MarkeiApp`.

## Validation Evidence

- `flutter analyze` passed.
- Focused Closure diagnostics tests passed after timeout rerun: 40 tests.
- Focused Closure surface / MarkeiApp propagation tests passed: 3 tests.
- Focused MarkeiApp regression test file passed: 26 tests.
- Android Debug APK build passed with explicit R06 identity defines.
- Windows Release build passed with explicit R06 identity defines after stopping a local process that locked the Release executable.
- Artifact SHA-256 values were recorded separately and are not treated as common source identity.

## PRC-01 Ceilings

- Source inspection supports only `common identity model implemented`.
- Widget tests support only `validation and presentation work in test scope`.
- Codex builds support only `local artifacts built with supplied identity`.
- Artifact hashes identify exact local bytes, not installed preserved clients.
- No live Sync, convergence, acknowledgement, no-op replay, or GCM03 closure claim is promoted.

## Didactic Follow-Up

- A future Didactic Chat may classify "source identity vs artifact identity" as a concept if Main wants a durable learning entry.
- No permanent didactic memory was edited by Codex.

## Terminals

C10_GCM03_S09_R06=IMPLEMENTED_VALIDATED
COMMON_BOOT_IDENTITY=PASS
FULL_SOURCE_REVISION_VALIDATION=PASS
COMMON_SOURCE_TREE_SHA256=PASS
ANDROID_IDENTITY_INJECTION=PASS
WINDOWS_RELEASE_IDENTITY_INJECTION=PASS
WINDOWS_DEBUG_IDENTITY_INJECTION=PASS
CLOSURE_COMMON_PRESENTATION=PASS
WINDOWS_ARTIFACT_SHA256_REPORT=PASS
ANDROID_ARTIFACT_SHA256_REPORT=PASS
SYNC_SOURCE_CHANGED=NO
PRESERVED_CLIENT_STATE_TOUCHED=NO
LIVE_SYNC_EXECUTED=NO
PROVIDER_MUTATION=NONE
NEXT_HUMAN_CHECK=TWO_PLATFORM_VISIBLE_IDENTITY_ONLY

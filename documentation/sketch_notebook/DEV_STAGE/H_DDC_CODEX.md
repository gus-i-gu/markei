# H_DDC_CODEX - Recovery Orchestration Semantics

> Unit: C10-MCG02-RECOVERY-ORCHESTRATION_20260721T003303Z
> Result: C10_MCG02_RECOVERY_ORCHESTRATION_PROVED

## Materialized Recovery States

- `no-recoverable-failure`: scoped discovery found no failed/notApplied candidate for the active Account and Device; sync proceeds normally.
- `failed-recovery-available`: exactly one valid failed/notApplied candidate was safely retired and its immutable member events were returned to the canonical pending upload path.
- `failed-recovery-blocked`: discovery found ambiguity or unsafe structure; sync stops with bounded unavailable behavior and no upload.
- `superseded`: retained evidence state for the legacy failed attempt after safe recovery.
- `pending`: recovered immutable member events waiting for the existing ordered lease path.
- `uploading`: one active retry submission owns the recovered event membership during transport.
- `accepted`: server accepted the retry and local member pending rows were accepted.
- `unknown`: interrupted or unknown transport outcome preserves the same retry identity for later retry.

Unsupported or closure wording was intentionally not added. Provider/human completion is not claimed by this unit; the human database still requires a separate authorized retest.

## Semantic Tests

- `scoped recovery discovery reports no candidate as no-op`
- `scoped recovery discovery blocks ambiguous candidates`
- `scoped recovery discovery blocks malformed failed candidate`
- `scoped recovery ignores non-failed-notApplied states`
- `scoped recovery blocks missing membership and hash mismatch`
- `scoped recovery leaves cross-device failed attempts untouched`
- `coordinator discovers failed recovery and uploads canonically`
- `concurrent scoped recovery creates one pending recovery`
- `unknown upload after recovery preserves same retry submission`
- `RECOVERY_ORCHESTRATION_HTTP_PROOF=true for coordinator recovery upload`

Existing ordered outbox, typed server-code, hosted binding, native closure, registration, migration, Purchase history, recovery, and local-first tests remained passing.

## Bounded User-Visible Outcomes

The UI continues to invoke the existing Sync action. It receives only closed synchronization states:

- ordinary completed/no-op behavior when there is no recoverable failure;
- ordinary completed behavior after one safe recovery and upload;
- bounded unavailable behavior when recovery is blocked or ambiguous;
- bounded interrupted behavior for unknown transport outcome.

Submission IDs, event IDs, Account IDs, Device IDs, hashes, payloads, SQL, provider configuration, and database details remain inside application/infrastructure layers and are not surfaced to presentation diagnostics.

## Failure-Code Behavior

The previous ordered-outbox semantics remain preserved:

- `sequence-gap` -> `SyncStatusCode.sequenceGap`
- `wrong-account` -> `SyncStatusCode.wrongAccount`
- `hash-mismatch` -> `SyncStatusCode.hashMismatch`
- unknown server codes -> generic conflict

Recovery orchestration does not reinterpret server rejection as success. It only admits stored failed submissions whose outcome is definitely `notApplied` and whose immutable members pass local structural validation.

## Privacy Evidence

Tests and reports use semantic states, candidate counts, row counts, and transmitted sequence order only. No production diagnostic exposes identifiers, hashes, payloads, SQL, tokens, provider configuration, or private database contents.

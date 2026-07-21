# H_DDC_CODEX — Ordered Outbox Recovery Semantics

> Unit: C10-MCG02-ORDERED-OUTBOX-RECOVERY_20260721T000323Z
> Result: C10_MCG02_ORDERED_OUTBOX_RECOVERY_PROVED

## Materialized states

- `waiting-upload`: pending events remain eligible and unleased.
- `uploading`: one active submission owns the event membership.
- `server-accepted`: accepted upload marks submission and member pending rows accepted.
- `duplicate-ignored`: equivalent accepted upload marks local rows accepted.
- `upload-outcome-unknown`: same submission identity/hash is retried; no new identity is created.
- `sequence-gap`: recognized server not-applied code, preserved distinctly.
- `wrong-account`: recognized server not-applied code, preserved distinctly.
- `hash-mismatch`: recognized server not-applied code, preserved distinctly.
- `failed-not-applied`: stored failed submission with `outcome=notApplied`.
- `failed-recovery-available`: explicit recovery requeues structurally valid immutable members.
- `failed-recovery-blocked`: unsafe or already retired recovery returns a bounded blocker.
- `sync-completed`: unchanged coordinator completion semantics.

`protocol-upgrade-required`, `full-rebootstrap-required`, and closure wording were not added or changed for this unit. The correction does not claim human/provider closure; human correction still requires a separate retest.

## Semantic tests

- `file-backed outbox canonicalizes reversed physical event order`
- `file-backed outbox preflight blocks non-contiguous batches`
- `file-backed failed notApplied recovery requeues one ordered retry`
- `file-backed recovery blocks unknown outcomes`
- `HTTP upload preserves recognized not-applied protocol codes`
- `ORDERED_OUTBOX_HTTP_PROOF=true for two-event hosted upload`
- Existing local registration, unknown retry, hosted binding, native closure, recovery, migration, Purchase, and local-first tests remained passing.

## Failure-code behavior

Flutter now maps protocol codes as follows:

- `sequence-gap` -> `SyncStatusCode.sequenceGap`
- `wrong-account` -> `SyncStatusCode.wrongAccount`
- `hash-mismatch` -> `SyncStatusCode.hashMismatch`
- unknown server codes -> `SyncStatusCode.conflict`

Persisted submission evidence stores the typed local status in `response_code` and the bounded protocol string in `error_code`. User-facing coordinator behavior remains bounded: recognized not-applied codes block as `sync-unavailable`; unknown transport outcomes remain `sync-interrupted`.

## Privacy evidence

Diagnostics and tests assert only semantic codes, counts, and sequence order. No production diagnostic exposes event IDs, Account IDs, Device IDs, hashes, payloads, SQL, tokens, provider configuration, or private database contents.

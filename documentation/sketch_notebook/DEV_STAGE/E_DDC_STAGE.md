# E_DDC_STAGE — Ordered Outbox Recovery Semantics

> Authority marker: C10-MCG02-ORDERED-OUTBOX-RECOVERY_20260721T000323Z
> Status: **ACTIVE CODEX DIDACTIC AUTHORITY**

## Closed states

- `waiting-upload`: immutable event is eligible but not leased.
- `uploading`: one bounded submission owns the event.
- `server-accepted`: server committed the exact event.
- `duplicate-ignored`: server already committed equivalent content.
- `upload-outcome-unknown`: acceptance is unknown; do not create a new identity or retry blindly.
- `sequence-gap`: server definitely rejected the ordered sequence contract; not applied.
- `wrong-account`: server definitely rejected Account/Device scope; not applied.
- `hash-mismatch`: server definitely rejected immutable content integrity; not applied.
- `failed-not-applied`: exact attempt failed without server application.
- `failed-recovery-available`: a structurally valid legacy not-applied attempt may be explicitly
  reconstructed once in canonical order.
- `failed-recovery-blocked`: recovery is unsafe or evidence is insufficient.
- `sync-completed`: upload/download/acknowledgement phases reached confirmed completion.

`conflict` is not an adequate substitute when the server supplied a recognized safe code. Recovery
must never imply that an unknown outcome was not applied. Ordering correction is not synchronization
success until an HTTP proof and later human provider retest confirm it.

User-facing wording remains short and recovery-oriented. It must not expose event order details,
IDs, hashes, Account/Device identifiers, payloads, SQL, provider configuration or tokens.

Required semantic tests cover reversed physical order, contiguous canonical order, one explicit
legacy recovery, repeated recovery, interruption/reopen, unknown-outcome blocking, and distinct
server failure-code preservation.

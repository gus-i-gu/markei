# H_DDC_CODEX - Gate 12.6 Evidence Semantics

Sequence: FLX-PRM-04 - Promotion/Reconciliation
Role: Codex didactic report
Evidence boundary: observational explanation only; no permanent didactic
promotion or methodology edit is authorized.

## Distinctions To Preserve

- repository-proven: `markei_shared_beta.sqlite` is a database file; `sqlite3.exe`
  is the separate CLI needed to inspect a copied database.
- human-observed: the accepted evidence came from a verified copied database,
  not from the live user database.
- inferred: copied-database integrity proves the copied file is readable and
  internally coherent for the inspected schema; it does not prove protected Sync
  success or provider application.
- repository-proven: `response_code` stores the local client enum name, while
  `error_code` stores the protocol body code.
- repository-proven/inferred: current mapping and legacy persisted
  representation can differ without contradiction when the copied file predates
  the mapping correction.
- repository-proven: failed/notApplied recovery and unknown Retry are different
  mechanisms. Unknown Retry reuses an unknown submission identity; failed
  recovery supersedes a failed submission and requeues member events.
- repository-proven: failed recovery is not the same as upload. Ordinary Sync
  performs recovery first and then continues to upload, download, and
  acknowledgement if no blocker occurs.
- inferred: a PASS copied-database diagnosis is not authorization to mutate.
  Gate 12.6 remains open, and Gate 12.7 still requires explicit human approval.

## Claim Classification

- human-observed: the copied database shows one active
  `failed / notApplied / conflict / service-unavailable` class and no unknown
  class in the reported summary.
- repository-proven: current source maps `service-unavailable` to
  `serviceUnavailable`; prior source fell through to `conflict`.
- inferred: the observed legacy representation is historically coherent, with
  row-level executable provenance unavailable.
- superseded: earlier Conclusion C for queue class is superseded by the copied
  database summary.
- unavailable: exact device scope, that scope's `next_sequence`, pending-work
  distribution by scope, next-upload contents, and safe request-hash equality
  are not present in the GS-SQLITE-03 transcript.
- prohibited: Codex cannot obtain those values by querying the user database or
  provider systems in this round.

## Diagnostic Decision Tree

1. If GS-SQLITE-04 reports exactly one failed/notApplied candidate on the
   hosted/current anonymized scope, with member sequences `1-2`, positions
   `0-1`, all member states failed, and no unexpected same-scope pending work,
   Main can prepare a tightly bounded Gate 12.7 decision packet.
2. If the candidate is on a non-hosted scope, has unexpected `next_sequence`,
   malformed membership, same-scope pending work that would join the first
   upload, or unsafe hash/identity ambiguity, Gate 12.6 remains open for
   reconciliation.
3. If the copied state contains unknown/uploading ambiguity or multiple failed
   candidates, unknown Retry remains inapplicable and failed recovery cannot be
   selected without further evidence.
4. Provider logs are only relevant after local scope correlation, and only as
   narrowly bounded read-only evidence; readiness checks do not substitute for
   protected Sync evidence.

## Conceptual Ambiguity

- inferred: the UI label `Retry unresolved submission` can sound broader than
  its implementation. In source it means exact unknown-submission retry, not
  failed/notApplied recovery.
- inferred: `sync-unavailable / provider-evidence-unavailable` is a later
  diagnostic/coordinator projection. It should not be restated as the original
  submission response unless local submission rows prove that link.
- inferred: Gate wording should keep "copied-database PASS" separate from
  "Gate 12.6 closed" and "Gate 12.7 authorized".

## Terminal Vocabulary

```text
COPIED_DATABASE_PROBE_PASS
GATE_12_6_COPIED_DATABASE_PROBE_PASS
FAILED_NOT_APPLIED_CLASS_CONFIRMED
UNKNOWN_RETRY_INAPPLICABLE
LEGACY_RESPONSE_REPRESENTATION_EXPLAINED_WITH_BOUNDARY
LEGACY_CONFLICT_SERVICE_UNAVAILABLE_EXPLAINED_WITH_BOUNDARY
EXACT_DEVICE_SCOPED_TRANSITION_CORRELATION_PENDING
GATE_12_6_OPEN
GATE_12_7_PENDING
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
PROVIDER_ACTION_UNAUTHORIZED
GCM02_OPEN
```

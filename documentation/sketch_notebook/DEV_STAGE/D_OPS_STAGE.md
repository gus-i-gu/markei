# D_OPS_STAGE — Ordered Hosted Outbox Recovery

> Authority marker: C10-MCG02-ORDERED-OUTBOX-RECOVERY_20260721T000323Z
> Required ancestor: 7e65d310260deeec7391915e5d3546a35b8dadb2
> Status: **ACTIVE CODEX CORRECTION AUTHORITY**

## Accepted evidence

Human v8 retest preserved two hosted Purchases and produced hosted Device events at contiguous
sequences `1,2`; local next sequence is `3`. Account, Device, sequence fields, stored hashes and
payload hashes all validate. Neon has one active Device expecting sequence `1` and contains zero
submissions/events/acknowledgements. The local submission is `failed/notApplied/conflict`, and its
two member events are `failed`. Render, authentication and Device enrollment are healthy.

Repository inspection shows the outbox selects pending rows without sequence ordering and reloads
events through an unordered `IN` query. The server evaluates events sequentially and rejects a
first event whose sequence differs from `next_expected_sequence`; the client collapses unrecognized
server failure codes to generic `conflict`. Reversed upload order is the leading hypothesis, not yet
promoted fact.

## Objective

Reproduce and correct nondeterministic hosted upload order, preserve precise safe server failure
codes, and provide a bounded explicit recovery for definitely-not-applied failed submissions
without renumbering, regenerating or manually editing immutable events.

## Checkpoints

1. Build a deterministic fixture with two same-Account/same-Device events whose physical row/order
   differs from Device sequence. Prove the current path can submit them out of order or establish a
   different evidenced cause before selecting the correction.
2. Lease scoped outbox events ordered by ascending `device_sequence`, with a stable tie-breaker.
   Preserve that order through event hydration and submission membership; never depend on SQLite
   row order or `WHERE id IN (...)` order.
3. Before transport, fail closed unless the batch is non-empty, belongs to one Account and Device,
   has unique event IDs/sequences, and is strictly contiguous in ascending sequence.
4. Extend client status decoding so `sequence-gap`, `wrong-account` and `hash-mismatch` remain
   distinct typed not-applied results rather than generic `conflict`. Production UI wording remains
   bounded and exposes no IDs, hashes, payloads, SQL or tokens.
5. Add an explicit, bounded recovery operation for legacy failed submissions only when stored
   outcome is `notApplied`, all member events remain immutable and structurally valid, and no event
   is accepted locally. Retire/supersede the failed attempt and create at most one ordered retry.
6. Never mutate event identity, Account/Device identity, sequence, payload or content hash. Never
   silently retry `unknown`, `uploading`, accepted, malformed, cross-identity or non-contiguous work.
7. Recovery must be idempotent across interruption/reopen and must not create duplicate active
   submissions. A second recovery request returns an equivalent state or a bounded blocker.
8. Prove an HTTP/API integration fixture expecting sequence `1` accepts ordered events `1,2`, stores
   one submission, advances server expectation to `3`, and treats the same retry identity/hash
   idempotently. Prove reversed, gapped, wrong-Account and bad-hash submissions remain not applied.
9. Preserve v8 migration, Purchase registration, old local-only events, hosted binding, cursor and
   all existing facts. The six local-only Device events remain outside the hosted outbox scope.

## Validation

- focused outbox order, hydration, preflight and recovery tests;
- real HTTP disposable API/PostgreSQL integration where supported;
- existing synchronization, Purchase, migration and hosted-authorization tests;
- full Flutter and TypeScript checks applicable to changed paths;
- Android debug and Windows release builds when supported;
- `git diff --check`, changed-path inventory and secret/artifact scan.

## Stop rules

No human database access/edit/reset, Neon/Auth0/Render access, provider mutation, PostgreSQL or Drift
schema migration, event payload/version change, Device reenrollment, sequence rewrite, automatic
generic-conflict retry, UI redesign, deployment, permanent promotion, MCG-03 or MCG-04. If ordering
does not reproduce the rejection, retain improved diagnostics only and report the missing evidence.

Success:

~~~text
C10_MCG02_ORDERED_OUTBOX_RECOVERY_PROVED
~~~

Otherwise:

~~~text
C10_MCG02_ORDERED_OUTBOX_RECOVERY_PARTIAL
~~~

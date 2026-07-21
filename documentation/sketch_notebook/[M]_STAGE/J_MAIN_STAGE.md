# J_MAIN_STAGE — Unknown-Outbox Recovery Coordination

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-UNKNOWN-RECOVERY_20260721
> Required ancestor: `301ea19b216f46a2d0375b9e52a3cbb27d8de998`
> Status: **RUNTIME DIAGNOSTICS ACCEPTED; UNKNOWN RECOVERY D/E/F ACTIVE**

## 1. Reconciliation result

Closure diagnostics are implemented, repository-validated and manually verified on the upgraded
Windows database. Two consecutive refreshes showed the same sanitized state and the second refresh
performed no Sync, authentication flow or mutation.

~~~text
authenticated / device-enrolled
unknown-work-needs-review
pending 0 / uploading 0 / failed 0 / unknown 2
unknown Device sequences 1 and 2
next local Device sequence 3
no locally recorded attempt history
~~~

The latest bounded hosted observation remains `submissions 0 / events 0 / next sequence 1`. This is
consistent with a retryable first submission but does not by itself authorize queue mutation or
prove the exact local submission shape.

Manual verification also exposed two separate product defects: Windows lacked installed
`auth0flutter://` protocol registration, and the desktop navigation rail overflowed at the tested
height. Manual current-user registration enabled sign-in; it is evidence of the missing packaging
step, not the permanent solution.

## 2. Decision

The next bounded unit is selected:

`C10-MCG02-UNKNOWN-RECOVERY`

It must prove and preserve exact idempotent retry identity, expose one guarded Closure recovery
action, fail closed on malformed/ambiguous state, package Windows callback registration, and remove
desktop navigation overflow. A provider retry remains prohibited during Codex materialization.

## 3. Authority

Only current D/E/F bearing `C10-MCG02-UNKNOWN-RECOVERY_20260721` authorize implementation. Current
G/H/I are accepted prior-unit evidence and must be replaced by Codex. Permanent domain promotion is
deferred until implementation reports and controlled runtime/provider verification return.

## 4. Acceptance sequence

1. Codex proves repository invariants and materializes the bounded unit.
2. Main reconciles new G/H/I and exact commit/tree evidence.
3. Human updates the Windows checkout and verifies protocol registration, navigation and the local
   recovery preflight without executing recovery.
4. Main authorizes at most one controlled unknown-submission retry.
5. Human captures sanitized Closure before/after evidence plus hosted `submissions/events/next`
   counts.
6. Convergence is accepted only if local and hosted evidence agree; otherwise Sync remains blocked
   and the stable outcome determines the next unit.

## 5. Current prohibition

Until step 4, do not press Sync or recovery; Query, Enroll, Clear diagnostic history, direct database
editing, new purchase creation and provider mutation are outside the verification path.

Success terminal: `C10_MCG02_UNKNOWN_RECOVERY_IMPLEMENTED`

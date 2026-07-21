# D_OPS_STAGE — Unknown-Outbox Recovery and Windows Closure Completion

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-UNKNOWN-RECOVERY_20260721
> Required ancestor: `301ea19b216f46a2d0375b9e52a3cbb27d8de998`
> Status: **ACTIVE CODEX MATERIALIZATION AUTHORITY**

## Accepted evidence

The Closure-diagnostics implementation passed repository validation and manual Windows verification:

~~~text
authentication                  authenticated
enrollment                      device-enrolled
readiness                       unknown-work-needs-review
pending/uploading/failed        0 / 0 / 0
unknown                         2 (Device sequences 1 and 2)
next local Device sequence      3
recent recorded attempts        empty (the interrupted attempt predates the ledger)
second diagnostic refresh       local-only and non-mutating
last provider observation       submissions 0 / events 0 / next expected sequence 1
~~~

The Windows client also required manual current-user registration of `auth0flutter://` before the
browser callback returned to Markei. With Closure visible, the navigation rail overflowed by about
90 pixels at one tested window height.

These observations validate Closure diagnostics. They do not validate synchronization convergence
or authorize an uncontrolled retry.

## Required materialization

1. Trace and document the exact persisted relationship among the two `unknown` pending-event rows,
   their submission row, submission membership/order, request hash and Device sequence. Do not
   print payloads or complete identifiers.
2. Preserve the existing idempotency invariant: an unknown submission may be retried only as the
   exact same submission identity, request hash, ordered event membership and event content. Never
   allocate a replacement submission or skip/resequence its events.
3. Add an explicit, user-confirmed Closure recovery action for eligible unknown work. It must:
   - require authenticated, active enrollment and one scoped unknown submission;
   - show a sanitized preflight summary and warn that hosted outcome is unresolved;
   - reuse the normal coordinator/transport and the exact persisted submission;
   - create one durable diagnostic attempt record;
   - disable conflicting actions while running;
   - refresh diagnostics after the terminal outcome.
4. Fail closed with stable guidance when unknown state is malformed, cross-scope, has missing or
   mismatched members, is non-contiguous, has multiple competing unknown submissions, or cannot
   prove exact retry identity. Do not mutate the queue in those cases.
5. Preserve response semantics:
   - accepted or duplicate-equivalent may transition the original submission/events to accepted;
   - another unknown result remains unknown and preserves the same retry identity;
   - stable not-applied results follow the existing failed/recovery representation;
   - sequence/hash/account/device conflicts remain blocked and visible.
6. Package/register the Windows `auth0flutter` callback protocol through a repository-owned,
   current-user-scoped development/install mechanism appropriate to Flutter Windows. Registration
   must quote the executable and `%1`, require no administrator rights, contain no credentials, and
   be testable. Keep the existing single-instance callback forwarding and validation.
7. Make desktop navigation vertically responsive/scrollable so all destinations, including
   Closure, remain reachable without RenderFlex overflow at supported Windows heights. Preserve
   compact navigation behavior and destination/index alignment.
8. Update developer-facing Windows run/setup guidance with the verified vcpkg discovery variables
   and Closure feature flag, using placeholders only.

## Validation

- repository snapshot test for the real shape: one unknown submission containing sequences 1–2,
  local next sequence 3, and exact same-submission retry;
- accepted, duplicate-equivalent, repeated-unknown, stable-not-applied, conflict and malformed-state
  tests with queue/submission invariants checked after each outcome;
- proof that confirmation cancellation and failed preflight make no transport call and no mutation;
- proof that exactly one attempt ledger entry is finalized per recovery invocation;
- widget tests for recovery visibility, sanitized confirmation, busy state and guidance;
- Windows protocol-registration contract test plus callback-forwarding regression;
- navigation tests at representative short and tall desktop heights, with no overflow exceptions;
- complete formatting, analysis, Flutter tests, Android debug build and Windows release build;
- `git diff --check`, exact changed-path review and tracked/staged secret scan.

## Boundaries and stop rules

Do not access or mutate Auth0, Render or Neon; deploy; execute the real recovery; edit the user's
database; reset/reclassify unknown rows directly; change event identity/content/order; introduce a
new server endpoint unless existing protocol behavior makes safe recovery impossible; merge Closure
with Settings; expose payloads, tokens, full identifiers or raw exceptions; start MCG-03/04; or
update permanent notebook memory.

If exact retry identity cannot be proven from persisted local state and existing server semantics,
stop with the precise gap rather than creating a destructive repair.

Replace G/H/I with evidence, commit and push one bounded implementation without force.

Success terminal: `C10_MCG02_UNKNOWN_RECOVERY_IMPLEMENTED`

Otherwise: `C10_MCG02_UNKNOWN_RECOVERY_PARTIAL` with the exact blocker.

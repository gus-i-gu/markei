# D_OPS_STAGE — Closure Diagnostics and Sync Retrospective

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-CLOSURE-DIAGNOSTICS_20260721
> Required ancestor: `bf78a3908ad05b3e7a0decc197fa2f99970059f1`
> Status: **ACTIVE CODEX MATERIALIZATION AUTHORITY**

## Objective

Turn the existing feature-gated Closure page into a sanitized user and developer diagnostic surface
that makes authentication, enrollment, local queue, Device sequence and recent synchronization
attempts observable without merging Closure into Settings.

Provider evidence immediately preceding this stage is bounded to:

~~~text
authentication: initially signed out; interactive sign-in succeeded
enrollment: confirmed; one active hosted Device
client TLS: TLS 1.3
Neon after the attempted Sync: submissions 0 / events 0 / next sequence 1
Render health: live 200 / ready 200
Render request/status evidence for the attempt: unavailable
current UI: only one transient action/result string
~~~

The `0 / 0 / 1` provider result proves no hosted commit. It does not prove which pre-transaction
client or transport phase failed.

## Required materialization

1. Add a read-only Closure diagnostic query/application port backed by the active local Drift
   database. Do not let widgets query Drift directly.
2. Add a durable, local-only sync-attempt ledger if no equivalent durable source exists. Record one
   row per user-initiated Sync run with start/end timestamps, terminal stable status code, bounded
   phase, outcome class and sanitized recovery code. Never store tokens, Auth0 subjects, raw HTTP
   bodies, SQL, stack traces, connection data, payload JSON or exception messages.
3. Instrument the hosted sync coordinator/runner at stable boundaries so interrupted, unavailable,
   blocked, completed and no-new-events outcomes become retrospective evidence. Preserve current
   synchronization behavior and transaction semantics.
4. Present a User diagnostics section containing:
   - authentication state;
   - enrollment state;
   - overall sync readiness/last outcome;
   - pending, uploading, failed and unknown queue counts;
   - next local Device sequence;
   - last successful synchronization time when evidence exists;
   - concise recovery guidance.
5. Present a Developer diagnostics section containing:
   - the most recent 20 sync attempts, newest first;
   - timestamp, duration when known, phase, stable result code and outcome;
   - a sanitized enrolled-device list using local aliases/short fingerprints rather than full UUIDs;
   - per-device status, local next sequence and whether it is the current Device;
   - queue-state counts and a bounded list of the most recent 20 pending/failed/unknown events using
     short event fingerprints, event type, sequence, state and timestamps only.
6. Provide explicit `Refresh diagnostics` and clear visual empty states. Refresh after every Closure
   action and when the page is opened. Do not initiate Sync during refresh.
7. Keep Status, Sign in, Enroll, Query, Sync and Logout actions. Disable only conflicting actions
   while an action runs; do not clear prior diagnostics while running.
8. Add a user-confirmed `Clear diagnostic history` action that deletes only the local attempt ledger.
   It must not delete events, queue rows, Devices, purchases, bindings, credentials or sync cursors.
9. Use stable keys and widget semantics for all summary values and history collections.
10. If a Drift schema change is required, add the next forward migration, regenerate Drift output and
    prove upgrade from the immediately preceding schema without destructive reset.

## Validation

- repository tests for sanitized snapshot queries, ordering, 20-row bounds and Account scoping;
- coordinator/runner tests for each recorded terminal outcome and interrupted attempts;
- widget tests for signed-out, enrolled, empty, pending, failed/unknown and populated-history states;
- a migration-upgrade test if schema version changes;
- regression proof that diagnostic refresh performs no network request and no synchronization;
- regression proof that clearing history preserves queue, Device, binding and cursor state;
- `dart format --set-exit-if-changed lib test`;
- `flutter analyze` and complete `flutter test`;
- supported Windows release and Android debug builds;
- `git diff --check`, exact changed-path review and tracked/staged secret scan.

## Boundaries and stop rules

Do not access Auth0, Render or Neon; deploy; retry the real Sync; alter server/API/event contracts;
change synchronization decisions; merge Closure with Settings; redesign unrelated pages; expose raw
identifiers or secrets; add telemetry; export diagnostics; promote permanent notebook memory; or
start MCG-03/04. Preserve unrelated and untracked files and existing user databases.

If retrospective history cannot be populated for actions that predate this implementation, say
`No locally recorded attempt history` rather than reconstructing or inventing an attempt.

Replace G/H/I with evidence, commit and push one bounded implementation without force.

Success terminal:

~~~text
C10_MCG02_CLOSURE_DIAGNOSTICS_IMPLEMENTED
~~~

Otherwise report `C10_MCG02_CLOSURE_DIAGNOSTICS_PARTIAL` and the exact blocker.

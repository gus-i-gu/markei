# D_OPS_STAGE — Gate 12.7 controlled recovery surface

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Operational materialization authority
Unit: C10-GCM02-S12-REC-01
Branch: `cycle10-intermid-grimoire`
Required ancestry: `76540c45702b027d56b52fea05a8025f14496cdf`
Authority: Main Chat under explicit human direction
Status: **ACTIVE — CODEX SOURCE MATERIALIZATION AUTHORIZED; HUMAN/PROVIDER
EXECUTION PROHIBITED**
Evidence boundary: repository source, generated artifacts, disposable local
tests and replacement G/H/I only

## 1. Accepted input evidence

Preserve the accepted C10-GCM02-S12-ERR-02 implementation and its tests.

The 2026-07-26 human-operated Windows inspection established:

```text
AUTHENTICATION=authenticated
ENROLLMENT=device-enrolled
READINESS=failed-work-needs-review
QUEUE_PENDING=0
QUEUE_UPLOADING=0
QUEUE_FAILED=2
CURRENT_DEVICE_NEXT_SEQUENCE=3
ACTIONABLE_FAILED_EVENTS=2
ACTIONABLE_SEQUENCE_RANGE=1-2
INSPECTION_CODE=MKS-UI-004
INSPECTION_PHASE=failed-recovery-preflight
INSPECTION_OUTCOME=not-applied
LOCAL_MUTATION=none
PROVIDER_CONTACT=not-started
TRUSTED_RESPONSE=not-received
RESULT_PERSISTENCE=not-started
SAFE_ACTION=hold for Gate 12.7 reconciliation; do not execute recovery
```

The operation and correlation fingerprints were present and bounded in the
UI. They are evidence labels only and must not become execution authority or
database identity.

Targeted source inspection also found diagnostic semantic drift:
`inspectFailedNotAppliedRecovery` emits `MKS-UI-004` for an eligible
preflight, while the registry still defines `MKS-UI-004` as the historical
condition in which the inspection action is missing. The action now exists.
Preserve that historical definition and stop emitting it as the successful
preflight code. Add or select a precise REC preflight code through the registry
and regenerate every projection.

This closes the read-only preflight requirement. It does not authorize a
recovery, provider request, ordinary Sync, a second action, deployment, or
GCM-02 closure.

## 2. Objective

Materialize one separately named, separately confirmed, bounded
failed/notApplied recovery-and-upload surface.

The new action must:

1. re-run the current authentication, enrollment, Device-scope and candidate
   preflight immediately before mutation;
2. require exactly one valid current-Device failed/notApplied candidate;
3. bind execution to the revalidated internal candidate and its exact member
   set, never to a 12-hex fingerprint alone;
4. transition only that candidate and its member events;
5. upload only that recovered member set;
6. stop after the upload terminal;
7. perform no download, acknowledgement, broad ordinary Sync, enrollment,
   repair, cleanup, or second recovery;
8. emit a complete ordered diagnostic timeline through the accepted v12
   envelope;
9. remain unexecuted outside disposable tests until a later exact Gate 12.7
   packet receives explicit human authorization;
10. correct the stale `MKS-UI-004` eligible-preflight emission through the
    single registry owner.

Suggested visible label:

```text
Recover failed/notApplied candidate
```

Do not reuse `Retry unknown-outcome submission` and do not rename ordinary
`Sync`.

## 3. Required execution boundary

Create a dedicated coordinator/use-case boundary rather than routing the new
button through `HostedSyncCoordinator.run`.

The bounded sequence is:

```text
authentication
→ exact Account/Device binding
→ failed/notApplied preflight refresh
→ explicit confirmation
→ atomic exact-candidate local recovery
→ exact recovered-batch validation
→ one upload request
→ local upload-result persistence
→ terminal
```

The action must not call download or acknowledgement ports.

The preflight/confirmation view must display only sanitized closed values:
candidate fingerprint, member count, sequence range, next Device sequence,
queue counts, operation fingerprint, expected single upload, prohibited
actions, and the no-second-action rule.

Cancellation must create no queue/submission mutation and no provider contact.

## 4. Identity and time-of-check safeguards

Do not treat a sanitized fingerprint as a unique database key.

At execution time, revalidate inside the local transactional boundary:

- current authenticated Account and enrolled Device binding;
- exactly one `failed/notApplied` submission in the current scope;
- complete and contiguous membership;
- canonical event content hashes;
- exact Account/Device ownership;
- no accepted member;
- no active overlapping submission;
- member states all `failed`;
- zero current-scope pending/uploading/unknown work;
- Device next sequence immediately follows the candidate range;
- displayed member count/range/next-sequence/fingerprint still match the
  confirmation snapshot.

Any mismatch must return a typed blocked terminal with no mutation and no
provider contact.

The recovery transaction must return an internal bounded batch descriptor
containing the exact recovered member identities needed by the uploader.
The uploader must validate and lease that exact set atomically. It must not
select newly appeared or unrelated pending work.

## 5. One-action and outcome rules

Use one action lock from confirmation through terminal. Disable the action
after the first execution attempt in that application session.

Accepted terminal families:

```text
applied
duplicate-equivalent
rejected/notApplied
unknown
blocked-before-contact
unexpected-local-failure
```

Rules:

- request not started: no provider inference;
- request started without trusted terminal: `unknown`, never auto-retry;
- trusted notApplied/rollback: preserve the typed rejection;
- duplicate-equivalent: accept only through the existing protocol contract;
- provider result and local persistence result remain separate;
- an unexpected terminal never triggers another action;
- no automatic fallback to ordinary Sync;
- no second upload, Retry, recovery, download, or acknowledgement.

## 6. Diagnostic evidence

Use one new top-level operation identity and distinct child correlations.
Persist ordered evidence for:

```text
authorization-preflight
binding
failed-recovery-preflight
failed-recovery-local-transition
recovered-batch-validation
upload-lease
upload-transport
upload-provider
upload-result-persistence
terminal
```

Each entered phase must preserve the accepted evidence axes:

```text
local mutation
provider contact
trusted response
provider transaction
local result persistence
terminal outcome
```

Use the existing diagnostic registry as the single vocabulary owner. Add or
revise definitions only when the new reachable action needs a precise code.
Regenerate all projections deterministically. Do not expose full identifiers,
payloads, tokens, URLs, SQL, exception messages, stack traces, connection
strings, or provider secrets.

## 7. Tests

Add focused disposable tests proving:

- inspection remains read-only and network-free;
- cancellation performs no mutation/contact;
- confirmation data is sanitized and complete;
- stale/mismatched preflight blocks before mutation/contact;
- zero or multiple candidates block;
- wrong Account/Device, invalid membership/hash/range/state, accepted members,
  active overlap, or unexpected queue work block;
- exact recovery changes only the selected submission/member set;
- upload lease contains exactly the recovered members;
- unrelated or concurrently appearing work is excluded and blocks safely;
- exactly one upload request can occur;
- download and acknowledgement ports are never called;
- duplicate-equivalent, rejected/notApplied, unknown and local-persistence
  failure remain distinct;
- unknown is never automatically retried;
- action lock prevents a second execution in the session;
- ordered diagnostics preserve parent/child identities and all evidence axes;
- an eligible inspection emits the precise REC preflight code and does not
  emit historical `MKS-UI-004`;
- existing ordinary Sync and unknown-outcome Retry behavior remain unchanged.

Run the generator update/check, Dart formatting, build_runner if needed,
Flutter analysis, focused tests, the full Flutter suite, applicable
TypeScript/API checks if a shared contract changes, `git diff --check`, and a
changed-file sensitive-content scan. Report exact commands and counts.

## 8. Writable scope

Authorized:

- necessary Flutter application/domain/infrastructure/UI source and tests;
- additive generated Drift output only if strictly necessary;
- the existing diagnostic registry, generator and generated projections only
  if the new reachable action requires compatible definitions;
- replacement G/H/I reports.

Prohibited:

- any live provider/API action;
- deployment;
- user-database inspection or mutation;
- Neon/Auth0/Render changes;
- migrations against hosted PostgreSQL;
- credentials or secrets;
- GRM procedure execution;
- J, A/B/C, permanent domain files, Main-root continuity, methodology, and
  unrelated cleanup.

## 9. G report requirements

G must report:

- exact source and test changes;
- the coordinator/action boundary;
- how exact batch identity is preserved;
- all mutation/contact/terminal rules;
- validation commands and counts;
- confirmation that no hosted action occurred;
- blockers or deviations.

Terminal markers:

```text
FAILED_NOT_APPLIED_EXECUTION_SURFACE=IMPLEMENTED_OR_BLOCKED
ELIGIBLE_PREFLIGHT_DIAGNOSTIC_CODE=CORRECTED_OR_BLOCKED
EXACT_RECOVERED_BATCH=VALIDATED_OR_BLOCKED
ONE_UPLOAD_ONLY=VALIDATED_OR_BLOCKED
DOWNLOAD_ACK_ABSENT=VALIDATED_OR_BLOCKED
NO_PROVIDER_ACTION_DURING_MATERIALIZATION=PASS_OR_BLOCKED
GATE_12_7=HELD
GCM02=OPEN
```

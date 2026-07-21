# J_MAIN_STAGE — Closure Diagnostics Coordination

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-CLOSURE-DIAGNOSTICS_20260721
> Required ancestor: `bf78a3908ad05b3e7a0decc197fa2f99970059f1`
> Status: **CLOSURE DIAGNOSTICS SELECTED; CODEX D/E/F ACTIVE**
> Active unit: **Local user/dev diagnostic and synchronization retrospective**

## 1. Human observation and provider boundary

The native Closure surface successfully supported Sign in and enrollment, but it exposes only one
transient status string. It does not show pending events, interrupted/failed events, Device sequence
or retrospective attempts.

The controlled external inspection established:

~~~text
client TLS                         TLS 1.3
hosted Device rows                1 active
Neon submissions/events/sequence  0 / 0 / 1
Render live/ready                 200 / 200
request/status for attempted Sync unavailable in retained free-plan logs
~~~

This proves the attempted Sync did not commit hosted data. It does not identify the failing local or
transport phase. No second real Sync is authorized by this stage.

## 2. Decision

The proposal is accepted with a precision correction: Closure will provide complete coverage of
locally observable diagnostic state, not claim a provider-wide “full error scan.” Closure remains
separate from Settings.

The implementation must add:

- a user-facing readiness and recovery overview;
- durable sanitized history for future user-initiated Sync attempts;
- current queue counts and bounded actionable-event rows;
- redacted enrolled-device summaries and next local sequence;
- a developer retrospective with stable phases/codes/timestamps;
- read-only refresh and narrowly scoped history clearing.

It must not fabricate the already-observed attempt in a new ledger. That attempt predates durable
client instrumentation and remains external evidence only.

## 3. Controlling authority

Codex materialization authority is exclusively:

- `DEV_STAGE/D_OPS_STAGE.md`
- `DEV_STAGE/E_DDC_STAGE.md`
- `DEV_STAGE/F_DSN_STAGE.md`

Current G/H/I are prior implementation evidence and must be replaced after materialization. They do
not authorize source changes.

## 4. Acceptance outcome

The unit succeeds when the feature-gated native Closure page can truthfully answer, across restart:

~~~text
Am I authenticated and enrolled?
Is local synchronization ready?
What local work is pending, uploading, failed or unknown?
What is the current Device's next local sequence?
What happened in the most recent recorded attempts?
Which safe next action is recommended?
~~~

All answers must remain Account/environment scoped, sanitized and locally evidenced.

Terminal:

~~~text
C10_MCG02_CLOSURE_DIAGNOSTICS_IMPLEMENTED
~~~

## 5. Exclusions and forward path

This unit does not retry provider Sync, inspect or mutate Auth0/Render/Neon, prove provider
convergence, merge Closure/Settings, add remote telemetry/export, start multi-Device convergence,
begin MCG-03/04 or promote permanent domain memory.

After Codex returns G/H/I, Main reconciles the implementation and validation. Only then should the
human run a controlled local Closure inspection and decide whether the pending sequence-1 event is
safe to retry under the newly observable diagnostics.

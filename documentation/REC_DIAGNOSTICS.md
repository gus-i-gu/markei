# MARKEI CLOSURE ASSAY — SANITIZED RECORDS

Created from the Closure screenshots supplied on 2026-07-26.

This document contains:

1. a canonical empty record for manual reuse;
2. Record 001 — pre-action screenshot baseline;
3. Record 002 — post–“Check hosted connection” screenshot result.

## Recording rules

- Record only short UI-generated fingerprints, never full identifiers.
- Do not record passwords, tokens, cookies, authorization headers, connection
  strings, environment-variable values, complete private URLs, full account or
  device identifiers, or request bodies containing purchase data.
- `[MANUAL]` means the screenshots do not establish the value. Fill it from
  direct observation only.
- `[SCREENSHOT]` means the value is visible in the supplied screenshots.
- `[CONTEXT]` means the value comes from the assay authorization state already
  established for this sequence, not from the screenshots.
- `[UNPROVED]` means the evidence supplied cannot establish the claim.
- Do not combine a client operation declaration with a server-request
  declaration unless their sanitized correlation evidence corresponds.

---

# CANONICAL EMPTY MODEL

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID:
DATE/TIME (local):
DATE/TIME (UTC, if available):
TESTER:
DEVICE/OS:
CLIENT BUILD OR COMMIT SHA:
ENVIRONMENT: development / disposable / other
ASSAY PURPOSE:

SAFETY
------
Secrets copied into this file: NO
Tokens/passwords/connection strings copied: NO
Gate 12.7 state: HELD / AUTHORIZED
Recovery execution authorized: NO / YES
Ordinary Sync authorized: NO / YES
New submission-bearing event authorized: NO / YES

PRE-ACTION CLIENT STATE
-----------------------
Authentication:
Enrollment:
Readiness:
Last result:
Last successful Sync:
Recovery guidance:

Declaration scope:
Operation kind:
Client result code:
Server request:
Last proved phase:
Configured deadline:
Deadline owner:
Elapsed time/band:

Operation fingerprint (sanitized/short):
Correlation fingerprint (sanitized/short):

LOCAL QUEUE
-----------
Pending:
Uploading:
Failed:
Unknown:
Next Device sequence:

FAILED/NOTAPPLIED CANDIDATE
---------------------------
Candidate present: YES / NO
MKS code:
Candidate member count:
Sequence range:
Inspection eligibility:
Local mutation:
Provider contact:
Trusted response:
Safe next action:
Displayed Gate instruction:

ACTION PERFORMED
----------------
Button/action:
Exact click count:
Action start time:
Action end time:
User cancellation/confirmation:
Unexpected UI behaviour:

POST-ACTION CLIENT RESULT
-------------------------
Title:
Outcome class:
Result code:
Declaration scope:
Operation kind:
Last proved phase:
Local mutation:
Provider contact:
Trusted response:
Server outcome:
Configured deadline:
Elapsed time/band:
Operation fingerprint:
Correlation fingerprint:
Safe next action:

POST-ACTION QUEUE
-----------------
Pending:
Uploading:
Failed:
Unknown:
Next Device sequence:
Queue changed: YES / NO
Expected change: YES / NO
Explanation:

RECENT CLOSURE ATTEMPT
----------------------
Attempt type:
Title/result:
Outcome:
Operation kind:
Declaration scope:
Status:
Headers received:
HTTP status:
Configured deadline:
Elapsed time/band:
Operation fingerprint:
Correlation fingerprint:

SERVER/RENDER EVIDENCE
----------------------
Log window start/end (UTC):
Request observed: YES / NO
Route class:
HTTP method:
HTTP status:
Declaration scope:
Operation kind:
Result code:
Elapsed band:
Operation fingerprint:
Correlation fingerprint:
Database/transaction phase, if declared:
Server terminal observed: YES / NO

Do the client/server fingerprints correspond: YES / NO / UNPROVED
Raw token, URL, database ID or account ID included: NO

PROJECTION CHECK
----------------
“Last successful Sync” before:
“Last successful Sync” after:
Should this action advance it: YES / NO
Projection behaved correctly: YES / NO

SCREENSHOTS/LOG EXCERPTS
------------------------
Client screenshot filename:
Render screenshot/excerpt filename:
Other evidence:

OBSERVATION
-----------
Expected:
Observed:
Difference:
Current hypothesis:
Next safe action:
```

---

# RECORD 001 — PRE-ACTION BASELINE

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-26-001-PRE-HOST-CHECK
DATE/TIME (local): [MANUAL — suggested source header: 2026-07-26 19:11; verify]
DATE/TIME (UTC, if available): [MANUAL]
TESTER: [MANUAL]
DEVICE/OS: Windows desktop [SCREENSHOT; exact Windows version MANUAL]
CLIENT BUILD OR COMMIT SHA: [MANUAL]
ENVIRONMENT: development / disposable / other [MANUAL]
ASSAY PURPOSE: Establish the Closure UI and local-queue baseline immediately
before one “Check hosted connection” action, without Sync, Retry, recovery
execution, or a new submission-bearing event.

SAFETY
------
Secrets copied into this file: NO
Tokens/passwords/connection strings copied: NO
Gate 12.7 state: HELD [CONTEXT]
Recovery execution authorized: NO [CONTEXT]
Ordinary Sync authorized: NO [CONTEXT]
New submission-bearing event authorized: NO [CONTEXT]

PRE-ACTION CLIENT STATE
-----------------------
Authentication: authenticated [SCREENSHOT]
Enrollment: device-enrolled [SCREENSHOT]
Readiness: failed-work-needs-review [SCREENSHOT]
Last result: hosted-connection-ready [SCREENSHOT]
Last successful Sync: Not recorded [SCREENSHOT]
Recovery guidance: review-local-sync-state-before-retry [SCREENSHOT]

Declaration scope: client-operation [SCREENSHOT]
Operation kind: ordinary-sync [SCREENSHOT]
Client result code: not-recorded [SCREENSHOT]
Server request: not aggregate success [SCREENSHOT]
Last proved phase: unknown [SCREENSHOT]
Configured deadline: 35000ms client [SCREENSHOT]
Deadline owner: client [SCREENSHOT]
Elapsed time/band: [MANUAL — not visible in the Sync overview card]

Operation fingerprint (sanitized/short): #not-recorded [SCREENSHOT]
Correlation fingerprint (sanitized/short): #not-observed [SCREENSHOT]

LOCAL QUEUE
-----------
Pending: 0 [SCREENSHOT]
Uploading: 0 [SCREENSHOT]
Failed: 2 [SCREENSHOT]
Unknown: 0 [SCREENSHOT]
Next Device sequence: 3 [SCREENSHOT]

FAILED/NOTAPPLIED CANDIDATE
---------------------------
Candidate present: YES [SCREENSHOT]
MKS code: MKS-REC-001 [SCREENSHOT]
Candidate member count: 2 [SCREENSHOT: actionable events sequences 1 and 2]
Sequence range: 1–2 [SCREENSHOT]
Inspection eligibility: eligible; exactly one current-device candidate
[SCREENSHOT]
Local mutation: none [SCREENSHOT]
Provider contact: not-started [SCREENSHOT]
Trusted response: not-received [SCREENSHOT]
Safe next action: hold for Gate 12.7 reconciliation; do not execute recovery
[SCREENSHOT]
Displayed Gate instruction: hold for Gate 12.7 reconciliation; do not execute
recovery [SCREENSHOT]

ACTION PERFORMED
----------------
Button/action: NONE — baseline record
Exact click count: 0
Action start time: not applicable
Action end time: not applicable
User cancellation/confirmation: not applicable
Unexpected UI behaviour: The “Current action result” is the earlier
failed/notApplied inspection, while “Last result” is hosted-connection-ready.
These appear to be different projections and must not be treated as one
operation.

POST-ACTION CLIENT RESULT
-------------------------
Title: not applicable — baseline record
Outcome class: not applicable
Result code: not applicable
Declaration scope: not applicable
Operation kind: not applicable
Last proved phase: not applicable
Local mutation: not applicable
Provider contact: not applicable
Trusted response: not applicable
Server outcome: not applicable
Configured deadline: not applicable
Elapsed time/band: not applicable
Operation fingerprint: not applicable
Correlation fingerprint: not applicable
Safe next action: Perform exactly one “Check hosted connection” control action
and capture the resulting UI plus the corresponding Render log window.

POST-ACTION QUEUE
-----------------
Pending: not applicable — baseline record
Uploading: not applicable
Failed: not applicable
Unknown: not applicable
Next Device sequence: not applicable
Queue changed: not applicable
Expected change: NO
Explanation: A hosted connection check should not mutate the local event queue.

RECENT CLOSURE ATTEMPT
----------------------
Attempt type: hosted-connection-check [SCREENSHOT]
Title/result: hosted-connection-ready [SCREENSHOT]
Outcome: completed / response-parsed / ready-does-not-prove-sync [SCREENSHOT]
Operation kind: [MANUAL — not explicitly shown in this attempt row]
Declaration scope: client-operation [SCREENSHOT]
Status: 200 [SCREENSHOT]
Headers received: YES [SCREENSHOT]
HTTP status: 200 [SCREENSHOT]
Configured deadline: deadline-not-applicable [SCREENSHOT]
Elapsed time/band: lt-1s [SCREENSHOT]
Operation fingerprint: #ac3b8b48 [SCREENSHOT]
Correlation fingerprint: 6656aba5 [SCREENSHOT]

SERVER/RENDER EVIDENCE
----------------------
Log window start/end (UTC): [MANUAL]
Request observed: [MANUAL — YES / NO]
Route class: [MANUAL]
HTTP method: [MANUAL]
HTTP status: [MANUAL]
Declaration scope: [MANUAL]
Operation kind: [MANUAL]
Result code: [MANUAL]
Elapsed band: [MANUAL]
Operation fingerprint: [MANUAL]
Correlation fingerprint: [MANUAL]
Database/transaction phase, if declared: [MANUAL]
Server terminal observed: [MANUAL — YES / NO]

Do the client/server fingerprints correspond: UNPROVED
Raw token, URL, database ID or account ID included: NO

PROJECTION CHECK
----------------
“Last successful Sync” before: Not recorded [SCREENSHOT]
“Last successful Sync” after: not applicable — baseline record
Should this action advance it: NO
Projection behaved correctly: not applicable — baseline record

SCREENSHOTS/LOG EXCERPTS
------------------------
Client screenshot filename:
- f56aa040-c3ca-4cd7-ae2c-de5399ad6bb0.png
- 9dc56de3-58d7-423a-a135-fe7ed16c868d.png
- 60773682-44b9-4fcd-8454-2c74557391fd.png
- 1170bc6b-d3a0-474a-b26b-5808516b2823.png
Render screenshot/excerpt filename: [MANUAL]
Other evidence: Pre-action UI shows two failed purchase.registered events,
sequences 1 and 2, with next Device sequence 3.

OBSERVATION
-----------
Expected: Stable authenticated/enrolled baseline; queue 0/0/2/0; recovery
candidate remains inspection-only; Last successful Sync remains Not recorded.
Observed: Baseline matches those expectations. The newest visible prior hosted
connection attempt completed with HTTP 200 in lt-1s, but does not prove Sync.
Difference: No baseline queue difference. The UI displays different kinds of
historical/current projections simultaneously, so fingerprints must be used
when associating evidence.
Current hypothesis: Hosted readiness has previously succeeded, while the
ordinary Sync/recovery defect remains unresolved. A fresh host check is a
projection and transport control, not a recovery test.
Next safe action: Press “Check hosted connection” exactly once and record the
newest Closure attempt. Do not press Sync, Retry, or recovery.
```

---

# RECORD 002 — POST–CHECK HOSTED CONNECTION

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-26-002-POST-HOST-CHECK
DATE/TIME (local): [MANUAL — action timestamp]
DATE/TIME (UTC, if available): [MANUAL]
TESTER: [MANUAL]
DEVICE/OS: Windows desktop [SCREENSHOT; exact Windows version MANUAL]
CLIENT BUILD OR COMMIT SHA: [MANUAL]
ENVIRONMENT: development / disposable / other [MANUAL]
ASSAY PURPOSE: Observe the client terminal and queue projection after exactly
one “Check hosted connection” action under the newly built client, while
ordinary Sync, Retry, recovery execution, and new submission creation remain
unauthorized.

SAFETY
------
Secrets copied into this file: NO
Tokens/passwords/connection strings copied: NO
Gate 12.7 state: HELD [CONTEXT]
Recovery execution authorized: NO [CONTEXT]
Ordinary Sync authorized: NO [CONTEXT]
New submission-bearing event authorized: NO [CONTEXT]

PRE-ACTION CLIENT STATE
-----------------------
Authentication: authenticated [SCREENSHOT]
Enrollment: device-enrolled [SCREENSHOT]
Readiness: failed-work-needs-review [SCREENSHOT]
Last result: hosted-connection-ready [SCREENSHOT]
Last successful Sync: Not recorded [SCREENSHOT]
Recovery guidance: review-local-sync-state-before-retry [SCREENSHOT]

Declaration scope: client-operation [SCREENSHOT]
Operation kind: ordinary-sync [SCREENSHOT]
Client result code: not-recorded [SCREENSHOT]
Server request: not aggregate success [SCREENSHOT]
Last proved phase: unknown [SCREENSHOT]
Configured deadline: 35000ms client [SCREENSHOT]
Deadline owner: client [SCREENSHOT]
Elapsed time/band: [MANUAL — not visible in the pre-action overview]

Operation fingerprint (sanitized/short): #not-recorded [SCREENSHOT]
Correlation fingerprint (sanitized/short): #not-observed [SCREENSHOT]

LOCAL QUEUE
-----------
Pending: 0 [SCREENSHOT]
Uploading: 0 [SCREENSHOT]
Failed: 2 [SCREENSHOT]
Unknown: 0 [SCREENSHOT]
Next Device sequence: 3 [SCREENSHOT]

FAILED/NOTAPPLIED CANDIDATE
---------------------------
Candidate present: YES [SCREENSHOT]
MKS code: MKS-REC-001 [SCREENSHOT]
Candidate member count: 2 [SCREENSHOT]
Sequence range: 1–2 [SCREENSHOT]
Inspection eligibility: eligible; exactly one current-device candidate
[SCREENSHOT]
Local mutation: none [SCREENSHOT]
Provider contact: not-started [SCREENSHOT]
Trusted response: not-received [SCREENSHOT]
Safe next action: hold for Gate 12.7 reconciliation; do not execute recovery
[SCREENSHOT]
Displayed Gate instruction: hold for Gate 12.7 reconciliation; do not execute
recovery [SCREENSHOT]

ACTION PERFORMED
----------------
Button/action: Check hosted connection [USER STATEMENT]
Exact click count: [MANUAL — expected 1; confirm]
Action start time: [MANUAL]
Action end time: [MANUAL]
User cancellation/confirmation: [MANUAL — none / describe]
Unexpected UI behaviour: YES. The page-level/Sync-overview “Last result”
changed to timeout-before-response, but the “Current action result” cards still
display the earlier MKS-REC-001 failed/notApplied preflight. The overview also
continues to display operation kind ordinary-sync and 35000ms client, while the
newest Closure-attempt row identifies hosted-connection-check with
deadline-not-applicable.

POST-ACTION CLIENT RESULT
-------------------------
Title: timeout-before-response [SCREENSHOT: page-level result]
Outcome class: unknown [SCREENSHOT: newest Closure attempt]
Result code: timeout-before-response [SCREENSHOT]
Declaration scope: client-operation [SCREENSHOT]
Operation kind: hosted-connection-check [SCREENSHOT: attempt type; the attempt
row does not show a separate operationKind field]
Last proved phase: transport-started [SCREENSHOT]
Local mutation: none expected; queue is unchanged [SCREENSHOT/INFERENCE]
Provider contact: request was started, but ingress is UNPROVED
Trusted response: not-received [SCREENSHOT: no headers/status observed]
Server outcome: unknown / not observed [SCREENSHOT]
Configured deadline: deadline-not-applicable in the Closure attempt row;
Sync-overview separately displays 35000ms client [SCREENSHOT]
Elapsed time/band: lt-30s [SCREENSHOT]
Operation fingerprint: #8d866e69 [SCREENSHOT]
Correlation fingerprint: 46fe8bf9 [SCREENSHOT]
Safe next action: Redeploy the latest server commit, capture its deployment SHA,
then repeat one bounded hosted-connection control with a matching Render log
window. Do not infer server failure from this client-only terminal.

POST-ACTION QUEUE
-----------------
Pending: 0 [SCREENSHOT]
Uploading: 0 [SCREENSHOT]
Failed: 2 [SCREENSHOT]
Unknown: 0 [SCREENSHOT]
Next Device sequence: 3 [SCREENSHOT]
Queue changed: NO [SCREENSHOT]
Expected change: NO
Explanation: A hosted connection check is not an event submission, Retry, Sync,
or recovery operation and should not mutate the local queue.

RECENT CLOSURE ATTEMPT
----------------------
Attempt type: hosted-connection-check [SCREENSHOT]
Title/result: timeout-before-response [SCREENSHOT]
Outcome: unknown / transport-started / retry-after-connection-review
[SCREENSHOT]
Operation kind: [MANUAL — no distinct operationKind value is shown in the row]
Declaration scope: client-operation [SCREENSHOT]
Status: not-observed [SCREENSHOT]
Headers received: NO [SCREENSHOT]
HTTP status: not observed [SCREENSHOT]
Configured deadline: deadline-not-applicable [SCREENSHOT]
Elapsed time/band: lt-30s [SCREENSHOT]
Operation fingerprint: #8d866e69 [SCREENSHOT]
Correlation fingerprint: 46fe8bf9 [SCREENSHOT]

SERVER/RENDER EVIDENCE
----------------------
Log window start/end (UTC): [MANUAL]
Request observed: [MANUAL — YES / NO]
Route class: [MANUAL]
HTTP method: [MANUAL]
HTTP status: [MANUAL]
Declaration scope: [MANUAL]
Operation kind: [MANUAL]
Result code: [MANUAL]
Elapsed band: [MANUAL]
Operation fingerprint: [MANUAL]
Correlation fingerprint: [MANUAL]
Database/transaction phase, if declared: [MANUAL]
Server terminal observed: [MANUAL — YES / NO]

Do the client/server fingerprints correspond: UNPROVED
Raw token, URL, database ID or account ID included: NO

PROJECTION CHECK
----------------
“Last successful Sync” before: Not recorded [SCREENSHOT]
“Last successful Sync” after: Not recorded [SCREENSHOT]
Should this action advance it: NO
Projection behaved correctly: YES [SCREENSHOT]

SCREENSHOTS/LOG EXCERPTS
------------------------
Client screenshot filename:
- e99b103a-631b-4e33-800c-3909b8c17468.png
- c8535550-1a58-4bfb-9283-09511bfaf85c.png
- 0b690a5e-690a-4f22-a1a1-fafb8baf6294.png
- 09176bf7-44e9-43f1-8980-6c58e386744c.png
Render screenshot/excerpt filename: [MANUAL]
Other evidence: The post-action recent-attempt list places
hosted-connection-check timeout-before-response #8d866e69 above the prior
hosted-connection-ready #ac3b8b48.

OBSERVATION
-----------
Expected: One hosted readiness request should either return a bounded readiness
terminal or provide matching client/server evidence; it must not advance Last
successful Sync or mutate the queue.
Observed: The client reports hosted-connection-check timeout-before-response,
transport-started, status not-observed, headers not-received, lt-30s. Last
successful Sync remains Not recorded and the queue remains 0/0/2/0 with next
sequence 3. No matching server evidence was supplied.
Difference: Readiness did not complete on this attempt despite earlier
hosted-connection-ready results. The UI’s page-level result and newest attempt
changed, but the Current action result cards retained the earlier recovery
inspection. The overview’s ordinary-sync/35000ms fields cannot safely be
attributed to the hosted-connection-check row.
Current hypothesis: The client began transport but did not receive trusted
response headers. Possible boundaries include an outdated/not-yet-redeployed
server, service wake-up, client-to-host transport, proxy response delivery, or
request ingress/handling. Without a matching Render window, server ingress and
the new server self-declaration behavior remain unproved. This assay does not
exercise ordinary Sync’s 35-second terminal contract or any submission path.
Next safe action: Complete deployment of the latest intended server commit and
record the deployed SHA/time. Then capture a narrow Render log window while
performing exactly one hosted-connection check. Compare the sanitized
correlation fingerprint if the server emits one. Keep Gate 12.7 held and do not
press Recover failed/notApplied candidate.
```

---

# MANUAL COMPLETION CHECKLIST FOR RECORDS 001–002

Fill these fields manually because they are not established by the screenshots:

- exact local date/time and UTC time;
- tester;
- exact Windows version/device label;
- client build or immutable commit SHA;
- environment classification;
- confirmation that the action was exactly one click;
- action start and end times;
- whether any cancellation or confirmation dialog appeared;
- deployed Render commit SHA and deployment completion time;
- Render log-window start and end in UTC;
- whether the request appeared in Render;
- server route class, method, HTTP status, declaration scope, operation kind,
  result code, elapsed band, and sanitized fingerprints;
- database/transaction phase, only if the server explicitly declares it;
- whether a server terminal was observed;
- Render screenshot or excerpt filename.

Do not fill a missing server field by copying its client-side counterpart.

---

# RECORD 003 — POST-DEPLOYMENT HOSTED-CONNECTION CONTROL

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-003
DATE/TIME (local): 2026-07-26, exact time [MANUAL]
DATE/TIME (UTC, if available): [MANUAL]
TESTER: [MANUAL]
DEVICE/OS: Windows, exact version [MANUAL]
CLIENT BUILD OR COMMIT SHA: [MANUAL]
ENVIRONMENT: development/disposable [CONTEXT; confirm manually]
ASSAY PURPOSE: Post-deployment hosted-readiness control; verify the client can
receive a trusted hosted response without mutating Sync state.

DEPLOYMENT BASELINE
-------------------
Deployed commit: 27e1b77 [USER-SUPPLIED]
Deployment start UTC: [MANUAL]
Deployment live UTC: [MANUAL]
Render deploy status: Ready [USER-SUPPLIED]
Startup/health result: Live [USER-SUPPLIED]

UTC means Coordinated Universal Time. On 2026-07-26, São Paulo local time is
UTC-03:00, so add three hours to a São Paulo timestamp to record UTC.

SAFETY
------
Secrets copied into this file: NO
Tokens/passwords/connection strings copied: NO
Gate 12.7 state: HELD [CONTEXT]
Recovery execution authorized: NO [CONTEXT]
Ordinary Sync authorized: NO for this readiness-only assay [CONTEXT]
New submission-bearing event authorized: NO [CONTEXT]

PRE-ACTION CLIENT STATE
-----------------------
Authentication: authenticated [SCREENSHOT]
Enrollment: device-enrolled [SCREENSHOT]
Readiness: failed-work-needs-review [SCREENSHOT: overview projection]
Last result: hosted-connection-ready [SCREENSHOT: post-action projection]
Last successful Sync: Not recorded [SCREENSHOT]
Recovery guidance: review-local-sync-state-before-retry [SCREENSHOT]

Declaration scope: client-operation [SCREENSHOT: recent attempt]
Operation kind: ordinary-sync [SCREENSHOT: overview; not attributable to the
hosted-connection attempt]
Client result code: not-recorded [SCREENSHOT: overview]
Server request: not aggregate success [SCREENSHOT: overview]
Last proved phase: unknown [SCREENSHOT: overview]
Configured deadline: 35000ms client [SCREENSHOT: ordinary-Sync overview]
Deadline owner: client [SCREENSHOT: hosted attempt]
Elapsed time/band: lt-1s [SCREENSHOT: successful hosted attempt]

Operation fingerprint (sanitized/short): #d6b1d265 [SCREENSHOT: newest
successful hosted attempt]
Correlation fingerprint (sanitized/short): e78680f2 [SCREENSHOT]

LOCAL QUEUE
-----------
Pending: 0 [SCREENSHOT]
Uploading: 0 [SCREENSHOT]
Failed: 2 [SCREENSHOT]
Unknown: 0 [SCREENSHOT]
Next Device sequence: 3 [SCREENSHOT]

FAILED/NOTAPPLIED CANDIDATE
---------------------------
Candidate present: YES [SCREENSHOT]
MKS code: MKS-REC-001 [SCREENSHOT]
Candidate member count: 2 [SCREENSHOT/CONTEXT]
Sequence range: 1–2 [SCREENSHOT/CONTEXT]
Inspection eligibility: eligible [SCREENSHOT]
Local mutation: none [SCREENSHOT]
Provider contact: not-started [SCREENSHOT]
Trusted response: not-received [SCREENSHOT]
Safe next action: hold; reconcile Gate 12.7 before recovery execution
[SCREENSHOT]
Displayed Gate instruction: hold for Gate 12.7 reconciliation; do not execute
recovery [SCREENSHOT]

ACTION PERFORMED
----------------
Button/action: Check hosted connection [USER-SUPPLIED]
Exact click count: 1 [MANUAL CONFIRMATION]
Action start time: [MANUAL]
Action end time: [MANUAL]
User cancellation/confirmation: [MANUAL]
Unexpected UI behaviour: Current action result continued to display the prior
MKS-REC-001 inspection rather than the newest hosted-check declaration
[SCREENSHOT]

POST-ACTION CLIENT RESULT
-------------------------
Title: hosted-connection-ready [SCREENSHOT: page and newest attempt]
Outcome class: completed [SCREENSHOT]
Result code: hosted-connection-ready [SCREENSHOT]
Declaration scope: client-operation [SCREENSHOT]
Operation kind: hosted-connection-check [SCREENSHOT: attempt type]
Last proved phase: response-parsed [SCREENSHOT]
Local mutation: none expected; queue unchanged [SCREENSHOT/INFERENCE]
Provider contact: completed request/response path [SCREENSHOT]
Trusted response: received; headers received [SCREENSHOT]
Server outcome: readiness HTTP response observed; aggregate Sync outcome not
established
Configured deadline: not-applicable for hosted check [SCREENSHOT]
Elapsed time/band: lt-1s [SCREENSHOT]
Operation fingerprint: #d6b1d265 [SCREENSHOT]
Correlation fingerprint: e78680f2 [SCREENSHOT]
Safe next action: Preserve the corresponding Render log window, then perform
one separately authorized ordinary-Sync control with pending=0.

POST-ACTION QUEUE
-----------------
Pending: 0 [SCREENSHOT]
Uploading: 0 [SCREENSHOT]
Failed: 2 [SCREENSHOT]
Unknown: 0 [SCREENSHOT]
Next Device sequence: 3 [SCREENSHOT]
Queue changed: NO [SCREENSHOT]
Expected change: NO
Explanation: Hosted readiness is not ordinary Sync, submission Retry, or
failed/notApplied recovery.

RECENT CLOSURE ATTEMPT
----------------------
Attempt type: hosted-connection-check [SCREENSHOT]
Title/result: hosted-connection-ready [SCREENSHOT]
Outcome: completed / response-parsed / ready-does-not-prove-sync [SCREENSHOT]
Operation kind: hosted-connection-check [DERIVED FROM ATTEMPT TYPE]
Declaration scope: client-operation [SCREENSHOT]
Status: 200 [SCREENSHOT]
Headers received: YES [SCREENSHOT]
HTTP status: 200 [SCREENSHOT]
Configured deadline: deadline-not-applicable [SCREENSHOT]
Elapsed time/band: lt-1s [SCREENSHOT]
Operation fingerprint: #d6b1d265 [SCREENSHOT]
Correlation fingerprint: e78680f2 [SCREENSHOT]

SERVER/RENDER EVIDENCE
----------------------
Log window start/end (UTC): [MANUAL]
Request observed: UNPROVED — no Render request log supplied
Route class: [MANUAL]
HTTP method: [MANUAL]
HTTP status: [MANUAL]
Declaration scope: [MANUAL]
Operation kind: [MANUAL]
Result code: [MANUAL]
Elapsed band: [MANUAL]
Operation fingerprint: [MANUAL]
Correlation fingerprint: [MANUAL]
Database/transaction phase, if declared: [MANUAL]
Server terminal observed: UNPROVED

Do the client/server fingerprints correspond: UNPROVED
Raw token, URL, database ID or account ID included: NO

PROJECTION CHECK
----------------
“Last successful Sync” before: Not recorded [CONTEXT/SCREENSHOT]
“Last successful Sync” after: Not recorded [SCREENSHOT]
Should this action advance it: NO
Projection behaved correctly: YES [SCREENSHOT]

SCREENSHOTS/LOG EXCERPTS
------------------------
Client screenshot filename:
- 798829b6-ab4b-49c7-ae86-4a5e80c49d3e.png
- 9f38dbac-9bdc-434d-94e8-52b2ef540405.png
- b82646ec-2980-4002-a924-06ad5250e460.png
- 99589f76-ba10-4621-868a-745f9711b1a8.png
Render screenshot/excerpt filename: [MANUAL]
Other evidence: The newest displayed hosted check is ready #d6b1d265. The
history also preserves earlier alternating ready and timeout outcomes. The
Current action result remains MKS-REC-001 operation #6b1cadb76e99, which is a
separate local recovery inspection.

OBSERVATION
-----------
Expected: A post-deployment hosted check returns a bounded readiness result,
does not mutate the queue, and does not advance Last successful Sync.
Observed: hosted-connection-ready; HTTP 200; headers received; response parsed;
lt-1s. Queue remains pending/uploading/failed/unknown=0/0/2/0, next sequence=3.
Last successful Sync remains Not recorded.
Difference: No readiness-contract defect is visible in this attempt. Server-log
correlation is still unavailable, and the Current action result panel remains
focused on the older MKS-REC-001 inspection instead of the newest action.
Current hypothesis: Basic post-deployment readiness transport is healthy. The
remaining Sync failure is therefore more likely inside an ordinary-Sync-specific
boundary—request construction, authorization/enrollment contract, Sync route,
database/transaction work, response delivery for that route, or client terminal
projection—than in generic host availability. Intermittent historical readiness
timeouts remain relevant but were not reproduced in this assay.
Next safe action: Capture the Render log window for this request if retained.
Then run one ordinary-Sync control with pending=0, preserving both client UI and
server terminal output. Do not recover the failed candidate yet.
```

---

# DIFFERENTIAL CONCLUSIONS AFTER RECORD 003

| Question | Evidence status | Current conclusion |
| --- | --- | --- |
| Is the deployed service live? | Supported by user-supplied Ready/Live status and client HTTP 200 | Yes for readiness at this assay time |
| Can the Windows client receive a hosted response? | Supported by headers received, HTTP 200, response-parsed, lt-1s | Yes for the readiness route |
| Does readiness prove ordinary Sync? | Explicit UI warning: ready-does-not-prove-sync | No |
| Did readiness mutate the queue? | Queue remained 0/0/2/0; next sequence 3 | No |
| Did readiness falsely advance Last successful Sync? | It remained Not recorded | No; projection correction behaved correctly |
| Did the new server declaration appear in Render logs? | No server log supplied | UNPROVED |
| Is the 35-second ordinary-Sync contract validated live? | No ordinary Sync performed in this record | No |
| Was submission/upload tested? | pending=0; hosted check only | No |
| Was failed/notApplied recovery tested? | Current cards show inspection only; provider contact not-started | No |
| Is Retry unknown-outcome applicable? | unknown=0 | No |

## Proposed next assays

### Assay 004 — ordinary-Sync control, empty pending queue

Purpose: exercise the actual Sync route, 35-second client deadline, terminal
mapping, and client/server correlation without uploading a new event.

Preconditions:

- deployment remains `27e1b77` or a documented descendant;
- pending/uploading/unknown remain `0/0/0`;
- failed remains `2`, next sequence remains `3`;
- one narrow Render log window is open;
- failed/notApplied recovery remains held.

Action:

1. Press Refresh diagnostics once and record the baseline.
2. Press Sync exactly once.
3. Do not press any other Closure action while it is in progress.
4. Capture the UI terminal and matching Render lines.
5. Refresh diagnostics once and record the post-state.

Most useful outcomes:

- `sync-no-new-events` plus matching server terminal: Sync transport and
  correlation work; submission remains untested.
- `sync-completed` plus matching server terminal: route completed; verify why
  completion rather than no-new-events was selected.
- `sync-rejected`: inspect the matching server declaration for auth,
  enrollment, authorization, or request-contract boundary.
- `sync-failed` with no Render ingress: investigate client transport/routing.
- `sync-failed` with server start but no terminal: investigate server handler,
  auth verification, Neon acquisition, or database execution.
- `sync-failed` while the server completed: investigate proxy/response delivery
  or client response handling.

### Assay 005 — one new bounded submission

Purpose: test an actual submit/upload request independently of the historical
failed/notApplied recovery candidate.

Run only after Assay 004 is reconciled. Create exactly one harmless development
purchase/event so it receives the next local sequence, confirm `pending=1`,
then press Sync exactly once and capture UI plus Render declarations. Record
whether the event becomes completed, failed, or unknown and whether next
sequence advances only as expected.

Do not repurpose sequences 1–2 for this assay. They belong to the separately
held recovery path.

### Recovery-button classification

| Button | Use now? | Reason |
| --- | --- | --- |
| Refresh diagnostics | Yes | Read-only state snapshot; useful before and after each assay |
| Check hosted connection | No immediate repeat needed | REC-003 already passed post-deployment readiness |
| Sync | Next controlled assay | Exercises ordinary-Sync route and 35-second contract |
| Retry unknown-outcome submission | No | Unknown queue count is zero |
| Inspect failed/notApplied recovery | Optional read-only confirmation | Already produced an eligible candidate; repetition adds little unless state changes |
| Recover failed/notApplied candidate | No | Mutating recovery remains held for Gate 12.7 reconciliation |
| Clear diagnostic history | No | Would erase differential evidence |

---

# OBSERVABILITY REQUIREMENT FOR A FOLLOW-UP IMPLEMENTATION

The next diagnostic implementation should make one assay visible in three
coherent places without exposing secrets:

1. Client terminal: structured start, phase transition, trusted-response,
   exception/deadline, and terminal declarations.
2. Closure UI: sanitized durable summary for the same client operation.
3. Render terminal: structured request-ingress, authorization, database phase,
   response, and terminal declarations.

Every declaration should preserve the same sanitized correlation lineage where
available, plus:

- declaration scope;
- operation kind;
- result code;
- last proved phase;
- configured deadline and owner;
- elapsed duration/band;
- HTTP status and headers-received state where applicable;
- trusted-response and server-outcome state;
- safe next action.

Never log tokens, authorization headers, cookies, connection strings, complete
private URLs, account/device identifiers, request bodies, or purchase data.
Client terminal silence during a Closure action should be treated as an
observability defect even when the UI records a result.

---

# APPENDIX A — ERR-04 CORRECTED-REVISION CLIENT CONTROL PACKET

This appendix is append-only. It preserves Records 001–003 and their earlier
hypotheses unchanged while adding the later corrected-revision observations.
Where an earlier record describes queue `0/0/2/0`, `Last successful Sync: Not
recorded`, deployment `27e1b77`, or recovery still being held, that statement
remains valid for that earlier assay time. It must not be silently projected
onto the later packet below.

Formal hierarchy at the time of this packet:

```text
Cycle 10
└─ GCM-02
   └─ Step 12
      └─ Gate 12.7 — corrected-revision hosted acceptance under observation
```

Relevant corrected lineage established before these UI assays:

```text
a5d198da  ERR-04 J + D/E/F staging
↓
bb4e5796  ERR-04 corrective implementation and G/H/I replacement
↓
cf405347  ERR-04 implementation reconciliation in J
```

The screenshots establish client-side UI evidence only. No Render log excerpt,
provider-row query, or second-device observation was supplied in this packet.
Client/server pairing and provider-state conclusions therefore remain outside
the evidence boundary unless stated otherwise.

## RECORD 004 — UNTOUCHED BASELINE AND NARROW DIAGNOSTIC CONTROLS

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-26-004-BASELINE-DIAGNOSTIC-CONTROLS
DATE/TIME (local): 2026-07-26, exact time [MANUAL]
DATE/TIME (UTC, if available): [MANUAL]
TESTER: [MANUAL]
DEVICE/OS: Windows desktop [SCREENSHOT; exact version MANUAL]
CLIENT BUILD OR COMMIT SHA: cf405347 lineage [CONTEXT; exact executable SHA
confirmation MANUAL]
ENVIRONMENT: development/disposable [CONTEXT; confirm manually]
ASSAY PURPOSE: Compare the untouched corrected-revision state with the
projections produced by Refresh diagnostics, Status, and Query, without
executing readiness, ordinary Sync, Retry, or recovery.

ACTION SEQUENCE
---------------
Situation 1: untouched baseline
Situation 2: Refresh diagnostics
Situation 3: Status
Situation 4: Query
Exact click count: one for each named action [USER STATEMENT]

OBSERVED INVARIANTS
-------------------
Authentication: authenticated [SCREENSHOT]
Enrollment: device-enrolled [SCREENSHOT]
Pending: 0 [SCREENSHOT]
Uploading: 0 [SCREENSHOT]
Failed: 0 [SCREENSHOT]
Unknown: 0 [SCREENSHOT]
Next Device sequence: 3 [SCREENSHOT]
Last successful Sync: 2026-07-26T22:50:27.000Z [SCREENSHOT]
Queue changed across the packet: NO [SCREENSHOT]
Next Device sequence changed across the packet: NO [SCREENSHOT]
Last successful Sync changed across the packet: NO [SCREENSHOT]

ACTION-SPECIFIC PROJECTION
--------------------------
Refresh diagnostics: Re-projected the durable Closure state without visible
queue, sequence, or successful-Sync mutation [SCREENSHOT].
Status: Returned/projected the authenticated state [SCREENSHOT].
Query: Returned/projected device-enrolled and became the latest page-level
action/result [SCREENSHOT].
Sync executed: NO.
Hosted readiness executed: NO.
Retry or failed/notApplied recovery executed: NO.

OBSERVATION
-----------
Expected: All three narrow controls remain non-Sync diagnostic operations and
do not allocate a Device sequence or change the local event queue.
Observed: Queue remained 0/0/0/0, Next Device sequence remained 3, and Last
successful Sync remained 2026-07-26T22:50:27.000Z. Status and Query returned
the already-established authenticated/enrolled state.
Difference: No state-transition defect is visible. The practical difference
between the three buttons is mostly how narrowly they refresh or project
diagnostic information.
Current hypothesis: Refresh diagnostics remains useful as a durable local
reprojection. Status and Query remain functionally distinguishable, but in an
already authenticated and enrolled steady state they provide little additional
user value as separate top-level controls. The screenshots alone do not prove
whether Status and Query have identical provider-contact, cache, or failure
behavior.
Next safe action at the time: Run one separately identified hosted-readiness
control, then—only if coherent—one ordinary Sync control.
```

### Prospective control-panel conclusion after Record 004

The UI may consolidate **Status**, **Query**, and **Refresh diagnostics** into
one **Diagnostics** action, provided the resulting view preserves three
separately labelled subresults:

1. authentication state;
2. enrollment/binding state;
3. refreshed durable queue and diagnostic history.

This is a design recommendation, not yet an implementation authorization.
During development, the underlying operations should remain separately
addressable in code and tests so that a failure in one subcheck does not become
an ambiguous aggregate “Diagnostics failed” result.

The proposed **Diagnostics** action must not:

- execute ordinary Sync;
- perform failed/notApplied recovery;
- retry an unknown-outcome submission;
- allocate a Device event sequence;
- advance Last successful Sync;
- silently convert a local refresh into a hosted-readiness claim.

`Check hosted connection` and `Sync` should remain distinct from Diagnostics.
The first tests hosted readiness; the second runs the synchronization protocol.
Combining either with the three narrow diagnostic controls would erase a useful
operational and authorization boundary.

## RECORD 005 — COLD/WARM HOSTED-CONNECTION DIFFERENTIAL

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-26-005-COLD-WARM-HOSTED-CHECK
DATE/TIME (local): 2026-07-26, exact times [MANUAL]
DATE/TIME (UTC, if available): [MANUAL]
TESTER: [MANUAL]
DEVICE/OS: Windows desktop [SCREENSHOT; exact version MANUAL]
CLIENT BUILD OR COMMIT SHA: cf405347 lineage [CONTEXT; exact executable SHA
confirmation MANUAL]
ENVIRONMENT: development/disposable [CONTEXT; confirm manually]
ASSAY PURPOSE: Compare two subsequent Check hosted connection attempts across
a cold/wake-up boundary and an immediately warm/redeployed service state.

ACTION PERFORMED
----------------
Button/action: Check hosted connection
Attempt count: 2 [USER STATEMENT]
Attempt 1 condition: Render cold state [USER STATEMENT]
Attempt 2 condition: immediately after attempt 1 and a Render redeployment;
service warm [USER STATEMENT]

ATTEMPT 1 — COLD/WAKING SERVICE
-------------------------------
Attempt type: hosted-connection-check [SCREENSHOT]
Title/result: timeout-before-response [SCREENSHOT]
Outcome class: unknown [SCREENSHOT]
Last proved phase: transport-started [SCREENSHOT]
Recovery guidance: retry-after-connection-review [SCREENSHOT]
HTTP status: not applicable — see child requests [SCREENSHOT]
Headers: not applicable — see child requests [SCREENSHOT]
Configured deadline: deadline-not-applicable [SCREENSHOT]
Elapsed band: lt-30s [SCREENSHOT]
Operation fingerprint: #e147f127 [SCREENSHOT]
Correlation fingerprint: b308047a [SCREENSHOT]

ATTEMPT 2 — WARM SERVICE
------------------------
Attempt type: hosted-connection-check [SCREENSHOT]
Title/result: hosted-connection-ready [SCREENSHOT]
Outcome: completed / response-parsed / ready-does-not-prove-sync [SCREENSHOT]
HTTP status: 200 [SCREENSHOT]
Headers received: YES [SCREENSHOT]
Configured deadline: deadline-not-applicable [SCREENSHOT]
Elapsed band: lt-1s [SCREENSHOT]
Operation fingerprint: #ba47e661 [SCREENSHOT]
Correlation fingerprint: dc6bda5c [SCREENSHOT]

POST-ACTION STATE
-----------------
Queue mutation attributable to hosted readiness: none visible [SCREENSHOT]
Device-sequence allocation attributable to hosted readiness: none visible
[SCREENSHOT]
Ordinary Sync success proved by readiness: NO
Matching Render request declarations supplied: NO

OBSERVATION
-----------
Expected: A warm hosted service should return the readiness contract without
mutating Sync state. A sleeping service may expose a wake-up latency risk.
Observed: The first cold-state attempt timed out before a response. The
immediately subsequent warm-state attempt completed with headers, HTTP 200,
response parsing, and an lt-1s elapsed band.
Difference: Hosted readiness is healthy once the deployment is warm, but the
current assay does not demonstrate that the configured client timing tolerates
the complete Render cold-start path.
Current hypothesis: The timing configuration is sufficient for a warm service.
The cold failure is consistent with service wake-up/deployment readiness
latency, although client/Render correlation is required to distinguish “request
never reached the service” from “service started but answered after the client
stopped waiting.”
Next safe action at the time: With the service warm, run one ordinary Sync
control and separate its aggregate client result from its child requests.
```

### Record 005 conclusion

The evidence supports:

- warm hosted connection: **PASS at this assay time**;
- generic hosted availability: **supported while warm**;
- cold-start tolerance: **not proved**;
- ordinary Sync: **not proved by this record**;
- server-side ingress and terminal correlation: **unproved without Render
  logs**.

It would be inaccurate to conclude that hosted readiness is unconditionally
reliable merely because the second attempt passed. The more precise conclusion
is that it works correctly under the observed warm timing state, while the cold
boundary still deserves explicit product handling or a longer/wake-aware
readiness contract.

## RECORD 006 — CORRECTED-REVISION ORDINARY SYNC CONTROL

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-26-006-ORDINARY-SYNC-CONTROL
DATE/TIME (local): 2026-07-26 approximately 22:30 [SCREENSHOT; exact seconds
MANUAL]
DATE/TIME (UTC, if available): successful-Sync projection
2026-07-27T01:29:48.000Z [SCREENSHOT]
TESTER: [MANUAL]
DEVICE/OS: Windows desktop [SCREENSHOT; exact version MANUAL]
CLIENT BUILD OR COMMIT SHA: cf405347 lineage [CONTEXT; exact executable SHA
confirmation MANUAL]
ENVIRONMENT: development/disposable [CONTEXT; confirm manually]
ASSAY PURPOSE: Exercise ordinary Sync after ERR-04 while the local actionable
queue is empty, checking terminal outcome, queue/sequence invariants, scope-aware
diagnostics, and absence of implicit failed/notApplied recovery.

PRE-ACTION CLIENT STATE
-----------------------
Authentication: authenticated [SCREENSHOT]
Enrollment: device-enrolled [SCREENSHOT]
Pending: 0 [SCREENSHOT]
Uploading: 0 [SCREENSHOT]
Failed: 0 [SCREENSHOT]
Unknown: 0 [SCREENSHOT]
Next Device sequence: 3 [SCREENSHOT]
Last successful Sync: 2026-07-26T22:50:27.000Z [CONTEXT/PRIOR SCREENSHOT]

ACTION PERFORMED
----------------
Button/action: Sync [USER STATEMENT]
Exact click count: 1 [USER STATEMENT]
Retry/recovery button used: NO [CONTEXT]
New local submission-bearing event created: NO [CONTEXT/SCREENSHOT]

POST-ACTION CLIENT RESULT
-------------------------
Page result: sync-completed [SCREENSHOT]
MKS code: MKS-OBS-001 [SCREENSHOT]
Diagnostic title: Observation diagnostic 001 [SCREENSHOT]
Outcome: applied [SCREENSHOT]
Last proved phase: terminal [SCREENSHOT]
Local mutation for terminal observation: none [SCREENSHOT]
Provider contact for terminal observation: not-started [SCREENSHOT]
Trusted response for terminal observation: see-causal-event [SCREENSHOT]
Operation fingerprint: #d723c1f392f3 [SCREENSHOT]

SYNC OVERVIEW
-------------
Authentication: authenticated [SCREENSHOT]
Enrollment: device-enrolled [SCREENSHOT]
Readiness: ready-no-local-work [SCREENSHOT]
Last result: sync-completed [SCREENSHOT]
Last successful Sync: 2026-07-27T01:29:48.000Z [SCREENSHOT]
Recovery guidance: no-local-sync-action-needed [SCREENSHOT]
Declaration scope: client-operation [SCREENSHOT]
Operation kind: ordinary-sync [SCREENSHOT]
Client result code: sync-completed [SCREENSHOT]
Server request: not aggregate success [SCREENSHOT]
Last proved phase: terminal [SCREENSHOT]
Configured deadline: 35000ms client [SCREENSHOT]
Operation fingerprint: #d723c1f392f3 [SCREENSHOT]
Client child correlation: #2575218c1dbf [SCREENSHOT]

POST-ACTION QUEUE
-----------------
Pending: 0 [SCREENSHOT]
Uploading: 0 [SCREENSHOT]
Failed: 0 [SCREENSHOT]
Unknown: 0 [SCREENSHOT]
Next Device sequence: 3 [SCREENSHOT]
Queue changed: NO [SCREENSHOT]
Expected queue change: NO, because there was no local work
Next Device sequence changed: NO [SCREENSHOT]
Expected sequence change: NO, because Sync did not create a new local event

NEWEST RECENT CLOSURE ATTEMPT
-----------------------------
Attempt type: ordinary-sync [SCREENSHOT]
Title/result: sync-completed [SCREENSHOT]
Attempt fingerprint: #54f7d032 [SCREENSHOT]
Outcome: completed / completed / no-recovery-code [SCREENSHOT]
Declaration scope: client-operation [SCREENSHOT]
Configured deadline: 35000ms [SCREENSHOT]
Correlation/parent operation: d723c1f392f3 [SCREENSHOT]
Aggregate HTTP status: not applicable — see child requests [SCREENSHOT]
Aggregate response headers: not applicable — see child requests [SCREENSHOT]
Elapsed duration: 2000ms [SCREENSHOT]

ACTIONABLE EVENTS
-----------------
Result: No pending, failed or unknown events [SCREENSHOT]

DEVICES
-------
Current Device fingerprint: #a43532d0 [SCREENSHOT]
Enrollment: device-enrolled [SCREENSHOT]
Next Device sequence: 3 [SCREENSHOT]

SERVER/RENDER EVIDENCE
----------------------
Log window start/end (UTC): [MANUAL]
Request observed: UNPROVED — no Render excerpt supplied
Client-child/server-request fingerprint pairing: UNPROVED
Provider-row contents: UNPROVED
Second-device convergence: UNPROVED
Raw token, URL, database ID or account ID included here: NO

PROJECTION CHECK
----------------
“Last successful Sync” before: 2026-07-26T22:50:27.000Z
“Last successful Sync” after: 2026-07-27T01:29:48.000Z
Should this action advance it: YES, for a completed ordinary Sync
Projection behaved correctly: YES [SCREENSHOT]

SCREENSHOTS/LOG EXCERPTS
------------------------
Client screenshot filenames:
- 8db2ca55-9462-410b-aa5b-6fc4b477874c.png
- e0c1c136-6bec-4c7f-ac32-670ad90c77c1.png
- aad77634-1d68-454a-9cc2-4c6dc68a86cd.png
- d9a1c4fe-f42b-4f87-bac7-e1a9c735647f.png
- 0179098a-de74-433b-8abb-24bb75a146ff.png
- 735a32ba-8dcc-41a4-aa8b-39d0c432bdb1.png
- be480c07-3db7-4012-8698-2e37f9e7d8be.png
- c427963c-b44c-4294-9ac2-8583bf66011f.png
Render screenshot/excerpt filename: [MANUAL]

OBSERVATION
-----------
Expected: Ordinary Sync completes without invoking failed/notApplied recovery,
leaves an empty local queue empty, preserves Next Device sequence 3, advances
Last successful Sync, and retains a client-owned 35000ms deadline.
Observed: sync-completed; terminal client-operation; ready-no-local-work; queue
0/0/0/0; Next Device sequence 3; Last successful Sync advanced to
2026-07-27T01:29:48.000Z; configured deadline remained 35000ms; no actionable
events remained.
Difference: No client-UI defect is visible in the corrected ordinary-Sync
control. Aggregate HTTP evidence is correctly delegated to child requests, but
the corresponding Render packet was not supplied, so cross-host correlation is
not proved here.
Current hypothesis: The corrected ordinary-Sync path completed successfully
with no new local work. The ERR-04 recovery boundary appears respected in this
operation because the `d723c1f392f3` timeline contains no failed-recovery
phase. Provider contact occurred in causal child phases; the terminal
MKS-OBS-001 card’s `provider contact: not-started` describes that observation
event itself and must not be misread as “the entire Sync made no requests.”
Next safe action: Reconcile this client packet with the narrow Render log window
for operation/child correlation if available. Keep provider-row and
second-device claims unproved until their own evidence is collected.
```

## THREE-SITUATION DIFFERENTIAL

| Same property | Situation 1 — untouched baseline | Situation 2 — diagnostic/readiness controls | Situation 3 — ordinary Sync |
| --- | --- | --- | --- |
| Purpose | Observe durable state without action | Reproject state and test hosted readiness | Execute the ordinary synchronization coordinator |
| Buttons represented | None | Refresh diagnostics; Status; Query; Check hosted connection | Sync |
| Authentication | authenticated | authenticated | authenticated |
| Enrollment | device-enrolled | device-enrolled | device-enrolled |
| Queue | 0 pending / 0 uploading / 0 failed / 0 unknown | Remained 0/0/0/0 | Remained 0/0/0/0 |
| Next Device sequence | 3 | Remained 3 | Remained 3 |
| Last successful Sync | 2026-07-26T22:50:27.000Z | Did not advance | Advanced to 2026-07-27T01:29:48.000Z |
| Hosted contact | None attributable to untouched view | Cold attempt timed out; warm attempt ready, HTTP 200, headers received, lt-1s | Child request phases occurred; aggregate row correctly owns no HTTP status |
| Aggregate result | Existing persisted state | hosted-connection-ready on warm attempt; readiness does not prove Sync | sync-completed |
| Recovery execution | None | None | None visible in the new operation timeline |
| New local event allocation | None | None | None |
| Evidence ceiling | Client durable projection | Warm readiness works; cold tolerance and server correlation remain unproved | Corrected single-client ordinary Sync works in UI; provider contents and second-device convergence remain unproved |
| Practical UI conclusion | Stable baseline | Status/Query/Refresh may share one Diagnostics surface; readiness remains separate | Sync must remain a separately authorized action |

## WHY NEXT DEVICE SEQUENCE REMAINED 3

`Next Device sequence` is an allocator for the next **new local event created by
this Device**. It is not:

- a count of Sync button presses;
- a count of network requests;
- a count of diagnostic timeline rows;
- a remote cursor;
- an acknowledgement counter;
- an indicator that a replayed or downloaded event was newly allocated.

The observed Sync began with no pending, uploading, failed, or unknown local
events. It authenticated, verified binding, found no local work to upload,
processed the download/acknowledgement path, and completed. None of those steps
creates a new local event. Therefore the correct invariant is:

```text
before Sync: next Device sequence = 3
new local events created by Sync: 0
after Sync: next Device sequence = 3
```

The value should become `4` only after the current Device creates the local
event that consumes sequence `3`. A successful Sync by itself must not advance
it.

## WHY THE TIMELINE APPEARS TO SHOW “13 ERR”

The supplied screenshots do **not** show thirteen independent errors for the
new operation. They show thirteen numbered lifecycle diagnostic declarations
for operation `#d723c1f392f3`, displayed newest-first.

The current operation’s visible sequence is composed of causal phase records:

| Timeline range | Diagnostic family | Meaning |
| --- | --- | --- |
| 1–2 | `MKS-AUT-001` | authentication pre-state and applied result |
| 3–4 | `MKS-BND-001` | binding pre-state and applied result |
| 5–6 | `MKS-QUE-001` | upload-lease inspection and no-work/applied result |
| 7–9 | `MKS-TRN-001` / `MKS-DNL-001` | download request, trusted provider result, and local application |
| 10–11 | `MKS-ACK-001` | acknowledgement request and duplicate-equivalent/applied result |
| 12–13 | `MKS-OBS-001` | terminal observation before and after causal inspection |

Several rows say `unknown` because they are **pre-result phase declarations**:
the operation has started that phase but has not yet received or classified its
trusted result. Their paired later rows say `applied` or
`duplicateequivalent`. `duplicateequivalent` is an idempotent success
classification, not an error.

The most important separation is by operation fingerprint:

- `#d723c1f392f3` is the newest corrected ordinary Sync. Its visible timeline
  has no `MKS-REC-001` failed-recovery phase and ends `sync-completed`.
- `#cf23d2a09c74` is the older preserved operation. Its longer historical
  timeline includes `MKS-REC-001`, upload phases, and the earlier recovery
  behavior that motivated ERR-04.

The UI intentionally retains both histories. If rows from those fingerprints
are read as one uninterrupted operation, the old recovery defect appears to
have recurred even though it belongs to the older attempt.

This does reveal a presentation problem: the timeline is technically detailed
but visually expensive. A follow-up implementation should group or filter
timeline entries by parent operation fingerprint and show a compact phase
summary by default, with raw pre/post declarations expandable on demand.

## CONSOLIDATED DIAGNOSTIC CONCLUSION

Current evidence classification:

| Claim | Classification | Boundary |
| --- | --- | --- |
| Refresh diagnostics works without visible mutation | client-UI validated in this packet | Does not prove provider refresh |
| Status projects authenticated | client-UI validated in this packet | Already-authenticated steady state only |
| Query projects device-enrolled | client-UI validated in this packet | Already-enrolled steady state only |
| A warm hosted deployment answers readiness | client-UI validated in this packet | Cold-start reliability and Render correlation unproved |
| Ordinary Sync completes after ERR-04 | client-UI validated in this packet | Single client; no direct provider-row evidence |
| Ordinary Sync avoided implicit failed/notApplied recovery | supported by the new operation timeline and empty queue | Render/provider confirmation not included |
| Last successful Sync advanced correctly | client-UI validated | Projection evidence only |
| Next Device sequence correctly remained 3 | client-UI validated and consistent with allocator semantics | No new local event was created |
| Provider contents are correct | unproved | Requires sanitized read-only provider evidence |
| Second-device convergence works | unproved | Requires a separate authorized device assay |
| Gate 12.7 may be semantically closed | candidate conclusion | Requires Main/J reconciliation against the complete accepted exit criteria |

### Recommended next implementation

1. Replace the three top-level buttons **Status**, **Query**, and **Refresh
   diagnostics** with one **Diagnostics** button and one coherent results
   surface.
2. Preserve authentication, enrollment/binding, and local diagnostic refresh as
   separately named subchecks with individual terminal states.
3. Keep `Check hosted connection` separate and label it explicitly as hosted
   readiness, including cold/wake-up guidance.
4. Keep `Sync` separate and visually identify it as the stateful protocol
   action.
5. Group Recent diagnostic timeline rows by parent operation fingerprint.
6. Collapse each paired pre-result/result declaration into a phase summary by
   default; retain the complete raw lifecycle under an expandable technical
   view.
7. Mark historical operations clearly so an older `MKS-REC-001` row cannot be
   mistaken for part of the newest Sync.
8. Preserve the existing sanitized evidence and correlation fields; improve
   hierarchy and projection rather than deleting causal detail.

### Gate-level disposition

This appendix supports the following provisional Gate 12.7 statement:

```text
ERR-04 corrected client behavior: SUPPORTED
Warm hosted readiness: PASS for the observed attempt
Cold-start readiness tolerance: OPEN
Corrected ordinary Sync control: PASS at client-UI scope
Implicit recovery in newest operation: NOT OBSERVED
Queue invariant: PASS
Next Device sequence invariant: PASS
Last successful Sync projection: PASS
Render correlation: UNPROVED in this packet
Provider-row contents: UNPROVED
Second-device convergence: UNPROVED
Gate 12.7 final semantic disposition: RECONCILIATION REQUIRED
```

No Retry, recovery, Clear diagnostic history, new event creation, provider
mutation, or second-device action is recommended merely to repeat evidence
already established by this packet.

---

# APPENDIX B — DIAG-01 WINDOWS HOST OBSERVATION, INNER-STEPS 3–4

This appendix is append-only. It records the Windows UI observations supplied
on 2026-07-28 after the consolidated `Diagnostics` control had been
implemented. It does not rewrite Records 001–006 or project the current
signed-out state backward onto those earlier assay times.

Controlling sequence at the time of observation:

```text
Cycle 10
└─ GCM-02
   └─ Step 12
      ├─ Gate 12.7 — passed at the prior corrected single-client scope
      └─ DIAG-01 host observation
         ├─ inner-step 3 — exercise and inspect Diagnostics
         └─ inner-step 4 — freeze the unchanged Gate 12.7 client packet
```

The screenshots establish client-side Windows UI evidence only. They do not
establish a fresh Render request, provider-row contents, or second-Device
convergence. The Diagnostics action is evaluated against its intended local,
read-only projection boundary.

## RECORD 007 — CONSOLIDATED DIAGNOSTICS WINDOWS CONTROL

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-28-007-DIAG-01-WINDOWS-CONTROL
DATE/TIME (local): 2026-07-28, exact time [MANUAL]
DATE/TIME (UTC, if available): [MANUAL]
TESTER: [MANUAL]
DEVICE/OS: Windows desktop [SCREENSHOT; exact version MANUAL]
CLIENT BUILD OR COMMIT SHA: grm-guarded-provisioning-20260727 lineage
[CONTEXT; exact executable SHA MANUAL]
ENVIRONMENT: development/disposable [CONTEXT; confirm manually]
ASSAY PURPOSE: Exercise the consolidated Diagnostics control once, inspect its
local projections and operation-aware history, freeze the prior Gate 12.7
client packet, and assess whether DIAG-01 behaves as intended.

ACTION PERFORMED
----------------
Button/action: Diagnostics [USER STATEMENT/SCREENSHOT]
Exact click count: 1 [USER STATEMENT]
Hosted readiness executed by this action: NO evidence observed
Ordinary Sync executed by this action: NO evidence observed
Retry or failed/notApplied recovery executed: NO evidence observed
Enrollment or logout executed by this action: NO evidence observed
Diagnostic-history clear executed: NO evidence observed

CURRENT DIAGNOSTICS ACTION
--------------------------
Page status: diagnostics-partial [SCREENSHOT]
MKS code: MKS-UI-003 [SCREENSHOT]
Title: Current action collapsed into historical result [SCREENSHOT]
Outcome: blocked [SCREENSHOT]
Last proved phase: presentation [SCREENSHOT]
Local mutation: none [SCREENSHOT]
Provider contact: not-started [SCREENSHOT]
Trusted response: not-received [SCREENSHOT]
Operation: #local-diagnostics [SCREENSHOT]
Displayed safe action: separate current and historical result surfaces
[SCREENSHOT]

DIAGNOSTICS SUBCHECKS AND DURABLE PROJECTION
--------------------------------------------
Authentication: signed-out [SCREENSHOT]
Enrollment: device-enrolled [SCREENSHOT]
Readiness: authentication-required [SCREENSHOT]
Recovery guidance: sign-in-required [SCREENSHOT]
Last ordinary-Sync result: sync-completed [SCREENSHOT]
Last successful Sync: 2026-07-27T01:29:48.000Z [SCREENSHOT]
Declaration scope: client-operation [SCREENSHOT]
Historical operation kind: ordinary-sync [SCREENSHOT]
Historical client result code: sync-completed [SCREENSHOT]
Historical last proved phase: terminal [SCREENSHOT]
Configured ordinary-Sync deadline: 35000ms client [SCREENSHOT]
Historical operation fingerprint: #d723c1f392f3 [SCREENSHOT]
Historical child correlation: #2575218c1dbf [SCREENSHOT]

LOCAL QUEUE AND DEVICE
----------------------
Pending: 0 [SCREENSHOT]
Uploading: 0 [SCREENSHOT]
Failed: 0 [SCREENSHOT]
Unknown: 0 [SCREENSHOT]
Next Device sequence: 3 [SCREENSHOT]
Displayed sequence meaning: Allocated only to new local Device events
[SCREENSHOT]
Current Device fingerprint: #a43532d0 [SCREENSHOT]
Current Device enrollment: device-enrolled [SCREENSHOT]
Actionable events: No pending, failed or unknown events [SCREENSHOT]

OPERATION-AWARE HISTORY PROJECTION
----------------------------------
Newest operation: ordinary-sync #d723c1f392f3 [SCREENSHOT]
Newest operation terminal: successful / sync-completed [SCREENSHOT]
Newest compact phase count: 8 phases [SCREENSHOT]
Newest latest proved phase: terminal [SCREENSHOT]
Historical operation: ordinary-sync #cf23d2a09c74 [SCREENSHOT]
Historical compact phase count: 11 phases [SCREENSHOT]
Historical latest proved phase: terminal [SCREENSHOT]
Raw newest lifecycle: Sanitized raw lifecycle (13), expandable [SCREENSHOT]
Pre-result/result reduction visible: YES; download and acknowledgement phases
show later result-bearing classifications, including `downloadreceived` and
`duplicateequivalent`, rather than treating every earlier `unknown` declaration
as an independent failure [SCREENSHOT]
Newest/historical separation visible: YES [SCREENSHOT]

STATE COMPARISON WITH FROZEN RECORD 006
---------------------------------------
Queue before: 0/0/0/0 [RECORD 006]
Queue after Diagnostics: 0/0/0/0 [SCREENSHOT]
Next Device sequence before: 3 [RECORD 006]
Next Device sequence after Diagnostics: 3 [SCREENSHOT]
Last successful Sync before: 2026-07-27T01:29:48.000Z [RECORD 006]
Last successful Sync after Diagnostics: 2026-07-27T01:29:48.000Z [SCREENSHOT]
Newest accepted ordinary-Sync operation before: #d723c1f392f3 [RECORD 006]
Newest accepted ordinary-Sync operation after: #d723c1f392f3 [SCREENSHOT]
Visible client-state mutation attributable to Diagnostics: NONE
[RECORD 006/SCREENSHOT COMPARISON]

SCREENSHOTS
-----------
- 793e050d-bce6-43e3-9b4e-5cdea5884555.png
- 8e038bab-1589-4076-a740-f96825517573.png
- 73734b85-dce1-4aae-b2b9-d65a5371f38b.png
- 1afc527e-6556-424e-83da-79d846d53a0c.png
- c9876767-48c6-41e9-8bef-f2d09ca0bfcc.png

OBSERVATION
-----------
Expected: One Diagnostics action locally reprojects authentication,
enrollment/binding, durable Sync state, queue/sequence state, actionable
events, and grouped lifecycle history. It performs no hosted readiness,
ordinary Sync, Retry, recovery, enrollment, logout, history clear, provider
mutation, or new Device-event allocation. A signed-out client with retained
local enrollment should truthfully produce a partial diagnostic aggregate
rather than claim readiness.

Observed: The consolidated control is present and produces the expected local
projection. Authentication is signed-out, enrollment remains device-enrolled,
readiness is authentication-required, and the page-level status is
diagnostics-partial. The prior successful ordinary Sync remains historical and
unchanged. Queue 0/0/0/0, Next Device sequence 3, Last successful Sync, newest
operation identity, and actionable-event state remain consistent with frozen
Record 006. Newest and historical operations are separated, compact phase
summaries are shown, and the complete sanitized lifecycle remains expandable.

Difference: The aggregate `diagnostics-partial` classification is coherent
with the signed-out authentication subcheck and is not evidence that the
Diagnostics command failed. However, the Current action result is projected as
`MKS-UI-003 / blocked / Current action collapsed into historical result` even
though the UI now visibly separates `#local-diagnostics` from the historical
ordinary-Sync result. This is a residual semantic/presentation mismatch in the
current-action diagnostic mapping. It does not negate the successful local
snapshot refresh, but it prevents an unqualified claim that the complete
Diagnostics presentation is working exactly as intended.

Current hypothesis: The Diagnostics command boundary is operational and
read-only at the observed client-UI scope. Its subchecks, invariant
preservation, operation grouping, and raw-evidence access behave as expected.
The unconditional use of `MKS-UI-003` for an available local snapshot is
misleading and should be corrected so the current-action card reports the
truthful aggregate terminal (`diagnostics-ready`, `diagnostics-partial`, or
`diagnostics-configuration-missing`) without asserting a historical-collapse
defect that the new surface has already separated.

Next safe action: Preserve this client packet. Do not repeat Sync, readiness,
Retry, recovery, Enroll, logout, or history clear to improve the record. Route
the `MKS-UI-003` current-action classification mismatch as a bounded DIAG-01
presentation correction, while keeping provider contents and second-Device
claims outside this record.
```

## INNER-STEP 3 ASSESSMENT — IS THE DIAGNOSTICS BUTTON WORKING?

| Requirement | Host observation | Assessment |
| --- | --- | --- |
| One consolidated Diagnostics control | One `Diagnostics` button is visible | PASS |
| Authentication remains a distinct subcheck | `signed-out` is visible | PASS |
| Enrollment/binding remains distinct | `device-enrolled` is visible | PASS |
| Local snapshot is refreshed/projected | Queue, sequence, attempts, devices, actionable events, and lifecycle history are visible | PASS |
| Signed-out aggregate is truthful | `diagnostics-partial`, `authentication-required`, and `sign-in-required` agree | PASS |
| No visible queue mutation | Queue remains `0/0/0/0` | PASS at client-UI scope |
| No Device-sequence allocation | Next Device sequence remains `3` | PASS at client-UI scope |
| Last successful Sync is not advanced | Timestamp remains `2026-07-27T01:29:48.000Z` | PASS at client-UI scope |
| Newest and historical operations are separated | `#d723c1f392f3` is newest and `#cf23d2a09c74` is historical | PASS |
| Compact summaries do not treat lifecycle-row count as error count | 8/11 compact phase summaries and accepted result-bearing rows are visible | PASS |
| Raw sanitized evidence remains available | `Sanitized raw lifecycle (13)` is expandable | PASS |
| Current-action diagnostic is semantically accurate | `MKS-UI-003 / blocked` claims historical collapse despite the separated surface | PRESENTATION DEFECT |
| Provider contents or server correlation proved | No fresh provider/Render evidence supplied | OUTSIDE SCOPE |

Overall host assessment:

```text
DIAGNOSTICS_BUTTON_INVOCATION=PASS
DIAGNOSTICS_LOCAL_PROJECTION=PASS
DIAGNOSTICS_READ_ONLY_INVARIANTS=SUPPORTED_AT_CLIENT_UI_SCOPE
DIAGNOSTICS_SUBCHECK_SEPARATION=PASS
DIAGNOSTICS_OPERATION_GROUPING=PASS
DIAGNOSTICS_RAW_EVIDENCE=PASS
DIAGNOSTICS_AGGREGATE_PARTIAL=EXPECTED_WHILE_SIGNED_OUT
DIAGNOSTICS_CURRENT_ACTION_CLASSIFICATION=PRESENTATION_DEFECT
DIAG_01_HOST_ACCEPTANCE=PASS_WITH_BOUNDED_PRESENTATION_DEFECT
```

The first two supplied screenshots do contain Diagnostics results: they show
the refreshed lower portion of the same Closure diagnostics surface, including
operation grouping, lifecycle evidence, Devices, actionable events, and
Closure actions. The current-action aggregate itself appears in
`c9876767-48c6-41e9-8bef-f2d09ca0bfcc.png`; the Sync overview and invariant
state continue through `1afc527e-6556-424e-83da-79d846d53a0c.png`. The five
screenshots should therefore be read as one vertically distributed
post-Diagnostics evidence surface, not as independent actions.

## INNER-STEP 4 ASSESSMENT — FROZEN CLIENT PACKET

The prior Gate 12.7 client packet remains stable across the observed
Diagnostics action:

```text
accepted newest operation: #d723c1f392f3
accepted terminal: sync-completed
queue: 0 pending / 0 uploading / 0 failed / 0 unknown
Next Device sequence: 3
Last successful Sync: 2026-07-27T01:29:48.000Z
implicit failed/notApplied recovery in newest operation: not observed
new action attributable to Diagnostics: #local-diagnostics
provider contact attributable to Diagnostics: not-started
local mutation attributable to Diagnostics: none
```

This freezes inner-step 4 at client-UI scope. It neither strengthens nor
weakens the already accepted Gate 12.7 ordinary-Sync result. The bounded
`MKS-UI-003` presentation defect should be corrected or explicitly accepted
before DIAG-01 is described as fully host-clean, but it does not authorize a
new Sync or any recovery/provider mutation.

---

# APPENDIX C — POST-ENROLLMENT DIAG-01 CORRECTION EVIDENCE

This appendix is append-only. It records the sanitized Windows client evidence
supplied on 2026-07-28 after guarded hosted identity provisioning, first Device
enrollment, the required client restart, and post-restart authentication. It
does not replace the earlier records and does not promote client projection
into provider truth.

## RECORD 008 — POST-ENROLLMENT DURABLE BINDING AND CURRENT-ACTION CORRECTION

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-28-008-POST-ENROLLMENT-DIAG-01
DATE/TIME (local): 2026-07-28, exact time [MANUAL]
TESTER: [MANUAL]
DEVICE/OS: Windows desktop [SCREENSHOT; exact version MANUAL]
CLIENT LINEAGE: grm-guarded-provisioning-20260727 [CONTEXT]
ENVIRONMENT: development/disposable [CONTEXT; confirm manually]
ASSAY PURPOSE: Inspect the post-enrollment, post-restart Closure projection;
verify durable enrollment and authentication projection; and assess the bounded
MKS-UI-003 current-action defect retained by Record 007.

PRIOR GUARDED STATE
-------------------
GS-AUTH-03 hosted token accepted: PASS [USER-SUPPLIED SANITIZED TERMINAL]
Pre-provisioning identity state: token-accepted [USER-SUPPLIED]
Database provisioning: committed-or-idempotent [USER-SUPPLIED]
Post-provisioning identity state: membership-confirmed [USER-SUPPLIED]
Ready for Device enrollment: True [USER-SUPPLIED]
First enrollment action count: exactly once [USER STATEMENT]
Required client terminal: hosted-restart-required [USER STATEMENT/SCREENSHOT]
Client closed and reopened: YES [USER STATEMENT]
Post-restart sign-in projection: authenticated [SCREENSHOT]

CURRENT ACTION RESULT
---------------------
Native Closure status: hosted-restart-required [SCREENSHOT]
MKS code: MKS-OBS-001 [SCREENSHOT]
Title: Observation diagnostic 001 [SCREENSHOT]
Outcome: applied [SCREENSHOT]
Last proved phase: terminal [SCREENSHOT]
Local mutation: none [SCREENSHOT]
Provider contact: not-started [SCREENSHOT]
Trusted response: see-causal-event [SCREENSHOT]
Operation fingerprint: #d723c1f392f3 [SCREENSHOT]
Displayed semantic guidance: client declaration only; inspect causal diagnostic
before action [SCREENSHOT]

POST-RESTART CLIENT PROJECTION
------------------------------
Authentication: authenticated [SCREENSHOT]
Enrollment: device-enrolled [SCREENSHOT]
Readiness: ready-no-local-work [SCREENSHOT]
Last result: sync-completed [SCREENSHOT]
Recovery guidance: no-local-sync-action-needed [SCREENSHOT]
Last successful Sync: 2026-07-27T01:29:48.000Z [SCREENSHOT]
Declaration scope: client-operation [SCREENSHOT]
Operation kind: ordinary-sync [SCREENSHOT]
Client result code: sync-completed [SCREENSHOT]
Last proved phase: terminal [SCREENSHOT]
Configured deadline: 35000ms client [SCREENSHOT]
Aggregate server request: not aggregate success; inspect child requests
[SCREENSHOT]
Client child correlation: #2575218c1dbf [SCREENSHOT]

LOCAL QUEUE AND DEVICE
----------------------
Pending: 0 [SCREENSHOT]
Uploading: 0 [SCREENSHOT]
Failed: 0 [SCREENSHOT]
Unknown: 0 [SCREENSHOT]
Next Device sequence: 3 [SCREENSHOT]
Sequence meaning: Allocated only to new local Device events [SCREENSHOT]
Current Device fingerprint: #a43532d0 [SCREENSHOT]
Current Device enrollment: device-enrolled [SCREENSHOT]
Actionable events: No pending, failed or unknown events [SCREENSHOT]

OPERATION-AWARE HISTORY
-----------------------
Newest operation: ordinary-sync #d723c1f392f3 [SCREENSHOT]
Newest operation terminal: successful / sync-completed [SCREENSHOT]
Newest compact phase count: 8 phases [SCREENSHOT]
Historical operation: ordinary-sync #cf23d2a09c74 [SCREENSHOT]
Historical operation terminal: successful / sync-completed [SCREENSHOT]
Historical compact phase count: 11 phases [SCREENSHOT]
Sanitized newest raw lifecycle count: 13 [SCREENSHOT]
Latest hosted-connection observations include ready/HTTP 200 results and
preserved historical timeout-before-response attempts [SCREENSHOT]
Preserved historical interrupted/unavailable Sync declarations: YES
[SCREENSHOT; not the newest terminal]

SCREENSHOTS
-----------
- 21faf97c-06d7-4fa0-b9b8-223109a2e224.png
- 692cff26-a34f-4e9a-9955-28f01979360f.png
- 3cae3f48-ef08-4ab8-a779-84a86d8f055b.png
- 3e25539d-3e80-4000-b7fa-e83123bcc1f7.png
- 4947880c-0834-4286-8ce4-0af8cf8e5c9d.png

EVIDENCE CEILING
----------------
Full server Device UUID recovered: UNPROVED BY SCREENSHOTS
GRM-AUTH-02 exact hosted binding check: UNPROVED BY SCREENSHOTS
GRM-NEON-11 atomic provider baseline: UNPROVED BY SCREENSHOTS
Fresh provider-row contents: UNPROVED
Fresh Render lifecycle correlation: UNPROVED
Second-Device convergence: UNPROVED
New Sync, Retry, recovery, enrollment, migration or provider mutation
authorized by this record: NO

OBSERVATION
-----------
Expected: After the one-time enrollment and required restart, the local Device
binding persists; a fresh sign-in restores authenticated client state; the
consolidated Diagnostics surface truthfully projects enrollment, readiness,
queue and historical ordinary-Sync evidence; and the current-action card no
longer emits the obsolete MKS-UI-003 historical-collapse defect.

Observed: The current Device is projected as device-enrolled after restart,
authentication is authenticated, readiness is ready-no-local-work, and the
local queue remains 0/0/0/0 with Next Device sequence 3. The prior successful
ordinary-Sync packet remains unchanged. The current-action card now emits
MKS-OBS-001 / Observation diagnostic 001 / applied / terminal, with no local
mutation and no provider contact attributable to that observation event.

Difference: No client-side difference from the intended corrected DIAG-01
presentation is visible. Historical timeout/interrupted declarations remain
available as preserved history and do not override the newest successful
ordinary-Sync terminal. Exact hosted binding and provider state remain outside
the screenshot evidence.

Current hypothesis: First Device enrollment persisted across the required
restart, post-restart authentication succeeded, and the bounded MKS-UI-003
presentation defect from Record 007 is corrected at Windows client-UI scope.
This packet is sufficient to close the DIAG-01 current-action presentation
observation, but not to close Gate 12.8 provider/result reconciliation.

Next safe action: Preserve this packet. Recover or retain the complete server
Device UUID locally without recording it, run the exact read-only GRM-AUTH-02
binding check if not already completed, then run one fresh read-only
GRM-NEON-11 provider baseline. Stop before Sync, Retry, recovery, enrollment,
migration, provider editing, or a second action.
```

## RECORD 008 ASSESSMENT

| Claim | Assessment | Boundary |
| --- | --- | --- |
| Enrollment persisted across restart | SUPPORTED | Windows client projection |
| Post-restart authentication restored | PASS | Windows client projection |
| Binding exists locally | SUPPORTED | Enrolled Device projection; full UUID not displayed |
| DIAG-01 consolidated projection works | PASS | Windows client-UI scope |
| Prior MKS-UI-003 current-action defect is corrected | PASS | MKS-OBS-001/applied now displayed |
| Queue and sequence invariants remain stable | PASS | 0/0/0/0 and next sequence 3 |
| Newest ordinary-Sync terminal remains successful | PASS | Preserved client history |
| Historical timeout/interrupted rows are current failures | REJECTED | Preserved older attempts |
| Exact hosted Account/Device binding is proved | OPEN | Requires GRM-AUTH-02 evidence |
| Provider baseline is proved | OPEN | Requires GRM-NEON-11 evidence |
| Gate 12.8 provider/result reconciliation is complete | NO | Read-only hosted/provider comparison remains |

Terminal classification:

```text
POST_ENROLLMENT_RESTART=PASS_AT_CLIENT_SCOPE
POST_RESTART_AUTHENTICATION=PASS
DURABLE_DEVICE_ENROLLMENT=SUPPORTED
DIAG_01_CURRENT_ACTION_CORRECTION=PASS
MKS_UI_003_RESIDUAL_DEFECT=NOT_OBSERVED
QUEUE_INVARIANT=PASS
NEXT_DEVICE_SEQUENCE_INVARIANT=PASS
EXACT_HOSTED_BINDING=OPEN
ATOMIC_PROVIDER_BASELINE=OPEN
GATE_12_8_PROVIDER_RECONCILIATION=OPEN
MUTATING_ACTION_AUTHORIZATION=NONE
```


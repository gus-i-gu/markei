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

---

# APPENDIX D — EXACT BINDING AND ATOMIC PROVIDER BASELINE

This appendix is append-only. It records the sanitized `GRM-AUTH-02` and
`GRM-NEON-11` terminals supplied on 2026-07-28 after the first genuine Device
enrollment against the replacement development provider. It closes the
read-only evidence question left open by Record 008 without recording the
access token, Device UUID, Auth0 subject, Account identifier, database
credential, connection string, or full replay hash.

The terminal labels use the canonical GRIMOIRE entry names. The launcher
dispatches them as `GS-AUTH-02` and `GS-NEON-11`.

## RECORD 009 — POST-ENROLLMENT EXACT BINDING AND PROVIDER BASELINE

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-28-009-EXACT-BINDING-PROVIDER-BASELINE
DATE/TIME (local): 2026-07-28, exact time [MANUAL]
TESTER: [MANUAL]
DEVICE/OS: Windows desktop [USER-SUPPLIED TERMINAL CONTEXT]
CLIENT LINEAGE: grm-guarded-provisioning-20260727
INSPECTED REPOSITORY HEAD: 3cbc6d526a7a92da5306326acb9e809dbe13f3fa
ENVIRONMENT: development [USER-SUPPLIED SANITIZED TERMINAL]
NON-SECRET BRANCH COORDINATE: markei-c10 [USER-SUPPLIED SANITIZED TERMINAL]
DATABASE: markei_sync_dev [USER-SUPPLIED SANITIZED TERMINAL]
DATABASE ROLE: markei_migrator [USER-SUPPLIED SANITIZED TERMINAL]
NEON BRANCH ALIAS INDEPENDENTLY PROVED BY LAUNCHER: NO
ASSAY PURPOSE: Prove that one fresh Auth0 user token is accepted by the hosted
identity endpoint, that the same locally retained complete Device UUID is
authorized by the hosted Device-status endpoint, and that one atomic read-only
provider snapshot is internally consistent before any new Sync action.

SAFETY AND ACTION BOUNDARY
--------------------------
Secrets copied into this file: NO
Complete identifiers copied into this file: NO
Token or authorization header printed by procedure: NO
Provider payloads or response bodies recorded: NO
Ordinary Sync executed: NO
Retry or failed/notApplied recovery executed: NO
Enrollment executed during these two checks: NO
Migration or provider mutation executed: NO
Transaction terminal: ROLLBACK
New mutating action authorized by this record: NO

GRM-AUTH-02 — EXACT HOSTED BINDING
----------------------------------
IssuerMatches: True
AudienceMatches: True
AlgorithmMatches: True
SubjectPresent: True
TimeWindowValid: True
IdentityStatus: 200
DeviceStatus: 200
TokenAccepted: True
ExactDeviceBinding: True
BindingClass: exact-binding-confirmed

Interpretation: The fresh token passed the local compatibility checks and the
hosted API accepted both the identity request and the exact Device-status
request. The API, rather than the local parser alone, owns cryptographic token,
membership, enrollment, and Device-authorization enforcement.

GRM-NEON-11 — CONNECTION AND EXACT-DEVICE GUARD
------------------------------------------------
Role/database/TLS check: PASS
Fixture Device matches: 1
Exact Device guard: 1

GRM-NEON-11 — GLOBAL PROVIDER COUNTS
-------------------------------------
Accounts: 1
Devices: 1
Account cursor-state rows: 1
Submissions: 0
Sync events: 0
Device acknowledgements: 0
Accounts missing cursor state: 0
Orphan cursor-state rows: 0

GRM-NEON-11 — FIXTURE-ACCOUNT COUNTS AND DEVICE STATE
------------------------------------------------------
Fixture Accounts: 1
Fixture Account Devices: 1
Fixture Account cursor-state rows: 1
Fixture submissions: 0
Fixture Sync events: 0
Fixture Device acknowledgements: 0
Fixture Device status: active
Fixture Device next expected sequence: 1

GRM-NEON-11 — CURSOR AND SEQUENCE CONSISTENCY
----------------------------------------------
Account next cursor: 1
Hosted high-water: 0
Account cursor consistent: true
Device next expected sequence: 1
Device high-water: 0
Device sequence consistent: true

GRM-NEON-11 — SANITIZED REPLAY INVENTORY
-----------------------------------------
Fixture submissions: 0
Distinct request hashes: 0
Submission and request-hash fingerprints: [none]
Fixture Sync events: 0
Distinct content hashes: 0
Event and content-hash fingerprints: [none]

GRM-NEON-11 — TERMINAL
-----------------------
Transaction: ROLLBACK
Launcher result: PASS — provider-baseline completed

EVIDENCE CEILING
----------------
Fresh token accepted by hosted identity route: PROVED
Exact hosted Account/Device authorization: PROVED
Exact Device exists in replacement provider: PROVED
Replacement provider pre-Sync baseline is internally consistent: PROVED
Provider state changed by the baseline procedure: REJECTED; explicit ROLLBACK
Prior client historical Sync belongs to this replacement provider: UNPROVED
Current local queue contents immediately before a future Sync: UNPROVED BY
THIS TERMINAL
Upload, download, acknowledgement or convergence on this provider: UNPROVED
Second-Device convergence: UNPROVED
Production readiness: UNPROVED
```

## RECORD 009 ASSESSMENT

| Claim | Assessment | Evidence boundary |
| --- | --- | --- |
| Auth0 issuer, audience, algorithm, subject and time-window contract passed | PASS | Fresh token compatibility checks plus hosted acceptance |
| Hosted identity membership is accepted | PASS | Identity endpoint HTTP 200 |
| The retained complete Device UUID is the active hosted Device | PASS | Device-status endpoint HTTP 200 and exact-binding terminal |
| The UUID identifies exactly one provider Device | PASS | `fixture_device_matches=1`, fail-closed guard passed |
| Provider Account/Device/cursor structure is coherent | PASS | `1/1/1`, no missing or orphan cursor row |
| Provider contains a prior submission, Sync event or acknowledgement | REJECTED | All three global and fixture counts are zero |
| Account cursor is coherent at the empty baseline | PASS | next cursor 1, high-water 0, consistency true |
| Device sequence is coherent at the empty baseline | PASS | next expected 1, high-water 0, consistency true |
| `GRM-NEON-11` changed provider state | REJECTED | Repeatable read-only transaction ended in `ROLLBACK` |
| Earlier client Sync history is corroborated by this provider | UNPROVED | Replacement provider contains no corresponding rows |
| C10-GCM02-S12-ST08 read-only identity/provider reconciliation may close | PASS WITH BOUNDED RESULT | Exact binding and clean provider baseline proved; no transition result exists yet |
| A Sync or other mutating action is authorized by this evidence | NO | Separate ST09 preflight and explicit authorization required |

Terminal classification:

```text
GRM_AUTH_02=PASS
FRESH_TOKEN_CONTRACT=PASS
HOSTED_IDENTITY_STATUS=HTTP_200
HOSTED_DEVICE_STATUS=HTTP_200
EXACT_HOSTED_BINDING=PASS
GRM_NEON_11=PASS
EXACT_PROVIDER_DEVICE_GUARD=PASS
PROVIDER_GLOBAL_COUNTS=1_ACCOUNT_1_DEVICE_1_CURSOR_0_SUBMISSIONS_0_EVENTS_0_ACKS
PROVIDER_CURSOR_INTEGRITY=PASS
ACCOUNT_CURSOR_BASELINE=CONSISTENT_1_AFTER_0
DEVICE_SEQUENCE_BASELINE=CONSISTENT_1_AFTER_0
SANITIZED_REPLAY_INVENTORY=EMPTY
READ_ONLY_TRANSACTION=ROLLED_BACK
ST08_READ_ONLY_RECONCILIATION=PASS_BOUNDED
PRIOR_CLIENT_SYNC_PROVIDER_CORRELATION=UNPROVED
ST09=NEXT_PREPARATION_ONLY
MUTATING_ACTION_AUTHORIZATION=NONE
```

## RECORD 010 — ST09 INITIAL WINDOWS LOCAL PREFLIGHT

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-28-010-ST09-WINDOWS-LOCAL-PREFLIGHT
DATE/TIME (local): 2026-07-28, exact time [MANUAL]
TESTER: [MANUAL]
DEVICE/OS: Windows desktop [USER-SUPPLIED SCREENSHOT CONTEXT]
CLIENT LINEAGE: grm-guarded-provisioning-20260727
INSPECTED REPOSITORY HEAD: f54b9872daf37c26b33778a36f26f733c834401d
ENVIRONMENT: development
ASSAY PURPOSE: Freeze the first post-restart local client state for
C10-GCM02-S12-ST09 before creating or submitting a controlled Sync member.

SAFETY AND ACTION BOUNDARY
--------------------------
Secrets visible or copied into this record: NO
Complete Account, Device or subject identifiers recorded: NO
Provider request performed by Diagnostics: NO
Ordinary Sync executed: NO
Retry or failed/notApplied recovery executed: NO
Enrollment or migration executed: NO
Provider mutation authorized by this record: NO

NATIVE CLOSURE AND CURRENT-ACTION PROJECTION
---------------------------------------------
Native closure state: diagnostics-ready
Current-action MKS code: MKS-UI-003
Current-action title: Current action collapsed into historical result
Current-action outcome: blocked
Last proved phase: presentation
Local mutation: none
Provider contact: not-started
Trusted response: not-received
Operation: local-diagnostics

Interpretation: Diagnostics completed as a local preflight, but the current
action presentation still exposes the known MKS-UI-003 separation defect. This
presentation defect does not establish a hosted failure because the action
made no provider contact and performed no local mutation.

SYNC OVERVIEW
-------------
Authentication: authenticated
Enrollment: device-enrolled
Readiness: ready-no-local-work
Last result: no-recorded-attempts
Last successful Sync: not recorded
Recovery guidance: no-local-sync-action-needed
Declaration scope: client-operation
Operation kind: ordinary-sync
Client result code: not-recorded
Server request: not aggregate success
Last proved phase: unknown
Configured deadline: 35000ms client
Operation correlation: not recorded
Client child correlation: unavailable locally

LOCAL QUEUE
-----------
Pending: 0
Uploading: 0
Failed: 0
Unknown: 0
Next Device sequence: 1
Sequence meaning: allocated only to new local Device events

DEVICE AND ACTIONABLE-EVENT PROJECTION
---------------------------------------
Current Device projection count: 1
Current Device: device-enrolled
Current Device next sequence: 1
Actionable pending/failed/unknown events: none
Recent closure-attempt history: none recorded
Recent diagnostic-event history: none recorded

EVIDENCE CEILING
----------------
Post-restart hosted binding adopted by Windows client: PROVED AT CLIENT UI
Windows local queue empty and internally coherent: PROVED AT CLIENT UI
Next local Device event will use sequence 1: PROVED AT CLIENT UI
Current controlled Sync member set: EMPTY
Useful ordinary Sync transition can be authorized from this state: NO; one
intentional local test event must first be created and re-frozen
Provider baseline remains Record 009: RETAINED
Upload, acknowledgement, provider delta or convergence: UNPROVED
Second-Device or Android enrollment/convergence: UNPROVED
```

## RECORD 010 ASSESSMENT

| Claim | Assessment | Evidence boundary |
| --- | --- | --- |
| ST09.1 has a fresh post-restart local preflight | PASS | User-supplied Windows Diagnostics screenshots |
| Authentication and enrollment are loaded | PASS AT CLIENT UI | `authenticated` and `device-enrolled` projections |
| The Windows queue contains a Sync member | REJECTED | Pending/uploading/failed/unknown are all zero |
| Local Device sequence aligns with the empty provider baseline | PASS | Local next sequence 1 matches Record 009 provider next expected sequence 1 |
| `MKS-UI-003` proves a hosted failure | REJECTED | Local Diagnostics made no provider contact or mutation |
| An empty ordinary Sync should be used as the ST09 transition assay | NO | It would not exercise upload or event materialization |
| Android enrollment belongs inside the current ST09 transition | NO | Same-Device transition must close first; second-Device convergence remains separately authorized |

Terminal classification:

```text
ST09_LOCAL_PREFLIGHT=PASS
WINDOWS_BINDING_PROJECTION=ADOPTED
LOCAL_QUEUE=EMPTY_0_0_0_0
LOCAL_NEXT_DEVICE_SEQUENCE=1
PROVIDER_NEXT_EXPECTED_SEQUENCE_BASELINE=1
LOCAL_PROVIDER_SEQUENCE_ALIGNMENT=PASS
CONTROLLED_SYNC_MEMBER_SET=EMPTY
MKS_UI_003=PRESENTATION_DEFECT_OBSERVED
ST09_TEST_EVENT_CREATION=NEXT_PREPARATION
ORDINARY_SYNC=NOT_YET_AUTHORIZED
SECOND_DEVICE=NOT_AUTHORIZED_IN_ST09
```

## RECORD 011 — ST09 CONTROLLED SAME-DEVICE SYNC AND PROVIDER POSTFLIGHT

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-28-011-ST09-SAME-DEVICE-SYNC-POSTFLIGHT
DATE/TIME (local): 2026-07-28
LAST SUCCESSFUL SYNC (UTC): 2026-07-28T20:25:55.000Z
TESTER: [MANUAL]
DEVICE/OS: Windows desktop [USER-SUPPLIED SCREENSHOT CONTEXT]
CLIENT LINEAGE: grm-guarded-provisioning-20260727
INSPECTED REPOSITORY HEAD: f54b9872daf37c26b33778a36f26f733c834401d
ENVIRONMENT: development
ASSAY PURPOSE: Exercise exactly one intentionally created
purchase.registered event through the authenticated hosted Sync path, then
compare the terminal client state with one atomic read-only provider
postflight.

SAFETY AND ACTION BOUNDARY
--------------------------
Secrets visible or copied into this record: NO
Complete Account, Device or subject identifiers recorded: NO
Full request/content hashes recorded: NO
Ordinary Sync authorized and executed: EXACTLY ONE
Second Sync or retry executed: NO
Failed/notApplied recovery executed: NO
Enrollment or migration executed during this assay: NO
Provider-console or direct database mutation executed: NO
Postflight transaction terminal: ROLLBACK
New mutating action authorized by this record: NO

PRE-ACTION LOCAL MEMBER SET
---------------------------
Authentication: authenticated
Enrollment: device-enrolled
Hosted readiness after warm verification: hosted-connection-ready
Live endpoint: HTTP 200
Ready endpoint: HTTP 200
Pending: 1
Uploading: 0
Failed: 0
Unknown: 0
Pending event type: purchase.registered
Pending Device sequence: 1
Next local Device sequence: 2

One earlier hosted-connection check timed out before response during a cold
service start. The standalone live/ready checks then returned HTTP 200 and the
next client check completed successfully in under three seconds. The cold
timeout is retained as an operational sensitivity, not reclassified as an API,
authentication or Sync failure.

AUTHORIZED TRANSITION CONTRACT
------------------------------
Client action: ordinary Sync
Authorized click count: 1
Expected local queue transition: pending 1 -> 0
Expected provider payload transition: submissions/events/acknowledgements
0/0/0 -> 1/1/1
Expected Account cursor transition: next cursor 1 -> 2; high-water 0 -> 1
Expected Device sequence transition: next expected 1 -> 2; high-water 0 -> 1
Ambiguous-outcome retry authorization: NONE

CLIENT TERMINAL
---------------
Native closure state: sync-completed
Last result: sync-completed
Client result code: sync-completed
Last proved phase: terminal
Authentication: authenticated
Enrollment: device-enrolled
Readiness: ready-no-local-work
Recovery guidance: no-local-sync-action-needed
Operation kind: ordinary-sync
Declaration scope: client-operation
Configured deadline: 35000ms client
Last successful Sync: 2026-07-28T20:25:55.000Z
Operation fingerprint: d1cb6cb600a1
Client child-correlation fingerprint: 6a53d7090d68

POST-ACTION LOCAL QUEUE
-----------------------
Pending: 0
Uploading: 0
Failed: 0
Unknown: 0
Next Device sequence: 2
Actionable pending/failed/unknown events: none
Current Device projection: device-enrolled, next sequence 2

SANITIZED CLIENT LIFECYCLE PROJECTION
-------------------------------------
Authentication: authenticated
Binding: binding-accepted
Upload lease: upload-lease-committed
Upload transport: upload-request-started
Upload provider: serveraccepted
Upload result persistence: upload-result-persisted
Download transport: download-request-started
Download provider: download-response-received
Download local apply: downloadedapplied
Acknowledgement: acknowledged
Terminal: client-operation declaration / sync-completed

The raw lifecycle projection contains 17 ordered phase slots and 11 displayed
phase summaries. They are ordered evidence, not an error count.

GRM-NEON-11 — CONNECTION AND EXACT-DEVICE GUARD
------------------------------------------------
Role/database/TLS check: PASS
Fixture Device matches: 1
Exact Device guard: 1

GRM-NEON-11 — GLOBAL PROVIDER COUNTS
-------------------------------------
Accounts: 1
Devices: 1
Account cursor-state rows: 1
Submissions: 1
Sync events: 1
Device acknowledgements: 1
Accounts missing cursor state: 0
Orphan cursor-state rows: 0

GRM-NEON-11 — FIXTURE-ACCOUNT COUNTS AND DEVICE STATE
------------------------------------------------------
Fixture Accounts: 1
Fixture Account Devices: 1
Fixture Account cursor-state rows: 1
Fixture submissions: 1
Fixture Sync events: 1
Fixture Device acknowledgements: 1
Fixture Device status: active
Fixture Device next expected sequence: 2

GRM-NEON-11 — CURSOR AND SEQUENCE CONSISTENCY
----------------------------------------------
Account next cursor: 2
Hosted high-water: 1
Account cursor consistent: true
Device next expected sequence: 2
Device high-water: 1
Device sequence consistent: true

GRM-NEON-11 — SANITIZED REPLAY INVENTORY
-----------------------------------------
Fixture submissions: 1
Distinct request hashes: 1
First/last submission fingerprint: 0456e9ed / 0456e9ed
First/last request-hash fingerprint: 7be3ab38d19a / 7be3ab38d19a
Fixture Sync events: 1
Distinct content hashes: 1
First/last event fingerprint: 58f5fc68 / 58f5fc68
First/last content-hash fingerprint: b4d057dd26de / b4d057dd26de

GRM-NEON-11 — TERMINAL
-----------------------
Transaction: ROLLBACK
Launcher result: PASS — provider-baseline completed

INCIDENTAL LOCAL-WORKFLOW OBSERVATIONS
--------------------------------------
Product lookup dropdown assertion: OBSERVED before purchase creation; a fresh
Product object did not match exactly one dropdown item by object identity.
Purchase resolution rollback: OBSERVED and contained; one staged new-product
reference reached resolveProduct with an empty required code and created no
purchase or Sync event.
Successful controlled member preparation: ACHIEVED later through the existing
Product path; exactly one purchase.registered event at Device sequence 1 was
frozen before authorization.
Unauthenticated local purchase capture: OBSERVED as compatible with the present
offline-first local-write model; Account adoption/isolation UX remains an open
Cycle 11 design question rather than a proved Sync defect.
MKS-UI-003 current-versus-historical presentation defect: RETAINED.

EVIDENCE CEILING
----------------
One authorized Windows ordinary Sync reached a client success terminal: PROVED
The exact frozen local member set drained without failed/unknown residue:
PROVED
One provider submission, event and acknowledgement were materialized: PROVED
Account cursor and Device sequence advanced by the exact expected delta: PROVED
Read-only provider postflight rolled back and passed: PROVED
Same-Device client/provider transition: PROVED
Sanitized matching Render request-lifecycle log for this operation: NOT YET
CAPTURED IN THIS RECORD
Second-Device download/convergence: UNPROVED
Production readiness: UNPROVED
```

## RECORD 011 ASSESSMENT

| Claim | Assessment | Evidence boundary |
| --- | --- | --- |
| The authorized ordinary Sync was executed exactly once | PASS | User action report plus one newest client operation |
| The client reached a trustworthy local success terminal | PASS | `sync-completed`, terminal phase, no recovery guidance |
| The local queue drained exactly one controlled member | PASS | `1/0/0/0 -> 0/0/0/0`, next sequence retained at 2 |
| Provider payload rows match the expected one-event transition | PASS | `0/0/0 -> 1/1/1` against Records 009 and 011 |
| Account cursor and Device sequence invariants match | PASS | Both are consistent at 2 after high-water 1 |
| Provider postflight changed provider state | REJECTED | Explicit `ROLLBACK`; the ordinary Sync owns the accepted mutation |
| The initial hosted timeout invalidates the assay | REJECTED | Subsequent live/ready and client readiness checks passed before Sync |
| ST09 same-Device transition may close | PASS | Client terminal, local post-state and independent provider postflight agree |
| GCM02 may close without the final server-log correlation/classification | NOT YET | Render lifecycle evidence required by the controlling Gate-12.10 contract remains absent |
| Android/second-Device convergence was proved | NO | Deferred to GCM03 |

Terminal classification:

```text
ST09_PRE_ACTION_MEMBER_SET=PASS_ONE_EVENT_SEQUENCE_1
ST09_READINESS=PASS_AFTER_COLD_START_WARMUP
ST09_ONE_ACTION_AUTHORIZATION=SATISFIED
ST09_ORDINARY_SYNC=PASS_EXACTLY_ONCE
ST09_CLIENT_TERMINAL=SYNC_COMPLETED
ST09_LOCAL_QUEUE=PASS_DRAINED_1_TO_0
ST09_LOCAL_NEXT_DEVICE_SEQUENCE=2
ST09_PROVIDER_COUNTS=PASS_1_SUBMISSION_1_EVENT_1_ACK
ST09_ACCOUNT_CURSOR=CONSISTENT_2_AFTER_1
ST09_DEVICE_SEQUENCE=CONSISTENT_2_AFTER_1
ST09_PROVIDER_POSTFLIGHT=ROLLBACK_PASS
ST09_SAME_DEVICE_TRANSITION=PASS
ST09=PASSED_BOUNDED
ST10=NEXT_SERVER_CORRELATION_AND_TERMINAL_CLASSIFICATION
SECOND_DEVICE=HELD_FOR_GCM03
NEW_MUTATING_ACTION_AUTHORIZATION=NONE
```

## RECORD 012 — ST10 RENDER LIFECYCLE CORRELATION AND GCM02 TERMINAL

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-28-012-ST10-RENDER-CORRELATION
DATE/TIME (UTC): 2026-07-28T20:25:47Z–2026-07-28T20:25:58Z
TESTER: [MANUAL LOG COLLECTION]
CLIENT LINEAGE: grm-guarded-provisioning-20260727
INSPECTED REPOSITORY HEAD: f54b9872daf37c26b33778a36f26f733c834401d
ENVIRONMENT: development
ASSAY PURPOSE: Correlate the already completed ST09 ordinary Sync with the
sanitized Render request lifecycle, without repeating or mutating the assay.

SAFETY AND ACTION BOUNDARY
--------------------------
Secrets visible or copied into this record: NO
Complete Account, Device or subject identifiers recorded: NO
Authorization headers, tokens or request payloads recorded: NO
Full replay hashes recorded: NO
New Sync, Retry, recovery, enrollment or migration executed: NO
Provider mutation executed by this inspection: NO
New mutating action authorized by this record: NO

CORRELATION GUARD
-----------------
Expected operation fingerprint: d1cb6cb600a1
Matching Sync child operations: 3
Unrelated health-readiness requests in interval: present and separated
Operation-fingerprint mismatch: none

UPLOAD-SUBMISSION CHILD
-----------------------
Route class: /v1/sync/submissions
Method: POST
Request received: yes
Operation validation started: yes
Authentication accepted: yes
Response completed: yes
HTTP status: 200
Result code: request-completed
Elapsed band: lt-3s

DOWNLOAD-EVENTS CHILD
---------------------
Route class: /v1/sync/events
Method: GET
Request received: yes
Operation validation started: yes
Authentication accepted: yes
Response completed: yes
HTTP status: 200
Result code: request-completed
Elapsed band: lt-250ms

ACKNOWLEDGEMENT CHILD
---------------------
Route class: /v1/sync/acknowledgements
Method: POST
Request received: yes
Operation validation started: yes
Authentication accepted: yes
Response completed: yes
HTTP status: 200
Result code: request-completed
Elapsed band: lt-250ms

NEGATIVE-EVIDENCE REVIEW
------------------------
Authentication rejected: absent
Request failed: absent
HTTP status >= 400: absent
Unexpected server error: absent
Rejected/notApplied terminal: absent
Duplicate-equivalent terminal: absent
Timeout or unknown terminal: absent
MKS-* server result: absent

INTERVAL-BOUNDARY NOTE
----------------------
The final unrelated /health/ready request at 20:25:58Z is truncated after
request-received and operation-validation-started because the supplied interval
ends there. It is not part of operation d1cb6cb600a1 and does not contradict
the three completed Sync children. Earlier health-ready requests in the same
interval completed with HTTP 200.

CORRELATED EVIDENCE SPINE
-------------------------
Client terminal: sync-completed
Local queue transition: pending 1 -> 0; failed/unknown remained 0/0
Render upload terminal: authenticated HTTP 200 request-completed
Render download terminal: authenticated HTTP 200 request-completed
Render acknowledgement terminal: authenticated HTTP 200 request-completed
Provider transition: submissions/events/acknowledgements 0/0/0 -> 1/1/1
Account cursor: 2 after high-water 1, consistent
Device sequence: 2 after high-water 1, consistent
Provider postflight: ROLLBACK / PASS

EVIDENCE CEILING
----------------
Matching sanitized server lifecycle for the ST09 operation: PROVED
All three protocol children reached authenticated HTTP success terminals:
PROVED
Client, server and provider evidence agree without contradiction: PROVED
Gate 12.10 expected-success classification: SUPPORTED
GCM02 hosted single-Device closure scope: SUPPORTED
Android/second-Device convergence: UNPROVED
Production readiness: UNPROVED
Retention, snapshot and rebootstrap acceptance: UNPROVED
```

## RECORD 012 ASSESSMENT

| Claim | Assessment | Evidence boundary |
| --- | --- | --- |
| Render logs correlate to the ST09 client operation | PASS | The same sanitized operation fingerprint is present on all three Sync children |
| Upload reached an authenticated HTTP success terminal | PASS | POST submissions: accepted authentication, `200`, `request-completed` |
| Download reached an authenticated HTTP success terminal | PASS | GET events: accepted authentication, `200`, `request-completed` |
| Acknowledgement reached an authenticated HTTP success terminal | PASS | POST acknowledgements: accepted authentication, `200`, `request-completed` |
| A server failure or ambiguous terminal is present | REJECTED | No rejection, failure, `>=400`, timeout, unknown, unexpected error or `MKS-*` line |
| The truncated final health request invalidates correlation | REJECTED | It is unrelated to the completed Sync fingerprint and lies at the capture boundary |
| Gate 12.10 may classify expected success | PASS | Client, three-child server lifecycle and provider postflight agree |
| GCM02 may close at its hosted same-Device scope | PASS | ST08, ST09 and ST10 terminals are complete and non-contradictory |
| Second-Device convergence was proved | NO | This remains the next separately controlled objective |

Terminal classification:

```text
ST10_OPERATION_CORRELATION=PASS
ST10_UPLOAD_SUBMISSION=AUTHENTICATED_HTTP_200_REQUEST_COMPLETED
ST10_DOWNLOAD_EVENTS=AUTHENTICATED_HTTP_200_REQUEST_COMPLETED
ST10_ACKNOWLEDGEMENT=AUTHENTICATED_HTTP_200_REQUEST_COMPLETED
ST10_FAILURE_OR_AMBIGUITY=ABSENT
ST10=PASSED_READ_ONLY
GATE_12_10=PASS_EXPECTED_SUCCESS
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=READY_FOR_EXPLICIT_SECOND_DEVICE_DEFINITION
NEW_MUTATING_ACTION_AUTHORIZATION=NONE
```

## RECORD 013 — GCM03 WINDOWS CANDIDATE-MEMBER PREFLIGHT

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-28-013-GCM03-WINDOWS-CANDIDATE
DATE (LOCAL): 2026-07-28
TESTER: [MANUAL UI COLLECTION]
CLIENT LINEAGE: grm-guarded-provisioning-20260727
INSPECTED REPOSITORY HEAD: f54b9872daf37c26b33778a36f26f733c834401d
ENVIRONMENT: development
ASSAY PURPOSE: Freeze the newly created, unsynchronized Windows purchase event
as the candidate first member of a future Android inter-device convergence
assay, without performing another Sync or enrolling a second Device.

SAFETY AND ACTION BOUNDARY
--------------------------
Secrets visible or copied into this record: NO
Complete Account, Device or subject identifiers recorded: NO
Complete event identifiers or payloads recorded: NO
New Windows Sync, Retry or recovery executed: NO
Android client launched by this assay: NO
Android Device enrolled by this assay: NO
Provider mutation executed by this assay: NO
New mutating action authorized by this record: NO

WINDOWS LOCAL QUEUE
-------------------
Pending: 1
Uploading: 0
Failed: 0
Unknown outcome: 0
Next Device sequence: 3
Sequence meaning: allocated only to new local Device events

ACTIONABLE EVENT
----------------
Event type: purchase.registered
Sanitized event fingerprint: 05d21c54
State: pending
Device sequence: 2

CURRENT DEVICE
--------------
Sanitized Device fingerprint: 429e3422
Current marker: yes
Enrollment state: device-enrolled

SYNC OVERVIEW CONTINUITY
------------------------
Authentication: authenticated
Enrollment: device-enrolled
Readiness: ready-with-pending-work
Last result: sync-completed
Last successful Sync: retained from accepted ST09
Recovery guidance: sync-can-upload-local-work
Client result code: sync-completed
Last proved phase: terminal

EVIDENCE CEILING
----------------
One unsynchronized Windows purchase.registered event exists: PROVED
The event is pending at Windows Device sequence 2: PROVED
The next Windows Device sequence is 3: PROVED
The current Windows Device remains enrolled: PROVED
The event is suitable as a candidate Windows-to-Android member: SUPPORTED
Provider state after creation of this local-only event: NOT RECHECKED HERE
Android build/install/run readiness: UNPROVED IN THIS RECORD
Android authentication or enrollment: UNPROVED
Windows-to-Android download/convergence: UNPROVED
Android-to-Windows reverse convergence: UNPROVED
Repeated idempotent Sync: UNPROVED
```

## RECORD 013 ASSESSMENT

| Claim | Assessment | Evidence boundary |
| --- | --- | --- |
| The post-GCM02 purchase is now a frozen GCM03 candidate member | PASS | Windows Diagnostics shows one pending `purchase.registered` event |
| Its local Device sequence and next sequence are known | PASS | Event sequence 2; next Device sequence 3 |
| Failed, uploading or unknown local residue is present | REJECTED | All three counters are zero |
| The accepted GCM02 provider transition was repeated | NO | No Sync or provider mutation occurred |
| Android enrollment may begin without a separate pre-enrollment packet | NO | Android lineage, local state and provider two-Device expectations remain unfrozen |
| GCM03 inter-device convergence has already been proved | NO | Record 013 proves only the Windows candidate-member preflight |

Terminal classification:

```text
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03_WINDOWS_CANDIDATE_PREFLIGHT=PASS
GCM03_WINDOWS_PENDING_MEMBER=PURCHASE_REGISTERED_SEQUENCE_2
GCM03_WINDOWS_QUEUE=PASS_1_0_0_0
GCM03_WINDOWS_NEXT_DEVICE_SEQUENCE=3
GCM03_ANDROID_CHECKS=NEXT_PREPARATION_ONLY
ANDROID_ENROLLMENT=NOT_AUTHORIZED
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
SECOND_DEVICE_CONVERGENCE=UNPROVED
```

---

# APPENDIX E — GCM03 ANDROID PRE-ENROLLMENT AND AUTHENTICATION

This appendix is append-only. It records the sanitized Android runtime evidence
supplied on 2026-07-28 after the Main-owned `GS-FLUTTER-AND` selector repair,
Codex C3 validation, a human Android build/install/launch rerun, ordinary Sign
in, and one local Diagnostics press. It does not promote local SQLite
projection into provider truth and does not authorize enrollment or Sync.

## RECORD 014 — ANDROID ST04/ST05 PRE-ENROLLMENT CONTROL

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-28-014-GCM03-ANDROID-PRE-ENROLLMENT
DATE/TIME (local): 2026-07-28, screenshots 09:57-10:01
TESTER: [MANUAL UI COLLECTION]
CLIENT LINEAGE: grm-guarded-provisioning-20260727
VISIBLE BUILD PROVENANCE: 65c9ab56079c
TARGET: configured Android AVD DEV-GRM; transient ADB serial omitted
ENVIRONMENT: development
ASSAY PURPOSE: Close the bounded Android launcher/Closure and authentication
checks, freeze the Android local pre-enrollment state, compare one local
Diagnostics press against its untouched post-Sign-in state, and prepare the
next read-only enrollment preflight.

SAFETY AND ACTION BOUNDARY
--------------------------
Secrets, tokens or credentials copied into this record: NO
Complete Account, subject, Installation or Device identifiers recorded: NO
Complete provider URLs or connection strings recorded: NO
Android Sign in executed: YES, exactly one observed ordinary flow
Android Diagnostics executed: YES, exactly once
Android Enroll executed: NO
Android or Windows Sync executed: NO
Retry, recovery, logout or history clearing executed: NO
Provider mutation attributable to this record: NO

CODEX C3 VALIDATION INPUT
-------------------------
DEVSEL classification: DEVSEL-01
Actual GS-FLUTTER-AND fixtures: PASS
Android device enumeration: CORRECTED
Non-Android ID reaches ADB: NO
ADB serial cardinality: EXACTLY ONE
Android Sign-in classification before human retest: AUTHAND-06
Focused/full Flutter validation: PASS
Flutter test result: 199 passed / 4 skipped
Flutter analysis: PASS
Debug APK and redacted merged-manifest inspection: PASS
Live Android install/launch and interactive Sign in in Codex run: NOT EXECUTED
Source: [USER-SUPPLIED CODEX TERMINAL]

HUMAN ANDROID LINEAGE
---------------------
Configured emulator visible: DEV-GRM
Visible build provenance: #65c9ab56079c
Provenance matches the Main-owned selector-repair commit: YES
Shared Native Closure surface visible on Android: YES
Android application data explicitly cleared by the launcher: NO
Freshness of the complete Android SQLite database: UNPROVED

BEFORE THE DIAGNOSTICS PRESS
----------------------------
Authentication: authenticated [SCREENSHOT]
Enrollment: enrollment-required [SCREENSHOT]
Readiness: device-enrollment-required [SCREENSHOT]
Recovery guidance: enroll-or-query-device [SCREENSHOT]
Current Android Device state: local-only [SCREENSHOT]
Sanitized Android Device fingerprint: #2b75367e [SCREENSHOT]
Android local next Device sequence: 1 [SCREENSHOT]
Global enrolled-Device sequence projection: Unavailable [SCREENSHOT]
Pending/uploading/failed/unknown: 0/0/0/0 [SCREENSHOT]
Recent Closure attempts: none locally recorded [SCREENSHOT]
Grouped diagnostic lifecycle: none locally recorded [SCREENSHOT]
Actionable events: none [SCREENSHOT]
Last successful Sync: not recorded [SCREENSHOT]
Current ordinary-Sync result: not recorded [SCREENSHOT]
Provider request aggregate: not aggregate success [SCREENSHOT]
Client child evidence: unavailable locally [SCREENSHOT]

The ordinary-Sync labels above are empty-history placeholders. They do not
describe an earlier Windows Sync and do not prove a current hosted request.

CURRENT-ACTION PRESENTATION BEFORE DIAGNOSTICS
----------------------------------------------
MKS code: MKS-UI-003 [SCREENSHOT]
Title: Current action collapsed into historical result [SCREENSHOT]
Outcome: blocked [SCREENSHOT]
Last proved phase: presentation [SCREENSHOT]
Local mutation: none [SCREENSHOT]
Provider contact: not-started [SCREENSHOT]
Trusted response: not-received [SCREENSHOT]
Operation: #not-recorded [SCREENSHOT]

AFTER ONE DIAGNOSTICS PRESS
---------------------------
Page terminal: diagnostics-ready [SCREENSHOT]
Authentication: authenticated [SCREENSHOT]
Enrollment: enrollment-required [SCREENSHOT]
Readiness: device-enrollment-required [SCREENSHOT]
Pending/uploading/failed/unknown: 0/0/0/0 [SCREENSHOT]
Android local Device: same local-only record, next 1 [SCREENSHOT]
Recent Closure attempts: none locally recorded [SCREENSHOT]
Grouped diagnostic lifecycle: none locally recorded [SCREENSHOT]
Actionable events: none [SCREENSHOT]
Current-action MKS code: MKS-UI-003 [SCREENSHOT]
Current-action local mutation/provider contact/trusted response:
none/not-started/not-received [SCREENSHOT]

BEFORE/AFTER DIFFERENTIAL
-------------------------
Diagnostics snapshot refreshed: PASS
Page terminal changed to diagnostics-ready: PASS
Authentication or enrollment state changed: NO
Queue or Device sequence changed: NO
Attempt or diagnostic history created: NO
Provider contact occurred: NO
Local mutation occurred: NO
MKS-UI-003 fallback remained visible: YES

SCREENSHOTS
-----------
Before Diagnostics:
- 88867876-ca9f-494a-a378-ad6da3c08543.png
- f7820412-13fc-42df-b6b4-5a44c0bdcdf9.png
- baee461d-0569-4730-8056-939c4f2ca9eb.png
- 9872f6a7-9c94-4dc1-a003-f8857aa80853.png
- 5549872c-6e4a-4f05-9d1e-2c309b29d4db.png

After Diagnostics:
- 6024f960-1734-467d-8e20-ac0c2c40a790.png
- 02b308d5-0291-46a6-bab5-45df79f17cd5.png
- dcabeb7e-445d-4301-8d7a-15abb41c15de.png
- 9f564105-d1a0-4915-a690-a5075badbcf8.png
- 44866baf-c6fe-40da-b57c-5a76b9a20b24.png

EVIDENCE CEILING
----------------
Main-owned selector repair passed actual Android launch: SUPPORTED
Visible installed build matches provenance 65c9ab56079c: PASS
Android Closure parity is usable at runtime: PASS
Android local pre-enrollment state is frozen: PASS
Android authentication currently projects authenticated: PASS
The authenticated identity is the intended same Account: OPERATOR-INTENDED,
NOT EXACTLY PROVED BY SCREENSHOTS
The complete Android local database is newly created: UNPROVED
The Android state was copied from the Windows SQLite database: REJECTED
The Android local state may have survived an earlier Android install because
the launcher preserves app data: POSSIBLE / NOT CLASSIFIED
Fresh provider active-Device count before enrollment: NOT RECHECKED
Android enrollment or two-Device provider binding: UNPROVED
Any inter-device convergence: UNPROVED

OBSERVATION
-----------
The visible diagnostics are read from the Android client's own local
Drift/SQLite state plus its current native authentication session. They use the
same schema and presentation vocabulary as Windows, but are not a live view of
the Windows SQLite file. The local-only Device fingerprint differs from the
sanitized Windows Device fingerprint in Record 013, its local next sequence is
1, and it has no local attempt, diagnostic or actionable-event history.

Because `GRM-FLUTTER-AND` installs while preserving application data, this
packet cannot prove that every Android catalogue or local row was created in
this run. The visible hosted/synchronization projection is nevertheless a
clean pre-enrollment projection.

The Diagnostics press is working as a local read-only snapshot action. The
remaining MKS-UI-003 card is a presentation fallback produced when no
diagnostic event exists for the current Sign-in/Diagnostics action. It is not
evidence of authentication failure, provider contact, local mutation, or an
old Windows assay. Preserve it as a non-blocking presentation defect. During
enrollment, use the page terminal and post-restart Diagnostics as the
authoritative client evidence; never repeat Enroll merely to replace this
card.

NEXT SAFE ACTION
----------------
Do not press Enroll yet. First obtain the exact read-only pre-enrollment
provider baseline and one warm hosted-readiness result. The expected provider
baseline remains one active Windows Device and the accepted GCM02 payload
counts. After that evidence is reconciled, freeze and authorize exactly one
Android Enroll click with expected active-Device count 1 -> 2, Android provider
next expected sequence 1, unchanged payload/cursor/acknowledgement counts, and
no Windows or Android Sync.
```

## RECORD 014 ASSESSMENT

| Claim | Assessment | Evidence boundary |
| --- | --- | --- |
| Main-owned Android selector correction reached the intended AVD | PASS | C3 actual-fence fixtures plus human launched `DEV-GRM` surface |
| The installed Android artifact has the intended lineage | PASS | Visible build provenance `65c9ab56079c` |
| Android Closure parity is operational | PASS BOUNDED | Shared consolidated surface visible; no enrollment or Sync |
| Android pre-enrollment local projection is frozen | PASS | Local-only Device, next 1, queue 0/0/0/0, no attempts/events |
| Android Sign in works | PASS AT CLIENT SCOPE | `authenticated` visible after ordinary Sign in |
| Same-Account binding is exactly proved | OPEN | Screenshots expose no Account-binding proof |
| Diagnostics causes provider or queue mutation | REJECTED | Before/after state is invariant and provider contact is not-started |
| MKS-UI-003 is prior Windows assay data | REJECTED | It is the current Android empty-history fallback |
| MKS-UI-003 blocks enrollment semantics | NO | Presentation residual; top terminal and post-restart evidence remain available |
| Android SQLite was copied from Windows | REJECTED | Separate local Device identity and local database boundary |
| Complete Android storage is fresh | UNPROVED | Install preserves application data |
| Enrollment is authorized by this record | NO | Read-only provider/readiness preflight remains |

Terminal classification:

```text
C10_GCM03_ST04_R1_C3=VALIDATED
ANDROID_DEVICE_ENUMERATION=CORRECTED
ANDROID_BUILD_LINEAGE=PASS_65C9AB56079C
ANDROID_CLOSURE_RUNTIME=PASS_BOUNDED
ANDROID_PRE_ENROLLMENT_SNAPSHOT=PASS
ANDROID_LOCAL_DEVICE=DISTINCT_LOCAL_ONLY_NEXT_1
ANDROID_QUEUE=PASS_0_0_0_0
ANDROID_AUTHENTICATION=PASS_CLIENT_SCOPE
SAME_ACCOUNT_EXACT_BINDING=OPEN
DIAGNOSTICS_BUTTON=PASS_READ_ONLY_REFRESH
MKS_UI_003_EMPTY_HISTORY_PRESENTATION=OBSERVED_NON_BLOCKING
ANDROID_STORAGE_FRESHNESS=UNPROVED_PRESERVED_DATA_POSSIBLE
C10_GCM03_ST04=PASSED_BOUNDED
C10_GCM03_ST05=PASSED_CLIENT_AUTHENTICATION_SCOPE
C10_GCM03_ST06=NEXT_READ_ONLY_ENROLLMENT_PREFLIGHT
ANDROID_ENROLLMENT=NOT_AUTHORIZED_YET
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
SECOND_DEVICE_CONVERGENCE=UNPROVED
```

## RECORD 015 — ANDROID ST06 HOSTED-READINESS COLD-BOOT CONTROL

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-28-015-GCM03-ANDROID-HOSTED-READINESS
DATE/TIME (local): 2026-07-28
TESTER: [MANUAL UI COLLECTION]
CLIENT LINEAGE: grm-guarded-provisioning-20260727
VISIBLE BUILD PROVENANCE: retained from Record 014
TARGET: configured Android AVD DEV-GRM; transient ADB serial omitted
ENVIRONMENT: development
ASSAY PURPOSE: Reconcile two explicitly human-triggered hosted-connection
checks after Android cold boot and determine whether the ST06 client
hosted-readiness prerequisite is satisfied without enrollment or Sync.

SAFETY AND ACTION BOUNDARY
--------------------------
Secrets, tokens or credentials copied into this record: NO
Complete Account, subject, Installation or Device identifiers recorded: NO
Complete provider URLs or connection strings recorded: NO
Check hosted connection pressed: YES, twice because the first cold attempt
timed out before a response
Android Enroll executed: NO
Android or Windows Sync executed: NO
Retry, recovery, logout or history clearing executed: NO
Provider mutation attributable to this record: NO

RECENT CLOSURE ATTEMPTS
-----------------------
Newest attempt fingerprint: #03748b75 [SCREENSHOT]
Operation kind: hosted-connection-check [SCREENSHOT]
Result: hosted-connection-ready [SCREENSHOT]
Outcome/phase: completed / response-parsed [SCREENSHOT]
Readiness meaning: ready-does-not-prove-sync [SCREENSHOT]
Scope/deadline owner: client-operation / client [SCREENSHOT]
Deadline applicability: not-applicable [SCREENSHOT]
Sanitized correlation fingerprint: #7f263a5 [SCREENSHOT]
Aggregate HTTP status: 200 [SCREENSHOT]
Aggregate response headers: received [SCREENSHOT]
Observed latency band: less than 3 seconds [SCREENSHOT]

Earlier attempt fingerprint: #b6652cab [SCREENSHOT]
Operation kind: hosted-connection-check [SCREENSHOT]
Result: timeout-before-response [SCREENSHOT]
Outcome/phase: unknown / transport-started [SCREENSHOT]
Guidance: retry-after-connection-review [SCREENSHOT]
Scope/deadline owner: client-operation / client [SCREENSHOT]
Deadline applicability: not-applicable [SCREENSHOT]
Sanitized correlation fingerprint: 10a9f81a [SCREENSHOT]
Aggregate HTTP status: not applicable; inspect child requests [SCREENSHOT]
Aggregate response headers: not applicable; inspect child requests
[SCREENSHOT]
Observed latency band: approximately 30 seconds [SCREENSHOT]

SCREENSHOT
----------
- b33291a1-bfa0-466c-9a4a-c27df45a0e7e.png

EVIDENCE CLASSIFICATION
-----------------------
Human button activations: 2
Durable Closure-attempt rows: 2
Successful hosted-readiness results: 1
Cold attempt with unknown transport outcome: 1
Ordinary synchronization operations proved: 0
Enrollment operations proved: 0

The timeout and ready rows are separate attempts with different sanitized
attempt and correlation fingerprints. The later HTTP-200,
response-headers-received, response-parsed terminal proves client hosted
readiness for this bounded warm control. It does not rewrite or delete the
earlier timeout row and does not prove ordinary Sync, enrollment, provider
payload mutation, or two-Device binding.

The duplicate human press is accepted as an operational cold-boot recovery
observation because the first attempt reached no observable response and the
second produced one bounded ready terminal. No third press is required or
authorized. The timeout remains preserved for later transport/cold-start
analysis; it is not classified as an enrollment failure.

NEXT SAFE ACTION
----------------
Keep Android Enroll and both Sync actions held. Complete the remaining ST06
read-only provider baseline with the canonical GRM-NEON-11 procedure, require
explicit ROLLBACK and PASS, and verify:

- one active Windows Device before Android enrollment;
- submissions/events/acknowledgements remain 1/1/1;
- Account next cursor remains 2 after high-water 1;
- Windows provider next expected sequence remains 2;
- no provider payload, cursor or acknowledgement delta;
- no change to the frozen Windows or Android local queues.

After that evidence is reconciled, Main may freeze and authorize exactly one
Android Enroll press. Do not press Check hosted connection again merely to
replace the preserved timeout row.
```

## RECORD 015 ASSESSMENT

| Claim | Assessment | Evidence boundary |
| --- | --- | --- |
| Android hosted readiness passed | PASS BOUNDED AFTER COLD WARMUP | Later attempt completed with HTTP 200, headers received and response parsed in under three seconds |
| The cold timeout disappeared or was invalid | REJECTED | Earlier attempt remains a distinct `timeout-before-response` row with unknown outcome |
| Two button presses equal two successful operations | REJECTED | Two attempts exist; only the later attempt is ready/completed |
| Hosted readiness proves ordinary Sync | REJECTED | UI explicitly reports `ready-does-not-prove-sync` |
| Hosted readiness proves Android enrollment | REJECTED | Operation kind is `hosted-connection-check`; no enrollment terminal exists |
| A third hosted check is required | NO | The later bounded ready terminal satisfies the client-readiness prerequisite |
| ST06 enrollment is now authorized | NO | Fresh read-only provider baseline and expected-delta freeze remain |

Terminal classification:

```text
C10_GCM03_ST06_CLIENT_HOSTED_READINESS=PASS_AFTER_COLD_START_WARMUP
HOSTED_CONNECTION_HUMAN_ACTIVATIONS=2
HOSTED_CONNECTION_ATTEMPTS_RECORDED=2
HOSTED_CONNECTION_READY_RESULTS=1
HOSTED_CONNECTION_TIMEOUT_BEFORE_RESPONSE=1_PRESERVED_UNKNOWN
HOSTED_CONNECTION_HTTP_200=PASS_LATEST_ATTEMPT
READY_PROVES_SYNC=NO
ANDROID_ENROLLMENT=NOT_AUTHORIZED_YET
ST06_PROVIDER_BASELINE=OUTSTANDING_READ_ONLY
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
```

## RECORD 016 — ANDROID POST-RESTART DURABLE ENROLLMENT CONTROL

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-28-016-GCM03-ANDROID-POST-RESTART
DATE/TIME (local): 2026-07-28, screenshots 11:13-11:14
TESTER: [MANUAL UI COLLECTION]
CLIENT LINEAGE: grm-guarded-provisioning-20260727
VISIBLE BUILD PROVENANCE: 65c9ab56079c
TARGET: configured Android AVD DEV-GRM; transient ADB serial omitted
ENVIRONMENT: development
ASSAY PURPOSE: Verify that the one accepted Android enrollment survives the
required application restart, classify the change from the pre-enrollment
local Device fingerprint to the post-restart hosted Device fingerprint, and
freeze the clean client baseline before exact hosted binding and provider
inspection.

SAFETY AND ACTION BOUNDARY
--------------------------
Secrets, tokens or credentials copied into this record: NO
Complete Account, subject, Installation or Device identifiers recorded: NO
Complete provider URLs or connection strings recorded: NO
Android application restart completed: YES [USER STATEMENT/UI PACKET]
Android Diagnostics executed after restart: YES [USER STATEMENT]
Android Enroll repeated: NO
Android or Windows Sync executed: NO
Retry, recovery, logout or history clearing executed: NO
Provider mutation attributable to Diagnostics: NO

POST-RESTART CLIENT PROJECTION
------------------------------
Authentication: authenticated [SCREENSHOT]
Enrollment: device-enrolled [SCREENSHOT]
Current Device enrollment: device-enrolled [SCREENSHOT]
Pending/uploading/failed/unknown: 0/0/0/0 [SCREENSHOT]
Next Device sequence: 1 [SCREENSHOT]
Actionable events: none [SCREENSHOT]
Recent Closure attempts: none locally recorded [SCREENSHOT]
Last successful Sync: not recorded [SCREENSHOT]
Recovery guidance: no-local-sync-action-needed [SCREENSHOT]
Ordinary-Sync result: not recorded [SCREENSHOT]
Provider request aggregate: not aggregate success [SCREENSHOT]
Provider contact for displayed current action: not-started [SCREENSHOT]
Trusted response for displayed current action: not-received [SCREENSHOT]

DEVICE-IDENTITY HANDOFF
-----------------------
Pre-enrollment local-only Device fingerprint: #2b75367e [RECORD 014]
Post-restart current enrolled Device fingerprint: #a4d906aa [SCREENSHOT]
Fingerprint unchanged: NO
Fingerprint collision with frozen Windows Device: NOT OBSERVED

The change is consistent with the implemented composition boundary:
before enrollment, runtime composition uses the locally generated Device
identity; after enrollment and restart, it loads the persisted hosted binding
and composes the client with the hosted server Device identity. The UI
fingerprint change therefore does not by itself indicate loss of enrollment.
It also does not prove exact hosted authorization. That remains the purpose of
GRM-AUTH-02 and the exact-device guard in GRM-NEON-11.

CURRENT-ACTION PRESENTATION
---------------------------
MKS code: MKS-UI-003 [SCREENSHOT]
Title: Current action collapsed into historical result [SCREENSHOT]
Outcome: blocked [SCREENSHOT]
Last proved phase: presentation [SCREENSHOT]
Local mutation: none [SCREENSHOT]
Provider contact: not-started [SCREENSHOT]
Trusted response: not-received [SCREENSHOT]
Operation: #not-recorded [SCREENSHOT]

This is the already bounded empty-history presentation fallback. It does not
contradict the authoritative authenticated/device-enrolled projection and
must not cause a second Enroll, Sync, Retry or recovery action.

SCREENSHOTS
-----------
- 8a459457-2f4f-46d6-9a2f-839108993396.png
- 222ff829-be78-4478-87dd-b092709500c3.png
- 34a0fc42-1201-4322-8dff-f8b42702abf8.png
- 79de6a18-8611-4fa9-9ff3-16d1f2424762.png
- 5e4da6ae-a6e7-4542-972d-c997636e58bb.png

EVIDENCE CEILING
----------------
Enrollment survived the required restart at client projection scope: PASS
Post-restart authentication: PASS AT CLIENT SCOPE
Clean Android local queue: PASS
Fresh Android sequence baseline: PASS AT CLIENT SCOPE
Expected local-to-hosted Device identity handoff: SUPPORTED BY SOURCE/UI
Exact hosted Account/Device authorization: UNPROVED; GRM-AUTH-02 REQUIRED
Exact provider Device row and two-Device inventory: UNPROVED;
GRM-NEON-11 REQUIRED
Android purchase created after this packet: NO EVIDENCE
Windows or Android Sync: UNPROVED / NOT AUTHORIZED
Inter-device convergence: UNPROVED
```

## RECORD 016 ASSESSMENT

| Claim | Assessment | Evidence boundary |
| --- | --- | --- |
| Android enrollment survives restart | PASS BOUNDED | Post-restart client projects `device-enrolled` |
| Post-restart authentication is active | PASS AT CLIENT SCOPE | UI projects `authenticated` |
| Android is still at a clean pre-event baseline | PASS | Queue `0/0/0/0`, next sequence `1`, no actionable event |
| Changed fingerprint means enrollment was lost | REJECTED | Client is enrolled; source intentionally switches from local identity to persisted hosted `serverDeviceId` after restart |
| Changed fingerprint proves exact hosted binding | NO | Requires hosted Device-status authorization and provider exact-device guard |
| MKS-UI-003 is an enrollment failure | REJECTED | Empty-history presentation fallback with no provider contact or local mutation |
| An Android purchase may be mixed into the baseline checks | NO | It would alter queue and next sequence before AUTH-02/NEON-11 reconciliation |
| S08 convergence may begin now | HELD | Exact hosted binding and post-enrollment two-Device provider baseline remain open |

Terminal classification:

```text
C10_GCM03_S07_INNER_STEP_01=PASS
C10_GCM03_S07_INNER_STEP_02=PASS
C10_GCM03_S07_INNER_STEP_03=PASS
C10_GCM03_S07_INNER_STEP_04=PASS_PRE_RESTART_CLIENT_SCOPE
C10_GCM03_S07_INNER_STEP_05=PASS_POST_RESTART_CLIENT_SCOPE
ANDROID_POST_RESTART_AUTHENTICATION=PASS_CLIENT_SCOPE
ANDROID_DURABLE_ENROLLMENT=PASS_CLIENT_SCOPE
ANDROID_QUEUE_BASELINE=PASS_0_0_0_0
ANDROID_NEXT_DEVICE_SEQUENCE=1
ANDROID_DEVICE_FINGERPRINT_HANDOFF=EXPECTED_LOCAL_TO_HOSTED
EXACT_HOSTED_ANDROID_BINDING=OPEN_GRM_AUTH_02
TWO_DEVICE_PROVIDER_BASELINE=OPEN_GRM_NEON_11
ANDROID_PURCHASE=HELD
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
C10_GCM03_S08=HELD_PENDING_READ_ONLY_CHECKS
```

---

# APPENDIX F — GCM03 S08 EXACT BINDING AND TWO-DEVICE BASELINE

This appendix is append-only. It reconciles the previously sanitized GCM03
Android enrollment/post-restart reports with the operator-supplied
`GS-AUTH-02` and `GS-NEON-11 -Action provider-baseline` terminals collected on
2026-07-29. Complete tokens, UUIDs, subjects, connection strings and private
provider coordinates remain omitted.

## RECORD 017 — POST-ENROLLMENT EXACT BINDING / PROVIDER BASELINE

```text
MARKEI CLOSURE ASSAY — SANITIZED RECORD
========================================

ASSAY ID: REC-2026-07-29-017-GCM03-S08-EXACT-BINDING-BASELINE
DATE/TIME (local): 2026-07-29
TESTER: [MANUAL TERMINAL COLLECTION]
CLIENT/REPOSITORY BRANCH: grm-guarded-provisioning-20260727
ENVIRONMENT: development
DATABASE: markei_sync_dev
AUTH PROCEDURE: GS-AUTH-02
PROVIDER PROCEDURE: GS-NEON-11 / provider-baseline
ASSAY PURPOSE: Prove the post-restart Android user token and retained hosted
Device UUID resolve to one exact authorized binding, then freeze a
transactionally read-only two-Device provider baseline before any
inter-device convergence action.

SAFETY AND ACTION BOUNDARY
--------------------------
Fresh user access token pasted to masked local prompt: YES
Complete token copied into this record: NO
Complete hosted Device UUID pasted to masked local prompt: YES
Complete Device UUID copied into this record: NO
Password pasted to masked local prompt: YES
Password copied into this record: NO
Connection string or complete private URL copied into this record: NO
Android purchase created: NO
Windows or Android Sync executed: NO
Retry, recovery, migration, revocation or provider repair executed: NO
Provider-baseline transaction committed: NO
Explicit provider rollback observed: YES

AUTH0 / HOSTED BINDING RESULT
-----------------------------
Issuer matches configured issuer: PASS
Audience matches configured audience: PASS
Algorithm matches accepted algorithm: PASS
Subject claim present: PASS
Token time window valid: PASS
Identity endpoint: HTTP 200
Device endpoint: HTTP 200
Token accepted: PASS
Exact Device binding: PASS
Binding class: exact-binding-confirmed

PROVIDER CONNECTION RESULT
--------------------------
Role login: PASS
Database target: markei_sync_dev
TLS: active
Declared launcher environment: development
Declared launcher branch label: markei-c10
Declared launcher role: markei_migrator
Human-readable Neon branch alias independently proved by launcher: NO

The launcher limitation is a coordinate-provenance ceiling, not a query
failure. The authenticated role/database/TLS terminal and the returned
inventory are proved; the displayed branch label remains a declared
non-secret selector unless separately reconciled against the Neon control
plane.

TRANSACTIONAL PROVIDER INVENTORY
--------------------------------
Transaction opened: BEGIN
Fixture Device matches: 1
Exact Device guard: 1

Account rows: 1
Device rows: 2
Account cursor-state rows: 1
Submission rows: 1
Sync-event rows: 1
Device-acknowledgement rows: 1

Accounts missing cursor state: 0
Orphan cursor-state rows: 0

Fixture Account rows: 1
Fixture Account Device rows: 2
Fixture Account cursor-state rows: 1
Fixture submission rows: 1
Fixture Sync-event rows: 1
Fixture Device-acknowledgement rows: 1
Exact fixture Device status: active
Exact fixture Device next expected sequence: 1

Account next cursor: 2
Hosted Account high-water: 1
Account cursor consistent: true

Exact Device next expected sequence: 1
Exact Device high-water: 0
Exact Device sequence consistent: true

Exact Device submission count: 0
Exact Device distinct request hashes: 0
Exact Device submission fingerprints: none
Exact Device request-hash fingerprints: none

Exact Device Sync-event count: 0
Exact Device distinct content hashes: 0
Exact Device event fingerprints: none
Exact Device content-hash fingerprints: none

Transaction terminal: ROLLBACK
Procedure terminal: PASS — provider-baseline completed

RECONCILIATION
--------------
The Auth0 token and retained Android hosted Device UUID resolve through both
hosted identity and Device-status endpoints with an exact binding. This closes
the exact-hosted-binding gap left by Record 016.

The provider contains one Account and two Device rows. The exact selected
Android Device is active at its clean provider sequence baseline: next
expected sequence 1 after high-water 0. It owns no submission or Sync event.
Account-level submissions/events/acknowledgements remain 1/1/1, and the
Account cursor remains 2 after high-water 1. Enrollment therefore introduced
the second Device without adding a purchase payload, advancing the Account
cursor, or consuming an Android Device sequence.

The two-Device baseline is accepted only at this read-only development
boundary. The current terminal does not prove either direction of
inter-device convergence, an Android purchase, a Windows queue refresh,
production readiness, retention, snapshot or rebootstrap behavior.

NEXT SAFE ACTION
----------------
Keep both Sync buttons, Android purchase creation, Retry, recovery and provider
mutation held. Prepare a separate Windows-to-Android authorization packet
that:

1. reconfirms the frozen Windows sequence-2 purchase remains the sole pending
   upload member and the Android queue remains 0/0/0/0 at next sequence 1;
2. derives the exact per-phase submission, event, cursor, Device-sequence and
   acknowledgement deltas from the implemented protocol;
3. authorizes at most one Windows ordinary Sync first;
4. requires client, Render and provider postflight reconciliation before any
   Android ordinary Sync;
5. authorizes at most one Android ordinary Sync only after the Windows phase
   is classified as expected success;
6. preserves a stop on timeout, unknown, failed, notApplied, unexpected count,
   cursor/sequence inconsistency, duplicate/missing purchase, or binding
   rejection.

Do not create the reverse-direction Android purchase until the
Windows-to-Android member is proved converged and the catalogue-selection
defect is separately corrected and validated.
```

## RECORD 017 ASSESSMENT

| Claim | Assessment | Evidence boundary |
| --- | --- | --- |
| Fresh Auth0 user token is structurally and temporally accepted | PASS | Issuer, audience, algorithm, subject and time-window checks |
| Token resolves to the intended hosted identity and Device | PASS | Identity and Device endpoints HTTP 200; exact-binding-confirmed |
| Exact Android hosted Device row exists and is active | PASS | Fixture match 1, exact guard 1, status active |
| Account owns two Device rows | PASS | Account-scoped provider count 2 |
| Enrollment added purchase payload or advanced cursor | REJECTED | Payload remains 1/1/1; cursor remains 2 after high-water 1 |
| Android has already submitted or received an event | REJECTED | Exact Device submission/event counts 0/0; high-water 0 |
| Android provider sequence baseline is internally consistent | PASS | Next expected sequence 1 after high-water 0 |
| Provider inspection mutated durable state | REJECTED | Explicit `BEGIN` / `ROLLBACK`; procedure PASS |
| Launcher independently proved the Neon branch alias | NO | Explicit launcher caveat retained |
| S08 proves inter-device convergence | NO | No Sync or cross-client apply occurred |
| S08 authorizes either Sync action | NO | Separate exact-delta/action packet remains required |

Terminal classification:

```text
CYCLE10=OPEN
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
C10_GCM03_S07=PASS_BOUNDED_CLIENT_SCOPE
C10_GCM03_S08_AUTH0_BINDING=PASS_EXACT_BINDING_CONFIRMED
C10_GCM03_S08_PROVIDER_BASELINE=PASS_ROLLBACK
ANDROID_EXACT_HOSTED_BINDING=PASS
PROVIDER_ACCOUNT_COUNT=1
PROVIDER_DEVICE_COUNT=2
PROVIDER_PAYLOAD_COUNTS=PASS_1_1_1
PROVIDER_ACCOUNT_CURSOR=CONSISTENT_2_AFTER_1
ANDROID_PROVIDER_SEQUENCE=CONSISTENT_1_AFTER_0
ANDROID_PROVIDER_SUBMISSIONS_EVENTS=0_0
NEON_BRANCH_ALIAS_INDEPENDENTLY_PROVED_BY_LAUNCHER=NO
C10_GCM03_S08=PASSED_READ_ONLY_EXACT_BINDING_TWO_DEVICE_BASELINE
SECOND_DEVICE_CONVERGENCE=UNPROVED
GCM03_NEXT=WINDOWS_TO_ANDROID_AUTHORIZATION_PACKET
ANDROID_PURCHASE=HELD
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
```

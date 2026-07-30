# H_DDC_CODEX - C10-GCM03-S10-R05

## Evidence Boundary

This report is Codex observational evidence for R05 materialization. It does not promote live Sync, close GCM03, or replace Main reconciliation.

D was executable authority. E limited evidence interpretation. F defined architecture.

## Requirement-To-Test Mapping

- No upload, committed inbound apply, acknowledgement success:
  - `acknowledgement request preserves trusted download and committed apply`
- No upload, committed inbound apply, acknowledgement transport exception:
  - `acknowledgement exception keeps committed apply in runner fallback`
- Successful upload/result persistence followed by inbound apply rollback:
  - `upload commit plus inbound rollback keeps acknowledgement not-started`
- Successful upload/result persistence followed by committed inbound apply and acknowledgement transport exception:
  - `upload commit plus acknowledgement exception preserves every plane`
- Upload unknown/rejected early stop:
  - `upload rejection stops before download and acknowledgement`
  - existing timeout/rejected runner tests.
- Failed or unproved inbound apply keeps acknowledgement not-started:
  - `upload commit plus inbound rollback keeps acknowledgement not-started`
  - `diagnostic row failure preserves upload commit plus inbound rollback`
  - existing unexpected apply rollback tests.
- Diagnostic begin/row/completion failure across compound operations:
  - `diagnostic degradation preserves compound upload apply acknowledgement`
  - `diagnostic row failure preserves upload commit plus inbound rollback`
- Terminal success and runner fallback preserve independent planes:
  - `acknowledgement request preserves trusted download and committed apply`
  - `acknowledgement exception keeps committed apply in runner fallback`
  - `upload commit plus acknowledgement exception preserves every plane`
- Valid cross-plane outcomes avoid false invariant:
  - `upload commit plus inbound rollback keeps acknowledgement not-started`
  - `diagnostic row failure preserves upload commit plus inbound rollback`
- Same-plane contradiction bounded:
  - `same-plane contradiction is bounded by cumulative merge`
- Sanitization:
  - `ordinary Sync lifecycle lines are structured and redacted`
  - `upload commit plus acknowledgement exception preserves every plane`
  - changed-content sensitive scan.
- R03/R04 regression:
  - `remote_purchase_event_applier_test.dart`
  - `local_sync_application_test.dart`
  - `two_device_system_harness_test.dart`
  - catalogue/Store/Product-selector focused suite
  - full Flutter suite.

## Independent Plane Assertions

- Upload plane:
  - Tests assert `uploadRequestState=started`, `uploadTrustedResponseState=received`, `uploadProviderOutcome=committed`, `uploadLeaseLocalState=committed`, and `uploadResultPersistenceState=committed`.
  - Rejected upload asserts no download or acknowledgement proof.
- Download and inbound apply plane:
  - Tests assert `downloadRequestState=started`, `downloadTrustedResponseState=received`, `inboundApplyState=committed` or `rolled-back`, and `committedCursorProofState=available` or `unavailable`.
- Acknowledgement plane:
  - Success asserts `acknowledgementRequestState=request-started`, `acknowledgementTrustedResponseState=received`, and `acknowledgementOutcome=applied`.
  - Transport exception asserts request started, trusted response not received, and outcome unknown.
  - Failed/rolled-back apply asserts acknowledgement not-started.
- Diagnostic plane:
  - Begin, row, and completion failures assert `diagnosticPersistenceState=degraded` while core planes remain unchanged.
- Terminal plane:
  - Tests assert terminal result state, safe-action presence, latest proved phase, sanitized exception class where applicable, and forbidden downstream invocation counts.

## Same-Plane Invariant And Cross-Plane Compatibility

- Valid upload result persistence committed plus inbound apply rolled back remains a valid compound state and does not emit `diagnostic-causal-invariant-conflict`.
- Upload provider committed plus acknowledgement unknown remains valid.
- Inbound apply committed plus acknowledgement request-started/response-not-received remains valid.
- Same inbound apply plane committed plus rolled-back is bounded as `diagnostic-causal-invariant-conflict`.

## Forbidden Downstream Calls

- Upload rejection asserts downloads and acknowledgements remain zero.
- Rolled-back inbound apply asserts acknowledgement count remains zero.
- Acknowledgement transport exception asserts one acknowledgement attempt only and no automatic retry/recovery/query/second Sync.

## Sanitization Assertions

- Lifecycle tests reject payload/business fixtures, request hashes, raw cursor values, tokens, authorization text, exception messages, stacks, SQL, and unbounded diagnostic strings.
- Changed-content sensitive scan reported no high-risk secret-pattern matches.
- New plane fields contain bounded state vocabulary only.

## PRC-01 Ceiling

Evidence strength is source inspection, deterministic runner/coordinator tests, regression tests, and packaging/build inspection. It proves R05 source truth-plane separation at automated scope only.

It does not prove preserved Android/Windows runtime state, installed-client behavior, hosted provider convergence, live acknowledgement, inter-device sync acceptance, GCM03 closure, or MVP Sync acceptance.

## Partial, Skipped, Or Missing Direct Tests

No required R05 direct test is missing at automated scope. Four disposable hosted/provider labs were skipped because `MARKEI_RUN_SYNC_LAB=1` was absent and are not live evidence.

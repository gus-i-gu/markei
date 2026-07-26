# H_DDC_CODEX - C10-GCM02-S12-REC-01

Evidence class: repository-proven and test-validated unless marked otherwise.

## Meaning Projection

The Closure UI now distinguishes three meanings:

- Retry unknown-outcome submission: reuses the existing unresolved unknown-outcome submission path.
- Inspect failed/notApplied recovery: read-only, network-free, no local mutation.
- Recover failed/notApplied candidate: separately confirmed bounded recovery plus at most one upload request, stopping after upload-result persistence.

Implementation does not authorize human execution. Gate 12.7 remains held.

## Diagnostic Language

Eligible failed/notApplied inspection now emits MKS-REC-001 instead of MKS-UI-004.

- MKS-REC-001 means a read-only inspection found exactly one current-device failed/notApplied candidate with compatible state, membership, request hash, sequence bounds, next sequence, and queue isolation.
- MKS-UI-004 remains available for the historical "missing action" UI defect and is no longer used for eligible preflight.
- Blocked failed/notApplied inspection and recovery ambiguity continue to use MKS-REC-012.

The generated documentation, Dart projection, and TypeScript projection were regenerated from the single registry owner.

## UI Projection

The new confirmation text states that the action:

- revalidates current Account and Device;
- mutates local failed recovery state;
- sends at most one provider upload request;
- persists that upload result;
- does not run download, acknowledgement, enrollment, repair, cleanup, ordinary Sync, or automatic retry;
- changes nothing when cancelled.

Current-action diagnostics continue to show MKS code, title, meaning, outcome, last proved phase, local mutation, provider contact, trusted response, safe action, operation fingerprint, and sanitized technical details.

## Evidence Separation

- Proven locally: action names, UI confirmation boundary, local repository invariants, diagnostic code correction, generated projection alignment, and mocked upload boundaries.
- Test-validated: cancellation no-op, exact-batch leasing, one upload maximum, no download or acknowledgement, session disable after execution attempt.
- Human/provider execution: unavailable and not performed.
- Provider result truth for the real failed lineage: unavailable in this round.

## Redaction

The UI and reports use only bounded fingerprints, counts, statuses, sequence ranges, phases, and closed diagnostic values. Raw IDs, tokens, payloads, full hashes, URLs, SQL, exception messages, stack traces, and provider secrets are not displayed by the new surface.

## Didactic Boundary

This materialization clarifies terminology but does not promote permanent didactic memory:

- Inspection is observation.
- Recovery is local state transition plus bounded upload.
- Retry remains unknown-outcome only.
- Ordinary Sync remains broad orchestration and is not Gate 12.7's action.

FAILED_NOT_APPLIED_EXECUTION_SURFACE=IMPLEMENTED
ELIGIBLE_PREFLIGHT_DIAGNOSTIC_CODE=CORRECTED
EXACT_RECOVERED_BATCH=VALIDATED
ONE_UPLOAD_ONLY=VALIDATED
DOWNLOAD_ACK_ABSENT=VALIDATED
NO_PROVIDER_ACTION_DURING_MATERIALIZATION=PASS
GATE_12_7=HELD
GCM02=OPEN

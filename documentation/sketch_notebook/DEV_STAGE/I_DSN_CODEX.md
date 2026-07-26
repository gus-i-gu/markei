# I_DSN_CODEX - C10-GCM02-S12-REC-01

Evidence class: repository-proven and test-validated unless marked otherwise.

## Responsibility Boundaries

- Closure UI owns presentation, explicit confirmation, cancellation, and session-local second-execution prevention.
- NativeAuthClosureRunner owns parent operation identity, diagnostic attempt lifecycle, and runner exception capture.
- FailedNotAppliedRecoveryCoordinator owns the bounded REC-01 orchestration and intentionally has no download or acknowledgement dependency.
- DriftSyncOutboxRepository owns authoritative local candidate identity, request-hash validation, atomic recovery, and exact recovered-batch lease.
- SyncTransport owns the single upload request.
- SyncAttemptRecorder owns persisted parent/child diagnostic evidence.

## State Machine

Bounded recovery sequence:

1. authorization-preflight;
2. binding;
3. failed-recovery-preflight refresh;
4. failed-recovery-local-transition;
5. recovered-batch-validation;
6. upload-lease;
7. upload-transport;
8. upload-provider;
9. upload-result-persistence;
10. terminal.

The coordinator stops at terminal after upload-result persistence. There is no dependency path to download-local-apply or acknowledgement.

## Invariants

The exact recovery path requires:

- signed-in authentication;
- accepted current Device binding;
- exactly one current-device failed/notApplied candidate;
- zero current-device pending, uploading, and unknown work before mutation;
- confirmation snapshot equality for candidate fingerprint, counts, member count, sequence range, and next sequence;
- authoritative internal submission ID retained by the repository;
- contiguous canonical member order;
- all member states failed before recovery and pending before exact lease;
- request-hash equality;
- no accepted members;
- no active upload/unknown overlap;
- no unrelated pending work entering the exact leased batch.

Truncated fingerprints are never used as database selectors. They are drift checks and UI evidence only.

## Diagnostic Design

The single registry remains the owner of MKS definitions. MKS-REC-001 was refined for eligible failed/notApplied preflight and regenerated into Dart, TypeScript, and Markdown.

The bounded coordinator emits ordered parent/child diagnostics using the existing v1 envelope and Drift v12 ledger. No v13 migration was required.

## Architectural Findings

Unknown Retry, Inspect failed/notApplied recovery, Recover failed/notApplied candidate, and ordinary Sync are now separate surfaces.

Ordinary Sync still contains its existing broad recovery orchestration for the accepted ERR-02 baseline, but REC-01 does not route through it. The new Gate 12.7 surface is narrower: exact candidate, exact batch, one upload, stop.

## Validation Design

Tests added or updated prove:

- eligible inspection uses MKS-REC-001, not MKS-UI-004;
- cancellation has no mutation and no provider contact;
- exact local recovery returns and leases only confirmed members;
- stale confirmation fails closed without mutation;
- the confirmed action sends one upload, does not download, and does not acknowledge;
- the UI disables a second execution attempt in the application session;
- generated registry projections remain aligned.

Provider and live database validation remain intentionally absent.

FAILED_NOT_APPLIED_EXECUTION_SURFACE=IMPLEMENTED
ELIGIBLE_PREFLIGHT_DIAGNOSTIC_CODE=CORRECTED
EXACT_RECOVERED_BATCH=VALIDATED
ONE_UPLOAD_ONLY=VALIDATED
DOWNLOAD_ACK_ABSENT=VALIDATED
NO_PROVIDER_ACTION_DURING_MATERIALIZATION=PASS
GATE_12_7=HELD
GCM02=OPEN

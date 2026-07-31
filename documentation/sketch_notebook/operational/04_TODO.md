# 04_TODO.md

> Version: C11-PH02 Operational work view
> Branch: `grm-guarded-provisioning-20260727`
> Inspected implementation: `20e3d5f6c2f973d138e3b2680aa8adf96f17d0b6`
> Evidence: `DEV_STAGE/G_OPS_CODEX.md` plus `J_MAIN_STAGE.md` section 9
> Status: Active derived Operational view

# Current and Deferred Work

## Closed automated/build boundary

- Cycle 10 remains closed at GCM03's two-Device, one-Account development scope; production acceptance remains absent.
- C11-PH01-R01 Purchase/Catalogue reachability and History single-selection corrections are implemented and validated at automated/build scope.
- The R02 test-helper and hidden-Analytics lifecycle correction is implemented and validated.
- C11-PH02 local active-Account-scoped Analytics, complete joined load, typed History handoff, fixed-point operations, responsive state parity, 100-row presentation page and 500-ID selection bound are implemented and validated.
- Focused tests, the 26-test app-shell suite, the full 258-pass/4-skip suite, analysis, Windows release build and Android debug build passed.
- One Windows validation host established the committed ordinary and stress fixture timings; those timings do not generalize to all Devices.

## P0 — PH01 and PH02 human/rendered acceptance

- Perform screenshot-based review of Purchase, Catalogue, History and Analytics at compact, medium and wide boundaries.
- Confirm Purchase/Catalogue field reachability and History checkbox-versus-detail behavior through human interaction.
- Exercise Analytics matrix/card initialization, focus, reset, filtering, selection and typed History handoff in wide and compact layouts.
- Exercise Windows keyboard-only navigation and Narrator.
- Exercise Android TalkBack and real-device density/orientation behavior.
- Review human comprehension of Difference ordering, Percentage part/whole, unavailable results, evidence counts and periods.
- Review locale-sensitive presentation without changing deterministic stored facts.
- Record platform or comprehension defects as new evidence; do not restate automated/build success as human acceptance.

## P0 — Operational portability and bounded-performance confirmation

- Repeat the ordinary and stress fixtures on representative slower Windows and Android hardware when a performance-acceptance target is authorized.
- Confirm that initial load remains one joined Account-scoped request, each local Retry adds one request and local transitions add none.
- Confirm visibility gating prevents hidden Analytics reads during shell navigation and retained page-state transitions.
- Confirm 100-row rendering and the 500-ID selected-scope boundary remain responsive on a real Android Device.
- Keep any index/schema optimization as a separately evidenced and authorized change; the current implementation required none.

## Later C11 work retained

- Enter C11-PH03 only after Main reconciles all PH01/PH02 permanent-domain results.
- Make Settings and Audit functional and complete the tested disposition of Closure capabilities under separate staging.
- Preserve local Analytics, History handoff and PH01 visual behavior while PH03 is investigated.

## Deferred to C12-PHASE02

- GCM04 and conditional R07 reassessment.
- Multiple-Account isolation.
- Membership disablement and Device revocation.
- Outage, timeout and acknowledgement-uncertainty recovery.
- Retention, snapshot and rebootstrap.
- Production deployment, lifecycle and release acceptance.

No source, client, provider, database or live-operation authority is active through this file.

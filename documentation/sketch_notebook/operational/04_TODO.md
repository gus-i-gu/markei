# 04_TODO.md

> Version: C11-PH01 Operational work view
> Branch: `grm-guarded-provisioning-20260727`
> Evidence: Cycle 10 permanent registration plus `DEV_STAGE/G_OPS_CODEX.md`
> Status: Active derived Operational view

# Current and Deferred Work

## Closed evidence boundary

- Cycle 10 is closed at `GCM03=CLOSED_TWO_DEVICE_DEVELOPMENT_SCOPE`.
- Accepted Sync evidence remains limited to two Devices, one Account and the development environment.
- Production acceptance and a final provider-table recount after the golden no-op repeats remain absent.
- C11-PH01-S01 implemented stable destination identity, compact/medium/wide shell policies, the shared visual foundation, and Home/Lists recomposition.
- Focused tests, the full Flutter suite, analysis, Windows release build and Android debug build passed for S01.
- Lists Retry repeats only its local projection read; no live Sync/provider behavior was changed or exercised.

## P0 — C11-PH01-S01 human-platform acceptance

- Review Home, Lists and shell behavior on Windows at compact, medium and wide boundaries.
- Review compact Android layout on a real Device, including density, orientation and retained destination/page state.
- Exercise Windows keyboard-only navigation and Narrator.
- Exercise Android TalkBack.
- Check loading, read-error, first-use-empty, filtered-empty, insufficient-history and populated Lists states.
- Confirm that visual review does not activate Sync, protocol Retry, Recovery, Query or Enroll.
- Record any platform defect as new evidence; do not promote build success into human acceptance.

## P0 — Remaining C11-PH01 page convergence

- Recompose Catalogue, Purchase and History within the accepted shared visual language.
- Preserve their existing business commands, local persistence, selection, projection and export behavior.
- Add focused responsive/widget coverage and rerun the full test, analysis and Windows/Android build gates.
- Perform human Windows/Android visual, keyboard and assistive-technology acceptance after each bounded implementation unit.
- Treat approved golden coverage as a separate future gate; none exists from S01.

## Later C11 work retained

- C11-PH02: implement and validate deterministic local/account-scoped Analytics and History-to-Analytics context handoff.
- C11-PH03: make Settings and Audit functional and complete the tested disposition of Closure capabilities.
- Keep Analytics/Audit destination reservation distinct from implemented functionality.

## Deferred to C12-PHASE02

- GCM04 and conditional R07 reassessment.
- Multiple-Account isolation.
- Membership disablement and Device revocation.
- Outage, timeout and acknowledgement-uncertainty recovery.
- Retention, snapshot and rebootstrap.
- Production deployment, lifecycle and release acceptance.

No source, client, provider, database or live-operation authority is active through this file.

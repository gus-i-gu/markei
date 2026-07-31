# 04_TODO.md

> Version: C11-PH03 Operational derived work view
> Branch: `grm-guarded-provisioning-20260727`
> Inspected implementation: `0924e743931ea7aba2c9cc5d2e28063e737b2ff5`
> Latest Main reconciliation: `J_MAIN_STAGE.md` section 11 at `33dc1002b4a7b00fa67e863dfe98a43c97d66cee`
> Status: Current executable gates and deferred work

# Current and Deferred Work

## Closed implemented and validated boundary

C11-PH03 Settings, local read-only Audit and Closure navigation retirement are implemented and validated at the automated/build boundary. Bounded human UI verification is accepted for documentation and permanent absorption. Do not reopen PH03 for minor visual polish.

## P0 — Remaining human and platform gates

1. Validate Windows keyboard-only traversal and Narrator output for Settings and Audit.
2. Validate Android TalkBack traversal on at least one real Device.
3. Validate compact, medium and wide Audit paging, empty, stale, unavailable and local Retry behavior on representative Windows and Android surfaces.
4. Validate 200-percent text scale, locale-sensitive date/time presentation and supported locale behavior on real platform hosts.
5. Record any remaining accessibility defect separately from C12-PH01 visual refinement.
6. Preserve the evidence ceiling: successful builds and widget tests do not substitute for these gates.

## P0 — Operational portability confirmation

1. On a preserved local database fixture, confirm a non-default shortage threshold survives reopen and remains editable without data loss.
2. Confirm archived People and Payment Methods refresh immediately while existing Purchase history keeps its recorded label.
3. Confirm ordinary Audit use remains available without hosted connectivity and does not initiate Sign in, enrollment, connection check, Sync, protocol Retry, Recovery or provider activity.
4. Confirm Account/environment isolation, deterministic equal-timestamp paging and sanitization on representative multi-Account/multi-environment fixtures.
5. Confirm repeated local Retry and rapid navigation/disposal do not duplicate writes, leak resources or surface stale completions.

## C12-PH01 — Deferred minor UI refinement

- Carry the bounded PH03 visual refinements identified during human verification into C12-PH01.
- Keep the accepted PH03 functionality, two-query Audit boundary, Settings persistence and Closure retirement unchanged unless new evidence proves a regression.
- Do not classify aesthetic refinement as a corrective C11-PH03 source round.

## Deferred to C12-PHASE02

- GCM04 and conditional former R07 work under separate Main and human authority.
- Multiple-Account hosted isolation, membership disablement and Device revocation.
- Outage, timeout and acknowledgement-uncertainty recovery.
- Retention, snapshots, rebootstrap and production lifecycle acceptance.
- Provider recount or production acceptance not established by the C11 local implementation.

No TODO item authorizes source, database, provider, Sync, Main-root, staging or methodology mutation.

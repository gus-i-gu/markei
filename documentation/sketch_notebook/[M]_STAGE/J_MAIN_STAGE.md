# J_MAIN_STAGE — Cycle 10 active reconciliation

> Sequence: FLX-PRM-04 C10-GCM03 S08 exact hosted binding and two-Device
> provider-baseline reconciliation
> Role: Main Chat
> Branch: `grm-guarded-provisioning-20260727`
> Publication parent: `e37f03b66e594a8dd54bbec0de94a42afb3fcecd`
> Authority: explicit human-directed Main reconciliation
> Writable surface: `REC_DIAGNOSTICS.md`, mutable J recovery prefix, and
> append-only `Legacy_Progress`
> Evidence boundary: accepted GCM02 same-Device closure; frozen Windows
> sequence-2 candidate; C3 actual-fence/ADB validation; human Android
> build/install/launch with visible matching provenance; Android local
> pre-enrollment Diagnostics before and after one read-only refresh; ordinary
> Android Sign in with authenticated client projection; two explicitly
> human-triggered hosted-connection checks after cold boot, preserving one
> timeout-before-response and one later HTTP-200 hosted-connection-ready
> terminal; one accepted Android enrollment followed by the required
> application restart and a post-restart authenticated/device-enrolled client
> projection with queue 0/0/0/0 and next sequence 1; fresh masked-session
> `GS-AUTH-02` exact binding; read-only `GS-NEON-11` two-Device provider
> inventory with explicit rollback; no Sync, convergence, Android purchase,
> production, retention, snapshot or rebootstrap claim
> Status: **CYCLE 10 OPEN; GCM02 CLOSED AT HOSTED SAME-DEVICE SCOPE;
> GCM03 S07 INNER STEPS 1–5 PASSED AT BOUNDED CLIENT SCOPE; ANDROID
> ENROLLMENT SURVIVED RESTART; S08 EXACT HOSTED BINDING AND READ-ONLY
> TWO-DEVICE PROVIDER BASELINE PASSED; WINDOWS-TO-ANDROID AUTHORIZATION PACKET
> NEXT; PURCHASE AND BOTH SYNC ACTIONS HELD**

## 1. Recovery entrypoint

This mutable prefix is the current Main recovery surface. Read it before the
append-only `Legacy_Progress` history. Expand into the legacy entries, G/H/I,
permanent domains, GRM, or source only when the current task requires
deeper evidence.

Mandatory methodology boot remains:

```text
AGENTS.md
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/FLUX.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
```

Retain these ownership boundaries:

- Main synthesizes and stages authority.
- A/B/C are functional investigation and reconciliation inputs.
- D/E/F are synchronized Codex materialization authority.
- G/H/I are observational materialization reports.
- J is Main staging and continuity, not permanent domain canon.
- `Legacy_Progress` is append-only and must not be compacted or rewritten.
- Semantic promotion and physical materialization remain distinct.
- Human/provider actions require explicit, narrow authorization.

## 2. Current repository frame

```text
Repository: gus-i-gu/markei
Active branch: grm-guarded-provisioning-20260727
Current publication parent: e37f03b66e594a8dd54bbec0de94a42afb3fcecd
Cycle: 10
Active closure unit: MCG-02 / user-facing GCM-02
Latest completed corrective unit: C10-GCM02-S12-ERR-04 recovery-boundary and
observability correction
Latest accepted gate: Gate 12.7 corrected single-client control
Latest completed presentation unit: C10-GCM02-S12-DIAG-01
Latest completed evidence phase: C10-GCM02-S12-ST10 sanitized Render
correlation and Gate-12.10 terminal classification
Latest completed correction: C10-GCM03-ST04-R1-C3 Main-owned Android selector
repair validation
Latest human evidence: Android build/install/launch at visible provenance
65c9ab56079c, local pre-enrollment Diagnostics, authenticated client state,
hosted readiness after one preserved cold-start timeout and one later ready
HTTP-200 attempt, accepted one-time enrollment, and post-restart durable
authenticated/device-enrolled projection with a clean queue and next
sequence 1; masked-session `GS-AUTH-02` exact binding; and transactional
`GS-NEON-11` provider-baseline PASS with explicit rollback
Active phase: GCM03 S09 Windows-to-Android convergence authorization-packet
preparation; the Windows candidate member remains frozen and Android purchase
and both Sync actions are not yet authorized
```

The branch contains the GRM execution interface, hosted Sync
implementation and diagnostics, account-cursor provisioning repair,
human-operated provider evidence, and the latest Gate 12.6 staging.

The old `intermid-cycle-recovery` branch carried earlier J reconciliations.
Their accepted meaning has already been reconciled into this branch. Do not
merge that historical branch merely to recover J content.

The earlier parallel J/Codex and GRM-refactor rounds are integrated in the
current branch baseline. Do not replay their local-equivalent commits onto this
branch.

REC-01 was materialized at `a63367763716e2769ac58d5adc19de0c41774b35`.
Codex explicitly preserved the then-unrelated local dispatcher rename. The
subsequent isolated GRM alignment unit materializes
`documentation/NEON_CHECK.ps1` as `documentation/I_SCRIPTS.ps1` and aligns
every live five-file-interface reference. Historical occurrences under
`Legacy_Progress` remain observational evidence.

The subsequent `3d1e82e5259cf51e8cd2d6baf694423494bab7a5`
baseline renames the generated diagnostic projection to
`documentation/ERR_DIAGNOSTICS.md`. That rename is accepted as repository
state. The broad ERR-catalogue refactor remains deferred until the present
narrow assays conclude.

### 2.1 Controlling ST10 closure and GCM03 entry

This subsection is the newest controlling recovery surface. When an older
mutable-prefix statement conflicts with it, this subsection controls. The
older text remains available as pre-ST09 staging context, and the complete
chronology remains append-only under `Legacy_Progress`.

GCM02 now reconciles five aligned evidence families:

```text
Records 009-010
  exact hosted binding
  clean provider baseline 0/0/0
  Windows empty queue and sequence alignment

controlled member preflight
  authenticated and device-enrolled
  one pending purchase.registered event at Device sequence 1
  local next Device sequence 2
  warm hosted readiness HTTP 200 after one cold-start timeout

authorized Windows ordinary Sync
  exactly one click
  sync-completed
  pending 1 -> 0
  failed/unknown 0/0
  current Device next sequence 2

GRM-NEON-11 postflight
  exact Device guard 1
  submissions/events/acknowledgements 1/1/1
  Account cursor 2 after high-water 1, consistent
  Device sequence 2 after high-water 1, consistent
  one distinct sanitized request/content lineage
  explicit ROLLBACK and PASS

ST10 Render correlation
  one matching operation fingerprint across three Sync children
  upload-submission POST authenticated and completed HTTP 200
  download-events GET authenticated and completed HTTP 200
  acknowledgement POST authenticated and completed HTTP 200
  no rejected, failed, >=400, timeout, unknown, unexpected-error or MKS line
```

Reconciled meaning:

- the first correlated same-Device transition on the replacement development
  provider succeeded at client/local/provider scope;
- the actual provider delta exactly equals the frozen one-event contract;
- there is no failed, unknown or actionable local residue;
- acknowledgement, Account cursor and Device sequence projections agree;
- the cold-start readiness timeout is operational sensitivity, not a Sync
  contradiction, because both host endpoints and the immediately subsequent
  client readiness check passed before authorization;
- the Product selection/staging defects observed while creating the test member
  were contained locally and did not contaminate the successful assay;
- ST09 therefore passes at the same-Device transition boundary;
- ST10 correlates the exact same operation across all three server children;
- the client, server and provider terminals agree without contradiction;
- Gate 12.10 therefore classifies the operation as expected success;
- GCM02 closes at its hosted same-Device scope;
- second-Device enrollment and convergence remain unproved and begin only
  under a separately defined and authorized GCM03 sequence.

Current terminals:

```text
CYCLE10=OPEN
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
STEP12=CLOSED_THROUGH_GATE_12_10
GATE_12_7=PASSED_CORRECTED_SINGLE_CLIENT_CONTROL_SCOPE
ST08=PASSED_EXACT_BINDING_AND_CLEAN_PROVIDER_BASELINE
ST09_LOCAL_PREFLIGHT=PASS
ST09_CONTROLLED_MEMBER=ONE_PURCHASE_REGISTERED_SEQUENCE_1
ST09_HOSTED_READINESS=PASS_AFTER_COLD_START_WARMUP
ST09_ONE_ACTION_AUTHORIZATION=SATISFIED
ST09_ORDINARY_SYNC=PASS_EXACTLY_ONCE
ST09_CLIENT_TERMINAL=SYNC_COMPLETED
ST09_LOCAL_QUEUE=PASS_DRAINED_1_TO_0
ST09_PROVIDER_COUNTS=PASS_1_SUBMISSION_1_EVENT_1_ACK
ST09_ACCOUNT_CURSOR=CONSISTENT_2_AFTER_1
ST09_DEVICE_SEQUENCE=CONSISTENT_2_AFTER_1
ST09_PROVIDER_POSTFLIGHT=ROLLBACK_PASS
ST09=PASSED_SAME_DEVICE_CLIENT_PROVIDER_TRANSITION_SCOPE
ST10_RENDER_CORRELATION=PASS_THREE_AUTHENTICATED_HTTP_200_TERMINALS
ST10_FAILURE_OR_AMBIGUITY=ABSENT
ST10=PASSED_READ_ONLY
GATE_12_10=PASS_EXPECTED_SUCCESS
NEW_SYNC_OR_RETRY=NOT_AUTHORIZED
ENROLLMENT_OR_MIGRATION=NOT_AUTHORIZED
SECOND_DEVICE=UNPROVED_READY_FOR_GCM03_DEFINITION
GCM03=READY_FOR_DEFINITION_AND_READ_ONLY_PREFLIGHT
```

The shortest evidence-correct GCM03 entry is:

1. preserve the newly reported unsynchronized purchase without another Sync;
2. run Windows Diagnostics once to freeze its event type, queue class, Device
   sequence and next sequence;
3. reconfirm the provider remains at the accepted GCM02 `1/1/1` baseline
   before any new action, only if the GCM03 contract requires it;
4. verify Android toolchain/client lineage and establish a fresh, clearly
   identified local Device state;
5. sign in to the same Account without reusing or exposing tokens;
6. capture Android pre-enrollment Diagnostics and prepare an exact enrollment
   authorization packet;
7. enroll the Android Device exactly once only after explicit authorization;
8. reconcile the two-Device provider inventory before authorizing any upload
   or download/convergence action.

Record 013 now proves that the new unsynchronized Windows purchase is one
pending `purchase.registered` event at Device sequence 2, with
pending/uploading/failed/unknown `1/0/0/0` and next Device sequence 3. It is
the frozen candidate Windows-to-Android convergence member. Do not Sync,
recreate or discard it while Android readiness and pre-enrollment state are
prepared.

### 2.2 GCM03 TODOs and Android check placement

GCM03 is an investigative, separately authorized unit. This list defines its
evidence order; it does not authorize enrollment or Sync.

- [x] **GCM03.1 — Freeze Windows candidate member.** Record 013 proves one
  pending `purchase.registered` event at Windows Device sequence 2, next
  sequence 3, and no uploading/failed/unknown residue.
- [x] **GCM03.2 — Reconfirm repository and provider baseline.** Fast-forward
  the Windows checkout to the published GCM02 closure commit, require a clean
  worktree, run read-only host readiness, and use `GRM-NEON-11` only if Main
  requires a fresh pre-enrollment provider inventory. Expected pre-enrollment
  payload baseline remains the accepted GCM02 `1/1/1`, with one active Device.
  **Passed through the post-enrollment boundary:** Android artifact lineage
  `65c9ab56079c` is proved. The client
  hosted-readiness prerequisite passed after one preserved cold-start
  `timeout-before-response` attempt and one later
  `hosted-connection-ready`/HTTP-200 attempt. Record 017 adds exact hosted
  binding plus a transactional provider baseline with one Account, two Device
  rows, payload counts `1/1/1`, consistent Account cursor `2` after high-water
  `1`, exact Android sequence `1` after high-water `0`, and rollback/PASS.
- [x] **GCM03.3 — Android environment and client check.** Run canonical
  `GRM-FLUTTER-AND` / `GS-FLUTTER-AND` from the same published checkout.
  Require Flutter/Android toolchain readiness, exactly one supported Android
  target, configured AVD boot where needed, successful Closure build/install/
  launch, and the same public Auth0/Render coordinate lineage. This step must
  not sign in, enroll or Sync implicitly. **Passed bounded:** C3 validated the
  repaired exact fence and one-safe-ADB-serial boundary; the human rerun
  launched `DEV-GRM` with visible matching provenance `65c9ab56079c`.
- [x] **GCM03.4 — Android local pre-enrollment snapshot.** Open Closure on
  Android, preserve sanitized diagnostics, and prove whether the fresh
  installation has no enrolled local Device. Stop on inherited Device state,
  unexpected queue members, configuration mismatch, revoked/expired state, or
  any source Device fingerprint collision. **Passed with storage-freshness
  qualification:** one distinct local-only Android Device at next sequence 1,
  queue `0/0/0/0`, no attempts, diagnostic history or actionable events.
  Complete database freshness is unproved because installation preserves
  Android app data.
- [x] **GCM03.5 — Same-Account authentication.** Sign in through the ordinary
  Auth0 flow to the same test Account. Capture only sanitized authentication
  state; never copy tokens, subjects, credentials or complete identifiers.
  **Passed at client scope:** Android projects `authenticated`. Exact
  same-Account/provider binding remains to be proved by the bounded enrollment
  and provider postflight rather than by screenshots alone.
- [x] **GCM03.6 — Exact Android enrollment authorization packet.** Freeze the
  intended one-click Enroll action, expected new active-Device count
  `1 -> 2`, expected Android local enrollment terminal, evidence-capture
  order, and no-second-click/unknown-outcome rules. Obtain explicit human
  authorization before enrollment. **Passed by the prior bounded S07
  authorization packet; historical action authority is exhausted.**
- [x] **GCM03.7 — Enroll Android exactly once.** Execute only the authorized
  enrollment. Preserve the Android terminal, sanitized Device fingerprint,
  Render enrollment lifecycle and read-only provider inventory. Do not Sync
  either client in this step. **Passed bounded:** one accepted Enroll followed
  by required restart; no second click and no Sync.
- [x] **GCM03.8 — Two-Device baseline reconciliation.** Require one Account,
  two distinct active Devices, Windows next expected sequence 2 on the
  provider, Android next expected sequence at its fresh baseline, and no
  payload/cursor changes caused solely by enrollment. **Passed at the combined
  prior-Windows plus Record-017 boundary:** two Device rows; exact Android
  Device active; Account payload `1/1/1`; cursor `2` after `1`; Android
  sequence `1` after `0`; no Android submission/event; rollback/PASS. The
  launcher branch-alias caveat remains explicit.
- [ ] **GCM03.9 — Windows-to-Android convergence authorization.** Freeze the
  existing Windows sequence-2 event as the only upload member, calculate the
  exact submission/event/cursor/acknowledgement delta, and authorize one
  Windows Sync followed by one Android download Sync only after all stop
  conditions are explicit.
- [ ] **GCM03.10 — Windows-to-Android convergence assay.** Prove Windows queue
  drain, provider acceptance, Android download/application, matching purchase
  identity/content, acknowledgement, and preservation of Android-local state.
- [ ] **GCM03.11 — Android-to-Windows reverse member.** Create exactly one
  controlled Android purchase only after the first direction passes, freeze
  its Android queue/sequence, and prepare a new exact authorization packet.
- [ ] **GCM03.12 — Reverse convergence assay.** Authorize and prove Android
  upload followed by Windows download/application, with exact provider delta
  and no duplication or local-history loss.
- [ ] **GCM03.13 — Idempotent repeat.** With both queues empty and both clients
  converged, authorize one bounded repeat Sync per Device and require no new
  submissions/events, no duplicate purchases, stable cursors/sequences, and
  successful acknowledgements.
- [ ] **GCM03.14 — Reconcile and close.** Correlate client, Render and provider
  evidence; classify every unexpected/duplicate/rejected/unknown result;
  preserve Android operational findings; and close GCM03 only at the proven
  two-Device development scope.

GCM03 global stop conditions:

```text
dirty_or_diverged_checkout
android_target_ambiguous_or_unsupported
android_configuration_or_binding_mismatch
unexpected_inherited_android_device_or_queue_state
authentication_required_or_rejected
binding_invalid
device_revoked_or_expired
enrollment_timeout_unknown_or_duplicate
sync_timeout_unknown_failed_or_notApplied
cursor_or_sequence_inconsistency
unexpected_provider_delta
duplicate_or_missing_purchase_after_apply
```

On any stop condition, preserve the visible terminal and do not repeat the
action merely to improve evidence. Enrollment, Windows Sync, Android Sync,
Retry, recovery, migration, revocation and provider repair each require their
own explicit boundary.

Updated terminals:

```text
CYCLE10=OPEN
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
STEP12=CLOSED_THROUGH_GATE_12_10
GATE_12_10=PASS_EXPECTED_SUCCESS
GCM03_WINDOWS_CANDIDATE_PREFLIGHT=PASS
GCM03_WINDOWS_PENDING_MEMBER=PURCHASE_REGISTERED_SEQUENCE_2
GCM03_WINDOWS_QUEUE=PASS_1_0_0_0
GCM03_WINDOWS_NEXT_DEVICE_SEQUENCE=3
GCM03_ANDROID_SELECTOR_C3=PASS
GCM03_ANDROID_BUILD_LINEAGE=PASS_65C9AB56079C
GCM03_ANDROID_PRE_ENROLLMENT=PASS_LOCAL_ONLY_NEXT_1_QUEUE_0_0_0_0
GCM03_ANDROID_AUTHENTICATION=PASS_CLIENT_SCOPE
GCM03_ANDROID_SAME_ACCOUNT_EXACT_BINDING=PASS_EXACT_BINDING_CONFIRMED
GCM03_ANDROID_HOSTED_READINESS=PASS_AFTER_COLD_START_WARMUP
GCM03_ANDROID_HOSTED_ATTEMPTS=2_WITH_1_READY_1_TIMEOUT_PRESERVED
GCM03_ANDROID_DURABLE_ENROLLMENT=PASS_CLIENT_SCOPE
GCM03_PROVIDER_DEVICE_COUNT=2
GCM03_PROVIDER_PAYLOAD_COUNTS=PASS_1_1_1
GCM03_PROVIDER_ACCOUNT_CURSOR=CONSISTENT_2_AFTER_1
GCM03_ANDROID_PROVIDER_SEQUENCE=CONSISTENT_1_AFTER_0
GCM03_S08=PASSED_READ_ONLY_EXACT_BINDING_TWO_DEVICE_BASELINE
GCM03=ACTIVE_WINDOWS_TO_ANDROID_AUTHORIZATION_PACKET
ANDROID_ENROLLMENT=COMPLETE_DO_NOT_REPEAT
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
SECOND_DEVICE_CONVERGENCE=UNPROVED
GCM04=UNDEFINED_INACTIVE
```

### 2.3 ST04-R1 materialization reconciliation and Android GRM correction

Commit `231a76281d0016ee47dd719d3ddc24d422b18c35` materialized the bounded
Android Closure parity/provenance unit. D/E/F were compared against G/H/I,
the implementation diff, and the live GRM dispatcher cascade.

#### PRC-01 claims

```text
Claim: the shared Flutter Closure parity and build-provenance model passed the
       authorized local materialization boundary
Prior state: Android displayed a legacy Closure surface while current shared
             source appeared consolidated
Evidence: one shared NativeClosurePage; compact/wide coverage; sanitized
          7-12 lowercase-hex provenance projection; 199 passed / 4 lab-gated
          Flutter tests; clean Flutter analysis; local debug APK build with
          explicit provenance define
Evidence boundary: repository, widget tests, analysis and local build only
Contradiction: none inside the Flutter presentation/provenance boundary
Semantic owner: C10-GCM03-ST04-R1 local source result
Target role: J current recovery state
Resulting state: ACCEPTED / LOCALLY VALIDATED
History disposition: append
```

```text
Claim: the pushed GRM-FLUTTER-AND procedure is hardened and ready for a human
       rerun
Prior state: G reports ANDROID_GRM_PROVENANCE=HARDENED and
             ST04=READY_FOR_HUMAN_RETEST
Evidence: implementation scan shows GS-FLUTTER-AND reads $Branch before any
          assignment and later reads $BuildProvenance without assignment;
          their intended producer block was inserted into GS-FLUTTER-WIN
Evidence boundary: exact pushed G_SCRIPTS.md and I_SCRIPTS.ps1 strict-mode,
                   one-fence dispatcher semantics
Contradiction: PowerShell fence parse passed, but parse does not validate
               runtime variable initialization
Semantic owner: Android GRM executable procedure
Target role: corrected D/E/F and later replacement G/H/I
Resulting state: CONTRADICTED / BLOCKED VARIABLE CASCADE
History disposition: supersede only the prior Android-GRM hardening terminal
```

```text
Claim: ST04 or any later GCM03 action may proceed before correction
Prior state: ST04 awaited a human rebuilt-artifact retest
Evidence: canonical Android procedure terminates under strict mode at the
          first undefined $Branch read; $BuildProvenance is also undefined
Evidence boundary: no live Android, authentication or provider action needed
Contradiction: executing the procedure cannot produce the intended artifact
Semantic owner: GCM03 action gate
Target role: Main authorization boundary
Resulting state: REJECTED; ST04 AND ST05+ HELD
History disposition: append
```

#### Accepted and superseded evidence

Retained:

```text
SHARED_CLOSURE_PAGE=CONFIRMED
ANDROID_COMPACT_DIAGNOSTICS=TEST_PASS
BUILD_PROVENANCE=IMPLEMENTED
APPLICATION_DATA_PRESERVATION=DESIGNED_AND_SOURCE_PRESERVED
AUTH_ENROLL_SYNC_PROVIDER_ACTION=ABSENT
```

Superseded:

```text
ANDROID_GRM_PROVENANCE=HARDENED
ST04=READY_FOR_HUMAN_RETEST
```

Current:

```text
ANDROID_GRM_PROVENANCE=BLOCKED_VARIABLE_CASCADE
ST04=BLOCKED_PENDING_C10_GCM03_ST04_R1_C1
```

#### Correction contract

Synchronized D/E/F now authorize one narrow correction:

1. remove the accidentally inserted Android-unit producer/print block from
   `GS-FLUTTER-WIN`, restoring that procedure to its `db17f47` behavior;
2. add Windows-PowerShell-compatible repository containment, `$Branch`,
   `$InspectedHead`, and `$BuildProvenance` initialization inside
   `GS-FLUTTER-AND` before any consumer;
3. preserve the accepted Flutter source, Android coordinates, package,
   data-preserving install, artifact evidence and no-mutation boundaries;
4. validate exact-fence extraction, AST syntax, same-fence producer-before-
   consumer data flow, and a mocked/truncated strict-mode prefix;
5. produce replacement G/H/I without running the live Android procedure.

The human `GRM-FLUTTER-AND` rerun becomes eligible only after correction
review, commit, publication and Main reconciliation. It remains an ST04
artifact-lineage retest, not authentication, enrollment or Sync authority.

Updated terminals:

```text
CYCLE10=OPEN
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03_WINDOWS_CANDIDATE_PREFLIGHT=PASS
GCM03_WINDOWS_PENDING_MEMBER=PURCHASE_REGISTERED_SEQUENCE_2
C10_GCM03_ST04_R1_FLUTTER_SOURCE=ACCEPTED_LOCAL_VALIDATION
C10_GCM03_ST04_R1_ANDROID_GRM=CONTRADICTED
C10_GCM03_ST04_R1_C1=ACTIVE_MATERIALIZATION_STAGE
ST04=BLOCKED_PENDING_GRM_CASCADE_CORRECTION
LIVE_ANDROID_RETEST=NOT_AUTHORIZED_YET
ANDROID_ENROLLMENT=NOT_AUTHORIZED
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
GCM03_ST05_AND_LATER=HELD
SECOND_DEVICE_CONVERGENCE=UNPROVED
GCM04=UNDEFINED_INACTIVE
```

### 2.4 GCM03 S08 exact binding and provider baseline

Record 017 reconciles the masked-session `GS-AUTH-02` and transactional
`GS-NEON-11` terminals against Records 014–016.

The combined evidence proves:

- the fresh user access token satisfies issuer, audience, algorithm, subject
  and time-window checks;
- hosted identity and Device-status endpoints both return HTTP 200;
- the supplied hosted Android Device UUID is exactly bound to the token;
- the provider contains one Account and two Device rows;
- the exact Android Device is active at next expected sequence 1 after
  high-water 0;
- Account-level submissions/events/acknowledgements remain `1/1/1`;
- the Account cursor remains 2 after high-water 1 and is consistent;
- the Android Device owns no submission or Sync event;
- the provider transaction explicitly rolls back and the procedure passes.

The displayed development target label is retained as a launcher declaration.
`GS-NEON-11` does not independently prove the human-readable Neon branch
alias. This provenance ceiling does not contradict the authenticated
role/database/TLS terminal or the returned read-only inventory.

S08 closes exact hosted binding and the post-enrollment two-Device baseline.
It does not prove convergence and it authorizes no Sync. The next controlling
work is GCM03.9: derive and freeze the exact Windows-sequence-2 to Android
convergence action packet. This packet must separate the Windows upload phase,
its client/Render/provider postflight, the later Android download phase, and
its own postflight. Either phase stops on timeout, unknown, failed,
`notApplied`, binding rejection, unexpected delta, cursor/sequence
inconsistency, or duplicate/missing purchase.

Current terminal:

```text
C10_GCM03_S08_AUTH0_BINDING=PASS_EXACT_BINDING_CONFIRMED
C10_GCM03_S08_PROVIDER_BASELINE=PASS_ROLLBACK
GCM03_PROVIDER_DEVICE_COUNT=2
GCM03_PROVIDER_PAYLOAD_COUNTS=PASS_1_1_1
GCM03_PROVIDER_ACCOUNT_CURSOR=CONSISTENT_2_AFTER_1
GCM03_ANDROID_PROVIDER_SEQUENCE=CONSISTENT_1_AFTER_0
GCM03_S08=PASSED_READ_ONLY_EXACT_BINDING_TWO_DEVICE_BASELINE
GCM03=ACTIVE_WINDOWS_TO_ANDROID_AUTHORIZATION_PACKET
SECOND_DEVICE_CONVERGENCE=UNPROVED
ANDROID_PURCHASE=HELD
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
```

## 3. Retained pre-ST08 panorama

The following sections preserve the compact recovery panorama that controlled
before ST08. They are not rewritten as historical records. Section 2.1
supersedes their status, branch, gate, and next-action statements wherever
those statements differ.

Cycle 10 moved Markei from local synchronization groundwork toward bounded,
authenticated, hosted inter-device convergence. It is not yet closed.

### 3.1 Accepted implementation track

The source and reconciled reports establish:

- offline-first local data remains primary;
- immutable append-only Sync events and deterministic request content exist;
- Account/Device-scoped local queues, download/apply, acknowledgements and
  idempotent application paths exist;
- two-Device disposable convergence and recovery harnesses exist;
- hosted Auth0/OIDC verification, membership resolution, Device enrollment,
  query/replay/status/revocation and transaction-scoped authorization exist;
- RLS context and runtime/migrator privilege separation exist;
- Native Closure exposes guarded sign-in, enrollment, query, hosted
  connection, Sync and diagnostic/recovery actions;
- durable Sync-attempt and unknown-outcome observability exists;
- a separate, explicitly confirmed failed/notApplied recovery surface now
  exists, preserving read-only inspection, unknown Retry and ordinary Sync as
  distinct actions;
- the bounded REC-01 coordinator revalidates exact internal candidate identity,
  atomically recovers and leases only its members, performs at most one upload,
  persists that result, and contains no download or acknowledgement path;
- retention, snapshot and rebootstrap contracts and local harness groundwork
  exist.

These are implementation and bounded validation claims. REC-01 specifically
remains host-unvalidated and unexecuted against the user environment. They do
not by themselves establish production readiness, real multi-device
convergence, hosted retention execution, backup/PITR acceptance, or release
acceptance.

### 3.2 Account cursor-state correction

The protected hosted submission failure was traced locally to an Account that
existed without `account_cursor_state`.

The accepted correction lineage includes:

- fail-closed handling for a missing cursor row;
- explicit `service-unavailable / not-applied` classification;
- migration 007 provisioning exactly one cursor-state row for new Accounts;
- backfill only for missing historical rows;
- preservation of existing cursor rows;
- hosted high-water-derived initialization;
- revocation of runtime cursor INSERT/DELETE;
- retained scoped runtime SELECT/UPDATE;
- readiness-v2 migration capability.

Migration 007 was applied once to the development Neon target and
postflight-validated. It must not be reapplied.

### 3.3 Hosted preparation accepted

Within development-provider boundaries, accepted human-operated evidence
includes:

- the intended corrected Render revision was deployed;
- live and ready endpoints returned their expected ready results;
- readiness-v2 was true;
- Auth0 issuer, audience and RS256 metadata matched;
- an authenticated fixture principal resolved to active membership;
- exact enrolled Device binding was confirmed;
- provider state remained unchanged across the inspected pre-Sync checkpoint;
- secrets and complete identifiers were kept out of notebook evidence.

This does not authorize production deployment, provider mutation, credential
rotation, ordinary Sync, or a recovery operation.

### 3.4 Validation record retained

The latest complete materialization record before the current evidence-only
round retained:

```text
API format/lint/typecheck/build: PASS
API tests: 53 / 53
production dependency audit: 0 vulnerabilities
migration-007 disposable PostgreSQL probe: 29 / 29
hosted local authorization cases: 28 true / 0 pending
Flutter format/analyze: PASS
Flutter tests: 178 passed / 4 lab-gated skips
real convergence harness: 3 / 3
real recovery harness: 1 / 1
Windows release build: PASS
Android debug build: PASS
protected Python unittest suite: 5 / 5
```

One older aggregate orchestrator observation retained a
`query-replay-same-request-id` Flutter-producer failure while the direct suite
and opt-in harnesses passed. Do not mark that aggregate observation resolved
without a correlated rerun.

## 4. Current source and operational map

Use this map for targeted recovery rather than scanning the repository
indiscriminately.

### 4.1 Human execution interface

```text
documentation/GRM.md
documentation/G_SCRIPTS.md
documentation/NS_COORDINATES.md
documentation/I_SCRIPTS.ps1
documentation/DB_MGMT.sql
```

`GRM.md` is the concise indexed human entry surface. Every active `GRM-*`
block dispatches exactly one `GS-*` procedure through `I_SCRIPTS.ps1`.
`G_SCRIPTS.md` owns procedure logic and runtime requests,
`NS_COORDINATES.md` owns reviewed non-secret values, and `DB_MGMT.sql` owns
manual SQL plus indexed automation-query blocks. Coordinates are mutable and
must be freshly verified before provider action.

Current SQLite route:

```text
GRM-SQLITE-01 -> SQLite CLI availability
GRM-SQLITE-02 -> closed-app discovery and verified temporary copy
GRM-SQLITE-03 -> read-only sanitized copied-database classification
GRM-SQLITE-04 -> materialized read-only sanitized device-scope correlation
```

All four procedures are materialized and have human-observed results.
`GRM-SQLITE-04` queried only the preserved verified copy and completed the
device-scope correlation without Retry, Sync, provider action, mutation or
cleanup. Preserve `markei-gate-12-6-current` unchanged through the controlled
operation and post-operation reconciliation.

### 4.2 Flutter synchronization authorities

```text
clients/markei_flutter/lib/application/hosted_sync_coordinator.dart
clients/markei_flutter/lib/infrastructure/remote/http_sync_transport.dart
clients/markei_flutter/lib/infrastructure/local/sync/local_sync_repositories.dart
clients/markei_flutter/lib/domain/sync/sync_event.dart
```

`hosted_sync_coordinator.dart` owns ordinary Sync's
authentication-to-binding-to-pending-upload-to-download-to-acknowledgement
transition. ERR-04 removed failed/notApplied recovery from this ordinary path.
`failed_not_applied_recovery_coordinator.dart` owns REC-01's narrower exact
candidate recovery-to-one-upload terminal and intentionally has no download or
acknowledgement dependency. Local repositories own durable
queue/submission/event state. Transport owns protocol mapping. Domain Sync
models own event and state semantics.

### 4.3 Hosted API authorities

```text
services/markei_sync_api/src/
services/markei_sync_api/migrations/
packages/markei_sync_contract/
```

Inspect exact files through G/H/I or targeted search when the active question
requires server behavior. Do not infer hosted state from source capability.

## 5. Pre-ST08 GCM-02 state retained for context

GCM-02 remains open, but Gate 12.7 now passes at the corrected single-client
control scope. ERR-04 is source-accepted and locally validated. The subsequent
Windows packet proves one warm hosted-readiness terminal and one ordinary Sync
terminal with queue `0/0/0/0`, Next Device sequence `3`, Last successful Sync
advanced only by ordinary Sync, and no failed-recovery phase in the newest
operation. The first cold readiness attempt remains an unresolved wake-up
tolerance observation.

Gate 12.7 does not claim direct provider-row contents, complete Render
child-request correlation, or second-Device convergence. Those evidence
families remain explicit later gates. Gate 12.8 is therefore next as a
read-only provider/result reconciliation and must issue no second Sync, Retry,
recovery, enrollment, migration, or provider mutation.

The newest Sync's 13 displayed rows are ordered lifecycle declarations, not 13
errors. Their flat presentation is a UI comprehension defect. Main activates
`C10-GCM02-S12-DIAG-01` to consolidate Status, Query, and Refresh diagnostics
and to group lifecycle evidence by parent operation without changing protocol,
schema, API, or provider state.

### 5.1 Accepted Gate 12.6 copied-database evidence

The human-operated procedure:

- confirmed Markei and relevant Flutter execution were closed;
- found exactly one local database candidate;
- found no WAL/SHM sidecars;
- created a fixed-name copy;
- verified copy size and hash equality without printing hashes;
- queried only the copy with SQLite read-only and
  `PRAGMA query_only=ON`;
- returned `SQLiteQuickCheck: ok`;
- performed no Retry, ordinary Sync or provider action.

Sanitized classification:

```text
submissions:
  superseded / notApplied / conflict / null                  = 1
  superseded / notApplied / conflict / enrollment-required   = 1
  failed     / notApplied / conflict / service-unavailable   = 1

each submission:
  two member events
  event sequences 1–2
  event state failed
  positions 0–1

pending-event summary:
  failed  = 2, sequences 1–2
  pending = 6, sequences 1–5

latest attempt:
  sync-unavailable
  provider-evidence-unavailable
  no HTTP status
  no response headers
```

### 5.2 Reconciled conclusions

Accepted:

- copied-database procedure: PASS;
- database copy: healthy and internally coherent;
- exactly one active failed/notApplied two-event lineage: confirmed;
- two earlier two-event submissions: superseded;
- unknown-submission Retry path: inapplicable;
- earlier insufficient-evidence queue classification: superseded;
- no trustworthy provider result exists for the latest ordinary Sync;
- the six other pending events make ordinary Sync an unsafe substitute for
  the bounded recovery question.

The observed active legacy row stores:

```text
response_code = conflict
error_code = service-unavailable
```

Current source maps `service-unavailable` to `serviceUnavailable`. Git history
shows that explicit mapping was added in
`75dc7bed0789d693af93abb3ed15e107fd77433a`; the observed database timestamp
predates that correction. The pairing is historically coherent with the
older fallback, but this is not executable row-level provenance and must not
be silently rewritten.

### 5.3 Gate 12.6 device-scoped correlation

Human execution of `GRM-SQLITE-04` against the preserved verified copy
returned:

```text
SQLite quick check: ok
observed Device scopes: 3
hosted/enrolled scope rank: 3
hosted scope next_sequence: 3
failed candidate submission: failed / notApplied
legacy response/error: conflict / service-unavailable
candidate members: 2
candidate positions: 0–1, contiguous
candidate sequences: 1–2, contiguous
candidate member state: failed
same-hash superseded submissions: 0
same-hash active submissions: 0
simulated first upload count: 2
candidate events in first upload: 2
other pending events in hosted scope: 0
first upload contains only candidate events: true
other non-hosted pending work: rank 1 = 1; rank 2 = 5
latest Sync: sync-unavailable / provider-evidence-unavailable
```

The output proves:

- the hosted/enrolled Device scope is anonymized rank 3;
- it owns exactly the failed two-event lineage at sequences 1–2;
- its next local Device sequence is 3;
- the six other pending events belong only to non-hosted ranks 1 and 2;
- failed recovery would make exactly the two candidate events the first
  bounded upload;
- no active or superseded submission shares the candidate request hash;
- no latest provider result exists because the latest Sync stopped without
  HTTP status or response headers.

The procedure queried no live database and selected no Retry or Sync. Gate
12.6 evidence collection and correlation are complete. The local SQLite
snapshot and the earlier Neon checkpoint are not contradictory: they describe
different sides and times of a failed/notApplied boundary, while the latest
Sync obtained no fresh provider evidence.

### 5.4 Gate terminals

```text
GCM02_12_1_RENDER_READY_PASS
GCM02_12_2_AUTH0_METADATA_PASS
GCM02_12_3_ALIGNMENT_PASS_AT_INSPECTED_CHECKPOINT
GCM02_12_4_EXACT_BINDING_PASS
GCM02_12_5_PROVIDER_BASELINE_PASS
GCM02_12_6_COPIED_DATABASE_PROBE_PASS
GCM02_12_6_DEVICE_SCOPED_CORRELATION_PASS
GCM02_12_6_PASS
GCM02_12_7_READ_ONLY_PREFLIGHT_PASS
GCM02_S12_REC_01_SOURCE_ACCEPTED
GCM02_S12_REC_01_WINDOWS_SURFACE_PASS
GCM02_S12_HOSTED_READINESS_CLIENT_PASS
GCM02_S12_LAST_SUCCESSFUL_SYNC_PROJECTION_FAIL
GCM02_S12_SYNC_01_D_E_F_ACTIVE
GCM02_12_7_HUMAN_AUTHORIZATION_HELD
GCM02_12_8_CONTROLLED_OPERATION_HELD
GCM02_12_9_POST_OPERATION_COMPARISON_HELD
GCM02_12_10_RECONCILIATION_HELD
GCM02_OPEN
```

### 5.5 Active prohibitions

Until a new Main reconciliation explicitly changes them:

```text
Retry: NOT AUTHORIZED
ordinary Sync: NOT AUTHORIZED
Enroll/re-enroll: NOT AUTHORIZED
provider query or mutation: NOT AUTHORIZED
database repair, cleanup or deletion: NOT AUTHORIZED
credential inspection or rotation: NOT AUTHORIZED
Gate 12.7 authorization: NOT GRANTED
GCM-02 closure: NOT GRANTED
```

Keep Markei closed and preserve the copied database unchanged until the Gate
12.7 packet is reviewed. Do not execute ad hoc SQL.

## 6. Superseded pre-ST08 continuation — SYNC-01 before Phase 12.7

The Windows read-only preflight, dedicated recovery-control visibility and
confirmation cancellation are reconciled as PASS. The later readiness assay
also preserved the two-event failed candidate and Device sequence. It did not
execute recovery or ordinary Sync.

The readiness assay exposed one source-proven projection defect and one
credible timing hypothesis:

```text
projection:
  completed readiness was selected as "Last successful sync"

timing:
  protected Sync requests currently use a fixed 5-second client deadline
  causal role in the historical failure remains unproved
```

Proceed in this order:

1. Codex materializes synchronized D/E/F unit
   `C10-GCM02-S12-ERR-03`;
2. implement the complete operation-specific client terminal catalogue,
   route-specific server terminal logging and sanitized correlation join;
3. correct ordinary-Sync and hosted-readiness success projections;
4. replace the fixed five-second Sync request deadline with the bounded
   25-second server / 35-second client assay policy;
5. validate only through local/disposable Flutter and API tests and replace
   G/H/I;
6. Main reconciles source evidence before any Windows or hosted action;
7. the user pulls the accepted implementation and performs the canonical
   Windows build/launch;
8. run one readiness-only regression assay first, proving readiness time may
   advance while ordinary-Sync time and the failed candidate remain unchanged;
9. capture the matching Render window through sanitized correlation only;
10. only after a separate Main packet may one ordinary-Sync assay or the
    Gate 12.7 bounded recovery be considered; neither is authorized by this
    staging.

Unknown-outcome Retry, ordinary Sync, bounded recovery, Repair, Enroll,
provider-console mutation, database editing and cleanup remain prohibited
during materialization. SYNC-01 must not perform the deferred broad ERR
refactor.

## 7. GCM-03 provisional boundary

GCM-03 is undefined and inactive until GCM-02 closes. Its scope must be
derived from the actual GCM-02 terminal, not from the optimistic expectation
of success.

Current provisional candidate:

```text
bounded second-Device hosted convergence and acknowledgement proof
```

Main must first inspect GCM-02 closure evidence, inventory remaining accepted
gaps, select one narrow objective, stage fresh A/B/C investigation if needed,
then create new D/E/F authority.

GCM-03 must not silently absorb:

- production deployment;
- broad retention/rebootstrap acceptance;
- backup/PITR acceptance;
- credential-lifecycle acceptance;
- Cycle 11 UI/UX work.

## 8. GCM-04 provisional boundary

GCM-04 is undefined and inactive until earlier closure evidence establishes
what remains. It should contain the final bounded external/operational
acceptance needed for Cycle 10, potentially partitioned by Main if one unit
would otherwise become non-terminal.

Current candidate families:

```text
authorization, revocation and credential lifecycle
outage, recovery and retention acceptance
deployment/release operational boundary
```

These are planning candidates, not authority. Main must reconcile GCM-03
evidence before selecting GCM-04.

## 9. Cycle 10 closure route

Cycle 10 closes only after:

1. GCM-02 reaches a trustworthy correlated terminal or an explicitly accepted
   bounded blocker;
2. GCM-03 is defined, materialized, validated and reconciled;
3. GCM-04 is defined, materialized, validated and reconciled;
4. remaining host/provider/release gaps are classified;
5. source, G/H/I, domain memory and human evidence are reconciled;
6. Operational, Didactic and Design permanent files are promoted through
   their authorized FLX-PRM-04 sequences;
7. `00_PROJECT_STATE.md`, `05_SESSION_LOG.md` and
   `06_SESSION_SCHEME.md` are refreshed under Main authority;
8. Cycle 11 receives a clean entry baseline with Cycle 10 residuals explicit.

Cycle 11 remains separate. Its UI/UX and basic Analytics work must not be used
to bypass Cycle 10 closure.

## 10. Pre-ST08 PRC-01 claims retained for provenance

| Claim                                        | Result and evidence boundary                                          |
| -------------------------------------------- | --------------------------------------------------------------------- |
| Cycle 10 implementation foundation exists    | Implemented and locally validated within named reports                |
| Migration 007 repaired cursor provisioning   | Implemented; development-provider application and postflight accepted |
| Hosted readiness and exact binding passed    | Human-operated accepted development evidence                          |
| Gate 12.6 copied-database probe passed       | Human-operated accepted, read-only copied-database evidence           |
| Failed/notApplied lineage is known           | Accepted from sanitized copied-database output                        |
| Legacy response pairing is explained         | Source/history-consistent, not row-proven                             |
| Exact device-scoped next transition is known | Accepted from human-operated read-only `GRM-SQLITE-04` evidence       |
| Retry is eligible                            | Rejected; unknown-retry path is inapplicable                          |
| Ordinary Sync is a safe substitute           | Rejected; six other pending events exist                              |
| REC-01 bounded execution surface exists      | Implemented and locally validated at `a633677`; host-unvalidated       |
| Eligible preflight diagnostic is corrected   | `MKS-REC-001` generated and locally validated; Windows rerun pending   |
| Exact batch and one-upload boundary hold      | Locally test-validated; no live execution performed                    |
| REC-01 Windows inspection surface passed     | Human-observed; inspection/cancellation only, no execution              |
| Hosted readiness route passed                | Human-observed HTTP 200 client evidence; not ordinary Sync              |
| Last successful Sync projection is correct  | Rejected; readiness advanced the timestamp                              |
| Five-second deadline caused prior failure    | Provisional hypothesis; not proved                                     |
| ERR-03 terminal/timing packet is active      | Accepted D/E/F materialization authority at baseline `3d1e82e`          |
| Gate 12.7 packet is ready                    | Rejected; SYNC-01 and later freshness reconciliation required           |
| Gate 12.7 is authorized                      | Rejected                                                              |
| GCM-02 is closed                             | Rejected                                                              |
| GCM-03 or GCM-04 is active                   | Rejected                                                              |
| Cycle 10 is closed                           | Rejected                                                              |

## 11. Pruning disposition

This refresh replaces the former mutable prefix, which had accumulated:

- superseded cursor-state implementation instructions;
- pre-probe Gate 12.6 Cancel/Retry decision trees;
- repeated repository, methodology and validation panoramas;
- cleared provider-preflight and deployment steps;
- stale one-line continuation terminals;
- duplicated future GCM-03/04 and Cycle 10 closure descriptions.

Their continuing meaning is consolidated above. Historical progression remains
available under `Legacy_Progress`, which was preserved unchanged.

Current recovery pointer:

```text
read this mutable prefix
-> read active ERR-03 D/E/F for Codex authority
-> read REC-01 G/H/I for preserved recovery evidence
-> use the canonical I_SCRIPTS dispatcher for later Windows commands
-> expand into Legacy_Progress only for provenance/history
```

---

# Legacy_Progress

> Persistence rule: this section is append-only Main-stage continuity. Entries
> under `Legacy_Progress` must survive later J refresh, reconciliation,
> compaction, or structural mutation. Corrections are appended as new dated
> entries; prior entries are not removed or silently rewritten.

## 2026-07-23 — GRIMOIRE human-operationalisation inner sprint and Gate 02 closure

### Sprint identity

```text
Sequence: FLX-ORD-01 bounded human-supervised operational materialization
Cycle: 10
Phase: GCM-02 closure recovery
Gate: 02 — account cursor provisioning
Inner sprint: GRIMOIRE human-operationalisation check-up and build
Repository baseline: 837e9e18706b1eccb2bfafc0bf8980b69e1acf0a
Human authority: explicit
```

### Purpose and system mechanics

GRIMOIRE is the human-facing operational interface between project intent and
reviewed automation. It implements a hemi-automated chain:

```text
human selects a minimal indexed command
→ versioned PowerShell launcher validates local prerequisites and target role
→ committed mitigated-risk coordinates supply non-secret endpoint identity
→ password is entered only through a masked terminal prompt
→ Docker supplies the pinned PostgreSQL 18 client
→ libpq requires TLS and channel binding
→ SQL verifies database role and database identity
→ named SQL action or exact tracked migration is selected
→ mutation requires an explicit human confirmation boundary
→ sanitized evidence returns to the operator
→ Main/Operational reconciliation records meaning and next authority
```

The operational collection separates responsibilities:

- `GRIMOIRE.md` explains architecture, safety boundaries, workflow, failure
  classification, proven checkpoints, and ends with the active minimal-command
  index;
- `GENERAL_SCRIPTS.md` provides expanded operator commands and validation
  sequences;
- `models/NEON_CHECK.ps1` owns masked credentials, Docker `psql`, role/database
  preflight, TLS/channel-binding enforcement, action dispatch, exact migration
  path containment, Git tracking/cleanliness checks, SHA-256 display, and
  explicit mutation confirmation;
- `models/NEON_ACTION.sql` owns delimited, named, predominantly read-only SQL
  evidence blocks;
- root `NEON_ACTION.sql`, `NEON_CHECK.ps1`, and `NEON_CRED.md` preserve the
  user-uploaded operational originals;
- `NEON_CRED.md` is committed under an explicit mitigated-risk decision,
  stores only non-secret target coordinates and role names, and contains
  neither passwords nor complete connection URLs;
- `SECRET_INPUTS.md` remains the sole ignored private input surface.

Executable mechanics, reusable models, and minimal non-secret coordinates are
versioned. Secret inputs are not. Minimal commands are treated as stable
interfaces into reviewed verbose mechanics; when an action or variable name
changes, every reference must be reconciled in the same focused change.

### Failure-to-system learning

The sprint resolved four recurrent operator/tooling defects:

1. recycled download filenames produced stale script revisions, so development
   revisions use unique immutable names before promotion to the canonical
   repository filename;
2. `$PSScriptRoot` was unsafe in parameter defaults, so companion paths are
   resolved after script initialization;
3. server-side `pg_stat_ssl` behind Neon proxying was not authoritative for
   the client transport, so the launcher instead enforces
   `PGSSLMODE=require` and `PGCHANNELBINDING=require` and treats successful
   libpq authentication under those requirements as transport evidence;
4. textual Windows path-prefix comparison was separator-sensitive, so exact
   migration containment uses a parent-directory walk before Git tracked/clean
   checks.

### Gate 02 applied and validated evidence

Migration `007_account_cursor_provisioning.sql` was applied once with:

```text
role: markei_migrator
database: markei_sync_dev
client TLS/channel binding: required
file SHA-256: 89AB11302F8B860C52AA1C74FBFEDF6A4DB3A0EE62FE7CB715B20B74AEF99AC6
confirmation: APPLY-ONCE
transaction terminal: COMMIT
```

Postflight returned:

```text
migration_id: 007_account_cursor_provisioning
checksum: c10-mcg02-account-cursor-provisioning-v1
readiness_v2: true
provisioning function: present
provisioning trigger count: 1
account count: 1
cursor-state count: 1
accounts missing cursor state: 0
orphan cursor-state rows: 0
runtime SELECT: true
runtime INSERT: false
runtime DELETE: false
runtime next_cursor UPDATE: true
runtime readiness-v2 EXECUTE: true
runtime provisioning EXECUTE: false
inspection terminal: ROLLBACK
action terminal: PASS
```

The false privilege values are intended least-privilege boundaries and are not
caused by absent Flutter activity. Migration 007 must not be reapplied.

### Resulting state and next authority

```text
GRIMOIRE_BASELINE_ESTABLISHED
MIGRATION_007_APPLIED_ONCE
GATE_02_POSTFLIGHT_PASS
ACCOUNT_CURSOR_INVARIANT_PASS
RUNTIME_PRIVILEGE_SHAPE_PASS_BY_MIGRATOR_INSPECTION
GATE_02_CLOSED
RUNTIME_ROLE_DIRECT_READINESS_CHECK_NEXT
RENDER_CORRECTED_REVISION_NOT_YET_RECONCILED
REAL_SYNC_RETRY_UNAUTHORIZED
GCM02_OPEN
```

The next bounded operation is a direct runtime-role connection and
`markei_hosted_runtime_ready_v2()` call. After that passes, reconcile GitHub
HEAD and Render deployment revision, deploy only an explicitly authorized
reconciled revision, and require live/ready HTTP 200 evidence before any
controlled Sync attempt.

## 2026-07-23 — Canonical five-file reconciliation and branch remodelling

### Sprint identity

```text
Sequence: FLX-PRN-03 pruning + FLX-PRM-04 reconciliation
Cycle: 10
Phase: post-migration-007 GRIMOIRE consolidation
Source branch: intermid-cycle-recovery
Source HEAD: c76734e32f70702978f5c7a543c1f0ef3c63c521
Target branch: cycle10-intermid-grimoire
Human authority: explicit
Write scope: GRIMOIRE five-file set, obsolete duplicates, and this append
```

### Reconciliation result

The five latest uploaded files were compared with the `c76734e` tree. The
uploads were useful source evidence but were not accepted blindly as the final
tree: the existing repository documentation contained later Gate 02 closure
knowledge, while the former `models/` layer contained the launcher and SQL
corrections that had been operationally proven.

The live repository interface is now one commutatively maintained set:

```text
documentation/GRIMOIRE.md
documentation/GENERAL_SCRIPTS.md
documentation/NEON_CHECK.ps1
documentation/NEON_ACTION.sql
documentation/NEON_CRED.md
```

`NEON_ACTION.sql` is the canonical filename. The occasional plural
`NEON_ACTIONS.sql` and the uploaded numbered filenames are treated as naming
noise, not additional repository interfaces.

### Explicit tuning and pruning

- `GRIMOIRE.md` now defines the root five-file set as canonical, preserves the
  proven Gate 02 closure, keeps `GRIMOIRE_INDEX` as its final subsection, and
  points every launcher command to `documentation/NEON_CHECK.ps1`.
- `GENERAL_SCRIPTS.md` now uses the same root paths, identifies
  `cycle10-intermid-grimoire` as its Git-alignment branch, and retains migration
  007 as historical/do-not-rerun evidence.
- `NEON_CHECK.ps1` is the Windows-proven v8 launcher promoted from the former
  model layer. Its SHA-256 remains
  `c4c050e3c83ba17e3ca509bd97f7d8cb7f6fdc301db02f0a3c72e6f1d98f6818`.
- `NEON_ACTION.sql` is the aligned read-only catalogue promoted from the former
  model layer. Its connection action reports role, database, and read-only
  transaction state; transport assurance remains owned by the launcher's
  enforced libpq TLS and channel-binding settings rather than proxy-sensitive
  server-side TLS columns.
- `NEON_CRED.md` retains the latest uploaded minimal non-secret coordinates and
  role-name interface. Passwords, tokens, private keys, and complete connection
  URLs remain prohibited.
- `documentation/models/NEON_CHECK.ps1`,
  `documentation/models/NEON_ACTION.sql`, and
  `documentation/models/NEON_CRED.md` were removed after promotion because a
  second live layer would duplicate semantic and executable ownership.
- `documentation/legacy/GENERAL_SCRIPTS.md` was removed because Git already
  preserves its history and a stale copy would remain discoverable as a false
  operational route. `documentation/legacy/PT_INTRO.md` was retained because it
  is unrelated to the Neon/GRIMOIRE reconciliation.
- `documentation/SECRET_INPUTS.md` remains ignored and untracked as the sole
  private input surface.

### PRC-01 claims

```text
Claim: c76734e is the exact source coordinate for this remodelling
Prior state: requested / remotely verified
Evidence: GitHub comparison reports intermid-cycle-recovery identical to c76734e
Semantic owner: Git history
Resulting state: accepted

Claim: the models folder is still required for current operation
Prior state: accepted by the earlier 2026-07-23 Legacy_Progress entry
Evidence: latest uploaded v8 launcher equals the proven model launcher; the
          corrected model SQL can be promoted without losing behavior
Contradiction: duplicate root/model paths create two competing live interfaces
Semantic owner: GRIMOIRE operational documentation
Resulting state: superseded; models pruned after promotion
History disposition: earlier entry retained unchanged; this entry corrects it

Claim: migration 007 should be applied during this sprint
Prior state: already applied once and postflight-validated
Evidence boundary: documentation and static reconciliation only
Resulting state: rejected; do not rerun migration 007

Claim: creating cycle10-intermid-grimoire authorizes Render reconfiguration
Prior state: not authorized
Evidence: branch work is documentation/Git reconciliation
Resulting state: still not authorized
```

### Expected next sequence before resuming the former steps 4–14

The earlier eleven-step route is not replayed literally because migration 007
and Gate 02 have since completed. Resume through these seven bounded steps:

1. pull and inspect `cycle10-intermid-grimoire` locally; verify clean `0 0`
   divergence and review this five-file/J reconciliation;
2. run the direct runtime-role connection and
   `markei_hosted_runtime_ready_v2()` read-only proof;
3. reconcile the intended application revision against the current Render
   deployment fingerprint;
4. decide explicitly whether the new branch remains documentation-only or
   becomes the branch Render follows; branch creation alone changes no Render
   setting;
5. deploy exactly one authorized reconciled application revision and capture
   its full Git SHA plus Render deployment fingerprint;
6. require `/health/live = 200`, `/health/ready = 200`, and a fresh provider
   immobility baseline;
7. only then authorize at most one exact-identity Sync resolution attempt and
   reconcile its correlated terminal evidence.

Current terminals:

```text
GRIMOIRE_CANONICAL_FIVE_FILE_SET_RECONCILED
MODELS_LAYER_SUPERSEDED_AND_PRUNED
MIGRATION_007_DO_NOT_RERUN
GATE_02_REMAINS_CLOSED
RUNTIME_ROLE_DIRECT_READINESS_CHECK_NEXT
RENDER_BRANCH_CHANGE_NOT_AUTHORIZED
REAL_SYNC_RETRY_UNAUTHORIZED
GCM02_OPEN
```

## 2026-07-23 — Hosted pre-Sync gate closure and controlled-Sync planning boundary

### Sequence identity

```text
Sequence: post-Gate-02 hosted deployment verification
Cycle: 10
Phase: GCM-02 closure recovery
Active branch: cycle10-intermid-grimoire
Authorized revision: baaa3231c0b8f9b1af2c2aff80255e883309ca74
Previous observed Render revision: 5b36421
Provider database: markei_sync_dev
Evidence date: 2026-07-23
Human authority: explicit
Mutation boundary: one Render deployment; no Sync request
```

### Purpose

This sequence verified that the reconciled Cycle 10 branch could become the active Render branch, that its intended revision could be deployed exactly once, and that the hosted service could satisfy its live and ready contracts without changing the inspected Neon coordination state.

The sequence also completed the direct runtime-role readiness-v2 proof that remained pending after migration 007.

No controlled Sync request was performed. Migration 007 was not reapplied. No Neon schema, role, Auth0, hosted identity, or Render environment-variable change was performed during this gate.

### 1. Local Git alignment — PASS

The Windows checkout was clean and exactly aligned with the remote branch before deployment:

```text
Repository: gus-i-gu/markei
Branch: cycle10-intermid-grimoire
Local HEAD: baaa3231c0b8f9b1af2c2aff80255e883309ca74
Remote HEAD: baaa3231c0b8f9b1af2c2aff80255e883309ca74
Local/remote divergence: 0 / 0
Working tree: clean
```

This established an unambiguous application revision for the hosted gate.

### 2. Direct runtime-role readiness-v2 proof — PASS

A direct read-only connection was opened using the restricted runtime role.

Observed evidence:

```text
Role: markei_runtime
Database: markei_sync_dev
TLS: active
Protocol: TLS 1.3
Cipher: TLS_AES_256_GCM_SHA384
Readiness function: public.markei_hosted_runtime_ready_v2()
Readiness result: true
Transaction: read only
Terminal: ROLLBACK
```

The proof establishes that the runtime identity could reach the intended development database and execute the readiness-v2 contract.

It does not by itself prove application Sync, token validity, device identity resolution, or event convergence.

### 3. Pre-deployment provider baseline — PASS

A sanitized aggregate baseline was captured through the migrator inspection role inside a read-only transaction.

| Measure                               | Before deployment |
| ------------------------------------- | ----------------: |
| Accounts                              |                 1 |
| Devices                               |                 1 |
| Account cursor states                 |                 1 |
| Submissions                           |                 0 |
| Sync events                           |                 0 |
| Device acknowledgements               |                 0 |
| Sum of next cursors                   |                 1 |
| Sum of device next-expected sequences |                 1 |

The transaction ended with `ROLLBACK`.

The evidence contains no account ID, device ID, credential, token, connection string, event payload, or submission content.

The state is consistent with one previously provisioned account/device fixture and no submitted or synchronized application event.

### 4. Render revision comparison — PASS

The previous observed Render deployment was:

```text
Revision: 5b36421
Description: Implement transport observability diagnostics
Started: 2026-07-21 21:15 local dashboard time
Live: 2026-07-21 21:16 local dashboard time
Trigger: manual dashboard deployment
```

The intended revision for the new gate was:

```text
baaa3231c0b8f9b1af2c2aff80255e883309ca74
```

The intended revision differed from the previously hosted revision and belonged to the reconciled `cycle10-intermid-grimoire` branch.

The newest commit primarily reconciled documentation and GRIMOIRE structure while inheriting the hosted application implementation from its ancestry. Deploying the exact revision nevertheless established one reproducible Git fingerprint for subsequent evidence.

### 5. Render branch establishment — PASS

The Render development service was configured to follow:

```text
Repository: gus-i-gu/markei
Branch: cycle10-intermid-grimoire
Service type: Node web service
Instance class: free development instance
Auto-deploy during gate: off
```

No Render environment variable, secret, build command, start command, Neon coordinate, or Auth0 setting was changed during branch establishment.

### 6. Single authorized deployment — PASS

Exactly one deployment of the authorized revision was observed for this gate:

```text
Revision: baaa3231c0b8f9b1af2c2aff80255e883309ca74
Short revision: baaa323
Description: Reconcile Cycle 10 GRIMOIRE interface
Trigger: manual dashboard deployment
Started: 2026-07-23 20:18 local dashboard time
Final state: live
Unexpected second deployment: none observed
```

Build and startup evidence:

```text
Node.js: 24.14.1
Build command: npm ci --include=dev && npm run build
Packages installed: 208
Packages audited by npm install: 209
TypeScript compilation: PASS
Build upload: PASS
Runtime command: npm start
Hosted entry point: node dist/src/hosted.js
Startup marker: MARKEI_HOSTED_SYNC_READY
Render terminal: live
```

The service became publicly available after successful compilation, artifact upload, startup, and readiness probing.

Render’s initial platform probes included undefined-root `HEAD /` and `GET /` requests returning 404. These were unclassified root-route requests and did not contradict the designated health contracts.

### 7. Hosted HTTP health verification — PASS

The deployed service was queried through its public development origin.

| Endpoint        | Status | Sanitized response   |
| --------------- | -----: | -------------------- |
| `/health/live`  |    200 | `{"status":"live"}`  |
| `/health/ready` |    200 | `{"status":"ready"}` |

Render logs independently recorded `/health/ready` requests with:

```text
Route class: /health/ready
Operation: health-ready
Method: GET
Status: 200
Elapsed band: below 250 ms
```

The application logs used short correlation fingerprints and did not expose raw credentials or identity material.

### 8. Post-deployment provider immobility — PASS

After deployment and public health verification, the exact pre-deployment aggregate inspection was repeated through the migrator role in a read-only transaction.

Observed post-deployment state:

| Measure                               | Before | After | Difference |
| ------------------------------------- | -----: | ----: | ---------: |
| Accounts                              |      1 |     1 |          0 |
| Devices                               |      1 |     1 |          0 |
| Account cursor states                 |      1 |     1 |          0 |
| Submissions                           |      0 |     0 |          0 |
| Sync events                           |      0 |     0 |          0 |
| Device acknowledgements               |      0 |     0 |          0 |
| Sum of next cursors                   |      1 |     1 |          0 |
| Sum of device next-expected sequences |      1 |     1 |          0 |

Connection and transaction evidence:

```text
Role: markei_migrator
Database: markei_sync_dev
TLS: active
Protocol: TLS 1.3
Transaction: read only
Terminal: ROLLBACK
```

All eight values exactly matched the pre-deployment baseline.

Within the inspected coordination boundary, branch retargeting, deployment, startup, Render readiness probes, and explicit public health requests produced no observable provider mutation.

This evidence does not claim that no unobserved provider metric changed. It proves immobility only for the eight inspected database aggregates.

### 9. Deployment singularity — PASS

The Render event history showed one deployment of `baaa323` during this gate:

```text
Watched branch: cycle10-intermid-grimoire
Authorized revision: baaa3231c0b8f9b1af2c2aff80255e883309ca74
Deployment count for this gate: 1
Final state: live
Unexpected later deployment: no
```

The earlier `5b36421` deployment belongs to the preceding 2026-07-21 observability round and is not a duplicate deployment of the present revision.

### 10. Hosted pre-Sync gate conclusion — PASS

```text
LOCAL_GIT_ALIGNMENT_PASS
RUNTIME_ROLE_DIRECT_READINESS_V2_PASS
PRE_DEPLOYMENT_PROVIDER_BASELINE_CAPTURED
RENDER_REVISION_COMPARISON_PASS
RENDER_WATCHED_BRANCH_ESTABLISHED
SINGLE_AUTHORIZED_DEPLOYMENT_PASS
HOSTED_LIVENESS_HTTP_200
HOSTED_READINESS_HTTP_200
POST_DEPLOYMENT_PROVIDER_IMMOBILITY_PASS
HOSTED_PRE_SYNC_GATE_CLOSED
```

Preserved constraints:

```text
Migration 007 reapplied: NO
Sync request performed: NO
Application event intentionally submitted: NO
Neon schema edited: NO
Neon roles edited: NO
Auth0 configuration edited: NO
Render environment variables edited: NO
Provider aggregate difference: NONE
Controlled Sync authorization: PENDING SEPARATE REVIEW
```

### 11. Dependency-audit observation — OPEN / NOT YET DIAGNOSED

Render’s dependency installation reported:

```text
One high-severity vulnerability
```

This is an npm install-time advisory observation. It did not prevent compilation or deployment, but it must not be classified as a clean dependency-security result.

The first local follow-up command was executed from the repository root:

```text
npm audit
```

That directory has no npm lockfile. npm therefore returned:

```text
Code: ENOLOCK
Meaning: audit requires an existing lockfile
```

The generated `npm-audit-cycle10.json` contains only the `ENOLOCK` error. It is not a vulnerability report and provides no affected package, installed version, dependency path, exploitability, or remediation range.

Repository inspection locates the actual Node package and lockfile at:

```text
services/markei_sync_api/package.json
services/markei_sync_api/package-lock.json
```

Current classification:

```text
Render npm advisory observation: OPEN
Local vulnerability diagnosis: NOT YET PERFORMED
Local audit failure cause: WRONG WORKING DIRECTORY / LOCKFILE ABSENT THERE
Dependency remediation authorized: NO
npm audit fix authorized: NO
npm audit fix --force authorized: NO
```

The root-level JSON artifact should remain outside the repository. A corrected read-only audit must be run from `services/markei_sync_api` before selecting any dependency change.

The dependency observation is tracked separately from the hosted pre-Sync gate because it did not invalidate Git alignment, runtime readiness, deployment identity, health behavior, or provider immobility. Its actual runtime relevance remains unknown until the corrected audit is interpreted.

### Dependency-audit remediation — PASS

The hosted installation had reported one high-severity advisory affecting `find-my-way <=9.6.0`.

Dependency inspection established:

```text
Dependency: find-my-way
Installed before remediation: 9.6.0
Dependency type: transitive production dependency
Introduced by: fastify 5.10.0
Dependency path: @markei/sync-api → fastify → find-my-way
Advisory: GHSA-c96f-x56v-gq3h
Advisory class: HTTP/2 denial of service
Evidence of rogue installation or repository intrusion: NONE

find-my-way: 9.6.0 → 9.7.0
package.json changed: NO
Force or major-version remediation used: NO

npm ls find-my-way: 9.7.0
npm audit: 0 vulnerabilities
format:check: PASS
lint: PASS
typecheck: PASS
tests: 53 passed, 0 failed
build: PASS
```

### PRC-01 classification

```text
Claim: direct runtime readiness-v2 is available
Source: runtime-role read-only provider inspection
Current state: validated
Evidence: markei_hosted_runtime_ready_v2() returned true
Evidence boundary: markei_runtime against markei_sync_dev
Does not prove: authenticated Sync or event convergence
Semantic owner: Operational
Result: accepted within the named boundary

Claim: baaa323 was successfully hosted
Source: Render deployment event and runtime logs
Current state: validated
Evidence: build pass, startup marker, live terminal
Evidence boundary: Render development/free service
Does not prove: production acceptance
Semantic owner: Operational
Result: accepted within the development-host boundary

Claim: the hosted service was live and ready
Source: explicit HTTP requests and Render readiness logs
Current state: validated
Evidence: /health/live 200 and /health/ready 200
Does not prove: Sync success
Semantic owner: Operational
Result: accepted

Claim: the deployment mutated no inspected coordination state
Source: matched pre/post read-only aggregate inspections
Current state: validated
Evidence: all eight inspected values unchanged
Evidence boundary: named Neon tables and aggregate fields
Does not prove: universal provider immobility outside inspected measures
Semantic owner: Operational
Result: accepted within the inspected boundary

Claim: exactly one baaa323 deployment occurred during this gate
Source: Render event history
Current state: validated
Evidence: one manually triggered baaa323 deployment; earlier 5b36421 event belongs to a different round
Semantic owner: Operational
Result: accepted

Claim: the Node dependency tree contains a confirmed exploitable high-severity vulnerability
Source: Render npm install warning
Current state: candidate / unresolved
Evidence: aggregate advisory count only
Contradiction: local npm audit did not run against a lockfile
Semantic owner: Operational dependency evidence
Result: remain open pending corrected package-root audit

Claim: the ENOLOCK JSON is a dependency vulnerability report
Source: root-level local npm audit attempt
Current state: contradicted
Evidence: JSON contains only the ENOLOCK error
Result: rejected; do not preserve it as audit evidence

Claim: one controlled Sync request is now authorized
Source: hosted pre-Sync gate result
Current state: proposed
Evidence: prerequisite deployment and immobility gate passed
Missing evidence: exact identity, token, sequence, endpoint, expected mutation, and containment plan
Result: not yet authorized
```

Claim: the reported dependency vulnerability was safely remediated
Source: dependency explanation, lockfile resolution, npm audit, and API validation
State: validated
Evidence boundary: services/markei_sync_api dependency tree
Result: accepted

Claim: find-my-way represented an unauthorized or rogue dependency
State: contradicted
Evidence: normal Fastify dependency path recorded by npm
Result: rejected

### 12. Controlled exact-identity Sync attempt — PLANNING STARTED / EXECUTION HELD

The next sequence is a single bounded authenticated Sync experiment. Passing the hosted pre-Sync gate makes planning appropriate but does not automatically authorize execution.

Planning must resolve five evidence groups before a request is sent.

#### 12.1 Identity binding

Establish, without recording raw secrets:

```text
Auth0 issuer expected by the hosted API
Auth0 audience expected by the hosted API
Token subject fingerprint or sanitized comparison method
Token expiry and not-before validity
Fixture account mapped to the authenticated subject
Fixture device enrolled under that same account
Device active/revoked state
```

A raw access token, client secret, password, complete connection string, account UUID, or device UUID must not be copied into J.

#### 12.2 Request contract

Resolve from the committed implementation:

```text
Exact public endpoint
HTTP method
Required authorization header shape
Required request body schema
Operation name/version
Supported event type
Idempotency or submission identifier requirements
Expected success status and response schema
```

The procedure must be derived from the deployed `baaa323` source contract rather than reconstructed from memory.

#### 12.3 Sequence and cursor preconditions

Capture a sanitized read-only baseline immediately before the request:

```text
Account next cursor
Device next expected sequence
Submission count
Sync-event count
Acknowledgement count
Device enrollment state
Account/device relationship valid
```

The current aggregate baseline indicates cursor `1` and device sequence `1`, but exact-identity readiness must be checked at execution time.

#### 12.4 Expected single transition

Before authorization, specify exactly which values may change after one valid request.

The expected transition must identify:

```text
Expected submission count delta
Expected sync-event count delta
Expected acknowledgement behavior
Expected account-cursor delta
Expected device-sequence delta
Expected HTTP response
Expected correlated terminal log events
Expected local application effect, if any
```

Any mutation outside that allowlist is a stop condition.

#### 12.5 Containment and stop rules

The first request is limited to one attempt.

Do not automatically retry on:

```text
401 or 403 identity rejection
409 sequence or replay conflict
unexpected 4xx response
5xx response
timeout with uncertain provider outcome
missing terminal correlation
unexpected provider-state delta
```

A timeout or lost response does not prove that the provider remained unchanged. Inspect correlated logs and provider state before deciding whether the request was accepted.

No cleanup, deletion, sequence correction, fixture recreation, second submission, credential rotation, or migration is authorized merely because the attempt fails.

#### 12.6 Planned evidence order

```text
1. Complete corrected read-only npm audit diagnosis.
2. Inspect the deployed Sync route and authentication contract.
3. Verify sanitized Auth0 issuer/audience and token claim compatibility.
4. Verify exact fixture account/device binding read-only.
5. Capture exact pre-attempt provider baseline.
6. Define the one allowed state transition.
7. Review the assembled evidence and authorize or reject one request.
8. If authorized, send exactly one controlled request.
9. Capture HTTP result and correlated hosted logs.
10. Capture exact post-attempt provider state.
11. Compare expected and observed transitions.
12. Reconcile GCM-02 closure state and determine Cycle 11 readiness.
```

Current terminals:

```text
HOSTED_PRE_SYNC_GATE_PASS
RENDER_ACTIVE_BRANCH_CYCLE10_INTERMID_GRIMOIRE
RENDER_REVISION_BAAA323_LIVE
PROVIDER_IMMOBILITY_PASS
DEPENDENCY_AUDIT_DIAGNOSIS_OPEN
CONTROLLED_SYNC_PLAN_INCOMPLETE
CONTROLLED_SYNC_REQUEST_UNAUTHORIZED
MIGRATION_007_DO_NOT_RERUN
GCM02_OPEN
```

## Append-only reconciliation entry — 2026-07-23 — Neo-Grimoire indexed coordinate-system redesign

### Sprint identity

```text
Sequence: FLX-ORD-01 direct human-authorized documentation materialization
Cycle: 10
Phase: GCM-02 closure support / Step 12 preparation
Branch: cycle10-intermid-grimoire
Baseline HEAD: 1106dbea6a6d6b309d306d2f5a7911240b84bc2e
Immediate parent: f1851ca
Baseline commit: Neo-Grimoire system for Human Supervised Execution1.3
Human authority: explicit
Materialization scope: canonical GRIMOIRE five-file interface
Evidence boundary: isolated local checkout and static structural validation
Provider mutation authority: none
Persistence status: human replacement, diff review, commit, and push pending
```

The baseline ambiguity is resolved as follows:

```text
1106dbea6a6d6b309d306d2f5a7911240b84bc2e
    current branch HEAD / Execution1.3

f1851ca
    immediate parent / Execution1.2
```

### Objective

The sprint restructures the existing human-supervised execution system without
adding unrelated provider operations.

The intended active interface remains five files:

```text
documentation/GRIMOIRE.md
documentation/GENERAL_SCRIPTS.md
documentation/NS_COORDINATES.md
documentation/NEON_CHECK.ps1
documentation/NEON_ACTION.sql
```

The responsibilities are now separated as:

```text
GRIMOIRE.md
    human-facing architecture, safety rules, usage model, and concise index

GENERAL_SCRIPTS.md
    canonical expanded commands, queries, validation procedures, and evidence
    expectations

NS_COORDINATES.md
    repository-safe non-secret coordinates, lifecycle classifications, and
    verification sources

NEON_CHECK.ps1
    Windows launcher, coordinate parser, role/action dispatcher, secure runtime
    input, target guards, and Docker psql execution

NEON_ACTION.sql
    SQL-only indexed read-only action catalogue
```

### Naming reconciliation

Commit `1106dbe` had already renamed:

```text
documentation/NEON_CRED.md
→ documentation/NS_COORDINATES.md
```

The rename-only state left active GRIMOIRE commands and the launcher capable of
referring to the superseded filename. The present materialization reconciles the
live interface:

- `NEON_CHECK.ps1` now defaults to `NS_COORDINATES.md`;
- active GRIMOIRE and GENERAL_SCRIPTS command bodies pass
  `-ConfigPath ".\documentation\NS_COORDINATES.md"`;
- hosted and Git procedures load public values from `NS_COORDINATES.md`;
- no active execution route requires `documentation/NEON_CRED.md`;
- `NEON_ACTION.sql` remains the canonical singular filename.

Historical references to `NEON_CRED.md` remain valid observational evidence in
earlier J entries, Git history, and the migration explanation inside the active
documentation. They are not stale executable paths and must not be erased merely
to make a global text search return zero results.

### Materialized system

#### GRIMOIRE

`GRIMOIRE.md` now defines:

- the canonical five-file architecture;
- the coordinate and secret boundaries;
- the runtime-input model;
- Neon launcher and role behavior;
- SQL action architecture;
- migration and do-not-rerun boundaries;
- Gate 02’s proven checkpoint;
- failure classifications;
- interface-maintenance rules;
- the stable `GRIMOIRE_INDEX` landline.

The final index contains 16 `GRM-*` blocks. Every active block contains:

```text
GRM identifier and functionality name
01 — canonical command/query and hosting path
Copy-paste-ready body
What this does
Variables required
Expected output or result
```

Only the fenced copy-paste body is machine input. Its stable non-secret values
are loaded from `NS_COORDINATES.md`; manually supplied values are restricted to
runtime role selection, masked passwords, locally entered UUIDs, or an explicit
authorization phrase where the canonical procedure requires one.

#### GENERAL_SCRIPTS

`GENERAL_SCRIPTS.md` now contains 18 canonical `GS-*` procedures.

The active GRIMOIRE blocks map to 16 corresponding procedures. Two additional
procedures remain historical or deliberately non-indexed:

```text
GS-NEON-H01
GS-MIG-H01
```

The historical migration procedure preserves auditability but does not restore
migration 007 to the active GRIMOIRE index.

The Git, Render-health, Auth0-metadata, Windows-build, and Android-build
procedures fetch their public coordinates from `NS_COORDINATES.md` and reject
required placeholders instead of silently inventing values.

#### NS_COORDINATES

`NS_COORDINATES.md` is explicitly a coordinate allowlist, not a credential
store.

It now contains 60 unique machine-readable coordinate keys covering:

```text
repository and source
Render development service
Auth0 public development configuration
Neon development target
Markei hosted API contract
provider migration state
```

All 11 keys from the former `NEON_CRED.md` were retained by name and without
semantic loss:

```text
Environment
ProjectAlias
BranchAlias
Region
PostgreSQLVersion
Host
Port
Database
RuntimeUser
MigratorUser
DbOwnerUser
```

The file also records:

- where each coordinate must be verified;
- whether it is stable, mutable, rotatable, or ephemeral;
- which values remain optional until a procedure consumes them;
- which values must never be committed;
- when the coordinate set was last reviewed.

No password, token, client secret, API key, private key, complete connection
string, identity-bound UUID, authorization header, cookie, or raw environment
dump was migrated into the file.

The direct Neon hostname, database name, and role names remain non-secret.
Together they expose development topology, so they are retained under the
existing mitigated-risk decision and should not be redistributed
unnecessarily.

#### NEON_ACTION

`NEON_ACTION.sql` now contains eight indexed `NA-*` action blocks:

```text
NA-01  connection
NA-02  gate02-preflight
NA-03  gate02-postflight
NA-04  migration-ledger
NA-05  runtime-privileges
NA-06  schema-inventory
NA-07  list-devices-sanitized
NA-08  verify-device
```

The file remains SQL-only. Explanations are SQL comments, while extraction
continues to use the exact parser contract:

```sql
-- ACTION: action-name
...
-- END ACTION
```

Routine actions remain read-only and terminate through `ROLLBACK`.

#### NEON_CHECK

`NEON_CHECK.ps1` now:

- resolves `NS_COORDINATES.md` by default;
- loads the required Neon and migration coordinates dynamically;
- rejects unresolved required placeholders;
- remains locked to the development environment;
- requires the direct Neon hostname;
- requires PostgreSQL 18;
- requires TLS and channel binding;
- separates runtime, migrator, and database-owner roles;
- prompts for passwords through masked terminal input;
- requests a device UUID only for the exact action that requires it;
- forwards non-secret action variables through `psql`;
- preserves the tracked, clean, repository-contained migration guard;
- preserves the exact `APPLY-ONCE` mutation confirmation;
- clears PostgreSQL environment variables and temporary plaintext password
  material in `finally`.

Migration 007 remains applied-once historical evidence. This update does not
authorize or perform its reapplication.

### Validation record

Static validation returned:

```text
GRIMOIRE blocks:                         16
Canonical GENERAL_SCRIPTS procedures:   18
NEON_ACTION indexed actions:              8
NS_COORDINATES unique keys:              60
Original coordinate keys retained:     11/11
Active GRM → GS cross-references:        PASS
Executable bodies with placeholders:       0
Active stale executable NEON_CRED paths:   0
Canonical NS_COORDINATES default:        PASS
Secret-pattern scan:                     PASS
SQL action parsing:                    8/8 PASS
git diff --check:                        PASS
```

All eight SQL action bodies parsed as PostgreSQL after substituting the
non-secret `psql` variables supplied by the launcher.

The validation boundary is static and structural. The Linux materialization
environment did not repeat:

- Windows PowerShell execution;
- Docker Desktop execution;
- Neon connections or queries;
- Render requests or configuration;
- Auth0 requests or token acquisition;
- Windows or Android builds;
- a Sync submission.

No provider state, deployment, credential, migration, or application source was
changed by this documentation sprint.

### PRC-01 classification

```text
Claim: the redesigned five-file GRIMOIRE interface exists
Source: local repository diff against 1106dbea
Current state: implemented and statically validated
Evidence: five modified active-interface files, index counts, cross-reference
          checks, parser checks, and git diff --check
Evidence boundary: isolated local checkout
Semantic owner: operational execution documentation
Target role: active human-supervised execution interface
History disposition: prior Execution1.3 state retained in Git and J
Result: accepted as a materialization candidate pending human diff review and
        Git persistence
```

```text
Claim: NEON_CRED.md remains the active coordinate filename
Source: pre-reconciliation live references
Current state: contradicted
Evidence: canonical file is NS_COORDINATES.md; launcher default and active
          command bodies now use NS_COORDINATES.md
Semantic owner: canonical five-file interface
History disposition: historical NEON_CRED.md references preserved as evidence
Result: rejected as a live path; retained only as historical naming
```

```text
Claim: the coordinate file contains authentication secrets
Source: inspected NS_COORDINATES content and scoped secret-pattern scan
Current state: contradicted within the inspected five-file boundary
Evidence: only non-secret coordinates, identifiers, route names, public
          metadata, role names, and migration identifiers were found
Evidence boundary: inspected repository files; no claim about external secret
                   stores
Semantic owner: coordinate safety contract
Result: rejected
```

```text
Claim: every GRIMOIRE procedure is runtime-validated on Windows and providers
Source: static materialization validation
Current state: host-unvalidated for this sprint
Evidence: structural and parser validation passed; Windows/provider execution
          was not repeated
Semantic owner: operational runtime evidence
Result: remain host-unvalidated until the applicable procedures are executed in
        the intended Windows/provider environment
```

```text
Claim: this redesign authorizes migration, deployment, credential changes, or
       one controlled Sync request
Source: documentation materialization
Current state: contradicted
Evidence: no provider action was included in the authorized scope
Result: rejected; existing provider and Step 12 stop boundaries remain active
```

### Continuation boundary

The immediate continuation is:

1. replace the five local files with the reviewed candidate versions;
2. append this record to J;
3. run the naming and diff integrity guard;
4. inspect the complete six-file diff;
5. persist the batch only after human acceptance;
6. collect and independently verify the remaining non-secret coordinates;
7. fill `NS_COORDINATES.md` without adding secrets;
8. resume Cycle 10 GCM-02 closure and Step 12 from the read-only preparation
   boundary.

Step 12’s authenticated Sync mutation remains held. No request is authorized
until identity, token flow, exact device/account binding, canonical request
generation, expected state transition, and stop conditions are fully resolved.

Current terminals:

```text
NEO_GRIMOIRE_FIVE_FILE_REDESIGN_IMPLEMENTED_LOCALLY
ACTIVE_COORDINATE_FILENAME_NS_COORDINATES
STALE_LIVE_NEON_CRED_EXECUTION_PATHS_REMOVED
HISTORICAL_NEON_CRED_REFERENCES_PRESERVED
ORIGINAL_COORDINATE_KEYS_RETAINED_11_OF_11
STATIC_INTERFACE_VALIDATION_PASS
WINDOWS_AND_PROVIDER_RUNTIME_NOT_REEXECUTED
HUMAN_DIFF_REVIEW_AND_GIT_PERSISTENCE_PENDING
NS_COORDINATE_COLLECTION_NEXT
MIGRATION_007_DO_NOT_RERUN
CONTROLLED_SYNC_REQUEST_UNAUTHORIZED
GCM02_OPEN
```

## Append-only reconciliation entry — 2026-07-25 — Gate 12.6 copied-database classification

### Sequence identity

```text
Sequence: FLX-PRM-04 — Promotion/Reconciliation
Role: Main Chat
Round: C10-GCM02-GATE-12.6-COPIED-DATABASE-RECONCILIATION
Branch: cycle10-intermid-grimoire
Inspected remote baseline: 49534b2029ecc56441cc00a5ad8b5a1a29ddbb38
Authority: human-requested Main reconciliation and next-Codex staging
Evidence boundary: sanitized user-transcribed Windows/SQLite output,
                   repository source, and Git history
```

### Accepted copied-database observation

The human operator first aligned the Windows checkout to
`49534b2029ecc56441cc00a5ad8b5a1a29ddbb38`. Markei was closed. The canonical
`GS-SQLITE-02` procedure then:

- found exactly one local `markei_shared_beta.sqlite` candidate;
- observed no WAL/SHM sidecars;
- created the fixed-name Gate 12.6 working copy;
- verified equal source/copy sizes and hashes without printing hash values;
- did not query the live database;
- returned the terminal to repository root.

The canonical `GS-SQLITE-03` procedure queried only that copy in read-only
mode. It observed:

```text
Expected Sync tables:                    6/6 present
SQLite quick_check:                      ok
Active failed submissions:               1
Active failed outcome:                   notApplied
Active response/error representation:    conflict / service-unavailable
Active submission members:               2
Active member sequence range:            1–2
Active member positions:                 0–1
Active member event state:               failed
Superseded submissions:                  2
Each superseded member count/range:       2 / 1–2
Device next_sequence distribution:        2, 3, 6
Failed pending-event rows:                2 / sequences 1–2
Pending pending-event rows:               6 / sequences 1–5
Latest ordinary Sync result:              sync-unavailable
Latest recovery classification:           provider-evidence-unavailable
Latest HTTP status/headers:                absent / absent
Live database queried:                    false
Retry selected:                           false
Sync selected:                            false
Provider action performed:                false
```

This evidence contains no database path, account/device/submission/event ID,
payload, purchase content, token, URL, complete hash, or provider secret.

### Repository and history reconciliation

Current source proves:

1. `HttpSyncTransport._failure` now maps protocol
   `service-unavailable` to `SyncStatusCode.serviceUnavailable`;
2. `LocalSyncRepository.persistUploadResult` stores `result.code.name` in
   `response_code` and the protocol body code in `error_code`;
3. the fallback branch maps unrecognized protocol codes to
   `SyncStatusCode.conflict`;
4. commit `75dc7bed0789d693af93abb3ed15e107fd77433a`, authored
   2026-07-22 11:54:56 -0300, introduced the explicit
   `service-unavailable -> serviceUnavailable` mapping;
5. the copied database reports a last-modified time of
   2026-07-22 10:08:29 in the human's Windows locale, earlier than that commit.

The observed `conflict / service-unavailable` pair is therefore historically
coherent with the pre-fix fallback mapper: the client retained the precise
protocol code in `error_code` while persisting the fallback client enum name in
`response_code`. This is strong source-history evidence for a legacy
representation. It is not proof that every row was written by a uniquely
identified executable, because filesystem timestamps and Git author time do
not provide row-level provenance.

### Gate conclusion

PRC-01 classification:

```text
Claim: the copied database is structurally readable and internally healthy
Prior state: unavailable
Evidence: verified copy procedure, six-table presence, PRAGMA quick_check=ok
Evidence boundary: sanitized human-observed output; no Codex/user live-DB read
Contradiction: none
Semantic owner: GCM-02 operational evidence
Target role: Gate 12.6 copied-database subprocedure
Resulting state: accepted PASS
History disposition: diagnostic uncertainty superseded
```

```text
Claim: the current queue contains an unknown submission eligible for unknown Retry
Prior state: provisional possibility
Evidence: one active submission is failed/notApplied; no unknown class emitted
Evidence boundary: copied database at the preserved snapshot
Contradiction: earlier screenshot/procedure language implied unresolved unknown
Semantic owner: local Sync recovery classification
Target role: Gate 12.6 eligibility
Resulting state: rejected; unknown-retry path is inapplicable
History disposition: earlier provisional Conclusion C superseded
```

```text
Claim: exactly one failed/notApplied recovery candidate exists
Prior state: provisional
Evidence: active class and two-member failed lineage at sequences 1–2
Evidence boundary: sanitized grouping; exact device/account correlation omitted
Contradiction: none
Semantic owner: failed-recovery eligibility
Target role: Gate 12.6 transition definition
Resulting state: accepted as queue classification; exact scoped transition pending
History disposition: retain pre-probe diagnosis as observational history
```

```text
Claim: conflict/service-unavailable contradicts current mapping
Prior state: unresolved semantic anomaly
Evidence: source mapping, persistence fields, Git introduction commit, file time
Evidence boundary: source/history and file-level time; no row-level provenance
Contradiction: apparent current-source mismatch
Semantic owner: client protocol persistence history
Target role: Gate 12.6 evidence interpretation
Resulting state: explained as historically coherent legacy representation
History disposition: preserve boundary; do not rewrite the database
```

```text
Claim: the successful copied-database probe authorizes ordinary Sync
Prior state: unauthorized
Evidence: coordinator performs failed recovery before upload, download and ack;
          six other pending rows are present
Evidence boundary: current source plus copied grouping
Contradiction: none
Semantic owner: Gate 12.7 human authorization
Target role: mutation boundary
Resulting state: rejected; ordinary Sync remains unauthorized
History disposition: stop boundary retained
```

Gate 12.6 no longer waits on queue-classification evidence. It remains open
only because the sanitized output does not yet correlate the failed submission
to an anonymized device scope, that scope's `next_sequence`, or the distribution
of the six other pending events. Those facts determine whether the coordinator's
recovery-then-upload path can be described as one exact bounded transition.

### Next materialization round

D/E/F are replaced with one bounded evidence-reconciliation round:

```text
D: classify copied evidence; prove legacy mapping history; decide whether one
   additional sanitized copied-database correlation procedure is necessary
E: stabilize evidence vocabulary and prevent PASS/authorization conflation
F: trace failed recovery -> upload -> download -> acknowledgement and prepare
   a Gate 12.7 packet skeleton with every unproven field marked PENDING
```

The round may update G/H/I. It may add only `GS/GRM-SQLITE-04` if exact
device-scoped correlation cannot be established from current evidence. It may
not modify application source, query a user database, perform provider action,
authorize Gate 12.7, or close GCM-02.

### Current terminals

```text
GATE_12_6_COPIED_DATABASE_PROBE_PASS
FAILED_NOT_APPLIED_CLASS_CONFIRMED
UNKNOWN_RETRY_INAPPLICABLE
LEGACY_CONFLICT_SERVICE_UNAVAILABLE_EXPLAINED_WITH_BOUNDARY
EXACT_DEVICE_SCOPED_TRANSITION_CORRELATION_PENDING
GATE_12_6_OPEN
GATE_12_7_PENDING
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
PROVIDER_ACTION_UNAUTHORIZED
GCM02_OPEN
```

## Append-only reconciliation entry — 2026-07-25 — DB management cascade refactor

### Sequence identity

```text
Sequence: FLX-PRN-03 with active-state reconciliation
Scope: live GRIMOIRE operational interface
Baseline: 41c94be245ed093b2e92e3f8403ef72cfb42984b
Provider action: none
Database access: none
Gate authority change: none
```

The parallel Codex round materialized and fixture-validated
`GS/GRM-SQLITE-04`; no human database was queried. The preceding entry's
conditional materialization instruction is therefore superseded for current
use. The remaining Gate 12.6 action is the human-run, read-only
`GRM-SQLITE-04` procedure against the preserved verified copy.

The live five-file interface was reorganized without changing provider state:

```text
GRIMOIRE.md       -> concise GRM invocation index
NEON_CHECK.ps1    -> exact GS dispatcher and guarded Neon launcher
G_SCRIPTS.md      -> complete procedures, prompts, expectations and stops
NS_COORDINATES.md -> reviewed non-secret values
DB_MGMT.sql       -> manual SQL plus indexed automation queries
```

`DB_MGMT.sql` supersedes `NEON_ACTION.sql` as the live catalogue. Earlier
`NEON_ACTION.sql`/`NA-*` references remain valid historical evidence only.
Every active `GRM-*` block now invokes one exact `GS-*` procedure; operational
variables and query logic no longer live in GRM bodies. The nine existing
automation SQL bodies were preserved byte-for-byte, and one read-only
`runtime-readiness` automation block was added so `GRM-NEON-10` also follows
the uniform cascade.

Current terminals remain:

```text
EXACT_DEVICE_SCOPED_TRANSITION_CORRELATION_PENDING
GATE_12_6_OPEN
GATE_12_7_PENDING
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
PROVIDER_ACTION_UNAUTHORIZED
GCM02_OPEN
```

## Append-only reconciliation entry — 2026-07-25 — GRM rename and full catalogue audit

### Sequence identity

```text
Sequence: FLX-PRN-03 with PRC-01 evidence qualification
Scope: live GRM/GS procedural interface and Gate 12.6 recovery pointer
Baseline: 05265cfb91f92504e1ac5e627f0af62e351c4b8f
Provider action: none
Database access: none
Retry or ordinary Sync: none
Gate authority change: none
```

The concise human entrypoint was renamed:

```text
documentation/GRIMOIRE.md -> documentation/GRM.md
GRIMOIRE_INDEX             -> GRM_INDEX
```

The live file header now explains the complete procedural cascade and contains
one ordered code/name glossary for every active command. The canonical route
remains:

```text
human copies GRM
-> NEON_CHECK dispatches one GS
-> GS owns guards, coordinates and requested inputs
-> GS invokes PowerShell and/or one DB_MGMT automation query
-> sanitized evidence returns for human interpretation
```

Qualified static audit:

```text
ordered GRM glossary entries: 25 / 25
active GRM invocation blocks: 25 / 25
active GS procedure headings: 25 / 25
one exact GRM-to-GS mapping per active command: PASS
one PowerShell fence per active GS procedure: PASS
active GRM/GS order equality: PASS
DB_MGMT automation blocks and end markers: 10 / 10
launcher action-name coverage: PASS
historical GS procedures outside active GRM index: 2
live five-file references to old GRIMOIRE filename/index: 0
```

This audit proves catalogue structure, mapping, ordering and documentation
coherence at the inspected repository state. It is not a Windows PowerShell,
provider, database, Flutter, Retry or Sync execution. No GS procedure body was
changed by the rename round. Existing fixture and human evidence retain their
previous boundaries.

The mutable J recovery prefix now records that the evidence-only Codex round
is complete. The sole next Gate 12.6 evidence action is to run the indexed,
sanitized and read-only `GRM-SQLITE-04` procedure against the preserved
verified copy after the integrated branch is published and pulled.

Current terminals remain:

```text
GCM02_12_6_COPIED_DATABASE_PROBE_PASS
GCM02_12_6_DEVICE_SCOPED_CORRELATION_PENDING
GCM02_12_7_HUMAN_AUTHORIZATION_PENDING
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
PROVIDER_ACTION_UNAUTHORIZED
GCM02_OPEN
```

## Append-only reconciliation entry — 2026-07-25 — Gate 12.6 device-scope closure

### Sequence identity

```text
Sequence: FLX-PRM-04 Main reconciliation
Round: C10-GCM02-GATE-12.6-DEVICE-SCOPE-CLOSURE
Branch baseline: 52ea09c9e08380fb7c2a85b58ae9909385bd3bdc
Human evidence: sanitized GS-SQLITE-04 output
Provider action: none
Live database access: none
Retry or ordinary Sync: none
Gate authority change: Gate 12.6 PASS; Gate 12.7 remains unauthorized
```

Claim: the remaining failed lineage is correlated to one Device scope.

Prior state: Gate 12.6 was open for exact anonymized scope ownership,
`next_sequence`, other-pending-work partition and simulated first-upload
membership.

Evidence: the human-operated read-only copied-database procedure found three
Device scopes. Rank 3 is the hosted/enrolled scope, has `next_sequence=3`, and
owns the failed/notApplied two-event candidate at contiguous sequences 1–2 and
positions 0–1.

Evidence boundary: the procedure queried only the preserved verified SQLite
copy with quick-check already OK. It did not query the live database, select
Retry or Sync, contact a provider, mutate data or clean anything.

Contradiction: none. The six other pending events divide across non-hosted
rank 1 (one event) and rank 2 (five events). The hosted scope has no other
pending work.

Semantic owner: Main GCM-02 gate reconciliation.

Target role: Gate 12.6 device-scoped transition correlation.

Resulting state: accepted PASS. Simulated recovery places exactly the two
candidate events in the first upload; no active or superseded submission has
the same request hash.

History disposition: the earlier Gate 12.6 pending terminals remain historical
and are superseded for current recovery by this entry and the mutable prefix.

Claim: the latest local Sync proves a fresh provider contradiction.

Prior state: unresolved because the copied database stores
`sync-unavailable / provider-evidence-unavailable`.

Evidence: the latest attempt has no HTTP status and no response headers.

Evidence boundary: local observational classification only.

Contradiction: rejected. No fresh provider comparison occurred, so the local
failed/notApplied lineage and earlier Neon checkpoint describe different
sides/times of the boundary rather than proven conflicting state.

Semantic owner: Gate 12.7 pre-operation freshness packet.

Target role: provider-baseline interpretation.

Resulting state: fresh provider readiness and baseline must be rechecked before
authorization; no database repair is justified by the present evidence.

History disposition: preserved as the reason 12.7 requires freshness checks.

Current terminals:

```text
GCM02_12_6_COPIED_DATABASE_PROBE_PASS
GCM02_12_6_DEVICE_SCOPED_CORRELATION_PASS
GCM02_12_6_PASS
GCM02_12_7_PACKET_PREPARATION_ACTIVE
GCM02_12_7_HUMAN_AUTHORIZATION_PENDING
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
REPAIR_UNAUTHORIZED
PROVIDER_MUTATION_UNAUTHORIZED
GCM02_OPEN
```

## System Diagnosis

Date: 2026-07-25

Record class: append-only Step 12.1–12.6 diagnostic synthesis.

Change authority: documentation and Gate interpretation only. This entry does
not authorize Retry, ordinary Sync, Repair, Enroll, provider mutation, or direct
database mutation.

### Reconciliation correction

The prior Gate 12.7 preparation named `Retry unresolved submission` as the
candidate one-action recovery. Source inspection and the captured UI state
invalidate that action selection for the current lineage:

- the visible Retry control is an **unknown-outcome Retry**;
- the current hosted Device scope has `pending=0`, `uploading=0`, `failed=2`,
  and `unknown=0`;
- its preflight therefore returns the existing native code
  `unknown-retry-queue-not-isolated`;
- the blocked branch performs no local mutation and no provider request;
- the page refreshes Diagnostics and changes only its compact status text; it
  does not show a blocking dialog or an in-view banner;
- the correct current lineage is the already-proved `failed/notApplied`
  candidate containing Device sequences `1–2`, with `next_sequence=3`.

The latest Retry button press is therefore explained. It is not evidence of a
new SQLite/Neon contradiction, provider rejection, failed database repair, or
HTTP 500.

The displayed `sync-unavailable / provider-evidence-unavailable` result belongs
to an earlier ordinary Sync attempt. Its exact internal failure phase remains
unproved. Null HTTP status/header fields in the current attempt record must not
be interpreted as proof that the earlier Sync never contacted the API, because
the ordinary Sync path does not currently populate those fields. The supplied
Render window proves only that the latest blocked Retry click produced health
requests and no protected Sync request in that window.

Current corrected terminal:

```text
GCM02_12_6_PASS
GCM02_12_7_ACTION_INTERFACE_ALIGNMENT_BLOCKED
CURRENT_UNKNOWN_RETRY_INAPPLICABLE
BOUNDED_FAILED_NOT_APPLIED_RECOVERY_NOT_IMPLEMENTED
PRIOR_SYNC_FAILURE_PHASE_UNRESOLVED
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
REPAIR_UNAUTHORIZED
PROVIDER_MUTATION_UNAUTHORIZED
GCM02_OPEN
```

### Error Protocol purpose

This protocol catalogues only events that are reachable from the inspected
Flutter, API, PostgreSQL, and SQLite composition or are directly required to
explain the accepted Step 12 evidence. It deliberately excludes speculative
external systems and failure modes not represented by the current source.

The protocol has four objectives:

1. prevent an expected, classifiable failure from collapsing into a generic
   `500/service-unavailable`;
2. distinguish a local preflight stop from a request that may have reached the
   provider;
3. preserve whether an operation was blocked, not applied, applied,
   duplicate-equivalent, or left with unknown outcome;
4. make every UI action traceable through one sanitized operation fingerprint
   without exposing tokens, raw account/device IDs, payloads, SQL, or full
   request hashes.

### Code and classification contract

Protocol codes use:

```text
MKS-<LAYER>-<NNN>
```

The protocol code wraps rather than replaces an existing runtime
`resultCode`, `protocolCode`, `errorCode`, or Auth0 state. For example:

```text
protocolCode: MKS-UI-001
nativeCode: unknown-retry-queue-not-isolated
```

Layers:

| Layer | Meaning                                                          |
| ----- | ---------------------------------------------------------------- |
| `UI`  | action selection, preflight presentation, and visible result     |
| `CFG` | compiled configuration, composition, revision, and endpoint      |
| `AUT` | authentication and token acquisition                             |
| `BND` | account, installation, Device, enrollment, and hosted binding    |
| `LDB` | local SQLite access, schema, transaction, and attempt ledger     |
| `REC` | failed/notApplied recovery candidate and requeue                 |
| `QUE` | pending/uploading/unknown queue lease and persistence            |
| `TRN` | HTTP construction, connection, timeout, and response decoding    |
| `API` | API ingress, route, authorization, and request validation        |
| `PDB` | PostgreSQL connection, transaction, privileges, and constraints  |
| `UPL` | submission validation and provider upload application            |
| `DNL` | provider download and local remote-event application             |
| `ACK` | provider acknowledgement                                         |
| `OBS` | observability, correlation, redaction, and diagnostic projection |
| `INV` | invariant violations and partial-application hazards             |

Severity is independent of outcome:

| Severity   | Meaning                                                   |
| ---------- | --------------------------------------------------------- |
| `INFO`     | expected no-op or completed state                         |
| `WARNING`  | safe blocked state requiring review or a different action |
| `ERROR`    | known failure with a proved application boundary          |
| `UNKNOWN`  | provider or persistence outcome cannot be proved          |
| `CRITICAL` | invariant or atomicity violation; freeze mutation         |

Allowed outcomes:

```text
blocked
not-applied
applied
duplicate-equivalent
unknown
completed
```

Evidence relevance:

| Value         | Meaning                                                     |
| ------------- | ----------------------------------------------------------- |
| `CONFIRMED`   | observed and sufficient to explain the named event          |
| `REACHABLE`   | explicit current source branch; not yet observed here       |
| `LATENT`      | source-level ambiguity or defect requiring tightening       |
| `LOW-CURRENT` | reachable, but contradicted or reduced by accepted evidence |
| `FRESHNESS`   | previously accepted; must be rechecked before mutation      |

### Required diagnostic envelope

Every top-level UI action must create one `operationId`; every child HTTP
request must inherit it and add a request ordinal. The persisted and logged
envelope must contain:

| Field                                                           | Rule                                                                                                                        |
| --------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `diagnosticVersion`                                             | schema version, initially `1`                                                                                               |
| `protocolCode`                                                  | stable `MKS-*` code                                                                                                         |
| `nativeCode`                                                    | existing sanitized runtime code, if one exists                                                                              |
| `severity` / `outcome`                                          | values from the contracts above                                                                                             |
| `operationKind`                                                 | `diagnostics`, `unknown-retry`, `failed-recovery`, `sync`, `upload`, `download`, or `acknowledge`                           |
| `phase`                                                         | exact last completed or failed pipeline phase                                                                               |
| `operationFingerprint`                                          | first 12 hex characters of SHA-256 over a random per-action operation ID                                                    |
| `correlationFingerprint`                                        | first 12 hex characters of SHA-256 over the full request correlation ID                                                     |
| `requestOrdinal`                                                | `0` for local preflight; `1..n` for child requests                                                                          |
| `submissionFingerprint`                                         | first 12 hex characters of SHA-256 over submission identity; never the raw ID                                               |
| `requestHashShape`                                              | only `sha256-64-hex-valid` or `invalid`; never the full request hash                                                        |
| `accountScopeFingerprint`                                       | first 12 hex characters of SHA-256 over the normalized account UUID                                                         |
| `deviceScopeFingerprint`                                        | first 12 hex characters of SHA-256 over the normalized Device UUID                                                          |
| `sourceRevision`                                                | deployed/client short Git revision                                                                                          |
| `clientBuild` / `apiBuild`                                      | sanitized build identifiers                                                                                                 |
| `routeClass`                                                    | route template, never a URL containing identifiers                                                                          |
| `queueScope`                                                    | explicitly `account` or `device`                                                                                            |
| `pendingCount`, `uploadingCount`, `failedCount`, `unknownCount` | target scope counts captured at action start                                                                                |
| `memberCount`, `firstSequence`, `lastSequence`, `nextSequence`  | numeric boundary only                                                                                                       |
| `localMutation`                                                 | `none`, `started`, `committed`, `rolled-back`, or `unknown`                                                                 |
| `providerContact`                                               | `not-started`, `request-started`, `headers-received`, `trusted-response`, or `unknown`                                      |
| `providerTransaction`                                           | `not-started`, `committed`, `rolled-back`, or `unknown`                                                                     |
| `httpStatus`                                                    | numeric status when received                                                                                                |
| `headersReceived`                                               | boolean                                                                                                                     |
| `responseTrusted`                                               | boolean after origin, size, JSON, and contract validation                                                                   |
| `elapsedBand`                                                   | bounded band, not precise timing                                                                                            |
| `retryable`                                                     | typed protocol value, never inferred solely from HTTP 500                                                                   |
| `safeAction`                                                    | bounded guidance such as `preserve-local-state`, `sign-in`, `recheck-enrollment`, `inspect-candidate`, or `operator-review` |
| `exceptionClass`                                                | closed sanitized allow-list; no message or stack in UI                                                                      |
| `sqlStateClass`                                                 | allow-listed SQLSTATE class in server logs only                                                                             |

Never persist or display bearer/refresh/ID tokens, authorization codes, raw
account/device/event/submission IDs, payload bodies, personal purchase data,
connection strings, SQL text, complete hashes, raw exception messages, or stack
traces.

### Event parsing and precedence

Events must be reduced in this order:

1. Verify the `diagnosticVersion` and stable protocol code.
2. Join by `operationFingerprint`, then `requestOrdinal`.
3. Prefer a trusted typed provider response over an HTTP status label.
4. Prefer a proved transaction outcome over a transport outcome.
5. If request transmission started but no trusted provider outcome exists,
   classify `unknown`; never automatically requeue as `not-applied`.
6. If local preflight stopped before mutation and request start, classify
   `blocked`.
7. If the provider proves `not-applied`, preserve the failed lineage until a
   separately authorized failed-recovery action.
8. If local result persistence fails after a trusted provider response,
   preserve the provider outcome and emit a separate local-persistence event.
9. A later event may refine an earlier `unknown`, but must not erase it.
10. UI projection must show the current action result separately from the last
    ordinary Sync result.

### A. Present incident and UI selection

| Code         | Event / native signal                                                            | Detection fingerprint                                                                                          | Relevance   | Required disposition                                          |
| ------------ | -------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- | ----------- | ------------------------------------------------------------- |
| `MKS-UI-001` | Unknown Retry blocked by non-isolated queue / `unknown-retry-queue-not-isolated` | Device queue `failed=2`, `unknown=0`; preflight stops before mutation/request                                  | `CONFIRMED` | Visible warning; select no provider action                    |
| `MKS-UI-002` | Blocked preflight is not visibly presented                                       | state changes only in compact page status; no dialog/banner                                                    | `CONFIRMED` | Add persistent in-view warning with code and safe action      |
| `MKS-UI-003` | Wrong recovery action label                                                      | label says unresolved submission although implementation accepts only unknown outcome                          | `CONFIRMED` | Rename to `Retry unknown-outcome submission`                  |
| `MKS-UI-004` | Failed/notApplied action absent                                                  | failed candidate exists but no bounded failed-recovery control exists                                          | `CONFIRMED` | Implement separate preflight and separately authorized action |
| `MKS-UI-005` | Current action result conflated with prior Sync result                           | button preflight result and `Last result: sync-unavailable` occupy different UI state without clear chronology | `CONFIRMED` | Show action name, timestamp/order, and operation fingerprint  |
| `MKS-UI-006` | Action handler exception escapes visible reporting                               | page `_run` and diagnostic refresh/preflight lack a page-level presentation boundary                           | `LATENT`    | Catch, persist, and display sanitized typed failure           |
| `MKS-UI-007` | Account-scoped queue summary interpreted as Device-scoped                        | snapshot totals use Account scope while recovery preflight uses Device scope                                   | `LATENT`    | Label both scopes and fingerprint the target Device           |
| `MKS-UI-008` | Enrolled badge overstates full binding validity                                  | snapshot projects hosted row state; full binding validation happens later in Sync guard                        | `LATENT`    | Display binding-validation state separately                   |

### B. Configuration and composition

| Code          | Event / native signal                                             | Detection fingerprint                                                                | Relevance     | Required disposition                           |
| ------------- | ----------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ------------- | ---------------------------------------------- |
| `MKS-CFG-001` | Unsupported native platform / `platform-unsupported`              | client platform not supported by native Auth surface                                 | `LOW-CURRENT` | Block before sign-in or Sync                   |
| `MKS-CFG-002` | Missing/invalid Auth0 configuration / `configuration-invalid`     | domain, client ID, audience, or callback invalid/missing                             | `LOW-CURRENT` | Block and identify missing configuration class |
| `MKS-CFG-003` | Hosted surface disabled / `configuration-missing`                 | required hosted endpoint/define absent                                               | `LOW-CURRENT` | Block composition; no network attempt          |
| `MKS-CFG-004` | Invalid API origin                                                | endpoint parse, scheme, or allowed-origin validation fails                           | `REACHABLE`   | Emit origin/config code; do not call provider  |
| `MKS-CFG-005` | Binding created after app composition / `hosted-restart-required` | no active hosted binding loaded at startup although enrollment later succeeds        | `REACHABLE`   | Require controlled app restart before Sync     |
| `MKS-CFG-006` | Client/API/repository revision drift                              | client build, API build, and expected branch revision differ                         | `FRESHNESS`   | Stop Gate 12.7 and reconcile revisions         |
| `MKS-CFG-007` | Deployment healthy but wrong source revision                      | `/health/ready` succeeds but advertised API build differs from authorization packet  | `FRESHNESS`   | Treat readiness as insufficient; stop          |
| `MKS-CFG-008` | Constant request correlation source                               | all native closure requests derive from `native-closure` rather than a per-action ID | `LATENT`      | Generate unique correlation per action/request |

### C. Authentication and token acquisition

| Code          | Event / native signal                                                     | Detection fingerprint                                                     | Relevance     | Required disposition                                            |
| ------------- | ------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ------------- | --------------------------------------------------------------- |
| `MKS-AUT-001` | Signed out / `signed-out` or `auth-required`                              | no current authenticated state/token                                      | `LOW-CURRENT` | Sign in; no queue mutation                                      |
| `MKS-AUT-002` | Sign-in already running / `signing-in`                                    | concurrent sign-in state                                                  | `REACHABLE`   | Block duplicate action                                          |
| `MKS-AUT-003` | User cancelled sign-in / `sign-in-cancelled`                              | provider flow returns cancellation                                        | `REACHABLE`   | Preserve queue; present informational result                    |
| `MKS-AUT-004` | Provider unavailable / `provider-unavailable`                             | provider launch/discovery unavailable                                     | `REACHABLE`   | Preserve queue; operator/network review                         |
| `MKS-AUT-005` | Callback absent / `callback-not-received`                                 | authorization flow ends without callback                                  | `REACHABLE`   | Preserve queue; no Sync                                         |
| `MKS-AUT-006` | Callback state rejected / `callback-state-rejected`                       | returned state does not match local state                                 | `REACHABLE`   | Security stop; discard callback                                 |
| `MKS-AUT-007` | Code exchange rejected / `authorization-code-exchange-rejected`           | token endpoint rejects code exchange                                      | `REACHABLE`   | Preserve queue; new sign-in required                            |
| `MKS-AUT-008` | Access token missing / `access-token-missing`                             | exchange succeeds without usable access token                             | `REACHABLE`   | Reject credentials; no provider request                         |
| `MKS-AUT-009` | ID token missing / `id-token-missing`                                     | exchange lacks required ID token                                          | `REACHABLE`   | Reject credentials                                              |
| `MKS-AUT-010` | Token confusion rejected / `token-confusion-rejected`                     | token identity/type binding inconsistent                                  | `REACHABLE`   | Security stop                                                   |
| `MKS-AUT-011` | Local token expired / `token-expired`                                     | expiry within configured safety margin                                    | `REACHABLE`   | Sign in again; preserve queue                                   |
| `MKS-AUT-012` | Server token rejected / `token-rejected`                                  | JWT malformed, oversized, wrong issuer/audience/algorithm/key, or expired | `REACHABLE`   | Public code remains sanitized; server log records safe subphase |
| `MKS-AUT-013` | Membership missing / `membership-required`                                | verified principal has no active hosted membership                        | `LOW-CURRENT` | Stop; recheck Auth0/Neon identity                               |
| `MKS-AUT-014` | Account selection ambiguous / `account-selection-required`                | principal maps to multiple/ambiguous account choices                      | `LOW-CURRENT` | Stop; explicit account selection required                       |
| `MKS-AUT-015` | Authentication rejected, unclassified / `authentication-rejected-unknown` | provider error outside known local mapping                                | `REACHABLE`   | Preserve sanitized provider class and operation fingerprint     |

### D. Binding, enrollment, and Device authorization

| Code          | Event / native signal                              | Detection fingerprint                                                          | Relevance     | Required disposition                                |
| ------------- | -------------------------------------------------- | ------------------------------------------------------------------------------ | ------------- | --------------------------------------------------- |
| `MKS-BND-001` | Enrollment required / `device-enrollment-required` | no active enrolled Device for account/installation                             | `LOW-CURRENT` | Stop and query/enroll only under separate authority |
| `MKS-BND-002` | Local hosted binding invalid / `binding-invalid`   | environment alias, UUID, installation, generation, or active-state check fails | `LOW-CURRENT` | Stop; never silently substitute Device              |
| `MKS-BND-003` | Device header missing/malformed                    | protected request lacks valid `x-markei-device-id`                             | `REACHABLE`   | Reject before service execution                     |
| `MKS-BND-004` | Device revoked / `device-revoked`                  | local or hosted enrollment/device is revoked                                   | `LOW-CURRENT` | Stop; preserve local events                         |
| `MKS-BND-005` | Device expired / `device-expired`                  | enrollment/device expiry check fails                                           | `LOW-CURRENT` | Stop; explicit re-enrollment decision               |
| `MKS-BND-006` | Device/account binding mismatch / `wrong-account`  | event, token account, binding account, or Device account differs               | `LOW-CURRENT` | Critical identity stop; no repair mutation          |
| `MKS-BND-007` | Hosted authorization forbidden / `forbidden`       | authenticated principal lacks required operation permission                    | `REACHABLE`   | Stop; inspect policy/membership                     |
| `MKS-BND-008` | Local Device scope differs from authorized target  | queue target fingerprint/rank differs from Gate packet                         | `LOW-CURRENT` | Cancel action and rebuild evidence                  |

### E. Local SQLite and attempt ledger

| Code          | Event / native signal                   | Detection fingerprint                                                              | Relevance     | Required disposition                                               |
| ------------- | --------------------------------------- | ---------------------------------------------------------------------------------- | ------------- | ------------------------------------------------------------------ |
| `MKS-LDB-001` | SQLite open failure                     | database cannot be opened/read                                                     | `LOW-CURRENT` | Stop; preserve file and OS error class                             |
| `MKS-LDB-002` | Integrity/schema failure                | quick check fails or expected table count/schema differs                           | `LOW-CURRENT` | Freeze mutation; copied DB showed healthy expected schema          |
| `MKS-LDB-003` | Local migration/version mismatch        | client expects fields/tables absent from current DB                                | `LOW-CURRENT` | Stop; no ad hoc SQL                                                |
| `MKS-LDB-004` | Diagnostics query failure               | snapshot/preflight query throws or returns invalid shape                           | `REACHABLE`   | Emit typed local-read failure                                      |
| `MKS-LDB-005` | Attempt-begin persistence failure       | attempt row cannot be inserted before action                                       | `REACHABLE`   | Do not start provider contact                                      |
| `MKS-LDB-006` | Attempt-completion persistence failure  | operation finishes but result row cannot be finalized                              | `LATENT`      | Preserve external outcome separately; emit local-persistence error |
| `MKS-LDB-007` | Unknown stored enum/state               | text state cannot be decoded into current enum                                     | `REACHABLE`   | Invariant stop; never collapse to generic unavailable              |
| `MKS-LDB-008` | Local JSON/type/date decode failure     | persisted payload cannot be decoded/cast                                           | `REACHABLE`   | Quarantine candidate by identity fingerprint; no mutation          |
| `MKS-LDB-009` | Local transaction constraint failure    | recovery/lease/apply violates SQLite constraint                                    | `REACHABLE`   | Roll back and report transaction outcome                           |
| `MKS-LDB-010` | Attempt evidence field absent by design | Sync attempt has null correlation/status/header because writer never supplied them | `CONFIRMED`   | Treat as instrumentation gap, not proof of no provider contact     |

### F. Failed/notApplied recovery

| Code          | Event / native signal                                              | Detection fingerprint                                            | Relevance     | Required disposition                                  |
| ------------- | ------------------------------------------------------------------ | ---------------------------------------------------------------- | ------------- | ----------------------------------------------------- |
| `MKS-REC-001` | Recoverable failed lineage available / `failed-recovery-available` | exactly one valid scoped failed/notApplied candidate             | `CONFIRMED`   | Preflight only until Gate 12.7 authorization          |
| `MKS-REC-002` | No recoverable failed lineage / `no-recoverable-failure`           | zero valid failed/notApplied candidates                          | `REACHABLE`   | Informational stop                                    |
| `MKS-REC-003` | Ambiguous failed lineage / `failed-recovery-blocked`               | multiple candidate submissions                                   | `REACHABLE`   | Stop; operator reconciliation                         |
| `MKS-REC-004` | Candidate membership malformed                                     | count, position, contiguity, or event lookup invalid             | `REACHABLE`   | Critical local invariant stop                         |
| `MKS-REC-005` | Candidate state mismatch                                           | member/event not uniformly failed as expected                    | `REACHABLE`   | Stop; capture state-kind set                          |
| `MKS-REC-006` | Candidate contains accepted member                                 | candidate overlaps an accepted event                             | `REACHABLE`   | Stop; never requeue                                   |
| `MKS-REC-007` | Candidate overlaps active submission                               | uploading/unknown submission shares candidate members            | `REACHABLE`   | Stop; resolve active outcome first                    |
| `MKS-REC-008` | Candidate request hash/payload invalid                             | canonical payload or request-hash validation fails               | `LOW-CURRENT` | Stop; SQLite-04 observed valid hash shape/contiguity  |
| `MKS-REC-009` | Candidate Device/account mismatch                                  | candidate scope differs from authorized binding                  | `LOW-CURRENT` | Stop; no cross-scope recovery                         |
| `MKS-REC-010` | Recovery transaction rolled back                                   | supersede/requeue transaction fails before commit                | `REACHABLE`   | Preserve candidate and record rollback                |
| `MKS-REC-011` | Recovery commit result unknown                                     | local process/storage interruption around commit                 | `REACHABLE`   | Reopen diagnostics; do not repeat automatically       |
| `MKS-REC-012` | Mixed pending/failed candidate partial-requeue ambiguity           | recovery sees `alreadyPending` while other members remain failed | `LATENT`      | Tighten to all-or-none candidate state before release |

### G. Queue isolation, lease, and result persistence

| Code          | Event / native signal                                 | Detection fingerprint                                                    | Relevance     | Required disposition                                                 |
| ------------- | ----------------------------------------------------- | ------------------------------------------------------------------------ | ------------- | -------------------------------------------------------------------- |
| `MKS-QUE-001` | Pending and unknown collision / `local-batch-invalid` | target Device has pending and unknown work together                      | `REACHABLE`   | Stop; resolve unknown first                                          |
| `MKS-QUE-002` | Multiple unknown submissions                          | more than one scoped unknown candidate                                   | `REACHABLE`   | Stop; ambiguous provider outcome                                     |
| `MKS-QUE-003` | Unknown candidate malformed                           | membership/hash/state/sequence validation fails                          | `REACHABLE`   | Stop; preserve unknown                                               |
| `MKS-QUE-004` | Unknown Retry eligible / `unknown-retry-eligible`     | exactly one valid unknown candidate and no pending/uploading/failed work | `LOW-CURRENT` | Separate authorization path; current `unknown=0`                     |
| `MKS-QUE-005` | Empty upload lease                                    | no pending events after recovery/preflight                               | `REACHABLE`   | Continue to download only for ordinary Sync; bounded recovery stops  |
| `MKS-QUE-006` | Local event hash/identity invalid                     | canonical event validation fails before lease                            | `LOW-CURRENT` | Stop; current candidate passed SQLite-04 structural checks           |
| `MKS-QUE-007` | Local sequence gap/noncanonical order                 | leased events are not contiguous/canonical                               | `LOW-CURRENT` | Stop before request                                                  |
| `MKS-QUE-008` | Lease transaction failure                             | submission/members/event uploading states not committed atomically       | `REACHABLE`   | Roll back; no network request                                        |
| `MKS-QUE-009` | Uploading state stranded after transport throw        | lease committed, then transport throws before typed result persistence   | `LATENT`      | Persist outcome in `finally`; diagnostics must expose stranded lease |
| `MKS-QUE-010` | Upload result persistence target missing              | scoped submission lookup fails and current writer silently returns       | `LATENT`      | Convert silent return to invariant error                             |
| `MKS-QUE-011` | Provider result persisted as failed                   | trusted `not-applied` response maps events/members to failed             | `REACHABLE`   | Preserve exact provider code and candidate                           |
| `MKS-QUE-012` | Provider result persisted as unknown                  | no trusted response after request start                                  | `REACHABLE`   | Preserve unknown; do not failed-recover                              |

### H. HTTP transport and response contract

| Code          | Event / native signal                                 | Detection fingerprint                                                  | Relevance   | Required disposition                                         |
| ------------- | ----------------------------------------------------- | ---------------------------------------------------------------------- | ----------- | ------------------------------------------------------------ |
| `MKS-TRN-001` | Token source fails during request construction        | authenticated UI state cannot supply a current token                   | `REACHABLE` | No request; return exact token phase                         |
| `MKS-TRN-002` | DNS resolution failure / `dns-failed`                 | connection fails before socket establishment                           | `REACHABLE` | Unknown only if transmission cannot be disproved             |
| `MKS-TRN-003` | TCP/connect failure / `connection-failed`             | client exception before trusted response                               | `REACHABLE` | Preserve request-start boundary                              |
| `MKS-TRN-004` | TLS failure / `tls-failed`                            | certificate/handshake failure                                          | `REACHABLE` | Security/transport stop                                      |
| `MKS-TRN-005` | Timeout before response / `timeout-before-response`   | timeout with no response headers                                       | `REACHABLE` | Upload outcome is `unknown` after request start              |
| `MKS-TRN-006` | Timeout during response / `timeout-during-response`   | headers or partial response observed before timeout                    | `REACHABLE` | Record status/header evidence; outcome may remain unknown    |
| `MKS-TRN-007` | HTTP client exception collapsed to null upload result | `_sendJson` catches `ClientException` without phase detail             | `LATENT`    | Replace null with typed transport result                     |
| `MKS-TRN-008` | Response is not JSON                                  | body parse throws                                                      | `REACHABLE` | Record status/size/content class; do not generic-collapse    |
| `MKS-TRN-009` | JSON contract invalid / `response-contract-invalid`   | decoded body has wrong top-level or field types                        | `REACHABLE` | Treat response untrusted; preserve provider-contact evidence |
| `MKS-TRN-010` | Response exceeds size limit                           | body exceeds 262144-byte bound                                         | `REACHABLE` | Reject safely; record size band                              |
| `MKS-TRN-011` | HTTP status lacks trusted protocol body               | non-success status cannot be mapped from sanitized body                | `REACHABLE` | Preserve status and untrusted-response code                  |
| `MKS-TRN-012` | Redirect/unexpected effective origin                  | request does not terminate at authorized API origin                    | `REACHABLE` | Security stop; do not forward bearer across untrusted origin |
| `MKS-TRN-013` | Download `ClientException` escapes transport mapper   | download path does not use the upload `_sendJson` exception mapping    | `LATENT`    | Use one typed transport boundary for all routes              |
| `MKS-TRN-014` | Different timeout semantics by route                  | upload null-maps timeout while download lets timeout reach coordinator | `LATENT`    | Normalize with route and phase retained                      |

### I. API ingress and authorization

| Code          | Event / native signal                            | Detection fingerprint                                                                                                | Relevance     | Required disposition                                             |
| ------------- | ------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------- | ------------- | ---------------------------------------------------------------- |
| `MKS-API-001` | Route absent or revision mismatch / HTTP 404     | protected route not present at deployed revision                                                                     | `FRESHNESS`   | Verify exact revision and route inventory                        |
| `MKS-API-002` | Method/content type rejected                     | wrong method or media type                                                                                           | `REACHABLE`   | Typed 4xx; never generic 500                                     |
| `MKS-API-003` | Request body missing/malformed                   | unvalidated body cast causes type/runtime error                                                                      | `LATENT`      | Add schema validation before transaction                         |
| `MKS-API-004` | Authentication required                          | bearer absent                                                                                                        | `REACHABLE`   | Typed 401 with no service execution                              |
| `MKS-API-005` | JWT rejected                                     | verifier rejects token                                                                                               | `REACHABLE`   | Typed auth failure; sanitized verifier subphase in server log    |
| `MKS-API-006` | Membership/account selection rejected            | principal cannot resolve one active account                                                                          | `LOW-CURRENT` | Typed authorization result                                       |
| `MKS-API-007` | Device header/enrollment rejected                | header or active enrollment invalid                                                                                  | `LOW-CURRENT` | Typed device result                                              |
| `MKS-API-008` | Forbidden operation                              | policy denies authenticated request                                                                                  | `REACHABLE`   | Typed 403                                                        |
| `MKS-API-009` | API database composition absent                  | service starts without usable database composition                                                                   | `LOW-CURRENT` | Existing typed 503; readiness is presently healthy               |
| `MKS-API-010` | Rate limited / `rate-limited`                    | provider or authorization layer rejects request rate                                                                 | `REACHABLE`   | Preserve retry-after class; no immediate automatic Retry         |
| `MKS-API-011` | Request lifecycle stops after `request-received` | no later validation/auth/transaction stage for same correlation                                                      | `REACHABLE`   | Server alert identifies last stage                               |
| `MKS-API-012` | Unexpected exception genericized                 | current error handler emits `500/service-unavailable`, operation `server`, outcome `unknown` for all non-auth errors | `LATENT`      | Retain safe phase-specific internal code and transaction outcome |
| `MKS-API-013` | Health-ready incorrectly treated as Sync proof   | `/health/ready` 200 exists without protected route execution                                                         | `CONFIRMED`   | Treat readiness only as startup/DB readiness evidence            |
| `MKS-API-014` | Correlation ID missing/reused                    | request lacks unique per-action correlation                                                                          | `LATENT`      | Generate/reject according to correlation contract                |

### J. PostgreSQL connection and transaction

| Code          | Event / native signal                      | Detection fingerprint                                            | Relevance     | Required disposition                                             |
| ------------- | ------------------------------------------ | ---------------------------------------------------------------- | ------------- | ---------------------------------------------------------------- |
| `MKS-PDB-001` | Pool connection unavailable                | `pool.connect()` fails before transaction                        | `REACHABLE`   | Typed `db-connect-unavailable`; provider transaction not started |
| `MKS-PDB-002` | Transaction begin/context failure          | `BEGIN`, transaction-local context, or authorization setup fails | `REACHABLE`   | Record rolled-back/not-started exactly                           |
| `MKS-PDB-003` | Serialization retry / SQLSTATE `40001`     | serializable conflict before retry budget expires                | `REACHABLE`   | Internal warning; retry only within bounded DB helper            |
| `MKS-PDB-004` | Deadlock retry / SQLSTATE `40P01`          | deadlock before retry budget expires                             | `REACHABLE`   | Same bounded internal retry                                      |
| `MKS-PDB-005` | Serialization/deadlock retries exhausted   | three attempts or five-second budget exhausted                   | `REACHABLE`   | Typed transient DB failure; outcome/rollback required            |
| `MKS-PDB-006` | Permission/RLS failure                     | runtime role lacks allowed operation or context                  | `LOW-CURRENT` | Typed server configuration failure                               |
| `MKS-PDB-007` | Schema/migration mismatch                  | relation/function/column/readiness contract absent               | `LOW-CURRENT` | Stop deployment; migration 007/readiness previously passed       |
| `MKS-PDB-008` | Constraint/type failure                    | insert/update violates DB constraint or type                     | `REACHABLE`   | Typed invariant/validation class; rollback                       |
| `MKS-PDB-009` | Transaction commit failure                 | commit returns error or connection loss                          | `REACHABLE`   | Provider outcome `unknown` unless DB proves rollback             |
| `MKS-PDB-010` | Rollback failure suppressed                | rollback attempt also fails and current helper suppresses it     | `LATENT`      | Log rollback outcome separately; public response sanitized       |
| `MKS-PDB-011` | Cursor state row missing                   | active account has no `account_sync_state` row                   | `LOW-CURRENT` | Stop; prior Neon baseline proved row and `next_cursor=1`         |
| `MKS-PDB-012` | Readiness passes but request-time DB fails | pool/transaction changes after last readiness check              | `FRESHNESS`   | Fresh baseline required immediately before authorization         |

### K. Upload validation and provider application

| Code          | Event / native signal                                               | Detection fingerprint                                                                                                 | Relevance     | Required disposition                                           |
| ------------- | ------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | ------------- | -------------------------------------------------------------- |
| `MKS-UPL-001` | Submission Device differs from authorized Device / `device-revoked` | request Device and authorized Device mismatch                                                                         | `LOW-CURRENT` | Reject before event writes                                     |
| `MKS-UPL-002` | Submission shape invalid                                            | missing/invalid submission ID, hash, events, sequence, or payload fields                                              | `LATENT`      | Validate complete request before transaction mutation          |
| `MKS-UPL-003` | Existing submission hash differs / `hash-mismatch`                  | same submission ID, different request hash                                                                            | `REACHABLE`   | Reject; preserve original submission                           |
| `MKS-UPL-004` | Event scope differs / `wrong-account`                               | event account/device differs from submission context                                                                  | `LOW-CURRENT` | Reject entire batch atomically                                 |
| `MKS-UPL-005` | Event content hash differs / `hash-mismatch`                        | canonical provider hash check fails                                                                                   | `LOW-CURRENT` | Reject entire batch atomically                                 |
| `MKS-UPL-006` | Provider sequence gap / `sequence-gap`                              | event sequence differs from next expected Device sequence                                                             | `LOW-CURRENT` | Reject not-applied and report expected/observed safely         |
| `MKS-UPL-007` | Provider cursor state unavailable / `service-unavailable`           | cursor row absent while assigning event cursor                                                                        | `LOW-CURRENT` | Roll back; classify DB invariant, not generic service outage   |
| `MKS-UPL-008` | Duplicate event is equivalent                                       | existing event identity/hash/content matches                                                                          | `REACHABLE`   | Return `duplicate-equivalent`; do not duplicate write          |
| `MKS-UPL-009` | Submission applied                                                  | all events and submission committed                                                                                   | `REACHABLE`   | Return trusted `server-accepted` with committed outcome        |
| `MKS-UPL-010` | Stored submission replay                                            | same submission ID/hash already has stored result                                                                     | `REACHABLE`   | Return explicit replay/duplicate semantic                      |
| `MKS-UPL-011` | Request hash not independently recomputed server-side               | server trusts request-level hash except identity collision comparison                                                 | `LATENT`      | Recompute canonical request hash before writes                 |
| `MKS-UPL-012` | Partial-batch commit hazard                                         | service may return a normal `ProtocolFailure` after earlier loop iterations wrote events, allowing transaction commit | `LATENT`      | Validate full batch first or throw rollback-only typed failure |
| `MKS-UPL-013` | Failure lacks event/field/submission context                        | failure contract supports context but service often omits it                                                          | `LATENT`      | Populate sanitized member position/field and fingerprints      |
| `MKS-UPL-014` | Failure retryability/safe action inconsistent                       | cursor-missing/service failure may carry unsafe retry meaning                                                         | `LATENT`      | Derive safe action from outcome and transaction proof          |

### L. Download and local remote-event application

| Code          | Event / native signal                                 | Detection fingerprint                                      | Relevance   | Required disposition                                       |
| ------------- | ----------------------------------------------------- | ---------------------------------------------------------- | ----------- | ---------------------------------------------------------- |
| `MKS-DNL-001` | Provider cursor expired / `cursor-expired`            | requested cursor is outside retained/provider boundary     | `REACHABLE` | Stop; determine recovery snapshot path                     |
| `MKS-DNL-002` | Recovery unavailable / `recovery-unavailable`         | cursor expired and no provider snapshot exists             | `REACHABLE` | Stop; explicit recovery decision                           |
| `MKS-DNL-003` | Full rebootstrap required                             | provider requires full local rebuild                       | `REACHABLE` | Separate destructive authorization                         |
| `MKS-DNL-004` | Local changes block rebootstrap                       | unuploaded local work prevents safe rebuild                | `REACHABLE` | Preserve local work; operator reconciliation               |
| `MKS-DNL-005` | Protocol upgrade required                             | response/event version unsupported                         | `REACHABLE` | Stop and update client                                     |
| `MKS-DNL-006` | Download response shape invalid                       | response/event/cursor fields fail type/contract checks     | `REACHABLE` | Reject page before apply                                   |
| `MKS-DNL-007` | Remote event wrong account/type/version/hash          | remote applier validation fails                            | `REACHABLE` | Local transaction rollback; typed conflict subcode         |
| `MKS-DNL-008` | Remote cursor not contiguous                          | returned cursor sequence skips expected local cursor       | `REACHABLE` | Roll back; preserve page fingerprint                       |
| `MKS-DNL-009` | Duplicate event identity with different hash          | inbox already has identity but different content           | `REACHABLE` | Critical conflict; no overwrite                            |
| `MKS-DNL-010` | Required fact reference absent                        | person/payment reference snapshot unavailable              | `REACHABLE` | Roll back local page                                       |
| `MKS-DNL-011` | Store/product/purchase identity conflict              | remote fact collides with incompatible local identity      | `REACHABLE` | Roll back and name entity class only                       |
| `MKS-DNL-012` | Local fact type/date/constraint failure               | decoded payload cannot be written under schema constraints | `REACHABLE` | Roll back and classify local apply                         |
| `MKS-DNL-013` | Duplicate-only page does not advance local cursor     | duplicate outcome returns without updating sync state      | `LATENT`    | Prove/update cursor advancement for equivalent pages       |
| `MKS-DNL-014` | Local apply committed but later acknowledgement fails | download transaction succeeds before ack failure           | `REACHABLE` | Preserve applied cursor; Retry acknowledgement, not upload |

### M. Acknowledgement

| Code          | Event / native signal                                     | Detection fingerprint                             | Relevance   | Required disposition                                    |
| ------------- | --------------------------------------------------------- | ------------------------------------------------- | ----------- | ------------------------------------------------------- |
| `MKS-ACK-001` | No local cursor to acknowledge                            | local sync state absent after download/apply      | `REACHABLE` | Stop; local invariant                                   |
| `MKS-ACK-002` | Ack cursor exceeds provider high-water / `cursor-expired` | provider rejects impossible/out-of-range cursor   | `REACHABLE` | Stop and reconcile cursors                              |
| `MKS-ACK-003` | Ack transport outcome unknown                             | request started without trusted ack response      | `REACHABLE` | Query/retry same idempotent ack only under typed policy |
| `MKS-ACK-004` | Ack protocol failure                                      | trusted provider failure body returned            | `REACHABLE` | Preserve code/status/correlation                        |
| `MKS-ACK-005` | Ack observability absent from local ledger                | top-level Sync result hides independent ack phase | `LATENT`    | Persist child request/phase record                      |

### N. Cross-cutting observability and invariant controls

| Code          | Event / native signal                                      | Detection fingerprint                                                             | Relevance   | Required disposition                                       |
| ------------- | ---------------------------------------------------------- | --------------------------------------------------------------------------------- | ----------- | ---------------------------------------------------------- |
| `MKS-OBS-001` | Client catch-all / `local-exception-redacted`              | uncaught `Object` becomes `sync-unavailable`, phase `unexpected-terminal`         | `LATENT`    | Retain sanitized exception class and last completed phase  |
| `MKS-OBS-002` | Coordinator state loses native cause                       | many guard/protocol codes map only to `unavailable`                               | `LATENT`    | Keep projected state and diagnostic code separately        |
| `MKS-OBS-003` | API generic 500 collapse                                   | non-auth exception maps to `service-unavailable/server/unknown`                   | `LATENT`    | Typed internal taxonomy; public envelope remains sanitized |
| `MKS-OBS-004` | Sync attempt lacks child request evidence                  | no correlation, status, header, or route fields persisted for upload/download/ack | `LATENT`    | Persist one parent plus child phase events                 |
| `MKS-OBS-005` | Same correlation reused across operations                  | constant `native-closure` correlation source                                      | `LATENT`    | Unique correlation per top-level action                    |
| `MKS-OBS-006` | Render health noise mistaken for operation evidence        | only `/health/ready` entries appear                                               | `CONFIRMED` | Filter logs by operation/correlation and protected route   |
| `MKS-OBS-007` | Provider contact inferred from missing fields              | absent fields are treated as negative evidence although not instrumented          | `CONFIRMED` | Add explicit `providerContact` state                       |
| `MKS-OBS-008` | Sensitive raw exception/log data risk                      | unbounded error messages or payloads could enter UI/logs                          | `REACHABLE` | Closed allow-list and fingerprint-only identifiers         |
| `MKS-INV-001` | Automatic retry after generic 500                          | HTTP status alone drives Retry despite unknown commit outcome                     | `LATENT`    | Prohibit; reconcile same submission identity first         |
| `MKS-INV-002` | Failed recovery before provider proves not-applied         | unknown outcome is requeued as failed                                             | `REACHABLE` | Prohibit state transition                                  |
| `MKS-INV-003` | Second action before first outcome captured                | repeated Retry/Sync changes evidence                                              | `REACHABLE` | One-operation lock and explicit terminal                   |
| `MKS-INV-004` | Provider and local mutations cannot be joined              | missing operation/correlation/submission fingerprints                             | `LATENT`    | Require diagnostic envelope before Gate action             |
| `MKS-INV-005` | Partial local/provider state hidden by final `unavailable` | compound Sync collapses recovery, upload, download, and ack                       | `LATENT`    | Record phase transitions and transaction outcomes          |

### Conditions reduced by accepted Step 12 evidence

These events remain in the catalogue because they are reachable, but they are
not leading explanations for the latest blocked Retry:

| Reduced hypothesis                                      | Accepted evidence                                                                                             |
| ------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Corrupt or structurally wrong SQLite database           | copied DB quick check passed and expected table count matched                                                 |
| Wrong hosted Device candidate                           | rank 3 was the enrolled hosted scope and owned exactly the two failed events                                  |
| Unrelated local pending events joining recovery         | simulated hosted-scope first upload contained only sequences `1–2`; six pending events belong to other scopes |
| Unknown-outcome Retry candidate exists                  | hosted scope has `unknown=0`; candidate is failed/notApplied                                                  |
| Same-hash active/superseded submission collision        | SQLite-04 found neither                                                                                       |
| Provider/API wholly offline at captured time            | Render readiness repeatedly returned 200                                                                      |
| Missing migration 007 cursor state at accepted baseline | Neon readiness and cursor baseline previously passed                                                          |
| Authentication absent at the displayed checkpoint       | UI reported authenticated after recent login                                                                  |
| Enrollment absent at the displayed checkpoint           | UI reported Device enrolled and earlier exact binding checks passed                                           |
| Latest button caused a provider 500                     | no protected request followed the locally blocked preflight                                                   |

These are freshness-sensitive rather than permanently excluded:

- deployed revision and route inventory;
- current Auth0 principal/membership;
- current exact account/Device binding;
- current Neon cursor/submission/event baseline;
- request-time PostgreSQL connectivity and transaction behavior;
- token validity at the instant of the authorized operation.

### Ranked diagnosis for the present state

1. **Proved present event:** `MKS-UI-001`. The pressed button selected the
   unknown-outcome Retry path, which correctly blocked on two failed events and
   zero unknown events.
2. **Proved presentation defect:** `MKS-UI-002` and `MKS-UI-005`. The blocked
   result was not made visible enough and the earlier Sync result remained the
   prominent explanation.
3. **Proved action gap:** `MKS-UI-004`. No bounded failed/notApplied recovery
   surface exists; ordinary Sync is the only current code path that invokes
   failed recovery, but it also uploads, downloads, and acknowledges.
4. **Unresolved historical event:** the earlier `sync-unavailable` cannot yet be
   assigned to transport, provider, database, local persistence, or response
   parsing because `MKS-LDB-010`, `MKS-OBS-001`, `MKS-OBS-002`, and
   `MKS-OBS-004` erase the necessary distinctions.
5. **Pre-release source hazards:** `MKS-QUE-009`, `MKS-QUE-010`,
   `MKS-UPL-012`, `MKS-DNL-013`, and `MKS-OBS-003` require explicit tests or
   correction before the controlled Gate 12.7 mutation.

### Required tightening before Gate 12.7 can reopen

The next Codex unit should remain source-only and non-provider:

1. implement the diagnostic envelope and stable code registry as one
   language-neutral source of truth consumed by Dart UI and TypeScript/API
   logging;
2. retain existing native codes and map each to one `MKS-*` protocol code;
3. rename the existing action to `Retry unknown-outcome submission`;
4. display all blocked preflights as persistent in-view banners/dialogs;
5. implement a separate **non-mutating** failed/notApplied preflight showing
   Device-scoped count, sequence range, next sequence, and sanitized candidate
   fingerprint;
6. do not initially attach that preflight to an executing provider action;
7. instrument ordinary Sync and future bounded recovery with parent/child
   phases, unique correlations, provider-contact state, trusted-response state,
   and local/provider transaction outcomes;
8. validate the complete upload batch before any provider write and make every
   later protocol failure roll back the transaction;
9. convert silent local persistence misses and generic catch-alls into typed
   invariant/phase events;
10. add tests proving that blocked actions make no local/provider mutation,
    ambiguous upload outcomes are never automatically requeued, and every
    unexpected server path produces a sanitized phase-specific diagnostic
    rather than an undifferentiated generic 500;
11. render a readable `SYNC_DIAGNOSTICS.md` from the same registry rather than
    maintaining a second hand-written catalogue;
12. return to J with validation evidence before any build/deployment or Gate
    12.7 authorization packet is activated.

No current evidence justifies direct SQLite editing, Neon editing, another
Repair, ordinary Sync, unknown Retry, or provider-side cleanup.

---

## Step 12 Diagnostic Tightening Materialization Reconciliation

Date: 2026-07-26
Round: C10-GCM02-S12-ERR-01
Sequence: FLX-ORD-01 — Ordinary Sequence
Materialization commit:
`ecb0c500f43dd6fd8b614dcec92d06a3c2a79f26`
Parent staging commit:
`02aa7a0a57219faba856a22c73f1cac0ff2d1988`
Branch: `cycle10-intermid-grimoire`
Authority: Main reconciliation under explicit human direction
Evidence classes: repository-proven, source-inspected, Codex-reported
test-validated, independently projection-checked, unavailable in the present
Work host
Disposition: **PARTIAL ACCEPTANCE WITH BOUNDED FOLLOW-UP; NO GATE 12.7
AUTHORIZATION**

### 1. Reconciliation purpose

This entry reconciles the C10-GCM02-S12-ERR-01 source materialization against:

- the active D/E/F packet at `02aa7a0`;
- the append-only `System Diagnosis` catalogue in this J file;
- the materialized source and tests at `ecb0c50`;
- the replacement G/H/I Codex reports;
- the accepted Gate 12.6 state;
- the prohibition against provider mutation before an exact Gate 12.7
  authorization packet and explicit human approval.

This reconciliation does not semantically promote G/H/I into permanent domain
memory. It records the Main conclusion and preserves the materialization
history needed for later functional promotion and Gate 12.7 preparation.

### 2. Repository and publication evidence

The selected GitHub branch was inspected through the connected repository and
then fetched into a detached clean reconciliation worktree.

Confirmed:

```text
REMOTE_BRANCH=cycle10-intermid-grimoire
REMOTE_TIP=ecb0c500f43dd6fd8b614dcec92d06a3c2a79f26
PARENT=02aa7a0a57219faba856a22c73f1cac0ff2d1988
COMMIT_MESSAGE=Tighten Step 12 sync diagnostics
REMOTE_RELATION=ONE_FAST_FORWARD_COMMIT_OVER_D_E_F
```

The commit changes 33 task-relevant files only:

- Flutter Closure, diagnostics, local Sync and migration source;
- focused Flutter Closure, diagnostics, migration and Sync tests;
- the machine registry, schema and README;
- the deterministic generator;
- generated Dart, TypeScript and Markdown projections;
- API Sync/protocol/error source and tests;
- G/H/I Codex evidence reports.

No hosted migration, methodology file, permanent domain-memory file, Main-root
continuity file, D/E/F file or pre-existing J entry was modified by Codex.

### 3. Accepted implementation results

#### 3.1 Single diagnostic catalogue owner

Repository inspection accepts:

```text
MACHINE_OWNER=contracts/shared_beta/diagnostics_v1/diagnostics.registry.json
REGISTRY_VERSION=1
REGISTRY_CODES=159
REGISTRY_UNIQUE_CODES=159
DART_PROJECTION_CODES=159
TYPESCRIPT_PROJECTION_CODES=159
MARKDOWN_PROJECTION_CODES=159
PROJECTION_CODE_SET_DIFFERENCE=0
```

The registry is the only intended hand-maintained list. The Dart, TypeScript
and `documentation/SYNC_DIAGNOSTICS.md` views are generated dependencies.

The present Work host independently parsed all four artifacts and confirmed
identical 159-code sets. `git diff --check 02aa7a0..ecb0c50` also passed.

The generator's own `--check` mode could not be independently rerun in this
Work host because Dart is unavailable here and the generator correctly stops
when it cannot locate Dart. Codex reports successful generation, check mode
and deterministic validation in its implementation environment. Therefore:

```text
CODE_SET_EQUALITY=INDEPENDENTLY_CHECKED_PASS
GENERATOR_DART_DEPENDENT_CHECK=CODEX_REPORTED_PASS
CURRENT_WORK_HOST_RERUN=UNAVAILABLE_NO_DART
```

This is an evidence distinction, not a contradiction.

#### 3.2 Local diagnostic persistence and UI

Source inspection accepts:

- additive Drift schema version 11;
- `sync_attempts` retained as the operation parent;
- additive `sync_diagnostic_events` child-event storage;
- migration-ledger identifier
  `v10-to-v11-sync-diagnostic-events`;
- the visible action label `Retry unknown-outcome submission`;
- the separate `Inspect failed/notApplied recovery` action;
- current-action diagnostic projection with MKS code, meaning, outcome,
  phase, mutation/contact state, safe action and fingerprint;
- visible blocked/error/unknown results;
- a read-only current-Device failed/notApplied candidate inspection;
- no execution callback attached to that inspection.

The read-only inspection explicitly records:

```text
LOCAL_MUTATION=none
PROVIDER_CONTACT=not-started
PROVIDER_TRANSACTION=not-started
RETRYABLE=false
SAFE_ACTION=hold for Gate 12.7 reconciliation
```

This materially corrects the earlier action/interface ambiguity without
executing or authorizing the failed lineage.

#### 3.3 Five named source hazards

Source and test evidence support accepting the five bounded corrections:

| Code | Reconciled implementation result |
| --- | --- |
| `MKS-QUE-009` | A post-lease transport exception is converted to an unknown outcome so the submission identity is preserved instead of remaining an unexplained upload lease. |
| `MKS-QUE-010` | A scoped upload-result persistence miss throws `SyncPersistenceInvariantException` instead of returning silently. |
| `MKS-REC-012` | Candidate inspection/recovery distinguishes all-pending, all-failed and mixed states; mixed states block rather than partially requeue. |
| `MKS-UPL-012` | The complete provider submission is validated before the first write; the later-member failure fixture proves no partial submission/event/cursor/Device-sequence mutation. |
| `MKS-DNL-013` | Equivalent duplicate-only downloads transactionally advance the contiguous local cursor; conflicting duplicates remain failures. |

These corrections are source-implemented and test-validated in the Codex
environment. They are not live-provider validated.

#### 3.4 Validation accepted with evidence limits

G reports the following successful commands:

```text
node scripts/generate_sync_diagnostics.mjs
node scripts/generate_sync_diagnostics.mjs --check
npm run diagnostics:check
flutter pub run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed lib test
flutter analyze
focused Flutter diagnostic/sync/migration/UI tests
flutter test: 183 passed, 4 existing lab-gated skips
npm run format:check
npm run lint
npm run typecheck
npm run build
npm test: 58 passed
git diff --check
credential-pattern scan: no reported assignment match
```

Main accepts these as Codex-reported test evidence. Main independently checked:

- commit ancestry and remote branch position;
- changed-file scope;
- 159 unique registry codes;
- identical registry/Dart/TypeScript/Markdown code sets;
- relevant source ownership and action labels;
- additive v11 table and migration-ledger source;
- absence of an executing failed/notApplied UI callback;
- `git diff --check`.

Main did not repeat Flutter, Dart or complete npm validation in this Work host.
No Windows, Android, Render, Auth0, Neon or end-to-end provider validation
belongs to this materialization claim.

### 4. D/E/F conformance limits

The materialization is not a complete realization of every D/E/F requirement.
The following differences remain material and must not be hidden by the broad
`ERROR_PROTOCOL_SOURCE_IMPLEMENTED` terminal in G:

#### 4.1 Ordinary Sync remains coarsely terminalized

`NativeAuthClosureRunner.hostedSyncProbe()` still catches an unclassified
`Object` and records:

```text
resultCode=sync-unavailable
phase=unexpected-terminal
recoveryCode=local-exception-redacted
```

The new MKS child-event envelope is not yet emitted across every ordinary Sync
phase required by D:

```text
authentication
binding
failed-recovery
upload-lease
upload-transport
upload-provider
upload-result-persistence
download-transport
download-provider
download-local-apply
acknowledgement
terminal
```

The new child-event ledger is materially used for the local failed/notApplied
inspection, but source inspection does not prove complete end-to-end
instrumentation of the existing ordinary Sync coordinator.

#### 4.2 Parent/child correlation remains incomplete

For the local failed/notApplied inspection, the operation fingerprint is also
used as the correlation fingerprint. This is sufficient to group that
network-free local preflight, but it does not implement the staged rule for
distinct full child correlation identities, sanitized child fingerprints and
deterministic request ordinals across every future HTTP child request.

The persisted envelope also does not yet carry every field listed in the full
D/F target, including a persisted diagnostic version and all source/build,
route, submission and request-hash projections.

#### 4.3 Public/internal API diagnostic separation needs one more tightening

The API catch-all now avoids generic retry permission and returns
`retryable=false`, which is accepted.

However, it presently returns `correlationId` and
`sanitizedExceptionClass` in the public 500 body. D/F requested a safe
correlation fingerprint publicly while retaining exception class and richer
failure detail internally. The current implementation therefore improves the
500 result but does not fully satisfy the public/internal projection boundary.

The helper used for ordinary protocol failures also assigns
`MKS-UPL-012` broadly. Future tightening must map the actual operation/boundary
instead of treating the partial-upload hazard code as a generic failure code.

#### 4.4 Registry presence is broader than runtime emission coverage

The 159-code registry and generated explanation surfaces exist, but source
inspection does not prove that every reachable detector currently emits its
corresponding MKS code at its pathogenic boundary. The catalogue is callable
from Dart and TypeScript; full source-adjacent emission remains incremental
work.

### 5. PRC-01 classification

| Claim | Classification | Main disposition |
| --- | --- | --- |
| Remote tip and ancestry | repository-proven | accepted |
| 159-code registry and equal projections | repository-proven and independently checked | accepted |
| Deterministic generator/check | Codex-reported test-validated; present host unavailable | accepted with evidence qualifier |
| Drift v11 additive diagnostic ledger | repository-proven; Codex test-validated | accepted locally |
| Visible renamed Retry and read-only failed inspection | repository-proven and test-validated | accepted |
| Failed/notApplied execution absent | repository-proven | accepted |
| Five named source-hazard corrections | source-inspected and Codex test-validated | accepted locally |
| Complete ordinary Sync phase instrumentation | not proved by source | deferred corrective follow-up |
| Complete parent/child correlation design | partially implemented | deferred corrective follow-up |
| Public/internal API diagnostic separation | partially implemented | deferred corrective follow-up |
| Live provider behavior | unavailable and intentionally unperformed | not accepted |
| Gate 12.7 readiness | not yet established | held |
| GCM02 closure | not established | open |

### 6. Main reconciliation conclusion

The round achieved the decisive structural objective:

```text
ERROR_CATALOGUE_SINGLE_OWNER_IMPLEMENTED
ERROR_CATALOGUE_PROJECTIONS_ALIGNED
ERROR_DOCUMENTATION_GENERATED
DIAGNOSTIC_LEDGER_V11_IMPLEMENTED
CURRENT_ACTION_DIAGNOSTICS_VISIBLE
UNKNOWN_RETRY_SEMANTICS_VISIBLE
FAILED_NOT_APPLIED_INSPECTION_READ_ONLY
FIVE_NAMED_SOURCE_HAZARDS_LOCALLY_CORRECTED
GENERIC_500_AUTORETRY_REJECTED
```

It did not complete:

```text
ORDINARY_SYNC_ALL_PHASE_MKS_EMISSION
FULL_CHILD_REQUEST_CORRELATION
FULL_DIAGNOSTIC_ENVELOPE_PROJECTION
PUBLIC_FINGERPRINT_INTERNAL_EXCEPTION_SPLIT
EVERY_REGISTRY_CODE_SOURCE_BOUNDARY_EMISSION
WINDOWS_CORRECTED_CLIENT_BUILD
FRESH_USER_DATABASE_READ_ONLY_INSPECTION
GATE_12_7_AUTHORIZATION_PACKET
CONTROLLED_PROVIDER_OPERATION
POST_OPERATION_CONVERGENCE
```

The correct materialization classification is:

```text
C10_GCM02_S12_ERR_01=PARTIAL_ACCEPT_WITH_FOLLOW_UP
SOURCE_STRUCTURE=IMPLEMENTED
NAMED_HAZARD_FIXES=LOCALLY_TEST_VALIDATED
DIAGNOSTIC_RUNTIME_COVERAGE=PARTIAL
HOST_PROVIDER_VALIDATION=NOT_PERFORMED
```

### 7. Legacy and forward disposition

This reconciliation belongs in `Legacy_Progress` because it records:

- the exact published materialization commit and its parent;
- the transformation of the J error catalogue into runtime-owned artifacts;
- the evidence boundary between Codex validation and Main independent checks;
- the accepted five-hazard correction;
- the residual D/E/F conformance gap;
- the reason Gate 12.7 remains held.

The 159-row `System Diagnosis` catalogue remains historical provenance. It
must not be manually maintained as a second runtime registry after this point.
Future code/meaning changes begin in
`contracts/shared_beta/diagnostics_v1/diagnostics.registry.json`, regenerate
Dart/TypeScript/Markdown, and then return to J as reconciliation evidence.

The next source unit should be bounded to the four conformance gaps above,
followed by:

1. a corrected Windows client build;
2. the read-only failed/notApplied inspection only;
3. cancellation without local mutation or provider contact;
4. fresh sanitized Gate 12.7 baselines;
5. an exact authorization packet;
6. one controlled action only after explicit human approval;
7. correlated post-operation client, server and provider comparison.

The pre-existing Gate 12.7 rule remains authoritative:

```text
ANYTHING_OTHER_THAN_EXPLICIT_APPROVAL=NO_AUTHORIZATION
NO_SECOND_ACTION_AFTER_AN_AMBIGUOUS_RESULT
```

### 8. Terminal state

```text
GATE_12_6=PASS
C10_GCM02_S12_ERR_01=PARTIAL_ACCEPT_WITH_FOLLOW_UP
DIAGNOSTIC_REGISTRY_SINGLE_OWNER=PASS
DIAGNOSTIC_PROJECTION_CODE_SET=PASS
FAILED_NOT_APPLIED_PREFLIGHT=IMPLEMENTED_READ_ONLY
FAILED_NOT_APPLIED_EXECUTION=ABSENT
FIVE_NAMED_SOURCE_HAZARDS=LOCALLY_TEST_VALIDATED
ORDINARY_SYNC_PHASE_DIAGNOSTICS=PARTIAL
PROVIDER_ACTION=NOT_PERFORMED
GATE_12_7=HELD_FOR_CORRECTIVE_RECONCILIATION
GCM02=OPEN
```

---

## C10-GCM02-S12-ERR-02 — post-Codex source and host reconciliation

Sequence: FLX-PRM-04 — Promotion/Reconciliation
Role: Main Chat [M]
Round or unit: C10-GCM02-S12-ERR-02-HOST-HANDOFF
Branch: `cycle10-intermid-grimoire`
Baseline / inspected HEAD: `17e37eb8b83eb77e56c6421e09cb5ad768dbbfd4`
Authority: human-directed G/H/I reconciliation and next-step preparation
Writable surfaces: `[M]_STAGE/J_MAIN_STAGE.md` only
Evidence boundary: repository inspection at `17e37eb`; Codex G/H/I evidence at
`512f690`; human-reported Windows/Android observations; no provider mutation,
failed/notApplied execution, Render deployment, live Sync, Retry, Repair, or
Enroll

### 1. Repository sequence recovered

The remote branch contains the complete corrective sequence:

```text
0636c54  Main reconciliation and six-gap decision
d56c3a6  active D/E/F implementation packet
512f690  Codex source materialization and replacement G/H/I
baaccfa  Android AVD startup automation
17e37eb  local Android AVD coordinate alignment
```

The C10-GCM02-S12-ERR-02 D/E/F packet was active and bounded. Codex
materialized the six requested conformance corrections and replaced G/H/I.
No further source-conformance unit is required before the Windows host
validation and read-only failed/notApplied inspection.

### 2. PRC-01 claim reconciliation

Claim: ordinary Sync now records the complete required phase evidence.

Prior state: partial; authentication and terminal summaries existed, but the
ordinary Sync path lacked full child-phase evidence.

Evidence: `G_OPS_CODEX.md` records the tested order authentication, binding,
failed-recovery, upload lease/transport/provider/result-persistence, download
transport/provider/local-apply, acknowledgement, and terminal.

Evidence boundary: repository-proven and locally test-validated by Codex;
Windows/provider end-to-end execution was not part of that validation.

Contradiction: none remaining at source-conformance level.

Semantic owner: Operational domain.

Target role: accepted implemented and locally validated source behavior.

Resulting state: `ORDINARY_SYNC_PHASE_DIAGNOSTICS=IMPLEMENTED`.

History disposition: the earlier partial state remains historical provenance.

Claim: one ordinary Sync owns a top-level operation identity with deterministic
child correlation identities and ordinals.

Prior state: parent/child semantics were requested but incomplete.

Evidence: G/H/I and the source at `512f690` record one random top-level
operation identity, deterministic child ordinals, scoped child correlation IDs,
and persisted terminal causal summaries.

Evidence boundary: repository-proven and locally test-validated.

Contradiction: none remaining.

Semantic owner: Design domain.

Target role: accepted implemented relationship boundary.

Resulting state: `PARENT_CHILD_CORRELATION=IMPLEMENTED`.

History disposition: prior incomplete correlation is superseded, not erased.

Claim: diagnostic persistence, public projection, and UI causal meaning now
conform to the approved v1 diagnostic model.

Prior state: the runtime registry existed, but schema envelope, API
public/internal separation, reachable-code attribution, and causal UI meaning
remained incomplete.

Evidence: Drift schema v12 and migration ledger
`v11-to-v12-diagnostic-envelope-v1`; shared typed diagnostic projections;
fingerprinted public failures without internal exception/SQL/raw-identifier
material; narrower reachable MKS attribution; trusted-response and
result-persistence UI state; recent child timeline.

Evidence boundary: repository-proven and locally test-validated. Migration 007
was already applied in the earlier provider sequence and is not to be rerun;
this reconciliation authorizes no migration.

Contradiction: none remaining at source-conformance level.

Semantic owner: Operational, Didactic, and Design domains by their respective
perspectives.

Target role: accepted implementation evidence pending later permanent-domain
promotion.

Resulting state:

```text
DIAGNOSTIC_ENVELOPE_V1=IMPLEMENTED
PUBLIC_INTERNAL_DIAGNOSTIC_SPLIT=IMPLEMENTED
REACHABLE_MKS_ATTRIBUTION=VALIDATED
CAUSAL_DIAGNOSTIC_MEANING=IMPLEMENTED
```

History disposition: G/H/I remain observational evidence; this J entry is the
Main reconciliation cache.

Claim: the failed/notApplied interface is now sufficient for the next
investigative inner-step.

Prior state: the UI exposed unknown-outcome Retry but lacked a bounded
failed/notApplied preflight.

Evidence: the Closure UI exposes `Inspect failed/notApplied recovery`; its
query is local, read-only, network-free, and distinct from unknown-outcome
Retry. No failed/notApplied execution callback exists.

Evidence boundary: repository-proven and locally test-validated; the human
Windows inspection has not yet been returned at this baseline.

Contradiction: none at source level.

Semantic owner: Gate 12.7 authorization preparation.

Target role: accepted read-only preflight; mutation remains absent and
unauthorized.

Resulting state:

```text
FAILED_NOT_APPLIED_PREFLIGHT=READ_ONLY
FAILED_NOT_APPLIED_EXECUTION=ABSENT
```

History disposition: the earlier action-interface block is superseded by the
implemented preflight, while the no-execution boundary remains active.

### 3. Validation reconciliation

Codex validation at `512f690`:

```text
FLUTTER_ANALYZE=PASS
FLUTTER_TEST=184_PASS_4_LAB_GATED_SKIP
API_FORMAT_LINT_TYPECHECK_BUILD=PASS
API_TEST=58_PASS
DIAGNOSTIC_GENERATION_CHECK=PASS
```

The user subsequently proved the Android development environment, AVD boot,
Markei installation, and visible application launcher on the Android virtual
device. This is accepted as human-observed Android build/install/run
conformance for the present Cycle 10 platform boundary.

The same trial exposed a narrow PowerShell 5.1 post-boot selection defect in
`GS-FLUTTER-AND`: after the correct AVD became available, the parsed Flutter
device inventory could yield `windows` as `$AndroidDeviceId`, causing
`adb -s windows`. This does not retract the human-observed Android
build/install/run result and does not block Gate 12.7, whose controlled client
is Windows. It remains a bounded operational follow-up for later correction.

No new application refactor or D/E/F implementation packet is activated by
this reconciliation. If the generic launcher must later provide an entirely
clean automated Android result, Main should stage a separate narrow
PowerShell-procedure correction with its own Windows PowerShell 5.1 regression
evidence. It must not be mixed into Gate 12.7 preparation.

Fresh Windows Closure validation from the current remote source remains
required. Earlier Windows success proves the host/toolchain baseline but does
not replace a build/run of the C10-GCM02-S12-ERR-02 materialization.

### 4. Exact next investigative inner-steps

#### Inner-step 4 — align and prove the Windows checkout

From the Windows repository:

```powershell
git switch cycle10-intermid-grimoire
git pull --ff-only origin cycle10-intermid-grimoire
git status --short
git rev-parse HEAD
git merge-base --is-ancestor 512f6903535ce53f325660850709ac4bb254a0dc HEAD
```

Required:

```text
HEAD=17e37eb8b83eb77e56c6421e09cb5ad768dbbfd4_OR_DESCENDANT
WORKTREE=CLEAN
512f690=ANCESTOR
```

Stop on divergence, merge conflict, dirty overlap, or failed ancestry.

#### Inner-step 5 — build and open the current Windows Closure client

Run the canonical command:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
    -File ".\documentation\NEON_CHECK.ps1" `
    -Procedure "GS-FLUTTER-WIN"
```

Required evidence:

```text
FLUTTER_ANALYZE=PASS
FLUTTER_TEST=PASS
WINDOWS_RELEASE_BUILD=PASS
AUTH0FLUTTER_PROTOCOL_REGISTRATION=PASS
FRESH_WINDOWS_CLOSURE_CLIENT=OPEN
CLOSURE_DESTINATION=VISIBLE
```

Do not select Enroll, Query, Sync, Retry, Repair, or Clear diagnostic history.

#### Inner-step 6 — perform only the read-only candidate inspection

Inside the freshly built Windows Closure client:

1. Open `Closure`.
2. Select only `Inspect failed/notApplied recovery`.
3. Record only the sanitized fields displayed by the preflight:
   eligibility/result state, diagnostic code and native code, operation and
   correlation fingerprints, failed/notApplied candidate count, pending-event
   count, sequence range, event count, retryability, and safe action.
4. Do not select `Retry unknown-outcome submission`.
5. Do not select Sync, Enroll, Query, Repair, or Clear diagnostic history.
6. If any confirmation or execution control appears, choose Cancel/close and
   stop.

This inner-step must perform no provider contact and no local mutation beyond
the diagnostic observation written by the read-only inspection path itself.
It is not Gate 12.7 authorization and is not the controlled recovery.

#### Inner-step 7 — return the sanitized preflight evidence

Return:

```text
INSPECTION_ACTION=Inspect failed/notApplied recovery
ELIGIBLE=<sanitized displayed value>
DIAGNOSTIC_CODE=<sanitized displayed value>
NATIVE_CODE=<sanitized displayed value>
OPERATION_FINGERPRINT=<bounded fingerprint only>
CORRELATION_FINGERPRINT=<bounded fingerprint only>
FAILED_NOT_APPLIED_CANDIDATE_COUNT=<count>
PENDING_EVENT_COUNT=<count>
SEQUENCE_RANGE=<bounded range>
EVENT_COUNT=<count>
RETRYABLE=<boolean>
SAFE_ACTION=<sanitized displayed value>
PROVIDER_CONTACT=NO
FAILED_NOT_APPLIED_EXECUTION=NO
CANCELLED_WITHOUT_MUTATION=YES
```

Do not return tokens, connection strings, complete UUIDs, complete hashes,
payloads, purchase content, private paths, or provider secrets.

#### Inner-step 8 — prepare, but do not execute, Gate 12.7

Main reconciles the returned preflight with fresh Git/Windows, Render health,
Auth0 metadata, and Neon/provider baseline evidence. Only then may Main present
one exact Gate 12.7 authorization packet containing the eligible transition,
expected HTTP operations, evidence-capture order, stop classifications, and
the no-second-action rule.

Anything other than explicit human approval of that exact packet is no
authorization. Steps 12.8–12.10 remain held. No recovery execution or provider
contact is authorized by this J entry.

### 5. Terminal state

```text
C10_GCM02_S12_ERR_02=SOURCE_ACCEPTED
SIX_CORRECTIVE_GAPS=PASS
ORDINARY_SYNC_PHASE_DIAGNOSTICS=IMPLEMENTED
PARENT_CHILD_CORRELATION=IMPLEMENTED
DIAGNOSTIC_ENVELOPE_V1=IMPLEMENTED
PUBLIC_INTERNAL_DIAGNOSTIC_SPLIT=IMPLEMENTED
REACHABLE_MKS_ATTRIBUTION=VALIDATED
CAUSAL_DIAGNOSTIC_MEANING=IMPLEMENTED
ANDROID_BUILD_INSTALL_RUN=HUMAN_OBSERVED_PASS
GS_FLUTTER_AND_POST_BOOT_SELECTION=DEFERRED_NARROW_FOLLOW_UP
WINDOWS_CURRENT_SOURCE_BUILD_RUN=PENDING
FAILED_NOT_APPLIED_PREFLIGHT=READ_ONLY
FAILED_NOT_APPLIED_EXECUTION=ABSENT
PROVIDER_ACTION=NOT_PERFORMED
GATE_12_7=HELD
GCM02=OPEN
```

---

## cycle 10 - guideline

> Date: 2026-07-26
> Sequence: FLX-PRM-04 — Promotion/Reconciliation
> Role: Main Chat [M]
> Branch: `cycle10-intermid-grimoire`
> Reconciled remote baseline: `71bb73f88e88f3b94dd78fb5131bd6262ae7321f`
> Authority: human-requested navigation reconciliation
> Scope: Cycle 10 remaining work, GCM-02 conclusion, provisional GCM-03/GCM-04
> organisation, and closure route
> Materialization effect: J append only; no D/E/F activation, source change,
> provider action, Sync, Retry, Repair, Enroll, recovery execution, or semantic
> promotion

### 1. Navigation grammar

The following hierarchy is a provisional Cycle 10 navigation grammar. It
organises existing work; it does not amend canonical methodology or silently
activate an implementation unit.

```text
Cycle
└─ GCM / MCG phase
   ├─ Sprint — bounded implementation or investigation package
   └─ Gate — mandatory evidence, decision, or authorization boundary
      └─ Gate/Sprint subphase — investigate, stage, materialize, validate,
         authorize, execute, or reconcile
         └─ Step — one concrete human or agent action
```

`GCM` is retained as the current conversation/J spelling. Older operational
artifacts may use `MCG` for the same phase level. A Gate controls mandatory
ordering and authority. A Sprint packages major work. Neither is automatically
inside the other; their order is declared by the active GCM plan.

### 2. Documentary state-of-union

The most current recovery surfaces are:

1. the mutable Cycle 10 prefix and newest append-only entries in
   `[M]_STAGE/J_MAIN_STAGE.md`;
2. current D/E/F when an implementation unit is explicitly active;
3. the newest G/H/I materialization evidence;
4. targeted source or provider evidence only for unresolved claims.

Current remote G/H/I at the Step 12 diagnostic materialization establish:

```text
ORDINARY_SYNC_PHASE_DIAGNOSTICS=IMPLEMENTED
PARENT_CHILD_CORRELATION=IMPLEMENTED
DIAGNOSTIC_ENVELOPE_V1=IMPLEMENTED
PUBLIC_INTERNAL_DIAGNOSTIC_SPLIT=IMPLEMENTED
REACHABLE_MKS_ATTRIBUTION=VALIDATED
CAUSAL_DIAGNOSTIC_MEANING=IMPLEMENTED
FAILED_NOT_APPLIED_PREFLIGHT=READ_ONLY
FAILED_NOT_APPLIED_EXECUTION=ABSENT
PROVIDER_ACTION=NOT_PERFORMED
GCM02=OPEN
```

The repository also contains older state-of-union surfaces that have not kept
pace with this sequence:

- `00_PROJECT_STATE.md` remains a Cycle 09 closure checkpoint;
- `06_SESSION_SCHEME.md` remains the pre-activation Cycle 10 plan;
- permanent domain checkpoints and `operational/04_TODO.md` retain earlier
  C10-S03A corrective-stop language;
- `CYCLE_10_GCMS_STEP_SEQUENCE.md` preserves the earlier broad MCG-02 Gates
  0–11 provider-proof scaffold and older branch/baseline references.

These files remain useful provenance and closure debt. They must not rewind the
active Step 12 state. Their reconciliation and refresh are mandatory before
Cycle 10 closure.

```text
DOCUMENTARY_DRIFT=CONFIRMED
ACTIVE_RECOVERY_SURFACE=J_PLUS_NEWEST_GHI
PERMANENT_PROMOTION=PENDING
MAIN_ROOT_REFRESH=PENDING
```

### 3. Cycle 10 expectations

Cycle 10 is now a hosted synchronization, recovery, and operational acceptance
cycle built on the earlier local reliability work. Its successful terminal
requires all of the following:

1. preserve the offline-first/local-authoritative application boundary;
2. obtain a trustworthy GCM-02 hosted recovery/synchronization terminal with
   correlated client, server, and provider evidence;
3. define and complete one bounded GCM-03 from the actual GCM-02 residuals;
4. define and complete one bounded GCM-04 from the actual GCM-03 residuals;
5. reconcile source, G/H/I, human evidence, domain memory, and Main continuity;
6. promote accepted Operational, Didactic, and Design claims through
   FLX-PRM-04;
7. refresh the stale Main-root and domain checkpoint surfaces;
8. inventory migrations, schema/protocol versions, provider resources,
   development/production distinctions, rollback boundaries, and deferrals;
9. pass repository, secret, generated-artifact, and final platform hygiene;
10. establish a clean, explicit Cycle 11 baseline.

Cycle 11 UI/UX convergence and basic Analytics remain separate and cannot be
used to bypass Cycle 10 closure.

### 4. Phase organisation

#### GCM-01 — development provider foundation

State: accepted within its sanitized development boundary.

Its accepted meaning includes the isolated Neon development foundation,
separate migrator/runtime roles, TLS/channel binding, least-privilege checks,
provider metadata/readiness preparation, and related development evidence.
It does not prove production acceptance.

```text
GCM01=ACCEPTED_DEVELOPMENT_BOUNDARY
PRODUCTION_ACCEPTANCE=ABSENT
```

#### GCM-02 — hosted synchronization and exact recovery proof

State: active and open.

Completed Sprint/evidence packages include the local convergence foundation,
retention/rebootstrap foundation, hosted-auth/device foundation and corrections,
GRIMOIRE human-operation procedures, Gate 12.6 copied-database/device-scoped
classification, and the Step 12 diagnostic-runtime completion represented by
the current G/H/I.

The active mandatory Gate sequence is:

| Gate | Purpose | Current state |
| --- | --- | --- |
| 12.1 | Render/API readiness | pass at inspected evidence |
| 12.2 | Auth0 metadata/contract | pass at inspected evidence |
| 12.3 | client/deployment alignment | pass at inspected checkpoint; refresh before action |
| 12.4 | exact Account/Device binding | pass at inspected evidence; refresh before action |
| 12.5 | provider pre-operation baseline | pass at inspected evidence; refresh before action |
| 12.6 | copied-database and Device-scoped candidate correlation | pass |
| pre-12.7 | fresh Windows build plus read-only failed/notApplied preflight | active next boundary |
| 12.7 | exact one-action authorization and controlled action | held |
| 12.8 | correlated post-action client/server evidence capture | held |
| 12.9 | fresh provider baseline and allowlisted comparison | held |
| 12.10 | terminal classification and Main reconciliation | held |

The accepted Gate 12.6 candidate is a failed/notApplied hosted-scope lineage
containing exactly two contiguous events at Device sequences 1–2, with no other
pending event in that hosted scope. The six other pending events belong to
non-hosted scopes. Ordinary Sync is therefore not an acceptable substitute.

### 5. Current restart point — pre-12.7

The human has reported the Windows checkout pulled, established, and clean.
Treat repository alignment as human-observed and require the build output to
carry the tested HEAD before accepting it as host evidence.

Proceed in this order:

#### Subphase A — fresh Windows host proof

1. Run the current canonical `GS-FLUTTER-WIN` procedure through the dispatcher
   named by the checked-out GRM documentation.
2. Require Flutter analysis, the full Flutter tests, Windows Release build,
   Auth0Flutter protocol registration, application launch, and visible Closure
   destination.
3. Do not select Enroll, Query, Sync, Retry, Repair, or Clear diagnostics.
4. Stop on build, launch, configuration, authentication-surface, or Closure
   initialization failure.

#### Subphase B — read-only candidate inspection

1. Open `Closure`.
2. Select only `Inspect failed/notApplied recovery`.
3. Capture only the sanitized displayed classification, MKS/native codes,
   bounded operation/correlation fingerprints, candidate count, pending count,
   sequence range, event count, retryability, and safe action.
4. Cancel/close if any mutation or confirmation control appears.
5. Do not select `Retry unknown-outcome submission`, ordinary Sync, Enroll,
   Query, Repair, or Clear diagnostics.

Required terminal:

```text
PROVIDER_CONTACT=NO
FAILED_NOT_APPLIED_EXECUTION=NO
ORDINARY_SYNC=NO
CANCELLED_WITHOUT_MUTATION=YES
```

#### Subphase C — Main reconciliation and implementation decision

Reconcile the read-only preflight against Gate 12.6 and the fresh Windows/Git
evidence.

- If the candidate is absent, ambiguous, differently classified, differently
  scoped, or has different counts/ranges/fingerprints, stop. Keep GCM-02 open
  and stage only the narrow diagnosis/correction justified by the evidence.
- If the candidate matches and is eligible, do not execute it yet. Current
  source evidence states `FAILED_NOT_APPLIED_EXECUTION=ABSENT`.
- If execution remains absent, Main must prepare one narrow synchronized D/E/F
  packet for the failed/notApplied controlled-action surface and its safety
  guards. Codex then materializes and validates it and returns new G/H/I.
- Main reconciles that new evidence before Gate 12.7 can be presented.

Therefore:

```text
NEW_DEF_BEFORE_WINDOWS_PREFLIGHT=NO
NEW_DEF_BEFORE_CONTROLLED_FAILED_NOT_APPLIED_EXECUTION=CONDITIONAL_YES
CONDITION=ELIGIBLE_PREFLIGHT_AND_EXECUTION_STILL_ABSENT
```

This resolves the earlier J ambiguity: a prepared authorization concept is not
an executable recovery capability.

#### Subphase D — Gate 12.7 exact authorization

Only after current-source conformance, fresh Git/Windows/Render/Auth0/Device/
provider-baseline evidence, and a matching candidate may Main present one exact
authorization packet.

The packet must name:

- the accepted 12.1–12.6 state and tested revisions;
- the sanitized candidate fingerprint;
- target Device scope, sequence range 1–2, and event count 2;
- the exact coordinator/action boundary;
- expected HTTP operations;
- the one accepted provider transition;
- duplicate-equivalent, rejected/notApplied, unknown, and unexpected rules;
- evidence-capture order;
- immediate stop conditions;
- the no-second-action rule.

Only explicit human approval of that complete packet authorizes exactly one
controlled action. It does not authorize ordinary Sync, a second action,
Enroll, Repair, provider-console mutation, database editing, or cleanup.

#### Subphase E — Gates 12.8–12.10

After an explicitly authorized one-action Gate 12.7 trial:

1. Gate 12.8 captures the sanitized client terminal, server lifecycle
   correlation, timestamps, and local post-state without issuing a second
   action.
2. Gate 12.9 runs the fresh approved provider/Neon comparison and compares only
   allowlisted counts, sequence/cursor/acknowledgement measures, and lifecycle
   state.
3. Gate 12.10 classifies the result as exactly one of:
   expected success, duplicate-equivalent, rejected/notApplied, unknown, or
   unexpected mutation.

GCM-02 closes only when the terminal is trustworthy across client
classification, server lifecycle logs, and provider state. Unknown,
out-of-allowlist, or contradictory evidence keeps GCM-02 open and activates
only a narrow diagnostic correction. Do not issue another Sync or retry.

### 6. GCM-03 provisional organisation

GCM-03 is undefined and inactive until GCM-02 reconciles.

Current planning candidate:

```text
bounded second-Device hosted convergence and acknowledgement proof
```

After GCM-02 closure, Main must:

1. inventory the actual remaining gaps;
2. choose one narrow GCM-03 objective and explicit non-goals;
3. request A/B/C investigation when alternatives remain;
4. reconcile J and issue synchronized D/E/F;
5. run bounded implementation and/or human proof;
6. receive and reconcile G/H/I;
7. promote accepted evidence or retain a named blocker.

Production deployment, broad retention/rebootstrap acceptance, backup/PITR,
credential lifecycle, and Cycle 11 UI/UX are not silently absorbed.

### 7. GCM-04 provisional organisation

GCM-04 is undefined and inactive until GCM-03 reconciles.

Candidate families, not authority:

- authorization, revocation, and credential lifecycle;
- outage, recovery, and retention acceptance;
- reproducible deployment/release operational boundary;
- provider cleanup, rollback, and final cross-platform acceptance.

Main repeats the GCM-03 definition/staging/materialization/reconciliation route
and must split the work if one terminal unit would otherwise become too broad.

### 8. Cycle 10 closure work after GCM-04

The closure sequence is:

1. reconcile the final GCM terminal in J;
2. run Operational, Didactic, and Design FLX-PRM-04 promotion;
3. refresh each permanent domain checkpoint and derived TODO surface;
4. refresh `00_PROJECT_STATE.md`, append `05_SESSION_LOG.md`, and refresh
   `06_SESSION_SCHEME.md`;
5. reconcile or retire stale planning surfaces without deleting provenance,
   including the older `CYCLE_10_GCMS_STEP_SEQUENCE.md` scaffold;
6. preserve J `Legacy_Progress` while keeping one compact current recovery
   pointer;
7. inventory migrations, Drift/PostgreSQL schemas, protocol and diagnostic
   versions, provider resources, credentials/rotation boundaries, and deferred
   production work;
8. run final Flutter/API tests, Windows validation, the accepted Android
   boundary, generated-document checks, `git diff --check`, and a secret/
   artifact hygiene scan;
9. resolve branch/local/remote continuity and require a clean terminal
   worktree;
10. declare the Cycle 10 terminal and establish the Cycle 11 entry baseline.

### 9. Immediate terminal

```text
CYCLE10=OPEN
GCM01=ACCEPTED_DEVELOPMENT_BOUNDARY
GCM02=OPEN_ACTIVE
GCM02_12_6=PASS
WINDOWS_CURRENT_SOURCE_BUILD_RUN=PENDING
FAILED_NOT_APPLIED_PREFLIGHT=READ_ONLY_PENDING_HUMAN_RUN
FAILED_NOT_APPLIED_EXECUTION=ABSENT
GATE_12_7=HELD
GATES_12_8_TO_12_10=HELD
GCM03=UNDEFINED_INACTIVE
GCM04=UNDEFINED_INACTIVE
PERMANENT_DOMAIN_PROMOTION=PENDING
MAIN_ROOT_REFRESH=PENDING
PROVIDER_ACTION=NOT_PERFORMED
ORDINARY_SYNC=NOT_AUTHORIZED
CONTROLLED_RECOVERY=NOT_AUTHORIZED
```

---

## 2026-07-26 — Gate 12.7 read-only inspection reconciliation and REC-01 staging

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Main Chat [M]
Branch: `cycle10-intermid-grimoire`
Reconciled repository baseline:
`76540c45702b027d56b52fea05a8025f14496cdf`
Evidence: five sanitized human-supplied Windows Closure screenshots plus
targeted inspection of the current J, G/H/I, diagnostic registry, Closure
runner/page, local diagnostic query, local recovery repository and ordinary
Sync coordinator
Disposition: **READ-ONLY PREFLIGHT PASS; NARROW D/E/F ACTIVATED; GATE 12.7
EXECUTION STILL HELD**

### 1. Scope and authority

This entry is appended under `Legacy_Progress` and does not rewrite any prior
entry. It reconciles only the human execution of:

```text
Inspect failed/notApplied recovery
```

No screenshot or source evidence establishes that the new controlled
failed/notApplied recovery-and-upload action exists. No recovery, provider
request, ordinary Sync, enrollment, repair, cleanup, database edit, or second
action is accepted as performed.

The human reported that the prescribed sequence was followed. The screenshots
prove a fresh Windows Closure application was running and that the inspection
completed. They do not contain the terminal output needed to independently
accept every analysis/test/build subcommand. Retain that distinction:

```text
WINDOWS_CLOSURE_RUN=HUMAN_OBSERVED_PASS
WINDOWS_FULL_BUILD_LOG=NOT_PRESENT_IN_SCREENSHOT_EVIDENCE
```

### 2. Before-inspection observations

The first three screenshots preserve the pre-inspection state.

Current-action surface:

```text
MKS_CODE=MKS-UI-003
TITLE=Current action collapsed into historical result
OUTCOME=blocked
LAST_PROVED_PHASE=presentation
LOCAL_MUTATION=none
PROVIDER_CONTACT=not-started
TRUSTED_RESPONSE=not-received
OPERATION=not-recorded
```

This is a prior presentation-state observation. It must not be mistaken for
the later failed/notApplied inspection terminal.

Sync overview and local queue:

```text
AUTHENTICATION=authenticated
ENROLLMENT=device-enrolled
READINESS=failed-work-needs-review
LAST_RESULT=sync-unavailable
RECOVERY_GUIDANCE=review-local-sync-state-before-retry
PENDING=0
UPLOADING=0
FAILED=2
```

Recent-attempt evidence retained:

- the latest ordinary Sync remained `sync-unavailable /
  provider-evidence-unavailable`;
- it carried no observed HTTP status or response headers;
- prior hosted-connection checks included ready responses;
- no local diagnostic child events were shown before the inspection;
- the current Device fingerprint was `#a43532d0`, enrolled, with next
  sequence `3`;
- two actionable `purchase.registered` events were failed at sequences `1`
  and `2`.

This confirms that the read-only action started from the expected Gate 12.6
shape. It does not refresh the live provider baseline.

### 3. After-inspection result

The final screenshot shows one new current diagnostic child:

```text
DIAGNOSTIC_CODE=MKS-UI-004
PHASE=failed-recovery-preflight
OUTCOME=not-applied
LAST_PROVED_PHASE=failed-recovery-preflight
LOCAL_MUTATION=none
PROVIDER_CONTACT=not-started
TRUSTED_RESPONSE=not-received
RESULT_PERSISTENCE=not-started
OPERATION_FINGERPRINT=#4af181b3d7e7
CORRELATION_FINGERPRINT=#0ebea2b44ec7
SAFE_ACTION=hold for Gate 12.7 reconciliation; do not execute recovery
```

The Device remained enrolled with next sequence `3`, and the same two
actionable events remained failed at sequences `1` and `2`.

Targeted source inspection confirms that an eligible `MKS-UI-004` inspection
requires exactly one current Account/Device failed/notApplied submission,
complete contiguous membership, valid scoped events and hashes, all member
states failed, no accepted member, no active overlap, no current-scope
pending/uploading/unknown work, and a matching next sequence.

The inspection runner records `mutation none`, `contact not-started`,
`trusted not-received`, and `persist not-started`; it has no execution
callback. Therefore:

```text
FAILED_NOT_APPLIED_CANDIDATE=ONE_ELIGIBLE
CANDIDATE_MEMBER_COUNT=2
CANDIDATE_SEQUENCE_RANGE=1-2
CURRENT_DEVICE_NEXT_SEQUENCE=3
READ_ONLY_INSPECTION=PASS
LOCAL_MUTATION=ABSENT
PROVIDER_CONTACT=ABSENT
FAILED_NOT_APPLIED_EXECUTION=ABSENT
ORDINARY_SYNC=ABSENT_DURING_INSPECTION
```

One source/meaning drift is confirmed. The eligible inspection emits
`MKS-UI-004`, while the registry title and meaning still describe the older
condition in which the failed/notApplied inspection action is missing. The
action now exists. The state axes and safe action remain sufficient to accept
the read-only preflight behavior, but the code cannot continue to mean both
“action missing” and “eligible preflight.” REC-01 must preserve the historical
UI code and emit a precise REC preflight code for the current condition.

The bounded fingerprints are useful for reconciliation and later confirmation
display. They are not authoritative database identities and must never be
used alone to select the candidate.

### 4. PRC-01 classification

```text
Claim: the Gate 12.7 failed/notApplied preflight is human-observed eligible
Source: Windows Closure screenshots and current source
Current state: validated within the read-only Windows inspection boundary
Evidence: MKS-UI-004 event plus unchanged two-event failed lineage
Evidence boundary: local UI/database observation; no live provider refresh
Contradictions: none within the supplied evidence
Semantic owner: Main GCM-02 Gate 12.7 reconciliation
Target role: J continuity and synchronized D/E/F materialization authority
History disposition: append; preserve earlier pending/blocked states
Confidence: high within the named boundary
Human/Main authority: reconciliation and staging requested
Required regeneration: Codex replacement G/H/I after REC-01 materialization
Result: preflight PASS; execution capability still absent
```

```text
Claim: MKS-UI-004 correctly names the eligible preflight
Source: current registry and Closure diagnostic query
Current state: contradicted
Evidence: runtime emits the code for eligibility; registry defines missing action
Evidence boundary: repository/source semantic consistency
Contradictions: direct code-to-registry mismatch
Semantic owner: diagnostic registry plus detector boundary
Target role: C10-GCM02-S12-REC-01 D/E/F
History disposition: preserve historical code; stop current mis-emission
Confidence: high
Human/Main authority: correction staged, not yet materialized
Required regeneration: registry projections, tests and replacement G/H/I
Result: bounded REC-01 correction required
```

```text
Claim: Gate 12.7 may now authorize a controlled recovery
Source: preflight evidence
Current state: blocked
Evidence: source contains inspection only; no dedicated bounded executor
Evidence boundary: repository/source and UI inspection
Contradictions: older J wording assumed an executable action
Semantic owner: Main Gate 12.7 authority
Target role: D/E/F corrective materialization first
History disposition: preserve and correct by this later entry
Confidence: high
Human/Main authority: no execution authorization granted
Required regeneration: source implementation, tests, G/H/I, Main reconciliation
Result: authorization remains held
```

### 5. Resolved Cycle 10 hierarchy

The navigation grammar is now instantiated as follows:

```text
Cycle 10 — hosted synchronization and operational acceptance
├─ GCM-01 — development-provider foundation
│  └─ Terminal: accepted within the sanitized development boundary
├─ GCM-02 — exact hosted recovery/synchronization proof [ACTIVE]
│  ├─ Gate 12.1 — Render/API readiness [PASS AT INSPECTED EVIDENCE]
│  ├─ Gate 12.2 — Auth0 metadata contract [PASS AT INSPECTED EVIDENCE]
│  ├─ Gate 12.3 — client/deployment alignment [PASS; REFRESH BEFORE ACTION]
│  ├─ Gate 12.4 — exact Account/Device binding [PASS; REFRESH BEFORE ACTION]
│  ├─ Gate 12.5 — provider baseline [PASS; REFRESH BEFORE ACTION]
│  ├─ Gate 12.6 — copied DB and Device-scope correlation [PASS]
│  ├─ Sprint S12-ERR-01/02 — diagnostic runtime tightening [SOURCE ACCEPTED]
│  ├─ Gate 12.7 — one controlled failed/notApplied recovery
│  │  ├─ Phase A — current-source Windows Closure run [HUMAN OBSERVED PASS]
│  │  ├─ Phase B — read-only candidate inspection [PASS]
│  │  ├─ Phase C — Main reconciliation [THIS ENTRY: PASS]
│  │  ├─ Sprint S12-REC-01 — bounded execution surface [D/E/F ACTIVE]
│  │  ├─ Phase D — Codex materialization and local validation [PENDING]
│  │  ├─ Phase E — G/H/I reconciliation [PENDING]
│  │  ├─ Phase F — fresh Windows build and repeated preflight [PENDING]
│  │  ├─ Phase G — Git/Render/Auth0/Device/provider freshness [PENDING]
│  │  ├─ Phase H — exact authorization packet [PENDING]
│  │  └─ Phase I — explicit approval plus one action [HELD]
│  ├─ Gate 12.8 — correlated client/server evidence [HELD]
│  ├─ Gate 12.9 — provider comparison [HELD]
│  └─ Gate 12.10 — terminal classification and GCM-02 reconciliation [HELD]
├─ GCM-03 — bounded second-Device convergence candidate [UNDEFINED/INACTIVE]
├─ GCM-04 — final operational acceptance families [UNDEFINED/INACTIVE]
└─ Cycle closure — promotion, continuity refresh, hygiene and Cycle 11 handoff
   [HELD]
```

### 6. Activated D/E/F unit

This reconciliation activates synchronized materialization unit:

```text
UNIT=C10-GCM02-S12-REC-01
OBJECTIVE=separate bounded failed/notApplied recovery-and-upload surface
SOURCE_ONLY=YES
LIVE_PROVIDER_ACTION=NO
GATE_12_7_AUTHORIZATION=NO
```

The unit must preserve inspection as read-only and introduce a distinct,
confirmed coordinator that:

1. revalidates exact Account/Device/candidate state immediately before
   mutation;
2. uses authoritative internal identity rather than a fingerprint selector;
3. atomically recovers exactly the candidate member set;
4. leases and uploads exactly that recovered set;
5. stops after one upload terminal;
6. never invokes download, acknowledgement or ordinary Sync;
7. records the complete diagnostic evidence axes;
8. prevents automatic or second execution;
9. replaces the eligible-preflight `MKS-UI-004` emission with a precise REC
   code without erasing the historical missing-action definition.

The synchronized controlling files are:

```text
DEV_STAGE/D_OPS_STAGE.md
DEV_STAGE/E_DDC_STAGE.md
DEV_STAGE/F_DSN_STAGE.md
```

### 7. Resolved continuation sequence

Proceed only in this order:

1. publish this J plus synchronized D/E/F staging;
2. send the exact seeding prompt below to Codex;
3. Codex verifies the required ancestry and materializes only
   C10-GCM02-S12-REC-01;
4. Codex runs local/disposable validation and replaces G/H/I;
5. Main reconciles source and G/H/I into a new append-only J entry;
6. pull the accepted commit into the clean Windows checkout;
7. run the canonical Windows validation/build/launch procedure;
8. repeat `Inspect failed/notApplied recovery`;
9. require the candidate fingerprint/count/range/next-sequence and all safety
   booleans to match the accepted packet;
10. refresh Git revision, Render readiness/revision, Auth0 metadata/principal,
    exact Device binding and the allowlisted provider baseline;
11. Main prepares one exact Gate 12.7 authorization packet;
12. obtain explicit human authorization for exactly one named action;
13. execute exactly one `Recover failed/notApplied candidate`;
14. issue no second action and freeze the post-action local state;
15. Gate 12.8 captures client terminal and correlated server lifecycle;
16. Gate 12.9 captures and compares the fresh allowlisted provider state;
17. Gate 12.10 classifies exactly one terminal and decides GCM-02 closure.

Any mismatch, unknown result, out-of-allowlist mutation, ambiguous response,
partial local transition, revision drift, or absent correlation stops the
sequence. It does not authorize another attempt.

### 8. Gate 12.8–12.10 expected terminal

The controlled action may be classified only as:

```text
expected success
duplicate-equivalent
rejected/notApplied
unknown
unexpected mutation/failure
```

GCM-02 may close only when client state, server lifecycle evidence and
provider state agree on a trustworthy terminal. An unknown or contradictory
terminal keeps GCM-02 open with a narrow diagnostic follow-up and no second
action.

### 9. Current terminal

```text
CYCLE10=OPEN
GCM01=ACCEPTED_DEVELOPMENT_BOUNDARY
GCM02=OPEN_ACTIVE
GCM02_12_6=PASS
WINDOWS_CLOSURE_RUN=HUMAN_OBSERVED_PASS
FAILED_NOT_APPLIED_PREFLIGHT=READ_ONLY_PASS
FAILED_NOT_APPLIED_CANDIDATE=ONE_ELIGIBLE
CANDIDATE_MEMBER_COUNT=2
CANDIDATE_SEQUENCE_RANGE=1-2
CURRENT_DEVICE_NEXT_SEQUENCE=3
LOCAL_MUTATION=ABSENT
PROVIDER_CONTACT=ABSENT
FAILED_NOT_APPLIED_EXECUTION=ABSENT
ELIGIBLE_PREFLIGHT_CODE_SEMANTICS=DRIFT_CONFIRMED
C10_GCM02_S12_REC_01=STAGED_ACTIVE
GATE_12_7=HELD_PENDING_CODEX_AND_RECONCILIATION
GATES_12_8_TO_12_10=HELD
GCM03=UNDEFINED_INACTIVE
GCM04=UNDEFINED_INACTIVE
ORDINARY_SYNC=NOT_AUTHORIZED
CONTROLLED_RECOVERY=NOT_AUTHORIZED
```

## 2026-07-26 — REC-01 source reconciliation and Gate 12.7 host handoff

### Sequence envelope

```text
Sequence: FLX-PRM-04 — Promotion/Reconciliation
Role: Main Chat [M]
Branch: cycle10-intermid-grimoire
Reconciled implementation commit: a63367763716e2769ac58d5adc19de0c41774b35
Evidence: replacement G/H/I, changed-path inventory and reported validation
Writable surface: J only
Disposition: REC-01 SOURCE ACCEPTED; HOST VALIDATION PENDING; GATE 12.7 HELD
```

### Materialization reconciliation

REC-01 is accepted within its repository and local/disposable test boundary.
The implementation now separates four surfaces:

```text
Retry unknown-outcome submission
Inspect failed/notApplied recovery
Recover failed/notApplied candidate
ordinary Sync
```

The new recovery action revalidates authentication, exact Account/Device
binding and the complete authoritative candidate immediately before mutation.
It retains full internal identity rather than selecting by a truncated
fingerprint, atomically recovers and leases exactly the candidate members,
sends at most one upload, persists the result and stops. Its dependency graph
contains no download or acknowledgement path.

The eligible read-only inspection now emits `MKS-REC-001`.
`MKS-UI-004` remains reserved for its historical missing-action meaning.
Generated Dart, TypeScript and Markdown projections were regenerated from the
single registry owner.

### PRC-01 claims

```text
Claim: REC-01 bounded failed/notApplied execution surface exists
Prior state: staged; execution surface absent
Evidence: a633677 source plus G/H/I and local/disposable tests
Evidence boundary: repository-proven and locally test-validated; host-unvalidated
Contradiction: none in replacement G/H/I
Semantic owner: GCM-02 Gate 12.7 Main reconciliation
Target role: J current state and continuation
Resulting state: SOURCE ACCEPTED; WINDOWS/LIVE EXECUTION NOT ACCEPTED
History disposition: append; supersede D/E/F-active wording
```

```text
Claim: exact candidate, one upload and no download/ack boundaries hold
Prior state: implementation requirement
Evidence: focused Flutter tests, full 189-pass/4-skip suite, analysis, API 58-pass suite
Evidence boundary: mocked/local/disposable transport and persistence boundaries
Contradiction: none reported
Semantic owner: REC-01 operational/design contract
Target role: J accepted source capability
Resulting state: LOCALLY VALIDATED; LIVE RESULT UNKNOWN
History disposition: append; retain future host/provider proof requirement
```

```text
Claim: Gate 12.7 may now execute
Prior state: held
Evidence: no fresh Windows build, repeated UI preflight or provider-freshness packet
Evidence boundary: source materialization only
Contradiction: capability exists, but authorization evidence is incomplete
Semantic owner: human/Main Gate 12.7 authority
Target role: prohibition and next-step boundary
Resulting state: REJECTED; AUTHORIZATION HELD
History disposition: append; no provider/user-database action accepted
```

### Validation absorbed

```text
generator update/check: PASS, including deterministic second check
Dart format: PASS
focused Flutter: 17 + 29 + 10 + 26 reported passing cases
Flutter analyze: PASS
full Flutter test: 189 passed, 4 skipped
API diagnostics/format/lint/typecheck/build: PASS
API tests: 58 passed
git diff --check: PASS
staged sensitive-pattern scan: no matches
provider/live action: NOT PERFORMED
user database inspection or mutation: NOT PERFORMED
Drift migration: NOT ADDED
```

The reports preserve one command-location correction: an initial diagnostics
check invoked from the repository root failed because no root
`package.json` exists; the same command run from
`services/markei_sync_api` passed. This is an invocation correction, not a
product-test failure.

### Separate dispatcher-rename boundary

Codex preserved unrelated machine-local work:

```text
deleted: documentation/NEON_CHECK.ps1
untracked: documentation/I_SCRIPTS.ps1
```

Therefore commit `a633677` does not publish or validate that rename. J must
continue to regard the tracked dispatcher and its references as authoritative
until the rename, all GRM/G_SCRIPTS references and dispatcher validation are
published together in a separate isolated commit. This boundary must be
resolved before relying on canonical Windows commands.

### Hierarchical progress update

```text
Cycle 10 — hosted synchronization and operational acceptance [OPEN]
└─ GCM-02 — exact hosted recovery/synchronization proof [ACTIVE]
   └─ Gate 12.7 — one controlled failed/notApplied recovery [ACTIVE/HELD]
      ├─ Phase A — Windows Closure and read-only inspection [PASS]
      ├─ Phase B — Main candidate reconciliation [PASS]
      ├─ Sprint S12-REC-01 — bounded execution surface [SOURCE ACCEPTED]
      ├─ Phase C — G/H/I reconciliation [PASS: THIS ENTRY]
      ├─ Phase D — dispatcher-name coherence [PENDING, SEPARATE]
      ├─ Phase E — fresh Windows validation/build/launch [PENDING]
      ├─ Phase F — repeated read-only MKS-REC-001 preflight [PENDING]
      ├─ Phase G — recovery confirmation-surface cancel test [PENDING]
      ├─ Phase H — Git/Render/Auth0/Device/provider freshness [PENDING]
      ├─ Phase I — exact authorization packet [PENDING]
      └─ Phase J — explicit approval plus exactly one action [HELD]
```

Gates 12.8–12.10 remain held. GCM-03 and GCM-04 remain undefined and
inactive. No new D/E/F packet is justified by REC-01 evidence alone; any new
packet must be triggered by a concrete Windows/freshness defect or by a later
Main-defined post-terminal unit.

### Current terminal

```text
CYCLE10=OPEN
GCM02=OPEN_ACTIVE
GCM02_12_6=PASS
GCM02_12_7_READ_ONLY_PREFLIGHT=PASS
C10_GCM02_S12_REC_01_SOURCE=ACCEPTED
ELIGIBLE_PREFLIGHT_DIAGNOSTIC_CODE=CORRECTED
EXACT_RECOVERED_BATCH=LOCALLY_VALIDATED
ONE_UPLOAD_ONLY=LOCALLY_VALIDATED
DOWNLOAD_ACK_ABSENT=LOCALLY_VALIDATED
WINDOWS_POST_REC01_VALIDATION=PENDING
DISPATCHER_RENAME=PENDING_SEPARATE_RECONCILIATION
GATE_12_7=HELD
CONTROLLED_RECOVERY=NOT_AUTHORIZED
ORDINARY_SYNC=NOT_AUTHORIZED
PROVIDER_ACTION=NOT_AUTHORIZED
GATES_12_8_TO_12_10=HELD
GCM03=UNDEFINED_INACTIVE
GCM04=UNDEFINED_INACTIVE
```

## 2026-07-26 — Post-REC-01 ERR evidence reconciliation and SYNC-01 staging

### Sequence envelope

```text
Sequence: FLX-PRM-04 → FLX-ORD-01
Role: Main Chat [M]
Branch: cycle10-intermid-grimoire
Reconciled baseline: 3d1e82e5259cf51e8cd2d6baf694423494bab7a5
Evidence: post-REC-01 Windows screenshots, supplied Render log window,
          source inspection and human timing/semantic direction
Writable surface: append-only J plus replacement D/E/F
Disposition: SYNC-01 ACTIVATED; GATE 12.7 HELD
```

This entry belongs to `Legacy_Progress`. It preserves the assay sequence and
activates one bounded source unit; it does not rewrite the earlier REC-01
reconciliation or authorize a provider operation.

### Evidence by observed step

| ERR / observation | Step | Expected | Meaningful evidence | Reconciled meaning |
| --- | --- | --- | --- | --- |
| `sync-interrupted` | Historical ordinary Sync/Retry | trusted terminal within observation budget | client observation limit was 5000 ms; two events later remained failed | client stopped observing; server receipt/application remains unknown |
| `timeout-before-response` | Earlier hosted communication | response headers or typed failure | about 30 seconds elapsed; no headers observed | stall occurred before observable headers; exact transport/API/auth/database boundary is unproved |
| `hosted-connection-ready` | Post-REC-01 readiness check | prove readiness only | HTTP 200, headers received, under one second | hosted readiness passed; ordinary Sync not proved |
| Render `/health/ready` | Supplied deployment window | readiness responses | 14 HTTP 200 responses, all under 250 ms | service readiness passed in that window |
| exact Render correlation absent | Client/server comparison | shared request lineage | client terminal near 19:19:04Z; supplied logs ended near 19:13:53Z | evidence-window mismatch; client request is not server-correlated |
| `MKS-REC-001` | failed/notApplied inspection | read-only eligible preflight | one candidate, two members, sequence 1-2, next sequence 3 | REC-01 diagnostic correction passed |
| queue/candidate immobility | inspection and readiness | no mutation | failed=2; pending/uploading/unknown=0; next sequence=3 before and after | neither operation changed recovery state |
| recovery confirmation | cancel-only UI assay | no execution | bounded confirmation displayed; no recovery terminal/request appeared | confirmation safety passed; recovery remains unexecuted |
| “Last successful sync” advanced | readiness assay | remain unchanged | 19:01:18Z became 19:19:04Z after readiness | definite projection defect: generic completed attempt impersonated Sync success |
| `outcomeClass=completed` | source/projection inspection | classify within operation kind | readiness and Sync may both be completed | generic completion is insufficient for Sync-success projection |
| 5-second Sync deadline | source inspection | adequate hosted observation budget | `HttpSyncTransport` default is 5 seconds; readiness uses 20 seconds | timing is a credible hypothesis requiring controlled relaxation, not a proved root cause |

### PRC-01 claims

```text
Claim: hosted readiness passed without changing the failed recovery candidate
Prior state: host validation pending
Evidence: before/after Windows screenshots and readiness terminal
Evidence boundary: client-observed; exact latest server request not correlated
Contradiction: none in queue/candidate evidence
Semantic owner: GCM-02 host observation
Target role: J observational reconciliation
Resulting state: ACCEPTED WITH SERVER-CORRELATION LIMIT
History disposition: append
```

```text
Claim: the displayed Last successful sync is semantically trustworthy
Prior state: assumed UI projection
Evidence: timestamp advanced immediately after hosted readiness
Evidence boundary: repeatable UI/source observation
Contradiction: readiness explicitly does not prove Sync
Semantic owner: Closure diagnostic projection
Target role: C10-GCM02-S12-SYNC-01
Resulting state: REJECTED; SOURCE CORRECTION REQUIRED
History disposition: append and supersede generic-completed predicate
```

```text
Claim: the five-second ordinary-Sync deadline caused the historical failure
Prior state: hypothesis
Evidence: 5000 ms interruption plus fast readiness and missing Sync correlation
Evidence boundary: no paired client/server ordinary-Sync terminal
Contradiction: a 30-second pre-header timeout was also observed historically
Semantic owner: SYNC-01 timing assay
Target role: configurable bounded timing experiment
Resulting state: PLAUSIBLE, UNPROVED
History disposition: preserve until one controlled correlated assay
```

### Activated implementation unit

```text
UNIT=C10-GCM02-S12-SYNC-01

Primary contract:
  operationKind=ordinary-sync

Client terminal resultCode:
  sync-completed
  sync-no-new-events
  sync-rejected
  sync-server-timeout
  sync-failed

Declaration scopes:
  client-operation
  server-request

Initial timing experiment:
  client ordinary-Sync deadline=35 seconds
  server deadline=25 seconds only with authoritative cancellation/rollback
  automatic retry=absent
```

The client owns the complete ordinary-Sync result. The server owns only each
request/transaction result it observed. Correlation joins those declarations;
it does not erase their different evidence scopes.

The “Last successful sync” predicate must become:

```text
operationKind = ordinary-sync
outcomeClass = completed
resultCode IN (sync-completed, sync-no-new-events)
completedAt IS NOT NULL
```

`Recent sync attempts` becomes `Recent Closure attempts`. Hosted readiness
retains its independent result and timestamp. No broad ERR list refactor is
authorized in this unit.

### Authority and held actions

D/E/F now authorize only repository source, focused tests, generated
diagnostic projections and replacement G/H/I. They do not authorize:

```text
deployment
live hosted request
ordinary Sync
Retry
failed/notApplied recovery
provider/database mutation
Gate 12.7 execution
```

After Codex materialization, Main must reconcile G/H/I before any manual
assay. The first manual assay remains readiness-only and must prove that the
readiness timestamp may advance while “Last successful sync” does not. A later
ordinary-Sync or recovery action requires a separate exact authorization
packet.

### Continuation

```text
SYNC-01 source materialization
→ G/H/I reconciliation
→ clean Windows build/launch
→ one readiness-only projection regression
→ exact UTC client/server log correlation
→ refreshed Git/Render/Auth0/Device/Neon freshness
→ Gate 12.7 authorization packet
→ one explicitly authorized action
→ Gates 12.8-12.10 reconciliation
```

### Current terminal

```text
CYCLE10=OPEN
GCM02=OPEN_ACTIVE
C10_GCM02_S12_REC_01_SOURCE=ACCEPTED
POST_REC01_WINDOWS_PREFLIGHT=PASS
HOSTED_READINESS_CLIENT=PASS
HOSTED_READINESS_EXACT_SERVER_CORRELATION=NOT_PROVED
LAST_SUCCESSFUL_SYNC_PROJECTION=FAILED
C10_GCM02_S12_SYNC_01=ACTIVE_STAGED
ORDINARY_SYNC_FIVE_RESULT_CONTRACT=STAGED
CLIENT_SERVER_DECLARATION_SCOPES=STAGED
CLIENT_SYNC_DEADLINE_35S=STAGED_AS_ASSAY
BROAD_ERR_REFACTOR=DEFERRED
GATE_12_7=HELD
CONTROLLED_RECOVERY=NOT_AUTHORIZED
ORDINARY_SYNC=NOT_AUTHORIZED
PROVIDER_ACTION=NOT_AUTHORIZED
GATES_12_8_TO_12_10=HELD
GCM03=UNDEFINED_INACTIVE
GCM04=UNDEFINED_INACTIVE
```

## 2026-07-26 — ERR-03 source reconciliation and correlated assay preparation

### Sequence envelope

```text
Sequence: FLX-PRM-04 — Promotion/Reconciliation
Role: Main Chat [M]
Round or unit: C10-GCM02-S12-ERR-03 within C10-GCM02-S12-SYNC-01
Branch: cycle10-intermid-grimoire
Reconciled implementation commit: 3b7bbeaf076a5dc8454a7e09dbb61076d34f4b36
Inputs: synchronized D/E/F, replacement G/H/I, source changed-path inventory,
        local validation evidence and human direction for the next assay
Writable surface: append-only J
Evidence boundary: repository-proven and locally test-validated;
                   Windows/host/provider/end-to-end unvalidated
Disposition: ERR-03 SOURCE ACCEPTED; ASSAY PREPARED; GATE 12.7 HELD
```

This entry reconciles the bounded ERR-03 materialization. It accepts the
implemented semantic and diagnostic contract only within the repository and
local-test boundary. It does not reinterpret local validation as a hosted Sync
result and does not authorize failed/notApplied recovery.

### Materialization reconciliation

The client ordinary-Sync terminal vocabulary is now:

```text
sync-completed
sync-no-new-events
sync-rejected
sync-server-timeout
sync-failed
```

The top-level Flutter action owns the aggregate ordinary-Sync result. Each API
lifecycle record owns only one server request. The two scopes remain explicit:

```text
client declarationScope=client-operation
server declarationScope=server-request
```

The client propagates full operation and child correlation identities only in
internal request headers. The UI and server logs expose sanitized twelve-hex
fingerprints. Correlation joins evidence but does not promote request success
into aggregate Sync success.

The client ordinary-Sync deadline is now an explicit 35000 ms client-owned
budget. A 25000 ms server deadline was not implemented because the source did
not establish authoritative cancellation or rollback for every database
operation. A client deadline before a trusted response remains
`sync-failed` with the provider/server outcome unknown. It must not be
classified as `sync-server-timeout`.

The corrected last-success predicate is:

```text
operationKind = ordinary-sync
outcomeClass = completed
resultCode IN (sync-completed, sync-no-new-events)
completedAt IS NOT NULL
```

Therefore hosted readiness, failed/notApplied inspection, recovery
confirmation, cancellation, Retry history and other Closure attempts cannot
advance `Last successful sync`. The mixed list is now labelled
`Recent Closure attempts`.

### PRC-01 claims

```text
Claim: the five-result ordinary-Sync contract and client/server declaration
       scopes exist
Prior state: staged
Evidence: implementation commit 3b7bbeaf, replacement G/H/I, focused and full
          local tests
Evidence boundary: repository and local tests; no Windows or hosted execution
Contradiction: none reported
Semantic owner: C10-GCM02-S12-ERR-03 source contract
Target role: J accepted source capability
Resulting state: IMPLEMENTED AND LOCALLY VALIDATED; HOST-UNVALIDATED
History disposition: append; supersede ACTIVE_STAGED wording only
```

```text
Claim: the historical five-second deadline caused the observed interruption
Prior state: plausible and unproved
Evidence: source now uses 35 seconds, but no post-change hosted ordinary Sync
          has occurred
Evidence boundary: causal assay absent
Contradiction: the historical approximately 30-second pre-header timeout may
               indicate a deeper transport/host/auth/database stall
Semantic owner: correlated ordinary-Sync assay
Target role: retained hypothesis
Resulting state: PLAUSIBLE, STILL UNPROVED
History disposition: retain until paired client/server evidence exists
```

```text
Claim: Last successful sync is now truthful on Windows
Prior state: failed projection with source correction staged
Evidence: corrected query and local tests
Evidence boundary: no fresh Windows build/launch or readiness regression
Contradiction: none in source; host presentation remains unobserved
Semantic owner: Closure UI projection
Target role: next readiness-only regression
Resulting state: SOURCE CORRECTED; WINDOWS/HOST VALIDATION PENDING
History disposition: append; preserve the earlier failed observation
```

```text
Claim: a single ordinary-Sync assay necessarily tests submission/upload
Prior state: human-requested test objective
Evidence: current recorded queue baseline has failed=2 and
          pending/uploading/unknown=0/0/0; automatic retry is absent
Evidence boundary: no new pending event has been authorized
Contradiction: failed/notApplied events belong to the separately held recovery
               surface and must not be silently reused by ordinary Sync
Semantic owner: next assay authorization packet
Target role: assay design
Resulting state: REJECTED AS AN ASSUMPTION; REQUEST-LIFECYCLE CONTROL MAY RUN,
                 SUBMISSION-BEARING ASSAY REQUIRES A BOUNDED PENDING CANDIDATE
History disposition: append; prevent accidental Gate 12.7 crossover
```

### Validation absorbed

```text
diagnostic generator update/check: PASS
deterministic second diagnostics check: PASS
Dart formatting: PASS after formatting
Flutter analyze: PASS
focused Flutter tests: PASS
full Flutter tests: 190 passed, 4 skipped
targeted Prettier on changed TypeScript: PASS
API lint/typecheck/build: PASS
API tests: 58 passed
git diff --check: PASS
changed-content sensitive scan: no real secret reported
live hosted/provider action: NOT PERFORMED
```

Full API `npm run format:check` remains unavailable as a clean repository-wide
gate because of 37 pre-existing formatting warnings outside ERR-03. Changed
TypeScript files passed the targeted Prettier check. This is a known
repository-formatting debt, not evidence that ERR-03 failed its bounded
validation.

No Windows release, Android, Render, Auth0, Neon, live provider, user-database
or live convergence validation was performed. Those states remain
unvalidated.

### Observable declaration surfaces

The fresh Closure UI should expose, for ordinary Sync:

```text
Declaration scope = client-operation
Operation kind = ordinary-sync
Client result code = one of the five terminals
Server request = not aggregate success
Last proved phase
Configured deadline = 35000ms client
Operation = sanitized fingerprint
Correlation = sanitized fingerprint
```

`Recent Closure attempts` should show operation kind, result code, outcome
class, latest stage, client scope, client deadline owner, 35000 ms for ordinary
Sync, sanitized correlation, HTTP status/header evidence and elapsed band.

The API/Render structured lifecycle line should expose:

```text
declarationScope=server-request
operationKind=server-request
resultCode=request-completed | request-failed | typed internal code
routeClass
operationFingerprint
correlationFingerprint
elapsedBand
status/result when available
lastProvedPhase and providerTransactionOutcome when available
```

A server `request-completed` declaration proves only that request. Aggregate
ordinary-Sync success still requires the client terminal.

### Next assay sequence

#### Assay A — fresh Windows and readiness projection regression

1. Pull the reconciled branch and require a clean worktree at the new J commit.
2. Produce or launch the fresh Windows client through the accepted local
   procedure.
3. Record the pre-action `Last successful sync` value and the newest Closure
   attempt.
4. Perform exactly one hosted readiness check.
5. Require `hosted-connection-ready` or a typed readiness failure.
6. Require a new hosted-readiness attempt while `Last successful sync`
   remains byte-for-byte unchanged.
7. Capture the client correlation fingerprint and the matching server-request
   lifecycle line when available.
8. Stop on projection drift, ambiguous lineage, untyped failure or any queue
   mutation.

Readiness remains non-Sync evidence. Passing Assay A does not prove the
35-second ordinary-Sync hypothesis.

#### Assay B — one ordinary-Sync request-lifecycle control

Assay B may begin only after Assay A passes and the pre-action queue,
authentication, Device binding, Git revision and hosted revision are freshly
recorded.

Exactly one ordinary-Sync action is allowed for the control. No Retry,
failed/notApplied recovery, second click or automatic retry is allowed.
Immediately freeze the UI and server evidence at the first terminal.

Expected client terminals and meanings:

| Terminal | Minimum meaning | Required follow-up |
| --- | --- | --- |
| `sync-no-new-events` | aggregate ordinary Sync completed with no new event work | correlate every server request and verify queue immobility |
| `sync-completed` | aggregate ordinary Sync completed inside its proved scope | correlate requests and compare local/provider state before acceptance |
| `sync-rejected` | trusted server response rejected the operation | record status, phase and typed diagnostic; do not retry |
| `sync-failed` | client could not prove aggregate success | inspect trusted-response flag, last phase and server lineage; do not retry |
| `sync-server-timeout` | only valid if a server-owned timeout is proved | unexpected in the current design; stop and inspect authoritative rollback evidence |

Interpretation of elapsed time:

```text
terminal between 5 s and 35 s
    -> the former five-second budget was materially causal

server ingress followed by a typed failure/stall
    -> timing exposed the next server/auth/database boundary

no matching server ingress
    -> client transport, routing or hosting ingress becomes primary

server request completed but client lacks a trusted terminal
    -> response delivery, correlation or client orchestration becomes primary

terminal below 5 s
    -> the old deadline was not exercised in this run; causal hypothesis remains
       unproved rather than rejected
```

#### Assay C — submission-bearing control, separately bounded

Assay B does not necessarily exercise upload/submission while the queue has no
pending event. The two failed/notApplied events must not be converted into an
implicit Retry or recovery.

A true submission-bearing assay therefore requires a separately authorized,
known test event or other bounded pending candidate, with:

```text
exact local candidate identity
expected sequence
expected payload class without sensitive content
single upload limit
no automatic retry
pre/post local state
allowlisted provider comparison
client operation fingerprint
all child correlation fingerprints
matching server-request declarations
explicit stop after the first terminal
```

Until that packet exists, do not manufacture a purchase event solely for
diagnostics and do not use the existing failed/notApplied candidate. Gate 12.7
remains held.

### Hierarchical progress update

```text
Cycle 10 — hosted synchronization and operational acceptance [OPEN]
└─ GCM-02 — exact hosted recovery/synchronization proof [ACTIVE]
   ├─ C10-GCM02-S12-REC-01 source [ACCEPTED]
   ├─ C10-GCM02-S12-ERR-03 source [ACCEPTED, HOST-UNVALIDATED]
   ├─ Assay A readiness projection regression [NEXT]
   ├─ Assay B one ordinary-Sync lifecycle control [PREPARED/CONDITIONAL]
   ├─ Assay C submission-bearing control [NOT YET AUTHORIZED]
   ├─ Gate 12.7 failed/notApplied recovery [HELD]
   └─ Gates 12.8-12.10 terminal reconciliation [HELD]
```

### Current terminal

```text
CYCLE10=OPEN
GCM02=OPEN_ACTIVE
C10_GCM02_S12_ERR_03_SOURCE=ACCEPTED
ORDINARY_SYNC_FIVE_RESULT_CONTRACT=IMPLEMENTED_LOCALLY_VALIDATED
CLIENT_OPERATION_DECLARATION=IMPLEMENTED_LOCALLY_VALIDATED
SERVER_REQUEST_DECLARATION=IMPLEMENTED_LOCALLY_VALIDATED
CLIENT_SERVER_CORRELATION=IMPLEMENTED_LOCALLY_VALIDATED
CLIENT_SYNC_DEADLINE_35S=IMPLEMENTED_HOST_UNVALIDATED
SERVER_DEADLINE_25S=NOT_IMPLEMENTED_WITH_REASON
SYNC_SERVER_TIMEOUT=RESERVED_NOT_CURRENTLY_SERVER_EMITTED
LAST_SUCCESSFUL_SYNC_PREDICATE=SOURCE_CORRECTED_WINDOWS_PENDING
RECENT_CLOSURE_ATTEMPTS=SOURCE_CORRECTED_WINDOWS_PENDING
HISTORICAL_FIVE_SECOND_CAUSAL_HYPOTHESIS=PLAUSIBLE_UNPROVED
READINESS_PROJECTION_ASSAY=NEXT
ORDINARY_SYNC_LIFECYCLE_ASSAY=PREPARED_CONDITIONAL
SUBMISSION_BEARING_ASSAY=NOT_AUTHORIZED
AUTOMATIC_RETRY=ABSENT
BROAD_ERR_REFACTOR=DEFERRED
GATE_12_7=HELD
CONTROLLED_RECOVERY=NOT_AUTHORIZED
PROVIDER_ACTION=NOT_YET_PERFORMED
GATES_12_8_TO_12_10=HELD
GCM03=UNDEFINED_INACTIVE
GCM04=UNDEFINED_INACTIVE
```

## 2026-07-26 — Correlated live Sync reconciliation and ERR-04 staging

### Sequence envelope

```text
Sequence: FLX-PRM-04 → FLX-ORD-01
Role: Main Chat [M]
Hierarchy: Cycle 10 → GCM-02 → Step 12 → Gate 12.7 pre-authorization
Reconciliation unit: C10-GCM02-S12-SYNC-01
Activated implementation unit: C10-GCM02-S12-ERR-04
Branch: cycle10-intermid-grimoire
Required staging ancestor: 27e1b77b81f658b5e704e46923ea48cce2274b3a
Evidence: supplied Windows Closure screenshots, supplied sanitized Render
          lifecycle lines, ERR-03 G/H/I and current source inspection
Writable surface: append-only J plus replacement D/E/F
Disposition: LIVE SYNC REQUEST LIFECYCLE PASSED; RECOVERY BOUNDARY FAILED;
             ERR-04 STAGED; FURTHER LIVE ACTIONS HELD
```

This entry belongs to `Legacy_Progress`. It appends the first correlated
post-ERR-03 hosted ordinary-Sync lifecycle. It does not rewrite the earlier
ERR-03 source reconciliation and does not convert the observed implicit
recovery into Gate 12.7 authorization.

### Complete hierarchical classification

```text
Cycle 10 — hosted synchronization and operational acceptance [OPEN]
└─ Phase GCM-02 — exact hosted recovery/synchronization proof [ACTIVE]
   └─ Step 12 — Closure diagnosis and bounded hosted assays [ACTIVE]
      ├─ Gate 12.6 — diagnostic/readiness preparation [PASSED IN PRIOR SCOPE]
      ├─ Gate 12.7 — failed/notApplied controlled recovery [HELD]
      │  ├─ REC-01 source and inspection surface [ACCEPTED]
      │  ├─ ERR-03 terminal/timing/correlation source [ACCEPTED]
      │  ├─ Readiness projection assay [PASSED]
      │  ├─ Ordinary-Sync correlated lifecycle assay [REQUEST LIFECYCLE PASS]
      │  ├─ Recovery authorization boundary [FAILED]
      │  └─ ERR-04 boundary/observability correction [ACTIVE STAGED]
      ├─ Gate 12.8 — post-action/provider reconciliation [HELD]
      ├─ Gate 12.9 — second-device convergence proof [HELD]
      └─ Gate 12.10 — GCM-02 terminal acceptance [HELD]

Cycle 10 → GCM-03 [UNDEFINED / INACTIVE]
Cycle 10 → GCM-04 [UNDEFINED / INACTIVE]
Cycle 10 closure [BLOCKED BY GCM-02]
```

No Sprint identity is invented for this work. The active hierarchy is a GCM
phase, Step and Gate sequence.

### Sanitized paired evidence

Client evidence:

```text
action=ordinary Sync, pressed once
operation fingerprint=cf23d2a09c74
terminal=sync-completed
completedAt=2026-07-26T22:50:27Z
configured deadline=35000ms client-owned
queue before=0 pending / 0 uploading / 2 failed / 0 unknown
queue after=0 pending / 0 uploading / 0 failed / 0 unknown
next Device sequence before=3
next Device sequence after=3
```

Server evidence:

| UTC terminal | Route / operation | Correlation | Auth | Result |
| --- | --- | --- | --- | --- |
| `22:50:25.708Z` | `POST /v1/sync/submissions` / upload-submission | `ddd649aa0aaa` | accepted | HTTP 200, `<3s` |
| `22:50:26.064Z` | `GET /v1/sync/events` / download-events | `90539afaa945` | accepted | HTTP 200, `<250ms` |
| `22:50:26.433Z` | `POST /v1/sync/acknowledgements` / acknowledgement | `d038eb15cd3f` | accepted | HTTP 200, `<250ms` |

All protected requests share operation fingerprint `cf23d2a09c74`. The listed
correlations are server-request fingerprints derived from Fastify request IDs;
they distinguish Render requests but do not yet prove exact equality with the
client's outbound child correlations. Interleaved `/health/ready` HTTP 200 lines have
`operationFingerprint=not-provided` and remain readiness evidence only.

### Reconciled success boundary

The Sync was truly successful within the observed single-client protocol
boundary:

1. the client reached the aggregate `sync-completed` terminal;
2. upload, download and acknowledgement reached the server;
3. authentication was accepted on all protected routes;
4. each server request returned HTTP 200;
5. the client persisted a successful completion timestamp;
6. the local queue ended without pending/uploading/failed/unknown work.

This is stronger than readiness and stronger than a server-only request
success. It is not yet full convergence acceptance. The evidence does not
prove exact provider contents, second-device materialization, retention,
rebootstrap, revocation, a server-owned timeout or exact client-child to
server-request fingerprint equality. The parent operation join is proved.

The 35-second relaxation did not explain this run causally: the aggregate run
finished in roughly two seconds. It proves the new budget does not block the
path, but the historical five-second hypothesis remains neither required nor
disproved by this fast success.

### Reconciled conflict

The planned assay was described as an empty-queue ordinary-Sync control that
must not touch the failed/notApplied candidate. It was not empty in the
relevant sense.

Source inspection proves:

```text
HostedSyncCoordinator.run()
  → unconditional recoverFailedNotApplied()
  → upload pending events
  → download/apply
  → acknowledgement
```

The live transition `failed=2 → failed=0`, the recorded failed-recovery
phases and the correlated submission upload prove that ordinary Sync executed
the held recovery path. This was a legacy implicit recovery call, not the
automatic retry added by ERR-03. Nevertheless it violates the accepted
separation between ordinary Sync and explicitly confirmed controlled
failed/notApplied recovery.

The unchanged `Next Device sequence=3` is not a defect. The action replayed
existing events with allocated sequences 1–2; it did not create a new local
event. Sequence 3 remains the next allocation.

### PRC-01 claims

```text
Claim: the post-ERR-03 ordinary-Sync request lifecycle succeeded
Prior state: prepared/conditional; host-unvalidated
Evidence: client sync-completed terminal plus correlated Render upload,
          download and acknowledgement HTTP 200 terminals
Evidence boundary: one Windows client and request-level server logs;
                   no second-device/provider-content inspection
Contradiction: none within the request lifecycle
Semantic owner: C10-GCM02-S12-SYNC-01 hosted assay
Target role: J observational reconciliation
Resulting state: ACCEPTED WITH SINGLE-CLIENT/REQUEST BOUNDARY
History disposition: append; supersede HOST_UNVALIDATED for this path
```

```text
Claim: the assay was an empty-queue control and preserved the held recovery
Prior state: required assay condition
Evidence: failed count 2→0, failed-recovery phases, upload request and
          unconditional source call
Evidence boundary: client queue/source and paired server request
Contradiction: explicit assay/Gate 12.7 prohibition
Semantic owner: ordinary Sync versus controlled recovery command boundary
Target role: C10-GCM02-S12-ERR-04
Resulting state: REJECTED; SOURCE CORRECTION REQUIRED
History disposition: append; preserve the accidental live action as evidence
```

```text
Claim: unchanged Next Device sequence indicates Sync did not work
Prior state: human concern
Evidence: next sequence remained 3 while allocated sequences 1–2 were replayed
Evidence boundary: local allocator and queue projection
Contradiction: a Sync attempt is not a new event allocation
Semantic owner: Device sequence invariant
Target role: ERR-04 tests and J explanation
Resulting state: REJECTED; UNCHANGED VALUE IS EXPECTED
History disposition: append
```

```text
Claim: current client UI/terminal evidence is fully coherent
Prior state: ERR-03 locally validated declaration surface
Evidence: Flutter terminal silence; aggregate attempt displays
          status-not-observed/headers-not-received; newest phase can display
          provider-contact-not-started after proved provider contact
Evidence boundary: Windows screenshots and source projection
Contradiction: paired Render evidence proves three trusted request terminals
Semantic owner: client observability and aggregate/phase projection
Target role: C10-GCM02-S12-ERR-04
Resulting state: PARTIAL; CORRECTION REQUIRED
History disposition: append; do not misclassify as transport failure
```

```text
Claim: child correlation identity is exactly paired across client and server
Prior state: locally validated correlation lineage
Evidence: shared operation fingerprint is equal, but Render correlation uses
          the Fastify request ID while the client sends x-correlation-id
Evidence boundary: source inspection and supplied Render lifecycle fields
Contradiction: no supplied client child fingerprint equals a proved Render
               field by contract
Semantic owner: paired client/server observability
Target role: C10-GCM02-S12-ERR-04
Resulting state: PARENT JOIN PASSED; EXACT CHILD PAIRING INCOMPLETE
History disposition: append and correct field ownership
```

### Activated ERR-04 direction

D/E/F now authorize one narrow source unit:

```text
UNIT=C10-GCM02-S12-ERR-04

remove ordinary Sync → failed/notApplied recovery invocation
preserve explicit confirmed recovery entry point
preserve ordinary pending upload/download/acknowledgement
add sanitized injectable client-operation/client-phase terminal logging
preserve structured server-request Render logging
expose separate client-child and server-request fingerprints
distinguish aggregate from phase-local and child-request evidence
preserve five Sync terminals and 35000ms client deadline
no migration
no automatic retry
no live provider action
```

The unit must not erase the successful live evidence or reinterpret technical
success as Gate authorization. G/H/I must replace ERR-03 reports with ERR-04
materialization evidence while identifying ERR-03 as the source baseline.

### Subsequent actions

```text
Cycle 10
→ GCM-02
→ Step 12
→ Gate 12.7 pre-authorization
→ ERR-04 source materialization
→ local G/H/I validation
→ Main reconciliation
→ fresh Windows build from the reconciled remote commit
→ no-action diagnostics/terminal projection check
→ one readiness control only if deployment freshness requires it
→ one ordinary Sync no-recovery invariant assay
→ explicit Gate 12.7 decision packet
→ controlled recovery only if a new valid failed/notApplied candidate exists
→ Gate 12.8 provider/result reconciliation
→ Gate 12.9 second-device convergence proof
→ Gate 12.10 GCM-02 acceptance
→ define GCM-03/GCM-04 or close them explicitly
→ Cycle 10 closure
```

The next ordinary-Sync assay must begin with failed=0 and must prove that
ordinary Sync cannot consume failed work if a deterministic local test
fixture contains it. Do not create a live failed candidate solely to test the
boundary.

### Current terminal

```text
CYCLE10=OPEN
GCM02=OPEN_ACTIVE
STEP12=OPEN_ACTIVE
GATE_12_6=PASSED_IN_PRIOR_SCOPE
GATE_12_7=HELD
C10_GCM02_S12_ERR_03_SOURCE=ACCEPTED
READINESS_PROJECTION_ASSAY=PASS
ORDINARY_SYNC_CORRELATED_LIFECYCLE=PASS_SINGLE_CLIENT_REQUEST_SCOPE
UPLOAD_REQUEST=HTTP_200_AUTH_ACCEPTED
DOWNLOAD_REQUEST=HTTP_200_AUTH_ACCEPTED
ACKNOWLEDGEMENT_REQUEST=HTTP_200_AUTH_ACCEPTED
CLIENT_AGGREGATE_TERMINAL=SYNC_COMPLETED
CLIENT_SERVER_PARENT_OPERATION_CORRELATION=PASS
CLIENT_SERVER_EXACT_CHILD_CORRELATION=INCOMPLETE_SOURCE_CORRECTION_STAGED
CLIENT_SYNC_DEADLINE_35S=HOST_VALIDATED_NOT_STRESSED
HISTORICAL_FIVE_SECOND_CAUSAL_HYPOTHESIS=UNRESOLVED_NOT_REQUIRED_THIS_RUN
FAILED_NOT_APPLIED_COUNT=ZERO_AFTER_IMPLICIT_RECOVERY
NEXT_DEVICE_SEQUENCE_THREE=EXPECTED
EMPTY_QUEUE_CONTROL=NOT_PERFORMED
RECOVERY_AUTHORIZATION_BOUNDARY=FAILED
C10_GCM02_S12_ERR_04=ACTIVE_STAGED
CLIENT_TERMINAL_LOGGING=SOURCE_CORRECTION_STAGED
AGGREGATE_CHILD_PROJECTION=SOURCE_CORRECTION_STAGED
FURTHER_LIVE_ACTIONS=HELD
GATE_12_8=HELD
GATE_12_9=HELD
GATE_12_10=HELD
GCM03=UNDEFINED_INACTIVE
GCM04=UNDEFINED_INACTIVE
CYCLE10_CLOSURE=BLOCKED_BY_GCM02
```

## 2026-07-26 — ERR-04 materialization reconciliation

### Sequence envelope

```text
Sequence: FLX-PRM-04
Role: Main Chat [M]
Hierarchy: Cycle 10 → GCM-02 → Step 12 → Gate 12.7 pre-authorization
Reconciliation unit: C10-GCM02-S12-ERR-04
Branch: cycle10-intermid-grimoire
Staging parent: a5d198daff698a14ba932579dd867de716ed1038
Materialization commit: bb4e579612d36924e266872c351449bc0becc30f
Evidence: exact remote ten-file patch, replacement G/H/I and reported local
          validation
Writable surface: mutable J recovery prefix plus append-only Legacy_Progress
Disposition: SOURCE ACCEPTED; HOST-UNVALIDATED; GATE 12.7 HELD
```

### Repository and ancestry result

The remote branch is identical to
`bb4e579612d36924e266872c351449bc0becc30f`. The materialization is exactly
one fast-forward commit after
`a5d198daff698a14ba932579dd867de716ed1038`, with no divergence. Its patch
contains exactly ten files: five Flutter source/test paths, two API source/test
paths, and the three replacement G/H/I reports.

### Directive classification

| ERR-04 directive | Result | Evidence boundary |
| --- | --- | --- |
| Ordinary Sync must not invoke failed/notApplied recovery | IMPLEMENTED / TEST-VALIDATED | unconditional recovery phase and call removed; failed rows remain failed under ordinary Sync |
| Explicit confirmed failed/notApplied recovery remains separate | PRESERVED / TEST-VALIDATED | dedicated runner/coordinator entry point and bounded recovery tests remain |
| Genuine pending-event upload remains ordinary behavior | PRESERVED / TEST-VALIDATED | pending lease/upload path and focused test pass |
| Sanitized Flutter terminal lifecycle output | IMPLEMENTED / TEST-VALIDATED | injectable sink, one-line JSON, client-operation/client-phase scopes, redaction and sink-isolation tests |
| Aggregate versus child evidence wording | IMPLEMENTED / TEST-VALIDATED | aggregate HTTP/header values now point to child requests; misleading absent-contact projection removed |
| Client-child versus server-request correlation ownership | IMPLEMENTED / TEST-VALIDATED | independent Fastify request IDs plus separately named fingerprints |
| Five ordinary-Sync terminals and 35000 ms deadline | PRESERVED / TEST-VALIDATED | existing vocabulary retained; deadline emitted by client lifecycle |
| No automatic retry, migration or provider action | PRESERVED / REPORTED | no schema change and no live action in materialization |
| Replacement G/H/I reports | COMPLETE | G/H/I now describe ERR-04 rather than ERR-03 |

No staged ERR-04 requirement is classified absent. The compatibility-retained
`recoverFailedNotApplied` constructor field is not used by ordinary
`HostedSyncCoordinator.run()`; removing that unused compatibility surface is
optional later cleanup, not a Gate 12.7 blocker.

### PRC-01 claims

```text
Claim: ERR-04 repairs the ordinary-Sync versus controlled-recovery boundary
Prior state: confirmed live defect; correction staged
Evidence: exact source patch, focused file-backed tests and full Flutter suite
Evidence boundary: repository and local validation; no corrected hosted assay
Contradiction: none found
Semantic owner: C10-GCM02-S12-ERR-04
Target role: J current state and append-only reconciliation history
Resulting state: ACCEPTED, HOST-UNVALIDATED
History disposition: append; preserve the accidental pre-fix live action
```

```text
Claim: ERR-04 completes the requested observability correction
Prior state: aggregate/child projection and exact child pairing incomplete
Evidence: injectable client lifecycle JSON, scope-aware UI wording, independent
          server request identity and paired sanitized fingerprints
Evidence boundary: source and automated tests; fresh Flutter/Render capture absent
Contradiction: none found
Semantic owner: ERR-04 client/server observability contract
Target role: J current state
Resulting state: IMPLEMENTED AND LOCALLY VALIDATED; HOST-UNVALIDATED
History disposition: append
```

```text
Claim: Gate 12.7 may close solely because ERR-04 tests pass
Prior state: gate held after unauthorized implicit recovery
Evidence: strong local regression coverage but no corrected hosted revision assay
Evidence boundary: local source/test evidence only
Contradiction: Gate conclusion still requires the bounded post-deployment packet
Semantic owner: Gate 12.7 acceptance
Target role: subsequent Main reconciliation
Resulting state: REJECTED FOR NOW; GATE REMAINS HELD
History disposition: append
```

### Validation absorbed

```text
Flutter diagnostics test: 21 PASS
Focused Flutter sync/diagnostics set: 59 PASS
Full Flutter suite: 194 PASS / 4 lab-gated SKIP
Flutter analyze: PASS
Diagnostics generator/check: PASS
Changed TypeScript Prettier: PASS
API lint/typecheck/build: PASS
API protocol/full tests: 58 PASS
git diff --check: PASS
changed-content sensitive scan: PASS
live hosted/provider action: NOT PERFORMED
```

The repository-root diagnostics command is inapplicable because the root has no
`package.json`. The broad API formatting check remains obstructed only by the
pre-existing unrelated
`test/sync_diagnostics_registry.test.ts` warning; both changed TypeScript
files pass targeted formatting. Neither item invalidates the bounded ERR-04
materialization.

### Subsequent action hierarchy

```text
Cycle 10 — hosted synchronization and operational acceptance [OPEN]
└─ GCM-02 — exact hosted recovery/synchronization proof [ACTIVE]
   └─ Step 12 — Closure diagnosis and bounded hosted assays [ACTIVE]
      ├─ Gate 12.6 — preparation/readiness evidence [PASSED IN PRIOR SCOPE]
      ├─ Gate 12.7 — controlled recovery boundary [HELD]
      │  ├─ ERR-04 source materialization [ACCEPTED, HOST-UNVALIDATED]
      │  ├─ exact corrected Windows revision/build [NEXT]
      │  ├─ exact corrected Render revision/deployment [NEXT]
      │  ├─ readiness projection control [PENDING]
      │  ├─ ordinary Sync no-recovery control [PENDING]
      │  └─ explicit Gate 12.7 conclusion packet [PENDING]
      ├─ Gate 12.8 — provider/result reconciliation [HELD]
      ├─ Gate 12.9 — second-device convergence proof [HELD]
      └─ Gate 12.10 — GCM-02 terminal acceptance [HELD]

Cycle 10 → GCM-03 [UNDEFINED / INACTIVE]
Cycle 10 → GCM-04 [UNDEFINED / INACTIVE]
Cycle 10 closure [BLOCKED BY GCM-02]
```

### Controlled acceptance order

1. Pull the reconciled branch by fast-forward and record the exact SHA.
2. Build/run the Windows client from that exact lineage; do not reuse an older
   binary.
3. Deploy Render from the same lineage because the API logging contract changed.
4. Record client SHA, deployed Render SHA, deployment-live UTC and clean initial
   queue/diagnostic state.
5. Perform one readiness control. Confirm readiness does not advance Last
   successful Sync or mutate the queue.
6. Perform one ordinary Sync control. Capture the UI terminal, Flutter JSON
   lifecycle lines and matching Render lifecycle lines.
7. Confirm ordinary Sync contains no failed-recovery phase and that
   client-child fingerprints pair with the corresponding server declarations.
8. Do not create a new failed candidate solely to demonstrate the fix; the local
   deterministic tests own that invariant.
9. Reconcile the resulting packet and issue the explicit Gate 12.7 decision.
10. Only after that decision proceed to Gate 12.8 provider-state reconciliation
    and Gate 12.9 second-device convergence.

No Retry, failed/notApplied recovery, diagnostic-history clearing, migration,
Auth0 mutation, Neon mutation or production action is authorized by this entry.

### Current terminal

```text
CYCLE10=OPEN
GCM02=OPEN_ACTIVE
STEP12=OPEN_ACTIVE
GATE_12_6=PASSED_IN_PRIOR_SCOPE
GATE_12_7=HELD
C10_GCM02_S12_ERR_04_SOURCE=ACCEPTED_HOST_UNVALIDATED
ERR_04_REMOTE_SHA=bb4e579612d36924e266872c351449bc0becc30f
ERR_04_EXACT_TEN_FILE_PATCH=VERIFIED
ORDINARY_SYNC_IMPLICIT_RECOVERY=REMOVED_LOCALLY_VALIDATED
EXPLICIT_RECOVERY_ENTRYPOINT=PRESERVED_LOCALLY_VALIDATED
ORDINARY_PENDING_UPLOAD=PRESERVED_LOCALLY_VALIDATED
CLIENT_TERMINAL_LIFECYCLE_LOGS=IMPLEMENTED_LOCALLY_VALIDATED
AGGREGATE_CHILD_PROJECTION=CORRECTED_LOCALLY_VALIDATED
CLIENT_SERVER_CHILD_PAIRING=IMPLEMENTED_LOCALLY_VALIDATED
CLIENT_SYNC_DEADLINE_35S=PRESERVED
NO_SCHEMA_MIGRATION=PASS
LIVE_CORRECTED_REVISION_ASSAY=NOT_PERFORMED
CORRECTED_WINDOWS_REVISION=NEXT
CORRECTED_RENDER_DEPLOYMENT=NEXT
READINESS_CONTROL=PENDING
ORDINARY_SYNC_NO_RECOVERY_CONTROL=PENDING
GATE_12_8=HELD
GATE_12_9=HELD
GATE_12_10=HELD
GCM03=UNDEFINED_INACTIVE
GCM04=UNDEFINED_INACTIVE
CYCLE10_CLOSURE=BLOCKED_BY_GCM02
```

## 2026-07-26 — Gate 12.7 conclusion and DIAG-01 activation

### Sequence envelope

```text
Sequence: FLX-PRM-04 → FLX-ORD-01
Role: Main Chat [M]
Hierarchy: Cycle 10 → GCM-02 → Step 12 → Gate 12.7 conclusion
Next gate: Gate 12.8 read-only provider/result reconciliation
Materialization unit: C10-GCM02-S12-DIAG-01
Branch: cycle10-intermid-grimoire
Inspected HEAD: cf405347b6fdc58bf0da698a1f07028e05ccd471
Evidence: ERR-04 source/G/H/I; sanitized client screenshots;
          REC_DIAGNOSTICS.md Records 004–006
Writable surface: mutable J prefix, append-only Legacy_Progress, D/E/F
Disposition: GATE 12.7 PASS AT CORRECTED SINGLE-CLIENT CONTROL SCOPE;
             DIAG-01 ACTIVE; GATE 12.8 NEXT READ-ONLY
```

### Assay reconciliation

The corrected client packet establishes:

| Control or invariant | Result | Evidence boundary |
| --- | --- | --- |
| warm `Check hosted connection` | PASS | second warm attempt reached `hosted-connection-ready`, HTTP 200, headers received, response parsed, `<1s` |
| cold readiness tolerance | OPEN | first attempt timed out before a trusted response; no exact Render correlation supplied |
| ordinary Sync | PASS | one `sync-completed` client operation |
| implicit failed/notApplied recovery | ABSENT IN NEWEST OPERATION | no `failed-recovery` phase under operation `d723c1f392f3` |
| queue invariant | PASS | `0 pending / 0 uploading / 0 failed / 0 unknown` before and after |
| Next Device sequence | PASS | remained `3` because no new local Device event was allocated |
| Last successful Sync | PASS | unchanged by diagnostics/readiness; advanced only by ordinary Sync |
| 35000 ms client deadline | PRESERVED | displayed by corrected client projection |
| provider-row state | UNPROVED | belongs to Gate 12.8/12.9 evidence |
| complete client-child/Render pairing | UNPROVED IN SCREENSHOT PACKET | carry to read-only result reconciliation |
| second-Device convergence | UNPROVED | later gate; not Gate 12.7 |

### PRC-01 classifications

```text
Claim: Gate 12.7 corrected single-client control may close
Source: ERR-04 implementation/test evidence plus corrected Windows controls
Current state: host-unvalidated before the assay
Evidence: warm readiness terminal; one ordinary sync-completed terminal;
          unchanged empty queue and Next Device sequence; advanced
          Last successful Sync; no recovery phase in newest operation
Evidence boundary: single Windows client and client-visible hosted control;
                   no direct provider rows or second Device
Contradictions: cold-start tolerance remains unresolved; full Render child
                correlation not supplied
Semantic owner: Main GCM-02 Gate 12.7
Target role: J current recovery state and append-only Legacy_Progress
History disposition: append; preserve prior held/defect entries
Confidence: sufficient for revised Gate 12.7 single-client control boundary
Human/Main authority: user requested conclusion and transition assessment
Required regeneration: mutable J prefix and synchronized D/E/F
Result: GATE 12.7 PASSED; bounded exclusions carried forward
```

```text
Claim: the 13 displayed entries are 13 Sync errors
Source: flat Recent diagnostic timeline presentation
Current state: user-observed anomaly
Evidence: all rows share the newest operation fingerprint, follow ordered
          causal phases, contain paired pre-result/result declarations and end
          in sync-completed; no failed-recovery phase occurs
Evidence boundary: sanitized client screenshot packet and current source
Contradictions: older preserved operations contain recovery rows but own a
                different parent fingerprint
Semantic owner: Closure diagnostic projection
Target role: DIAG-01 UI correction
History disposition: append; do not erase valid lifecycle rows
Confidence: high
Human/Main authority: explicit request to correct the presentation
Required regeneration: D/E/F and later G/H/I
Result: REJECTED AS FAILURE COUNT; ACCEPTED AS PRESENTATION DEFECT
```

```text
Claim: Next Device sequence should advance when Sync succeeds
Source: unchanged displayed value `3`
Current state: suspected defect
Evidence: queue empty; no new local event created; sequence is a local event
          allocator rather than an action/request counter
Evidence boundary: client state plus accepted sequence invariant
Contradictions: none
Semantic owner: local Device event allocation
Target role: preserved invariant and concise UI guidance
History disposition: append
Confidence: high
Human/Main authority: Main reconciliation
Required regeneration: DIAG-01 tests/projection only
Result: REJECTED; value `3` is correct
```

### DIAG-01 accepted implementation direction

Main activates synchronized D/E/F for:

```text
UNIT=C10-GCM02-S12-DIAG-01
TOP_LEVEL_CONTROLS=status + query + refresh diagnostics
REPLACEMENT_CONTROL=Diagnostics
DEFAULT_TIMELINE=operation-grouped compact phase summaries
RAW_TIMELINE=preserved under expandable technical view
READINESS=separate
ORDINARY_SYNC=separate
RETRY_AND_RECOVERY=separate
SCHEMA_CHANGE=NO
API_CHANGE=NO
PROVIDER_ACTION=NO
LIVE_ASSAY=NO
```

The consolidated Diagnostics action must preserve distinct authentication,
enrollment/binding and local-snapshot subcheck results. Consolidation is a
presentation/orchestration decision, not permission to collapse their meanings
or to add a provider request.

### Gate 12.8 transition

Gate 12.8 may now open as the next read-only evidence gate:

1. freeze the accepted Gate 12.7 client packet and exact branch lineage;
2. correlate any already available sanitized Render lifecycle lines without
   issuing a new client action;
3. run only the separately approved read-only provider/result comparison;
4. compare allowlisted counts, cursor/sequence/acknowledgement and lifecycle
   state;
5. preserve unknown or contradictory results without a second action;
6. do not use Sync, Retry, failed/notApplied recovery, Enroll, migration,
   provider-console mutation, or database editing.

DIAG-01 source materialization may proceed before the Gate 12.8 provider read.
It does not itself execute Gate 12.8 and must not alter the frozen assay
evidence.

### Next operational order

```text
1. publish J + D/E/F staging
2. seed Codex on exact staging SHA
3. Codex materializes DIAG-01 and replaces G/H/I
4. Main reconciles the exact patch and validation
5. preserve Gate 12.7 as passed; do not rerun it merely for UI presentation
6. prepare the exact read-only Gate 12.8 evidence packet
7. obtain explicit authorization for any connector/provider read that needs it
8. collect and reconcile Gate 12.8 without a second Sync/Retry/recovery action
```

### Current terminal

```text
CYCLE10=OPEN
GCM02=OPEN_ACTIVE
STEP12=OPEN_ACTIVE
GATE_12_6=PASSED_IN_PRIOR_SCOPE
GATE_12_7=PASSED_CORRECTED_SINGLE_CLIENT_CONTROL_SCOPE
WARM_HOSTED_READINESS=PASS
COLD_START_READINESS_TOLERANCE=OPEN
CORRECTED_ORDINARY_SYNC=PASS
NEWEST_OPERATION_IMPLICIT_RECOVERY=ABSENT
QUEUE_INVARIANT=PASS
NEXT_DEVICE_SEQUENCE_INVARIANT=PASS
LAST_SUCCESSFUL_SYNC_INVARIANT=PASS
THIRTEEN_ROWS=ORDERED_LIFECYCLE_NOT_THIRTEEN_ERRORS
DIAG_01=ACTIVE_CODEX_AUTHORIZED
DIAGNOSTICS_TOP_LEVEL_CONTROL=CONSOLIDATE_STATUS_QUERY_REFRESH
READINESS_AND_SYNC=REMAIN_SEPARATE
GATE_12_8=NEXT_READ_ONLY_PROVIDER_RESULT_RECONCILIATION
GATE_12_9=HELD
GATE_12_10=HELD
GCM03=UNDEFINED_INACTIVE
GCM04=UNDEFINED_INACTIVE
CYCLE10_CLOSURE=BLOCKED_BY_GCM02
```
## 2026-07-28 — C10-GCM02-S12-ST08 exact-binding/provider reconciliation

### Sequence envelope

```text
Sequence: FLX-PRM-04
Role: Main Chat [M]
Round or unit: C10-GCM02-S12-ST08
Branch: grm-guarded-provisioning-20260727
Inspected baseline: 3cbc6d526a7a92da5306326acb9e809dbe13f3fa
Question: Does the genuinely enrolled replacement-provider Device have an
          exact hosted identity binding and one coherent read-only pre-Sync
          provider baseline?
Inputs: GRM-AUTH-02 sanitized terminal; GRM-NEON-08 inventory observations;
        GRM-NEON-11 sanitized terminal; REC_DIAGNOSTICS Records 007–009;
        targeted GRIMOIRE and provider-baseline source inspection
Writable surfaces: REC_DIAGNOSTICS append; mutable J prefix; append-only
                   Legacy_Progress
Prohibited surfaces/actions: source, D/E/F, permanent domains, methodology,
                            Sync, Retry, recovery, Enroll, migration, provider
                            mutation, second Device, production
Authority: explicit human-directed ST08 reconciliation
Next sequence: C10-GCM02-S12-ST09 preparation
Stop condition: no mutating action before a fresh local preflight, exact delta
                contract, and explicit one-action authorization
```

### Reconstructed incident and correction boundary

The first attempted ST08 evidence packet contained a stale local enrollment
projection. `GRM-AUTH-02` reached the hosted Device-status route but returned
HTTP 403, and `GRM-NEON-11` failed its exact-device guard for the entered UUIDs.
`GRM-NEON-08` then returned no Device rows, proving that the replacement
provider had no enrolled Device at that time.

The client subsequently completed one genuine enrollment after a successful
hosted-connection check. `GRM-NEON-08` then returned exactly one active Device
with `next_expected_sequence=1`. The required restart and post-restart sign-in
were completed. The full Device UUID and fresh access token remained local and
were used only through masked prompts.

This entry does not erase the stale-binding attempts. They remain useful
observational history explaining why the final evidence required exact hosted
and provider corroboration rather than accepting the UI projection alone.

### GRIMOIRE improvements materialized and exercised during ST08

The five-file GRIMOIRE system improved materially during this phase:

| Improvement | GRIMOIRE ownership | ST08 effect |
| --- | --- | --- |
| Guarded branch handoff and exact clean-remote alignment | `GRM.md` index plus `G_SCRIPTS.md`/`I_SCRIPTS.ps1` Git procedures | Prevented provider work from an unproved or stale branch lineage |
| Reusable Windows debug preparation and named VS Code launch path | `GRM-FLUTTER-DEBUG` and generated debug configuration | Made the persisted Device binding and fresh access token observable in one controlled run without adding a credential-export path |
| Guarded development Account/membership provisioning | `GRM-AUTH-03`, `DBM-AUTO-12`, coordinates and launcher dispatch | Reconstructed the replacement-provider owner fixture only after hosted token verification and exact confirmation |
| Cryptographic hosted token verification tightening | `GRM-AUTH-03` source correction | Prevented provisioning from relying on an unverified decoded subject |
| Exact hosted identity/Device verification | `GRM-AUTH-02` | Distinguished token acceptance from exact enrolled-Device authorization and exposed stale UUIDs through the hosted 403 boundary |
| Optional JWT `nbf` compatibility correction under PowerShell StrictMode | `G_SCRIPTS.md` `GS-AUTH-02` | Accepted legitimate tokens with no optional `nbf` while retaining fail-closed expiry and malformed-claim handling |
| Sanitized Device inventory | `GRM-NEON-08` / `DBM-AUTO-07` | Proved first that no provider Device existed, then that one active Device existed after genuine enrollment, without printing UUIDs |
| Atomic exact-Device provider snapshot | `GRM-NEON-11` / `DBM-AUTO-09` | Added a single repeatable read-only snapshot for six-table counts, cursor integrity, sequence/high-water consistency and sanitized replay fingerprints |
| Fail-closed exact Device guard | `DBM-AUTO-09` | Prevented a zero-match UUID from producing a misleading provider-baseline PASS |
| Sanitized non-secret coordinate refresh | `NS_COORDINATES.md` | Aligned development branch/database/host routing while keeping credentials and complete identifiers outside Git |

These are materialized interface and evidence improvements. Their successful
use in ST08 does not promote every GRIMOIRE procedure to production
acceptance. `GRM-AUTH-03` remains a guarded development bridge;
`GRM-NEON-11` proves read-only execution and returned values only; and the
launcher still cannot independently prove the human-readable Neon branch alias.

### Accepted sanitized evidence

`GRM-AUTH-02` returned:

```text
IssuerMatches=True
AudienceMatches=True
AlgorithmMatches=True
SubjectPresent=True
TimeWindowValid=True
IdentityStatus=200
DeviceStatus=200
TokenAccepted=True
ExactDeviceBinding=True
BindingClass=exact-binding-confirmed
```

`GRM-NEON-11` returned one internally consistent snapshot:

```text
exact Device matches/guard: 1/1
global Account/Device/cursor: 1/1/1
global submissions/events/acknowledgements: 0/0/0
missing/orphan cursor rows: 0/0
fixture Account/Device/cursor: 1/1/1
fixture submissions/events/acknowledgements: 0/0/0
fixture Device: active, next expected sequence 1
Account cursor/high-water: 1/0, consistent
Device next/high-water: 1/0, consistent
submission/request fingerprints: none
event/content fingerprints: none
transaction terminal: ROLLBACK
launcher terminal: PASS
```

No token, subject, Account identifier, Device UUID, password, connection
string, payload, full request hash or full content hash was recorded.

### PRC-01 claims

```text
Claim: the authenticated identity is exactly authorized for the genuinely
       enrolled replacement-provider Device
Source: GRM-AUTH-02 sanitized terminal
Current state: open after stale UUID/HTTP 403 attempts
Evidence: hosted identity 200; hosted exact Device-status 200;
          ExactDeviceBinding true; exact-binding-confirmed
Evidence boundary: one fresh token and one exact Device on the development host
Contradictions: none in the final packet; earlier 403s belong to stale UUIDs
Semantic owner: ST08 hosted identity/Device binding
Target role: J staging plus REC_DIAGNOSTICS observational evidence
History disposition: append; preserve failed stale-binding attempts
Confidence: high
Human/Main authority: explicit ST08 reconciliation request
Required regeneration: J mutable prefix
Result: ACCEPTED / PASS
```

```text
Claim: the replacement provider is coherent before its first authorized Sync
Source: GRM-NEON-11 sanitized repeatable read-only snapshot
Current state: open after genuine enrollment
Evidence: exact Device guard; 1/1/1 structural rows; zero payload rows; no
          cursor defects; both next-after-high-water invariants true;
          ROLLBACK and PASS
Evidence boundary: one development database snapshot; launcher cannot
                   independently prove the Neon branch alias
Contradictions: none within the replacement-provider snapshot
Semantic owner: ST08 provider baseline
Target role: J staging plus REC_DIAGNOSTICS observational evidence
History disposition: append
Confidence: high
Human/Main authority: explicit ST08 reconciliation request
Required regeneration: J mutable prefix
Result: ACCEPTED / PASS
```

```text
Claim: the earlier client historical sync-completed terminal is corroborated
       by the replacement provider
Source: Record 008 client history compared with Record 009 provider snapshot
Current state: candidate cross-time inference
Evidence: provider has zero submissions, events and acknowledgements
Evidence boundary: client history and replacement-provider baseline belong to
                   different provider lifetimes
Contradictions: no corresponding provider result exists
Semantic owner: cross-provider evidence provenance
Target role: ST08 evidence ceiling and ST09 clean-baseline contract
History disposition: preserve both records with their original boundaries
Confidence: high
Human/Main authority: Main reconciliation
Required regeneration: none beyond J/REC classification
Result: REJECTED AS CORROBORATION; NOT A PROVIDER INVARIANT FAILURE
```

```text
Claim: ST08 authorizes one ordinary Sync
Source: completion of read-only exact-binding/provider checks
Current state: proposed transition
Evidence: preconditions are stronger, but current local queue/device state and
          expected provider delta are not yet frozen
Evidence boundary: no ST09 preflight or authorization packet exists
Contradictions: explicit stop-before-Sync contract
Semantic owner: human/Main action authorization
Target role: future ST09 authorization packet
History disposition: append
Confidence: high
Human/Main authority: not yet granted
Required regeneration: ST09 preflight and exact transition contract
Result: REJECTED FOR NOW; PREPARATION ONLY
```

### ST08 conclusion

ST08 passes at the narrow read-only boundary it was designed to establish:

```text
EXACT_HOSTED_BINDING=PASS
ATOMIC_PROVIDER_BASELINE=PASS
REPLACEMENT_PROVIDER_STRUCTURE=PASS
ACCOUNT_CURSOR_BASELINE=PASS
DEVICE_SEQUENCE_BASELINE=PASS
PROVIDER_PAYLOAD_BASELINE=EMPTY
READ_ONLY_ROLLBACK=PASS
PRIOR_CLIENT_HISTORY_SAME_PROVIDER_CORRELATION=UNPROVED
ST08=PASSED_BOUNDED
```

The absence of provider payload rows is expected for this newly reconstructed
and newly enrolled provider. It is not evidence that a Sync on this provider
has failed, because none has yet been authorized.

### C10-GCM02-S12-ST09 broad view

ST09 should establish the first correlated same-Device transition on the clean
replacement provider. It begins as investigation and preparation, not
execution authority.

Required evidence spine:

```text
fresh local sanitized preflight
↓
exact expected member/sequence/cursor delta
↓
one-action authorization packet
↓
explicit human authorization
↓
ordinary Sync exactly once
↓
client + Render terminal capture
↓
read-only GRM-NEON-11 postflight
↓
before/after reconciliation
```

Expected ST09 outcomes must be calculated only after the local preflight. In
particular, no entry should assume that the earlier screenshot-reported pending
count, local Device ranks, or next sequence still describes the client at the
moment of authorization.

ST09 success would require:

- the one authorized client action reaches one accepted terminal;
- no implicit failed/notApplied recovery occurs;
- the queue transition matches the frozen local member set;
- provider submission/event counts and replay fingerprints match that member
  set;
- Device next expected sequence equals the accepted Device high-water plus one;
- Account next cursor equals hosted high-water plus one;
- acknowledgement state matches the client terminal and protocol contract;
- the postflight ends in `ROLLBACK` and launcher `PASS`;
- no second click or alternative action is used to repair ambiguous evidence.

ST09 does not include second-Device convergence, production deployment,
retention/rebootstrap acceptance, provider cleanup, credential rotation, or
Cycle 11 UI/Analytics work.

### Current terminal

```text
CYCLE10=OPEN
GCM02=OPEN_ACTIVE
STEP12=OPEN_ACTIVE
GATE_12_7=PASSED_CORRECTED_SINGLE_CLIENT_CONTROL_SCOPE
DIAG_01=PASS_WINDOWS_CLIENT_UI_SCOPE
ST08_EXACT_BINDING=PASS
ST08_PROVIDER_BASELINE=PASS
ST08=PASSED_BOUNDED
ST09=NEXT_PREPARATION_ONLY
ST09_LOCAL_PREFLIGHT=PASS_EMPTY_QUEUE
ST09_TEST_EVENT_CREATION=NEXT_PREPARATION
ST09_EXPECTED_DELTA=PENDING
ST09_AUTHORIZATION_PACKET=PENDING
ST09_MUTATING_ACTION=NOT_AUTHORIZED
RETRY_OR_RECOVERY=NOT_AUTHORIZED
ENROLLMENT_OR_MIGRATION=NOT_AUTHORIZED
SECOND_DEVICE=NOT_AUTHORIZED
GCM03=UNDEFINED_INACTIVE
GCM04=UNDEFINED_INACTIVE
CYCLE10_CLOSURE=BLOCKED_BY_REMAINING_GCM02_TRANSITION_AND_LATER_UNITS
```

## 2026-07-28 — C10-GCM02-S12-ST09 same-Device transition reconciliation

### Sequence envelope

```text
Sequence: FLX-PRM-04
Role: Main Chat [M]
Round or unit: C10-GCM02-S12-ST09
Branch: grm-guarded-provisioning-20260727
Inspected baseline: f54b9872daf37c26b33778a36f26f733c834401d
Question: Did one explicitly authorized Windows ordinary Sync materialize the
          exact frozen one-event transition on the replacement development
          provider without local residue or cursor/sequence contradiction?
Inputs: REC_DIAGNOSTICS Records 009-011; user-supplied Windows preflight and
        post-Sync screenshots; GRM-HOST-01 sanitized health terminal;
        GRM-NEON-11 sanitized provider postflight
Writable surfaces: REC_DIAGNOSTICS append; mutable J prefix; append-only
                   Legacy_Progress
Prohibited actions: second Sync, Retry, recovery, Enroll, migration,
                    provider mutation, Android/second Device, production claim
Authority: explicit human-directed ST09 reconciliation
Next sequence: C10-GCM02-S12-ST10 read-only server correlation and terminal
               GCM02 classification
```

### Reconstructed assay sequence

Record 010 froze a post-restart Windows state with one authenticated, enrolled
Device, an empty local queue and next Device sequence 1. One controlled test
purchase was then prepared. During that preparation, the Product page exposed
two contained local defects:

- Product lookup could rebuild the dropdown around a distinct Product object
  and trigger Flutter's exactly-one-matching-item assertion;
- one staged new-product reference could reach `resolveProduct` with an empty
  required code, after which the purchase transaction rolled back without
  creating a purchase or Sync event.

The tester recovered through the existing-Product path and produced exactly one
pending `purchase.registered` event at Device sequence 1. The queue was frozen
at pending/uploading/failed/unknown `1/0/0/0`, with next sequence 2.

The first hosted-connection check timed out before response during a cold
Render start. `GRM-HOST-01` then returned live/ready HTTP 200, and the immediate
client readiness check returned `hosted-connection-ready` in under three
seconds. Main authorized exactly one ordinary Sync. No retry or alternative
action was authorized.

The Windows client reached `sync-completed`, drained the queue to `0/0/0/0`,
retained next sequence 2, and displayed no actionable events. The newest
lifecycle projection included accepted authentication/binding, upload lease,
upload request, server acceptance, persisted upload result, download response
and local application, acknowledgement, and terminal client success.

The subsequent `GRM-NEON-11` postflight independently returned exactly one
submission, one Sync event and one acknowledgement; Account cursor 2 after
high-water 1; Device next expected sequence 2 after high-water 1; both
consistency booleans true; one distinct sanitized replay lineage; `ROLLBACK`;
and launcher `PASS`.

### PRC-01 claims

```text
Claim: ST09 executed the exact authorized one-event same-Device transition
Prior state: prepared and held after Record 010
Evidence: one purchase.registered at Device sequence 1; exactly one ordinary
          Sync; client sync-completed; queue 1 -> 0; provider 0/0/0 -> 1/1/1
Evidence boundary: one Windows Device and one development provider lifetime
Contradiction: none across client/local/provider evidence
Semantic owner: C10-GCM02-S12-ST09 transition assay
Target role: REC_DIAGNOSTICS observational record and J current recovery state
Resulting state: ACCEPTED / PASS
History disposition: append
```

```text
Claim: cursor, sequence and acknowledgement state equal the frozen contract
Prior state: provider cursor/sequence 1 after high-water 0; no acknowledgement
Evidence: Account 2 after 1 consistent; Device 2 after 1 consistent;
          acknowledgement count 1; local next sequence 2
Evidence boundary: sanitized GRM-NEON-11 values plus Windows UI projection
Contradiction: none
Semantic owner: ST09 provider comparison
Target role: J current recovery state
Resulting state: ACCEPTED / PASS
History disposition: append
```

```text
Claim: the first cold hosted-connection timeout invalidates ST09
Prior state: transport outcome unknown before readiness refresh
Evidence: subsequent live/ready HTTP 200; client hosted readiness HTTP 200
          before authorization; successful Sync and exact provider delta
Evidence boundary: development Render cold-start behavior
Contradiction: no later failure at the same operation boundary
Semantic owner: operational readiness evidence
Target role: future operational promotion candidate
Resulting state: REJECTED AS ST09 FAILURE; RETAINED AS COLD-START SENSITIVITY
History disposition: append
```

```text
Claim: the Product-page defects or pre-auth local capture invalidate Sync
Prior state: incidental member-preparation observations
Evidence: failed resolution rolled back before event creation; later existing-
          Product path created exactly one controlled member; provider delta
          matches that member exactly
Evidence boundary: local Windows workflow; no Cycle 11 account-boundary
                   decision has been made
Contradiction: none to the successful Sync transition
Semantic owner: future UI/account-boundary investigation
Target role: Cycle 11 candidate backlog after Cycle 10 closure
Resulting state: DEFERRED NON-BLOCKING OBSERVATIONS
History disposition: append; do not silently convert offline-first capture
                     into an authentication requirement
```

```text
Claim: GCM02 is fully closed by ST09
Prior state: GCM02 requires trustworthy client, server and provider terminal
Evidence: client and provider evidence agree; matching sanitized Render request
          lifecycle has not yet been captured into the durable packet
Evidence boundary: server correlation remains missing, not contradicted
Contradiction: controlling Gate-12.10 contract requires server lifecycle
Semantic owner: C10-GCM02 terminal reconciliation
Target role: C10-GCM02-S12-ST10
Resulting state: NOT YET; ONE READ-ONLY TERMINAL STEP REMAINS
History disposition: append
```

### ST09 conclusion

```text
ST09_CONTROLLED_MEMBER=ONE_PURCHASE_REGISTERED_SEQUENCE_1
ST09_AUTHORIZATION=EXACTLY_ONE_ORDINARY_SYNC
ST09_CLIENT_TERMINAL=SYNC_COMPLETED
ST09_LOCAL_QUEUE=PASS_1_TO_0
ST09_PROVIDER_DELTA=PASS_0_0_0_TO_1_1_1
ST09_ACCOUNT_CURSOR=PASS_1_AFTER_0_TO_2_AFTER_1
ST09_DEVICE_SEQUENCE=PASS_1_AFTER_0_TO_2_AFTER_1
ST09_ACKNOWLEDGEMENT=PASS_0_TO_1
ST09_POSTFLIGHT=ROLLBACK_PASS
ST09=PASSED_BOUNDED
```

### ST10 and GCM02 closure boundary

ST10 does not rerun the assay. It inspects the already existing Render logs
around `2026-07-28T20:25:55Z`, searches for only the sanitized operation
fingerprint `d1cb6cb600a1` or client child-correlation fingerprint
`6a53d7090d68`, and records:

- request ingress and HTTP terminal;
- authenticated Account/Device authorization result;
- provider transaction/application result;
- response/acknowledgement lifecycle;
- absence or presence of exception, rejected/notApplied, duplicate-equivalent,
  timeout or unknown classification.

If those logs corroborate the client/provider packet, Gate 12.10 may classify
the transition as expected success and GCM02 may close. If the matching logs
are unavailable, contradictory, ambiguous or secret-bearing, stop without
another Sync and retain GCM02 as evidence-blocked.

Android enrollment and bounded inter-device download/convergence begin only
after this classification, under GCM03.

### Current terminal

```text
CYCLE10=OPEN
GCM02=OPEN_ONE_READ_ONLY_TERMINAL_STEP
ST08=PASSED_BOUNDED
ST09=PASSED_BOUNDED
ST10=NEXT_READ_ONLY_SERVER_CORRELATION_AND_GATE_12_10_CLASSIFICATION
NEW_SYNC_OR_RETRY=NOT_AUTHORIZED
SECOND_DEVICE=HELD_FOR_GCM03
GCM03=DEFINED_PROVISIONALLY_NOT_ACTIVE
GCM04=UNDEFINED_INACTIVE
```

## 2026-07-28 — C10-GCM02-S12-ST10 Render correlation and terminal closure

### Sequence envelope

```text
Sequence: FLX-PRM-04
Role: Main Chat [M]
Round or unit: C10-GCM02-S12-ST10
Branch: grm-guarded-provisioning-20260727
Inspected baseline: f54b9872daf37c26b33778a36f26f733c834401d
Question: Do the sanitized Render logs correlate the already accepted ST09
          client/provider transition to authenticated HTTP success terminals
          for upload, download and acknowledgement?
Inputs: REC_DIAGNOSTICS Records 009-012; user-supplied Render JSON interval;
        ST09 Windows terminal; GRM-NEON-11 provider postflight
Writable surfaces: REC_DIAGNOSTICS append; mutable J prefix; append-only
                   Legacy_Progress
Prohibited actions: new Sync, Retry, recovery, Enroll, migration, provider
                    mutation, Android/second Device, production claim
Authority: explicit human-directed ST10 evidence submission and reconciliation
Next sequence: GCM03 definition and read-only two-Device preflight
```

### Correlated server sequence

The sanitized Render interval contains three children with the same ST09
operation fingerprint:

```text
upload-submission
  POST /v1/sync/submissions
  request received
  validation started
  authentication accepted
  response completed / HTTP 200 / request-completed

download-events
  GET /v1/sync/events
  request received
  validation started
  authentication accepted
  response completed / HTTP 200 / request-completed

acknowledgement
  POST /v1/sync/acknowledgements
  request received
  validation started
  authentication accepted
  response completed / HTTP 200 / request-completed
```

No matching request is rejected, failed, ambiguous, timed out, classified
`notApplied`, completed with HTTP status `>=400`, or assigned an `MKS-*`
server result. The final unrelated readiness request is cut off by the supplied
log interval after ingress/validation; it is not part of the Sync operation and
does not contradict the three completed children.

### PRC-01 claims

```text
Claim: ST10 correlates the accepted ST09 operation across the Render boundary
Prior state: client and provider transition passed; server lifecycle pending
Evidence: one matching operation fingerprint on upload, download and
          acknowledgement; each child has ingress, validation, accepted
          authentication and HTTP 200 request-completed terminal
Evidence boundary: sanitized Render interval for one development Sync
Contradiction: none
Semantic owner: C10-GCM02-S12-ST10 server correlation
Target role: REC_DIAGNOSTICS observational record and J current recovery state
Resulting state: ACCEPTED / PASS
History disposition: append
```

```text
Claim: Gate 12.10 may classify the ST09 transition as expected success
Prior state: held for matching server lifecycle
Evidence: client sync-completed and queue drained; all three server children
          authenticated and completed HTTP 200; provider changed exactly
          0/0/0 -> 1/1/1 with consistent cursor/sequence and ROLLBACK postflight
Evidence boundary: one Account, one Windows Device, development provider
Contradiction: none
Semantic owner: Gate 12.10 terminal classification
Target role: J current recovery state
Resulting state: ACCEPTED / PASS EXPECTED SUCCESS
History disposition: append
```

```text
Claim: GCM02 closes
Prior state: open for one read-only terminal step
Evidence: exact binding and clean baseline passed in ST08; controlled
          same-Device transition passed in ST09; matching three-child server
          lifecycle passed in ST10
Evidence boundary: hosted authenticated same-Device development scope;
                   excludes second Device and production readiness
Contradiction: none
Semantic owner: C10 GCM02 closure
Target role: J current recovery state and later permanent-domain promotion
Resulting state: ACCEPTED / CLOSED BOUNDED
History disposition: append
```

```text
Claim: the newly reported unsynchronized purchase is already a controlled
       GCM03 member
Prior state: human observation after ST09 closure
Evidence: report that one purchase exists and has not been synchronized
Evidence boundary: no fresh Diagnostics member/sequence snapshot yet
Contradiction: none, but queue identity and sequence are unproved
Semantic owner: future GCM03 preflight
Target role: GCM03 candidate member set
Resulting state: PROVISIONAL; PRESERVE WITHOUT SYNC
History disposition: append
```

### ST10 and GCM02 conclusion

```text
ST10_OPERATION_CORRELATION=PASS
ST10_UPLOAD_SUBMISSION=AUTHENTICATED_HTTP_200_REQUEST_COMPLETED
ST10_DOWNLOAD_EVENTS=AUTHENTICATED_HTTP_200_REQUEST_COMPLETED
ST10_ACKNOWLEDGEMENT=AUTHENTICATED_HTTP_200_REQUEST_COMPLETED
ST10_FAILURE_OR_AMBIGUITY=ABSENT
ST10=PASSED_READ_ONLY
GATE_12_10=PASS_EXPECTED_SUCCESS
STEP12=CLOSED_THROUGH_GATE_12_10
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
```

### Next boundary

GCM03 may now be defined around Android enrollment and bounded inter-device
convergence. Its first action remains read-only: freeze the new Windows pending
member and inspect the Android client/device baseline before authorizing
enrollment or Sync. The existing unsynchronized purchase must not be synced,
recreated or discarded before that preflight.

### Current terminal

```text
CYCLE10=OPEN
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
STEP12=CLOSED_THROUGH_GATE_12_10
ST08=PASSED_BOUNDED
ST09=PASSED_BOUNDED
ST10=PASSED_READ_ONLY
GATE_12_10=PASS_EXPECTED_SUCCESS
GCM03=READY_FOR_DEFINITION_AND_READ_ONLY_PREFLIGHT
NEW_SYNC_OR_RETRY=NOT_AUTHORIZED
ANDROID_ENROLLMENT=NOT_AUTHORIZED
SECOND_DEVICE_CONVERGENCE=UNPROVED
GCM04=UNDEFINED_INACTIVE
```

## 2026-07-28 — GCM02 final closure handoff and GCM03 Windows preflight

### Sequence envelope

```text
Sequence: FLX-PRM-04
Role: Main Chat [M]
Round or unit: C10-GCM02-CLOSURE / C10-GCM03-ST01
Branch: grm-guarded-provisioning-20260727
Inspected baseline: f54b9872daf37c26b33778a36f26f733c834401d
Question: Is the bounded GCM02 closure packet complete, and does the new
          Windows local event provide a frozen candidate member from which
          Android readiness, enrollment and inter-device convergence may be
          prepared under GCM03?
Inputs: REC_DIAGNOSTICS Records 009-013; accepted ST08-ST10 client, Render and
        GRM-NEON-11 evidence; user-supplied post-GCM02 Windows Diagnostics
Writable surfaces: REC_DIAGNOSTICS append; mutable J recovery prefix;
                   append-only Legacy_Progress
Prohibited actions: Windows or Android Sync, Android enrollment, Retry,
                    recovery, migration, provider mutation, production claim
Authority: explicit human-directed final GCM02 reconciliation and GCM03 plan
Next sequence: C10-GCM03 Android readiness and pre-enrollment preparation
```

### PRC-01 claims

```text
Claim: the GCM02 closure packet is final at its bounded scope
Prior state: ST10 and Gate 12.10 passed; publication still pending
Evidence: exact binding and clean baseline in ST08; one controlled same-Device
          transition in ST09; correlated authenticated HTTP 200 upload,
          download and acknowledgement lifecycles in ST10; exact provider
          0/0/0 -> 1/1/1 delta and consistent cursor/sequence postflight
Evidence boundary: one Account, one Windows Device, development hosted provider
Contradiction: none
Semantic owner: C10 GCM02 closure
Target role: REC_DIAGNOSTICS and J closure handoff; later permanent promotion
Resulting state: ACCEPTED / CLOSED BOUNDED
History disposition: append
```

```text
Claim: the new Windows purchase is a controlled GCM03 candidate member
Prior state: provisionally reported but not frozen
Evidence: Record 013 shows one pending purchase.registered event at Windows
          Device sequence 2, next sequence 3, queue 1/0/0/0, same current
          enrolled Device
Evidence boundary: local Windows Diagnostics; no provider or Android action
Contradiction: none
Semantic owner: C10-GCM03-ST01 Windows candidate preflight
Target role: GCM03 member set and authorization preparation
Resulting state: ACCEPTED / PREFLIGHT PASS
History disposition: append
```

```text
Claim: Android enrollment or inter-device Sync is authorized by this plan
Prior state: held for separate GCM03 preparation
Evidence: Android environment, fresh local state, same-Account authentication,
          enrollment delta and two-Device provider baseline remain unproved
Evidence boundary: planning only
Contradiction: mutation would skip required evidence and authorization gates
Semantic owner: future GCM03 authorization packets
Target role: human/Main action boundary
Resulting state: REJECTED; PREPARATION ONLY
History disposition: append
```

### GCM03 staged direction

The controlling mutable prefix now holds the complete fourteen-item GCM03 TODO
sequence. Android checks are explicitly positioned before authentication and
enrollment:

```text
published closure checkout alignment
read-only provider/host freshness as required
GRM-FLUTTER-AND build/install/run
Android local pre-enrollment Diagnostics
same-Account Auth0 authentication
exact one-click enrollment packet and authorization
Android enrollment exactly once
two-Device provider baseline
Windows-to-Android controlled convergence
Android-to-Windows controlled reverse convergence
idempotent repeat
client/Render/provider reconciliation
```

Each mutating step remains separately held. Record 013's Windows event must
remain pending and unchanged through the Android readiness and enrollment
preflight.

### Current terminal

```text
CYCLE10=OPEN
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM02_FINAL_RECONCILIATION=READY_FOR_PUBLICATION
GCM03_WINDOWS_CANDIDATE_PREFLIGHT=PASS
GCM03_WINDOWS_PENDING_MEMBER=PURCHASE_REGISTERED_SEQUENCE_2
GCM03_WINDOWS_NEXT_DEVICE_SEQUENCE=3
GCM03=ACTIVE_PREPARATION_ANDROID_CHECKS_NEXT
ANDROID_ENROLLMENT=NOT_AUTHORIZED
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
SECOND_DEVICE_CONVERGENCE=UNPROVED
GCM04=UNDEFINED_INACTIVE
```

## 2026-07-28 — ST04-R1 Android GRM cascade contradiction

### Sequence envelope

```text
Sequence: FLX-PRM-04
Role: Main Chat [M]
Round or unit: C10-GCM03-ST04-R1 / C10-GCM03-ST04-R1-C1
Branch: grm-guarded-provisioning-20260727
Inspected baseline: 231a76281d0016ee47dd719d3ddc24d422b18c35
Inputs: synchronized D/E/F; replacement G/H/I; commit diff; exact
        GRM-FLUTTER-AND -> I_SCRIPTS -> GS-FLUTTER-AND cascade
Writable surfaces: mutable J prefix; append-only Legacy_Progress; synchronized
                   replacement D/E/F
Prohibited actions: live Android procedure, authentication, enrollment, Sync,
                    Retry, recovery, provider mutation, commit or push
Authority: explicit human-directed reconciliation and downstream-code solution
Next sequence: bounded Codex correction C10-GCM03-ST04-R1-C1
```

### Reconciliation

The Flutter portion of ST04-R1 is accepted at its local evidence boundary:
one shared Closure page, compact/wide tests, safe public provenance, a locally
built debug APK with an explicit define, and no protocol/provider expansion.

The Android procedure terminal is contradicted. Commit `231a762` placed
`$Branch`, `$InspectedHead`, `$BuildProvenance`, containment and reporting
producers in `GS-FLUTTER-WIN`, while `GS-FLUTTER-AND` owns the consumers.
Because `I_SCRIPTS.ps1` extracts only the selected fence and executes it under
strict mode, the Android procedure fails at its first undefined `$Branch`
read; `$BuildProvenance` is independently undefined later.

Parsing the fence was valid syntax evidence but not executable data-flow
evidence. The correction therefore restores the Windows fence to `db17f47`,
moves robust procedure-local producers into the Android fence before first
use, and adds exact-fence, AST, producer-before-consumer and strict-mode-prefix
validation.

### Terminal

```text
C10_GCM03_ST04_R1_FLUTTER_SOURCE=ACCEPTED_LOCAL_VALIDATION
C10_GCM03_ST04_R1_ANDROID_GRM=CONTRADICTED_VARIABLE_CASCADE
C10_GCM03_ST04_R1_C1=ACTIVE
ST04=BLOCKED_PENDING_CORRECTION_AND_RECONCILIATION
LIVE_ANDROID_RETEST=NOT_AUTHORIZED_YET
GCM03_ST05_AND_LATER=HELD
ANDROID_ENROLLMENT=NOT_AUTHORIZED
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
```

## 2026-07-28 — C10-GCM03 ST04/ST05 Android human-evidence reconciliation

### Sequence envelope

```text
Sequence: FLX-PRM-04
Role: Main Chat [M]
Round or unit: C10-GCM03-ST04-R1-C3 / ST04 / ST05
Branch: grm-guarded-provisioning-20260727
Inspected Android artifact lineage: 65c9ab56079c7a9866910db9037c28045efd1d34
Inputs: user-supplied C3 Codex terminal; ten Android screenshots divided into
        five before and five after one Diagnostics press; exact current
        NativeClosurePage Diagnostics and enrollment paths; Record 013
Writable surfaces: REC_DIAGNOSTICS append; mutable J recovery prefix
Prohibited actions: Enroll, Windows or Android Sync, Retry, recovery, logout,
                    clear history, provider mutation, secret capture
Authority: explicit human-directed ST04/ST05 reconciliation
Next sequence: C10-GCM03-ST06 read-only enrollment preflight
```

### Reconciled evidence

The C3 Codex result closes the static/host validation gap left by C2:

```text
DEVSEL_CLASSIFICATION=DEVSEL-01
ACTUAL_GS_FLUTTER_AND_FIXTURES=PASS
ANDROID_DEVICE_ENUMERATION=CORRECTED
NON_ANDROID_ID_REACHES_ADB=NO
ADB_SERIAL_CARDINALITY=EXACTLY_ONE
ANDROID_SIGN_IN_CLASSIFICATION=AUTHAND-06
ST04=BLOCKED_PENDING_HUMAN_RETEST
```

The human rerun supplies the evidence Codex intentionally could not:

- `DEV-GRM` is the visible Android target;
- the installed Closure surface exposes build provenance `65c9ab56079c`;
- the shared consolidated page is usable on the compact Android viewport;
- one distinct Android local-only Device exists at local next sequence 1;
- the Android queue is `0/0/0/0`;
- no local Closure attempt, diagnostic lifecycle or actionable event exists;
- ordinary Sign in returns an authenticated client projection;
- enrollment remains required and no enrollment or Sync occurred;
- one Diagnostics press returns `diagnostics-ready` without changing
  authentication, enrollment, queue, Device sequence, attempts or history.

This is Android-local evidence. The page reads the Android app's own
Drift/SQLite store and current native authentication session. It does not read
the Windows SQLite file. Because the canonical Android installer preserves
application data, the record does not claim that the complete Android database
was created by this exact installation. The clean hosted/sync projection is
accepted; complete storage freshness remains unproved.

### PRC-01 claims

```text
Claim: C10-GCM03-ST04-R1-C3 corrected and validated the Android target boundary
Prior state: selector repair materialized; human runtime retest pending
Evidence: actual-fence Windows PowerShell 5.1 fixtures; captured ADB vectors;
          no non-Android ID; exactly one scalar ADB serial; matching-provenance
          human launch on DEV-GRM
Evidence boundary: static/host tests plus one Android build/install/launch
Contradiction: none
Semantic owner: Android GRM execution boundary
Target role: ST04 terminal
Resulting state: VALIDATED / PASSED BOUNDED
History disposition: append; supersede prior ST04 blocker
```

```text
Claim: the Android pre-enrollment state is safe to freeze
Prior state: required fresh local observation
Evidence: distinct local-only Device fingerprint, next 1, queue 0/0/0/0,
          enrollment-required, no attempts/diagnostics/actionable events
Evidence boundary: Android local client projection only
Contradiction: installer preserves app data, so whole-database freshness is
               not proved
Semantic owner: C10-GCM03-ST04 pre-enrollment packet
Target role: ST04 runtime closure and ST06 input
Resulting state: ACCEPTED / PASSED WITH STORAGE-FRESHNESS QUALIFICATION
History disposition: append
```

```text
Claim: C10-GCM03-ST05 proves Android authentication
Prior state: AUTHAND-06 pending human observation
Evidence: ordinary native Sign in followed by visible authenticated projection
Evidence boundary: client session; screenshots expose no Account identifier
Contradiction: none for authentication; exact same-Account binding remains
               outside screenshot evidence
Semantic owner: C10-GCM03-ST05 authentication gate
Target role: ST05 terminal and ST06 input
Resulting state: PASSED CLIENT SCOPE; SAME-ACCOUNT EXACT BINDING OPEN
History disposition: append
```

```text
Claim: the persistent MKS-UI-003 card is an authentication or provider failure
Prior state: runtime symptom unclassified
Evidence: source fallback creates MKS-UI-003 when no recent diagnostic event
          exists; Diagnostics changes the page terminal to diagnostics-ready
          while provider contact/local mutation remain not-started/none
Evidence boundary: client presentation and before/after screenshots
Contradiction: card wording is misleading for a successful local snapshot
Semantic owner: Closure empty-history current-action presentation
Target role: non-blocking residual defect and enrollment evidence warning
Resulting state: REJECTED AS AUTH/PROVIDER FAILURE; OBSERVED PRESENTATION DEFECT
History disposition: append; defer source correction outside this assay
```

```text
Claim: this reconciliation authorizes Android enrollment
Prior state: held for an exact one-click packet
Evidence: a fresh read-only hosted/provider baseline and warm readiness result
          have not yet been reconciled
Evidence boundary: no provider preflight after the Android observation
Contradiction: immediate Enroll would skip ST06's expected-delta freeze
Semantic owner: C10-GCM03-ST06 authorization packet
Target role: next human action boundary
Resulting state: NOT YET AUTHORIZED; READ-ONLY PREFLIGHT NEXT
History disposition: append
```

### ST06 enrollment packet under preparation

The pre-enrollment invariants already frozen are:

```text
Windows candidate member:
  purchase.registered
  local state pending
  Device sequence 2
  Windows next local sequence 3
  queue 1/0/0/0

Android:
  authenticated at client scope
  enrollment-required
  distinct local-only Device
  local next sequence 1
  queue 0/0/0/0
  no attempts or diagnostic events

Accepted provider payload baseline from GCM02:
  one Account
  one active Windows Device
  submissions/events/acknowledgements 1/1/1
  Account next cursor 2 after high-water 1
  Windows provider next expected sequence 2
```

Before authorization, ST06 must reconfirm:

1. one warm `Check hosted connection` result with no enrollment or Sync;
2. one read-only `GRM-NEON-11` baseline ending in explicit `ROLLBACK` and
   `PASS`, still showing the expected one-Device GCM02 state;
3. no new provider payload/cursor/acknowledgement delta;
4. no change to either local queue.

Only then may Main authorize one Android Enroll press. The expected enrollment
delta is:

```text
accounts: unchanged
external identities and active membership: unchanged
active devices: 1 -> 2
active device enrollments: 1 -> 2
completed enrollment requests: +1 for the Android installation
device-enrolled security events: +1
Android provider next expected sequence: 1
submissions: unchanged
sync events: unchanged
device acknowledgements: unchanged
Account cursor/high-water: unchanged
Windows provider next expected sequence: unchanged at 2
Windows local pending member: unchanged
```

After the one click, any terminal other than a clearly applied/restart-required
result is a stop. Do not click Enroll a second time. Preserve the page terminal,
then follow the required restart and post-restart Sign in/Diagnostics packet.
The MKS-UI-003 fallback card must not be used to decide whether enrollment
should be repeated.

### Current terminal

```text
CYCLE10=OPEN
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03_WINDOWS_CANDIDATE_PREFLIGHT=PASS
GCM03_WINDOWS_PENDING_MEMBER=PURCHASE_REGISTERED_SEQUENCE_2
C10_GCM03_ST04_R1_C3=VALIDATED
C10_GCM03_ST04=PASSED_BOUNDED_ANDROID_RUNTIME_AND_LOCAL_PREFLIGHT
C10_GCM03_ST05=PASSED_CLIENT_AUTHENTICATION_SCOPE
ANDROID_SAME_ACCOUNT_EXACT_BINDING=OPEN
ANDROID_DIAGNOSTICS=PASS_READ_ONLY_REFRESH
MKS_UI_003_EMPTY_HISTORY_PRESENTATION=OBSERVED_NON_BLOCKING
ANDROID_STORAGE_FRESHNESS=UNPROVED_PRESERVED_DATA_POSSIBLE
C10_GCM03_ST06=ACTIVE_READ_ONLY_PREFLIGHT
ANDROID_ENROLLMENT=NOT_AUTHORIZED_YET
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
SECOND_DEVICE_CONVERGENCE=UNPROVED
GCM04=UNDEFINED_INACTIVE
```

## 2026-07-28 — C10-GCM03 ST06 Android hosted-readiness reconciliation

### Sequence envelope

```text
Sequence: FLX-PRM-04
Role: Main Chat [M]
Round or unit: C10-GCM03-ST06 read-only hosted-readiness preflight
Branch: grm-guarded-provisioning-20260727
Reconciliation baseline: 65c9ab56079c7a9866910db9037c28045efd1d34
Inputs: one user-supplied Recent Closure attempts screenshot; Record 014
Writable surfaces: REC_DIAGNOSTICS append; mutable J recovery prefix;
                   append-only Legacy_Progress
Prohibited actions: Android Enroll, Windows or Android Sync, Retry, recovery,
                    logout, history clearing, provider mutation, secret capture
Authority: explicit human-directed ST06 evidence registration and publication
Next sequence: read-only GRM-NEON-11 pre-enrollment provider baseline
```

### Reconciled evidence

The operator pressed `Check hosted connection` twice because the first
cold-start attempt timed out before receiving a response. The Closure history
preserves two distinct attempts:

```text
earlier #b6652cab
  hosted-connection-check
  timeout-before-response
  unknown / transport-started
  no applicable aggregate HTTP status or response headers
  latency approximately 30 seconds

later #03748b75
  hosted-connection-check
  hosted-connection-ready
  completed / response-parsed
  aggregate HTTP 200
  aggregate response headers received
  latency under 3 seconds
```

Different attempt and correlation fingerprints prove that the UI did not
collapse the two presses into one row. Only the later attempt is a successful
readiness result. The earlier unknown timeout remains valid historical
transport evidence and must not be silently rewritten as success.

The later ready terminal satisfies the bounded client hosted-readiness
prerequisite. It proves neither ordinary Sync nor enrollment; the UI itself
states `ready-does-not-prove-sync`. No third readiness press is required.

### PRC-01 claims

```text
Claim: pressing the hosted-readiness control twice produced two successes
Prior state: one warm hosted-readiness result required before enrollment
Evidence: two distinct attempt rows; only the later row is completed,
          response-parsed and HTTP 200
Evidence boundary: Android client attempt history screenshot
Contradiction: earlier row remains timeout-before-response with unknown outcome
Semantic owner: ST06 client hosted-readiness preflight
Target role: readiness terminal and cold-start operational history
Resulting state: REJECTED AS TWO SUCCESSES; ONE READY PLUS ONE PRESERVED TIMEOUT
History disposition: append
```

```text
Claim: the ST06 client hosted-readiness prerequisite is satisfied
Prior state: outstanding after Record 014
Evidence: later hosted-connection-ready attempt completed with response parsed,
          aggregate HTTP 200 and headers received in under three seconds
Evidence boundary: readiness only; no child Sync protocol or provider delta
Contradiction: cold attempt timed out before response
Semantic owner: C10-GCM03-ST06
Target role: enrollment authorization preflight
Resulting state: PASSED AFTER COLD-START WARMUP
History disposition: append; preserve cold timeout as sensitivity evidence
```

```text
Claim: Android enrollment is now authorized
Prior state: held for readiness plus fresh provider baseline
Evidence: readiness is satisfied; GRM-NEON-11 pre-enrollment inventory has not
          yet been supplied for this packet
Evidence boundary: no fresh provider inventory in Record 015
Contradiction: authorizing Enroll now would lose the exact provider delta
Semantic owner: ST06 enrollment authorization packet
Target role: next Main decision
Resulting state: NOT AUTHORIZED; READ-ONLY PROVIDER BASELINE NEXT
History disposition: append
```

### Current terminal

```text
C10_GCM03_ST06_CLIENT_HOSTED_READINESS=PASS_AFTER_COLD_START_WARMUP
HOSTED_CONNECTION_HUMAN_ACTIVATIONS=2
HOSTED_CONNECTION_ATTEMPTS_RECORDED=2
HOSTED_CONNECTION_READY_RESULTS=1
HOSTED_CONNECTION_TIMEOUT_BEFORE_RESPONSE=1_PRESERVED_UNKNOWN
READY_PROVES_SYNC=NO
C10_GCM03_ST06=ACTIVE_READ_ONLY_PROVIDER_BASELINE
ANDROID_ENROLLMENT=NOT_AUTHORIZED_YET
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
SECOND_DEVICE_CONVERGENCE=UNPROVED
```

## 2026-07-28 — GCM03 S07 post-restart Android enrollment reconciliation

### Sequence envelope

```text
Sequence: FLX-PRM-04
Role: Main Chat [M]
Round or unit: C10-GCM03-S07 inner steps 1-5
Branch: grm-guarded-provisioning-20260727
Reconciliation baseline: 65c9ab56079c7a9866910db9037c28045efd1d34
Inputs: REC_DIAGNOSTICS Records 014-016; user-supplied post-restart Android
        Closure screenshots; inspected runtime-composition source
Writable surfaces: REC_DIAGNOSTICS append; mutable J recovery prefix;
                   append-only Legacy_Progress
Prohibited actions: Android purchase, Windows or Android Sync, repeated
                    enrollment, Retry, recovery, provider mutation
Authority: explicit human-directed sanitized addition and check preparation
Next sequence: GRM-AUTH-02 followed by post-enrollment GRM-NEON-11
```

### PRC-01 claims

```text
Claim: Android enrollment persisted through the required restart
Prior state: enrollment accepted with hosted-restart-required; durability open
Evidence: post-restart client projects authenticated, device-enrolled, queue
          0/0/0/0, next Device sequence 1 and no actionable event
Evidence boundary: Android client projection; exact hosted authorization open
Contradiction: none
Semantic owner: C10-GCM03-S07 post-restart client verification
Target role: Record 016 and J current recovery state
Resulting state: ACCEPTED / PASS BOUNDED AT CLIENT SCOPE
History disposition: append
```

```text
Claim: the changed Device fingerprint means enrollment was lost
Prior state: pre-enrollment local-only fingerprint #2b75367e
Evidence: post-restart fingerprint #a4d906aa is device-enrolled; source loads
          hostedBinding.serverDeviceId after restart instead of the provisional
          local Device identity
Evidence boundary: source/UI relationship; exact hosted member still open
Contradiction: none
Semantic owner: local-to-hosted Device identity handoff
Target role: S07 interpretation and AUTH-02/NEON-11 preflight
Resulting state: REJECTED AS LOSS; EXPECTED HANDOFF SUPPORTED
History disposition: append
```

```text
Claim: an Android purchase may now be created
Prior state: Android queue 0/0/0/0 and next sequence 1 frozen for exact
             post-enrollment checks; Windows sequence-2 member already frozen
Evidence: GRM-AUTH-02 exact binding and GRM-NEON-11 two-Device inventory have
          not yet been supplied
Evidence boundary: action authorization
Contradiction: purchase creation would alter queue and sequence before the
               clean baseline is reconciled and mix the reverse-direction
               member into the Windows-to-Android assay
Semantic owner: future GCM03 reverse-direction authorization
Target role: human/Main action boundary
Resulting state: REJECTED / HELD
History disposition: append
```

### Current terminal

```text
C10_GCM03_S07_INNER_STEPS_1_TO_5=PASS_BOUNDED_CLIENT_SCOPE
ANDROID_DURABLE_ENROLLMENT=PASS_CLIENT_SCOPE
ANDROID_DEVICE_FINGERPRINT_HANDOFF=EXPECTED_LOCAL_TO_HOSTED
EXACT_HOSTED_ANDROID_BINDING=OPEN_GRM_AUTH_02
TWO_DEVICE_PROVIDER_BASELINE=OPEN_GRM_NEON_11
C10_GCM03_S08=HELD_PENDING_READ_ONLY_CHECKS
ANDROID_PURCHASE=HELD
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
```

## 2026-07-29 — GCM03 S08 exact binding and two-Device provider reconciliation

### Sequence envelope

```text
Sequence: FLX-PRM-04
Role: Main Chat [M]
Round or unit: C10-GCM03-S08 read-only exact binding/provider baseline
Branch: grm-guarded-provisioning-20260727
Publication parent: e37f03b66e594a8dd54bbec0de94a42afb3fcecd
Inputs: REC_DIAGNOSTICS Records 014-016; operator-supplied masked-session
        GS-AUTH-02 terminal; operator-supplied GS-NEON-11 provider-baseline
        terminal; launcher branch-alias caveat
Writable surfaces: REC_DIAGNOSTICS append; mutable J recovery prefix;
                   append-only Legacy_Progress
Prohibited actions: Windows or Android Sync, Android purchase, repeated
                    enrollment, Retry, recovery, migration, revocation,
                    provider repair, secret persistence
Authority: explicit human-directed sanitized reconciliation and publication
Next sequence: GCM03.9 Windows-to-Android convergence authorization packet
```

### PRC-01 claims

```text
Claim: the post-restart Android token and hosted Device are exactly bound
Prior state: authenticated/device-enrolled client projection; exact hosted
             authorization open
Evidence: issuer/audience/algorithm/time checks true; subject present; identity
          and Device endpoints HTTP 200; TokenAccepted true;
          ExactDeviceBinding true; exact-binding-confirmed
Evidence boundary: fresh masked local token/UUID prompts and hosted
                   authorization endpoints; no secret retained
Contradiction: none
Semantic owner: C10-GCM03-S08 exact hosted binding
Target role: Record 017 and J current recovery state
Resulting state: VALIDATED / PASS EXACT BINDING
History disposition: append; supersede S07 exact-binding-open terminal
```

```text
Claim: the post-enrollment provider baseline is clean and internally
       consistent
Prior state: Android enrollment durable at client scope; two-Device provider
             inventory open
Evidence: fixture match/guard 1/1; one Account; two Device rows; payload
          1/1/1; cursor 2 after high-water 1; exact Android active at sequence
          1 after high-water 0; exact Android submissions/events 0/0; explicit
          BEGIN/ROLLBACK and PASS
Evidence boundary: development database, selected exact Device and
                   transactionally read-only inventory
Contradiction: launcher cannot independently prove the human-readable branch
               alias
Semantic owner: C10-GCM03-S08 two-Device baseline
Target role: Record 017 and GCM03.9 input
Resulting state: VALIDATED / PASS WITH BRANCH-ALIAS PROVENANCE CEILING
History disposition: append
```

```text
Claim: S08 proves or authorizes inter-device convergence
Prior state: both Sync actions held
Evidence: no Windows or Android Sync occurred; exact Android owns no provider
          submission or event; frozen Windows candidate remains unapplied to
          Android
Evidence boundary: read-only exact binding and inventory only
Contradiction: convergence requires separately authorized upload/download and
               cross-client apply evidence
Semantic owner: GCM03.9/GCM03.10 action boundary
Target role: next Main authorization packet
Resulting state: REJECTED; CONVERGENCE UNPROVED AND BOTH SYNC ACTIONS HELD
History disposition: append
```

### Next TODOs

1. Reconfirm by local Diagnostics only that the Windows sequence-2 candidate
   remains the sole pending upload and Android remains `0/0/0/0`, next 1.
2. Inspect the implemented ordinary-Sync protocol and calculate exact
   per-phase provider and local deltas; do not infer acknowledgement or cursor
   increments.
3. Freeze one Windows ordinary-Sync authorization with explicit stop
   conditions and required client/Render/provider evidence.
4. Reconcile that Windows phase before considering one Android ordinary-Sync
   authorization.
5. Prove Android download/application and matching purchase identity/content
   without duplication or Android-local history loss.
6. Keep the reverse Android purchase held until the first direction passes
   and the catalogue dropdown identity defect is corrected and validated.

### Current terminal

```text
C10_GCM03_S08=PASSED_READ_ONLY_EXACT_BINDING_TWO_DEVICE_BASELINE
GCM03=ACTIVE_WINDOWS_TO_ANDROID_AUTHORIZATION_PACKET
SECOND_DEVICE_CONVERGENCE=UNPROVED
ANDROID_PURCHASE=HELD
WINDOWS_SYNC=NOT_AUTHORIZED
ANDROID_SYNC=NOT_AUTHORIZED
GCM04=UNDEFINED_INACTIVE
```

## 2026-07-29 — GCM03 S09/S10 Android failed-apply containment, R01 conclusion and R02 activation

### Sequence envelope

```text
Sequence: FLX-PRM-04 reconciliation -> FLX-ORD-01 materialization
Role: Main Chat [M]
Round or unit: C10-GCM03-S09/S10; C10-GCM02-S09-R01/R02 continuity labels
GitHub branch: grm-guarded-provisioning-20260727
Inspected remote HEAD: 716ae7f082714944b6b51042d98a56e685978c38
Inputs: S09 hosted two-event state; one Android ordinary-Sync failure;
        GS-SQLITE-05/06/07 frozen-snapshot evidence; Android History and
        Diagnostics human projection; read-only GS-NEON-11 postflight;
        Flutter assertion screenshot; exact remote source/blob inspection
Writable surfaces: replacement D/E/F; append-only J reconciliation
Prohibited actions: source materialization in this Main turn; Windows/Android
                    Sync; Retry; recovery; repeated enrollment; provider
                    mutation; migration; deployment; production action
Authority: explicit human direction to preserve the record, activate R02
           corrective staging, and publish D/E/F/J
Next sequence: Codex FLX-ORD-01 materialization from controlling D/E/F
Stop condition: any required migration, protocol/provider change, live action,
                secret exposure, unrelated dirty overlap or branch-head race
```

### Branch namespace clarification

The prior terminal:

```text
BRANCH PROVENANCE = CONFIRMED_MARKei-c10
```

was ambiguous and must not be interpreted as a GitHub operation.

No GitHub branch named `CONFIRMED_MARKei-c10` was created. The repository branch
remains:

```text
grm-guarded-provisioning-20260727
```

The current sanitized coordinates configure the Neon development branch alias:

```text
markei-c10
```

`GS-NEON-11` prints that configured target but explicitly cannot independently
prove the human-readable Neon alias. New records therefore use:

```text
GITHUB_BRANCH=grm-guarded-provisioning-20260727
CONFIGURED_PROVIDER_BRANCH_ALIAS=markei-c10
PROVIDER_BRANCH_ALIAS_LAUNCHER_INDEPENDENT_PROOF=NO
```

The historical marker is preserved as history and superseded for current
reporting vocabulary. This is a naming correction, not a provider or
repository mutation.

### S09 hosted transition carried into S10

The previously frozen Windows sequence-2 candidate was uploaded under its
separately authorized S09 action. By the S10 provider containment postflight,
the Account-wide provider totals were:

```text
submissions = 2
sync events = 2
device acknowledgement rows = 1
Account next cursor = 3
hosted high-water = 2
Account cursor relation = consistent
```

These totals include the completed Windows-origin transitions. They do not
describe Android producer activity. The exact selected Android Device remained
at next expected Device sequence 1 with zero selected-Device submissions,
events and acknowledgements.

The expected Windows-to-Android candidate therefore existed at the provider
before the Android download assay.

### S10 Innerstep 01 — one failed Android ordinary Sync

Exactly one ordinary Android Sync progressed through:

```text
authentication-check-entered
authenticated
binding-check-entered
binding-accepted
upload-lease-entered
no-pending-events
download-request-started
download-response-received
closure-runner-exception
```

The terminal was:

```text
operation = ordinary-sync
result = sync-failed
outcome = failed
phase/latest stage = unexpected-terminal
recovery = local-exception-redacted
sanitized exception class = DriftRemoteException
```

The causal child evidence proves a trusted download response was received.
The later broad runner fallback incorrectly recorded
`trusted_response_state=not-received`. This is an observability defect, not
evidence that the provider response was absent.

No second Sync, Retry or recovery action was selected.

### S10 Innerstep 02 — frozen Android SQLite rollback proof

`GS-SQLITE-05` created and verified one private Android database snapshot while
Markei was force-stopped. The manifest, size and hash comparison passed. The
live database was not queried or modified.

`GS-SQLITE-06` and `GS-SQLITE-07` inspected that snapshot through distinct SQL
programs embedded in `G_SCRIPTS.md`:

```text
GS-SQLITE-06 = general schema/state/diagnostic inventory
GS-SQLITE-07 = cross-field correlation and final local-state classification
```

They intentionally share underlying facts. Neither currently dispatches a
`DB_MGMT.sql` SQL block. That is a catalogue-organization observation, not an
assay defect.

Accepted snapshot evidence:

```text
schema table count = 13/13
SQLite integrity = ok
foreign-key check rows = 0

enrollment = device-enrolled
active Account scope count = 1
current Device count = 1
current Device next sequence = 1
current Installation count = 0

sync-state rows = 1
Account cursor = null
Account numeric cursor = null
inbox rows = 0
distinct inbox event/cursor counts = 0/0
applied inbox rows = 0
inbox high-water = 0
hosted Purchase/Purchase-item rows = 0/0

Android-originated events = 0
Android submissions = 0
pending/uploading/failed/unknown = 0/0/0/0

trusted download response child count = 1
acknowledgement-started count = 0
sync-completed count = 0
closure-runner-exception count = 1
```

Final classification:

```text
android_local_state_class=failed-download-empty-local-state
C10_GCM03_S10_I02=PASS_LOCAL_TRANSACTION_ROLLBACK
ANDROID_CURSOR_ADVANCED=NO
ANDROID_ACKNOWLEDGEMENT_STARTED=NO
ANDROID_BUSINESS_FACTS_RETAINED=NO
LIVE_DATABASE_QUERIED=NO
LOCAL_DATABASE_MODIFIED=NO
```

The snapshot proves complete local page rollback at this evidence boundary.
It does not claim the provider contains zero Purchases.

### S10 Innerstep 03 — human projection agreement

The app was opened without reinstalling or rebuilding. Human inspection
observed:

```text
Windows-origin candidate visible in Android History = no
unexpected hosted-origin Purchases visible = no
queue pending/uploading/failed/unknown = 0/0/0/0
Android next Device sequence = 1
latest ordinary Sync = sync-failed
acknowledgement/completion = not observed
```

Diagnostics retained the `closure-runner-exception` terminal and the earlier,
separate hosted-connection timeout. The latter is a different historical
operation and does not contradict the failed ordinary-Sync chain.

Gate:

```text
C10_GCM03_S10_I03=PASS_UI_PROJECTION_MATCHES_LOCAL_ROLLBACK
ANDROID_HISTORY_CANDIDATE=ABSENT
ANDROID_LAST_SUCCESSFUL_SYNC=NOT_ADVANCED
```

### S10 Innerstep 04 — read-only provider containment

One `GS-NEON-11` repeatable read-only postflight selected the exact Android
Device and returned:

```text
selected Device match/guard = 1/1
selected Device state = active
selected Device next expected sequence = 1
selected Device high-water = 0
selected Device submissions = 0
selected Device events = 0
selected Device acknowledgement rows = 0
selected Device acknowledged cursor = 0
selected Device consistency booleans = true
Account next cursor / hosted high-water = 3/2, consistent
transaction terminal = ROLLBACK
launcher terminal = PASS
```

Account-wide totals `2/2/1` belong to the already hosted Windows history. They
are not Android mutations.

Gate:

```text
C10_GCM03_S10_I04_PROVIDER_CONTAINMENT=PASS
ANDROID_PROVIDER_STATE_ADVANCED=NO
TRANSACTION_ROLLED_BACK=YES
```

The configured provider alias is `markei-c10`; the launcher alias-proof ceiling
remains explicit as recorded above.

### S10 Innerstep 05 / R01 — actionable source diagnosis

Exact remote blobs at HEAD matched the inspected local source for:

```text
PurchasePage
Product domain model
LocalQueryRepository
RemotePurchaseFactWriter
DriftRemoteEventApplier
sync use cases
HostedSyncCoordinator
NativeAuthClosureRunner
focused app and convergence tests
```

The source establishes:

1. `RemotePurchaseFactWriter` resolves incoming Store and Product snapshots
   only by incoming UUID.
2. local Products also enforce Account-scoped uniqueness on normalized
   user Product code and exact identity key.
3. Purchase Items use incoming Product UUIDs directly.
4. Purchases use incoming Store UUIDs directly.
5. the receiving Android database was intentionally preserved and may already
   contain equivalent catalogue rows under different local UUIDs.
6. `DriftRemoteEventApplier.applyPage()` already provides the correct
   page-wide facts/inbox/cursor transaction.
7. a Drift exception can escape the application boundary and be collapsed by
   the Closure runner into inaccurate hard-coded causal fields.

This proves an implementation gap at the remote natural-identity boundary.
It is a high-confidence actionable explanation for the observed failure. The
exact runtime SQLite extended constraint code was not retained, so J does not
claim that one particular constraint was proved in the live assay.

R01 conclusion:

```text
C10_GCM03_S10_I05=PASS_ACTIONABLE_DIAGNOSIS
C10_GCM02_S09_R01=CONCLUDED
PRIMARY_GAP=REMOTE_NATURAL_IDENTITY_NOT_RECONCILED
SECONDARY_GAP=LOCAL_APPLY_CAUSAL_EVIDENCE_COLLAPSED
LIVE_RETRY_REQUIRED_FOR_DIAGNOSIS=NO
```

### Independent Purchase-page Product-selection defect

The supplied Android screenshot records Flutter's
`DropdownButton<Product?>` exactly-one-item assertion after a Catalogue Product
is found by exact code from Purchase.

The screenshot wording permits either zero matching items or multiple matching
items. It does not prove duplicate database rows.

Source inspection provides the exact zero-match path:

```text
_products
  <- listProducts()
  <- one set of Product object instances

_findProductByCode()
  <- productByCode()
  <- a separately materialized Product object instance

Product
  <- no value equality override

DropdownButton<Product?> value
  <- selected lookup instance

Dropdown menu values
  <- list projection instances
```

Two objects representing the same Product UUID are not equal by Dart reference
identity. The selected value can therefore match zero menu items even when
SQLite contains one unique Product row.

Correction boundary:

```text
selection key = stable Product ID scalar
selected facts = exact Product resolved from current Account projection
refresh = rebind by Product ID
missing/ambiguous ID = safe invalidation and user recovery feedback
global Product equality change = rejected
```

R02 must also guard repeated/conflicting Product IDs in the UI projection so
that neither zero nor multiple menu matches can reach Flutter.

This defect is independent from the failed remote download, but both expose
the same architectural distinction between object instance, surrogate UUID
and natural identity. They are one cohesive Product-identity correction unit.

### PRC-01 claims

```text
Claim: CONFIRMED_MARKei-c10 is a newly created GitHub remote branch
Source: historical terminal wording compared with remote repository branch and
        NS_COORDINATES provider alias
Current state: user uncertainty
Evidence: GitHub branch is grm-guarded-provisioning-20260727;
          configured Neon BranchAlias is markei-c10
Evidence boundary: repository and configured provider coordinates; launcher
                   cannot independently prove the human-readable Neon alias
Contradictions: none
Semantic owner: external-resource provenance vocabulary
Target role: J history and D/E reporting contract
History disposition: preserve old marker; supersede its ambiguous wording
Confidence: high
Human/Main authority: explicit clarification request
Required regeneration: D/E/F vocabulary
Result: REJECTED; NO GITHUB BRANCH WAS CREATED BY THE MARKER
```

```text
Claim: the failed Android download left partially applied local facts or cursor
Source: frozen GS-SQLITE-05/06/07 snapshot and Android UI projection
Current state: open after DriftRemoteException
Evidence: zero inbox/facts; null cursor; zero queue/provider producer state;
          no acknowledgement; failed-download-empty-local-state
Evidence boundary: captured Android snapshot and non-mutating UI inspection
Contradictions: none
Semantic owner: C10-GCM03-S10 local containment
Target role: J R01 conclusion and R02 regression contract
History disposition: append
Confidence: high
Human/Main authority: explicit evidence reconciliation
Required regeneration: none
Result: VALIDATED / COMPLETE LOCAL ROLLBACK
```

```text
Claim: the failed Android assay advanced Android provider state
Source: GS-NEON-11 selected-Device read-only postflight
Current state: open after local failure
Evidence: Android next expected sequence 1; submissions/events/acks 0/0/0;
          acknowledged cursor 0; ROLLBACK/PASS
Evidence boundary: exact selected Device on configured development target
Contradictions: none
Semantic owner: C10-GCM03-S10 provider containment
Target role: J R01 conclusion
History disposition: append
Confidence: high
Human/Main authority: explicit evidence reconciliation
Required regeneration: none
Result: VALIDATED / PROVIDER NON-ADVANCEMENT
```

```text
Claim: one exact SQLite constraint caused the failed apply
Source: source inspection and sanitized DriftRemoteException
Current state: proposed
Evidence: UUID-only writer conflicts with multiple possible local constraints
Evidence boundary: exception extended result/message was not retained
Contradictions: several constraint paths can produce the same observed class
Semantic owner: R02 deterministic regression suite
Target role: source correction and typed diagnostic categories
History disposition: append without selecting an unproved constraint
Confidence: high that the boundary is defective; insufficient for one exact
            runtime constraint category
Human/Main authority: Main diagnosis
Required regeneration: deterministic test matrix
Result: PARTIALLY ACCEPTED; BOUNDARY CONFIRMED, EXACT RUNTIME CONSTRAINT UNKNOWN
```

```text
Claim: the Product dropdown screenshot proves duplicate Catalogue rows
Source: screenshot plus exact Product/PurchasePage/query source
Current state: proposed from assertion wording
Evidence: source-confirmed distinct-object/zero-match path; assertion combines
          zero and multiple matches
Evidence boundary: no direct duplicate-row query accompanied the screenshot
Contradictions: Products primary key and natural unique constraints exist
Semantic owner: Purchase presentation identity
Target role: R02 stable-ID correction and widget regressions
History disposition: append
Confidence: high
Human/Main authority: explicit correction request
Required regeneration: widget tests for zero and multiple projection classes
Result: REJECTED AS DATABASE-DUPLICATE PROOF; UI IDENTITY DEFECT CONFIRMED
```

```text
Claim: R02 may now materialize the bounded client corrections
Source: R01 conclusion, contained live state, exact source inspection and human
        implementation request
Current state: staged
Evidence: writable source boundary, regression matrix, transaction and
          diagnostic invariants, live-action exclusions are explicit
Evidence boundary: local source/tests only; corrected live convergence remains
                   unvalidated
Contradictions: none
Semantic owner: D/E/F controlling materialization stage
Target role: Codex FLX-ORD-01
History disposition: append; D/E/F replace superseded active stage
Confidence: high
Human/Main authority: explicit
Required regeneration: G/H/I after materialization
Result: ACCEPTED / ACTIVE CODEX IMPLEMENTATION AUTHORITY
```

### Activated R02 materialization

Controlling files:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

The cohesive correction owns:

1. Product-ID-keyed Purchase dropdown selection and refresh rebinding.
2. deterministic safe handling of missing or repeated Product IDs.
3. Account-scoped Product reconciliation by UUID, normalized code and exact
   identity.
4. Account-scoped Store reconciliation by UUID and current stable display
   identity.
5. remote-to-local Store/Product reference maps for Purchases and Items.
6. typed natural-identity conflict and sanitized SQLite failure categories.
7. preserved page-wide facts/inbox/cursor atomicity.
8. acknowledgement only after committed local cursor.
9. causal diagnostic preservation after a trusted response.

Explicit non-goals:

```text
no payload v4
no Person/Payment Method remote exchange
no migration or Drift schema change
no hosted API/server/provider change
no authentication or enrollment change
no retention/snapshot/rebootstrap change
no GRIMOIRE change
no live Sync/Retry/recovery
```

### Post-Codex and later live sequence

Codex must materialize and validate locally, replace G/H/I, and publish one
focused source/evidence commit. Unit tests and a disposable local convergence
lab may validate implementation, but they do not close real GCM03 convergence.

After Main reconciles G/H/I and a corrected Android artifact with matching
provenance is installed while preserving application data, a later human
packet may authorize exactly one Android ordinary Sync.

Expected later live result:

```text
both hosted Windows events materialize on Android
one coherent local Product/Store identity per Account
Purchase Items reference selected local Product IDs
Android Account cursor advances to c10b:2
one Android acknowledgement reaches cursor 2
Android producer sequence remains 1
Android producer queue remains empty
History and Catalogue projection show no duplicate fact
read-only local/provider postflights agree
```

None of those later live outcomes is claimed by the R02 staging commit.

### Current terminal

```text
CYCLE10=OPEN
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=ACTIVE_CORRECTIVE_MATERIALIZATION
C10_GCM03_S10_I02=PASS_LOCAL_TRANSACTION_ROLLBACK
C10_GCM03_S10_I03=PASS_UI_PROJECTION_MATCHES_LOCAL_ROLLBACK
C10_GCM03_S10_I04=PASS_PROVIDER_CONTAINMENT
C10_GCM03_S10_I05=PASS_ACTIONABLE_DIAGNOSIS
C10_GCM02_S09_R01=CONCLUDED
C10_GCM03_S10_R02=ACTIVE_CODEX_IMPLEMENTATION_AUTHORIZED
PURCHASE_PRODUCT_DROPDOWN_IDENTITY_FIX=IN_SCOPE
REMOTE_PRODUCT_STORE_IDENTITY_CONVERGENCE=IN_SCOPE
LOCAL_APPLY_CAUSAL_DIAGNOSTICS=IN_SCOPE
GITHUB_BRANCH=grm-guarded-provisioning-20260727
CONFIGURED_PROVIDER_BRANCH_ALIAS=markei-c10
PROVIDER_BRANCH_ALIAS_LAUNCHER_INDEPENDENT_PROOF=NO
ANDROID_SNAPSHOT=PRESERVE
WINDOWS_SYNC=HELD
ANDROID_SYNC=HELD
RETRY=HELD
RECOVERY=HELD
ENROLL=DO_NOT_REPEAT
PROVIDER_MUTATION=NONE
GCM04=UNDEFINED_INACTIVE
```


## 2026-07-29 — GCM03 S10 R02 post-Codex reconciliation and human-acceptance activation

### Sequence envelope

~~~text
Sequence: FLX-PRM-04 after FLX-ORD-01 materialization
Role: Main Chat [M]
Round or unit: C10-GCM03-S10-R02
Continuity alias: C10-GCM02-S09-R02
GitHub branch: grm-guarded-provisioning-20260727
Materialization parent: 9127a2e8a85ede3a6c881060b4ce47224f59e577
Materialization commit: cf8dcc6377b54c4b6944b2dec6cd844721bd29b1
Inputs: D/E/F controlling stage; G/H/I Codex reports; one-commit remote
        comparison; changed Flutter source; focused widget/infrastructure tests;
        existing GRM Android build/install procedure
Writable surface in this reconciliation: append-only J_MAIN_STAGE
Prohibited actions: Android/Windows Sync; Retry; Recovery; Enroll; Query;
                    acknowledgement; provider mutation; schema/migration/API
                    change; application-data clearing; snapshot replacement
Authority: human return with the completed pushed R02 materialization and prior
           instruction to reconcile before manual acceptance
Next sequence: C10-GCM03-S10-R02-H01 artifact-preserving Android install and
               offline Product-selection acceptance
Stop condition: branch/provenance mismatch; dirty Flutter/GRM overlap; data loss;
                automatic network action; missing authentication/enrollment;
                queue/cursor/Device-sequence drift
~~~

### Remote lineage and scope reconciliation

The remote comparison proves that R02 is exactly one fast-forward commit over
the controlling stage:

~~~text
9127a2e8a85ede3a6c881060b4ce47224f59e577
↓
cf8dcc6377b54c4b6944b2dec6cd844721bd29b1
~~~

Exactly nine paths changed:

~~~text
clients/markei_flutter/lib/app/pages/purchase_page.dart
clients/markei_flutter/lib/application/sync/sync_use_cases.dart
clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_event_applier.dart
clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_fact_writer.dart
clients/markei_flutter/test/app/markei_app_test.dart
clients/markei_flutter/test/infrastructure/remote_purchase_event_applier_test.dart
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
~~~

No migration, Drift schema, hosted API, payload contract, authentication,
enrollment, dependency, provider configuration, D/E/F/J, permanent domain
memory, methodology, DB_MGMT.sql, G_SCRIPTS.md or I_SCRIPTS.ps1 change entered
the materialization commit. The published scope therefore conforms to the
controlling R02 envelope.

### Source reconciliation

The Purchase UI now stores one nullable Product-ID scalar instead of a Product
object as dropdown identity. It normalizes the current Account-scoped Product
projection, resolves the selected Product only when exactly one current row
matches that ID, rebinds Find-code results through their Product ID, collapses
equivalent repeated IDs, rejects conflicting repetitions, and safely clears a
missing or ambiguous selection with bounded feedback.

This resolves the source-confirmed zero-match path from the original screenshot
without asserting that SQLite contained duplicate Product rows and without
globally redefining Product equality.

The remote fact writer now:

1. resolves Store by incoming UUID and existing Account-scoped display identity;
2. resolves Product by incoming UUID, normalized user Product code and exact
   identity key;
3. reuses one coherent local identity when the remote UUID differs;
4. rejects contradictory immutable/natural facts as a typed
   RemoteIdentityConflict;
5. maintains event-local incoming-to-local Product mapping;
6. writes Purchase Items with the selected local Product ID;
7. writes Purchases with the selected local Store ID.

The remote applier continues to own one page-wide Drift transaction. Catalogue
reconciliation, Purchase facts, Purchase Items, inbox rows and Account cursor
therefore commit or roll back together. Identity conflicts and SQLite failures
are translated only after rollback.

The ordinary-Sync diagnostic path now preserves:

~~~text
phase = download-local-apply
last proved phase = download-local-apply
trusted response state = received
local mutation state = rolled-back for conflict/SQLite failure
safe SQLite protocol category = local-sqlite-apply-failed
~~~

A failed local apply exposes no committed cursor to the acknowledgement use
case. The focused regression explicitly calls the acknowledgement boundary
after a sanitized SQLite apply failure and observes a null result with zero
transport acknowledgements.

### Codex validation classification

Codex reported:

~~~text
dart format lib/test = PASS
flutter analyze = PASS
focused Purchase widget test file = PASS
native Closure diagnostic tests = PASS
new remote event-applier tests = PASS
local synchronization application tests = PASS
full flutter test = PASS
debug Android build with reviewed public placeholder defines = PASS
merged manifest inspection = PASS
git diff --check = PASS
changed-content sensitive scan = PASS
~~~

The full Flutter suite skipped the disposable convergence lab because
MARKEI_RUN_SYNC_LAB was not set. That is an explicit evidence ceiling, not a
failure: the implementation stage prohibited a live lab/provider action.

The placeholder-defined APK build proves compile/package compatibility. It is
not the operator's final installed-artifact provenance and must not be used to
claim that the preserved Android client has been updated.

### PRC-01 claims

~~~text
Claim: R02 was materialized inside the controlling D/E/F scope
Prior state: ACTIVE_CODEX_IMPLEMENTATION_AUTHORIZED
Evidence: exact one-commit comparison, nine-path inventory and G/H/I reports
Evidence boundary: remote commit and inspected client source
Contradiction: none
Semantic owner: C10-GCM03-S10-R02 materialization record
Target role: J cross-domain reconciliation
Resulting state: VALIDATED / IMPLEMENTED AND AUTOMATED-TESTED
History disposition: append
~~~

~~~text
Claim: the Purchase Find-code assertion is corrected
Prior state: source-confirmed Product object-identity defect
Evidence: stable Product-ID implementation plus widget regressions for a
          separately materialized lookup object, refresh/removal, equivalent
          repetitions and conflicting repetitions
Evidence boundary: source and automated Flutter widget behavior
Contradiction: no corrected APK has yet been manually exercised over the
               preserved Android application data
Semantic owner: Purchase presentation identity
Target role: R02-H01 offline human acceptance
Resulting state: ACCEPTED AT AUTOMATED EVIDENCE; HUMAN ANDROID ACCEPTANCE OPEN
History disposition: append
~~~

~~~text
Claim: remote Product/Store reconciliation and page atomicity are corrected
Prior state: actionable R01 implementation gap
Evidence: Account-scoped reconciliation, remote-to-local remapping, typed
          conflicts, page-wide transaction and focused disposable-DB tests
Evidence boundary: deterministic local Flutter/Drift tests
Contradiction: corrected live Windows-to-Android download has not occurred
Semantic owner: remote local-materialization boundary
Target role: later single-operation live convergence assay
Resulting state: ACCEPTED AT IMPLEMENTATION/TEST SCOPE; LIVE ACCEPTANCE HELD
History disposition: append
~~~

~~~text
Claim: failed local apply cannot acknowledge
Prior state: frozen live failure showed acknowledgement not started
Evidence: no committed cursor after failure; focused test observes null
          acknowledgement result and zero transport acknowledgement calls
Evidence boundary: deterministic local failure path and prior frozen live assay
Contradiction: none
Semantic owner: local-commit-to-acknowledgement ordering
Target role: R02 regression evidence
Resulting state: VALIDATED AT REGRESSION SCOPE
History disposition: append
~~~

~~~text
Claim: R02 closes GCM03 or proves practical inter-device Sync usability
Prior state: GCM03 active; convergence unproved
Evidence: no live Sync, Retry, provider mutation, Android install or launch was
          executed during materialization
Evidence boundary: source/build/test only
Contradiction: practical usability requires preserved-state installation,
               offline UI acceptance, one bounded inbound Sync and postflights
Semantic owner: GCM03 live acceptance
Target role: human acceptance ladder
Resulting state: REJECTED / NOT YET PROVED
History disposition: append
~~~

### Human acceptance ladder

The remaining R02 acceptance is divided so one action cannot silently authorize
the next.

#### H01 — artifact-preserving install and offline preflight

Use the existing GS-FLUTTER-AND procedure from a clean local checkout whose
HEAD contains the reconciled J publication and R02 commit. It builds with the
configured public Closure coordinates, installs through adb install -r,
preserves application data, exposes build provenance, and launches Markei.

H01 must stop before any Closure network control. Required observations:

~~~text
installed build provenance contains cf8dcc6377b or its J-only descendant
Authentication remains authenticated
Enrollment remains device-enrolled
queue remains 0/0/0/0
Android next Device sequence remains 1
Android History still lacks the hosted candidate before corrected Sync
no automatic Sync or acknowledgement occurs
previous failed-operation evidence remains present or is safely retained
~~~

#### H02 — offline Purchase Product-selection acceptance

Without registering a Purchase:

1. open Purchase;
2. invoke Find code for the existing Catalogue Product that previously raised
   the Dropdown assertion;
3. verify exactly one existing Product becomes selected;
4. navigate away and return or trigger a harmless projection refresh;
5. verify the selection remains coherent by Product ID;
6. cancel/clear the draft without submission.

Required observations:

~~~text
red Flutter assertion = absent
selected Product = exactly one coherent existing Product
duplicate Catalogue row created = no
Purchase registered = no
producer queue changed = no
Device sequence changed = no
~~~

#### H03 — read-only pre-Sync baselines

Only after H01/H02 pass, take a fresh Android snapshot using the published
GS-SQLITE-05/06/07 sequence and one read-only GS-NEON-11 provider inventory.
The preserved pre-R02 snapshot remains immutable historical evidence; a new
snapshot must not overwrite it.

Expected local/provider invariants remain:

~~~text
Android cursor = null/0
Android inbox = empty
Android hosted Purchase facts = 0
Android queue = 0/0/0/0
Android Device sequence = 1
provider hosted high-water = 2
Android-origin provider submissions/events = 0/0
Android acknowledgement = absent/0
~~~

#### H04 — one corrected inbound Android ordinary Sync

H04 remains held until H01-H03 evidence is reconciled. A later Main packet may
authorize exactly one ordinary Sync, followed by immediate UI, SQLite and
read-only provider postflights. Retry, Recovery, Enroll and concurrent Windows
Sync remain prohibited.

### Current terminal

~~~text
CYCLE10=OPEN
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=ACTIVE_R02_HUMAN_ACCEPTANCE
C10_GCM03_S10_R02=IMPLEMENTED_VALIDATED_AUTOMATED_SCOPE
C10_GCM02_S09_R02=CONTINUITY_ALIAS_ONLY
R02_REMOTE_COMMIT=cf8dcc6377b54c4b6944b2dec6cd844721bd29b1
R02_SCOPE_RECONCILIATION=PASS
PRODUCT_SELECTOR_IDENTITY=STABLE_PRODUCT_ID
FIND_BY_CODE_AUTOMATED_REGRESSION=PASS
REMOTE_PRODUCT_IDENTITY_RECONCILIATION=PASS_AUTOMATED_SCOPE
REMOTE_STORE_IDENTITY_RECONCILIATION=PASS_AUTOMATED_SCOPE
REMOTE_ITEM_ID_REMAP=PASS_AUTOMATED_SCOPE
REMOTE_PAGE_ATOMICITY=PASS_AUTOMATED_SCOPE
LOCAL_APPLY_CAUSAL_DIAGNOSTICS=PASS_AUTOMATED_SCOPE
ACKNOWLEDGEMENT_AFTER_FAILED_LOCAL_APPLY=NOT_STARTED_VALIDATED
LIVE_CONVERGENCE_ACCEPTANCE=HELD
NEXT_GATE=C10_GCM03_S10_R02_H01
ANDROID_SNAPSHOT_PRE_R02=PRESERVE
WINDOWS_SYNC=HELD
ANDROID_SYNC=HELD
RETRY=HELD
RECOVERY=HELD
ENROLL=DO_NOT_REPEAT
PROVIDER_MUTATION=NONE
GCM04=UNDEFINED_INACTIVE
~~~


---

# Reconciliation — C10-GCM03-S10-R03 corrective staging

Recorded: 2026-07-29  
Primary unit: C10-GCM03-S10-R03  
Human-assay continuity alias: C10-GCM03-S09-R03  
Previous materialization: cf8dcc6377b54c4b6944b2dec6cd844721bd29b1  
Pre-stage head: 1975bf0d216ff03a3ead6c47e0892df00d55d62e  
Disposition: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED; LIVE SYNC HELD

## Historical sequence

### H01 preserved installation

~~~
BUILD_PROVENANCE=1975bf0d216f
AUTHENTICATION=AUTHENTICATED
ENROLLMENT=DEVICE_ENROLLED
QUEUE=0/0/0/0
NEXT_DEVICE_SEQUENCE=1
APP_DATA_CLEAR=NO
AUTOMATIC_SYNC=NOT_SEPARATELY_PROVED
~~~

### H02 Purchase acceptance

The prior Find Item assertion did not recur. Catalogue selection, review, and registration worked. The user’s C10-GCM03-S09-R03-H02 alias is preserved; the implementation authority is normalized to S10.

~~~
FIND_ITEM_ASSERTION=ABSENT
PURCHASE_REVIEW=PASS
PURCHASE_REGISTRATION=PASS
PENDING=0_TO_1
NEXT_DEVICE_SEQUENCE=1_TO_2
ACTIONABLE_EVENT_FINGERPRINT=e86df5c0
DUPLICATE_PRODUCT_OBSERVED=NO
~~~

No Product display name or user code is retained.

### Android attempts

Operation b161b297b16b uploaded the new event with HTTP 200 and persisted its trusted provider result. Download also returned HTTP 200, but local apply returned remote-product-natural-identity-conflict. No acknowledgement began.

Operation 5a3e6d18af89 had no pending upload, downloaded again, returned the same typed conflict, and did not acknowledge.

The Android event is hosted and must not be registered again. Repeated Sync remains held.

### Windows attempt

Operation e6e918285640 uploaded its event, persisted the trusted result, and received a trusted download response. It then escaped as closure-runner-exception before a durable local-apply result.

| UTC interval | Route | Child correlation | Result |
|---|---|---|---|
| 18:56:54.479–18:56:54.672 | POST /v1/sync/submissions | 013bbbc82c57 | authenticated; HTTP 200; under 250 ms |
| 18:56:54.949–18:56:54.981 | GET /v1/sync/events | d4e57c134aca | authenticated; HTTP 200; under 250 ms |
| absent | acknowledgement | none | correctly not started |

A readiness request completed with HTTP 200 before the operation. A later readiness request began at 18:56:58.786 but its completion is absent from the supplied excerpt. Health records have no operation fingerprint and cannot be attributed to Sync.

Windows lifecycle:

| Phase | Event | Result |
|---|---|---|
| 1–2 | authentication | authenticated |
| 3–4 | binding | accepted |
| 5–6 | upload lease | committed |
| 7–8 | upload transport/provider | server accepted |
| 9–10 | upload result persistence | committed |
| 11–12 | download transport/provider | trusted response received |
| 13 | terminal | closure-runner-exception |

Phase 13 claims trusted-response-not-received, contradicting phase 12. Stronger causal child evidence controls.

## PRC-01 reconciliation

~~~
WINDOWS_UPLOAD_TRANSPORT=PASS
WINDOWS_UPLOAD_PROVIDER=SERVER_ACCEPTED
WINDOWS_UPLOAD_RESULT_PERSISTENCE=COMMITTED
WINDOWS_DOWNLOAD_TRANSPORT=PASS
WINDOWS_DOWNLOAD_PROVIDER=TRUSTED_RESPONSE_RECEIVED
RENDER_REJECTION=FALSE
WINDOWS_LOCAL_APPLY=UNPROVED
WINDOWS_LOCAL_MUTATION=UNKNOWN
WINDOWS_FACTS_INBOX_CURSOR_COMMIT=UNKNOWN
WINDOWS_ACKNOWLEDGEMENT=NOT_STARTED
~~~

The evidence cannot distinguish an apply exception from diagnostic persistence failure after apply returned. No stronger claim is promoted.

~~~
ANDROID_TO_PROVIDER_UPLOAD=PASS
WINDOWS_TO_PROVIDER_UPLOAD=PASS
PROVIDER_TO_ANDROID_CONVERGENCE=FAIL_TYPED_PRODUCT_CONFLICT
PROVIDER_TO_WINDOWS_CONVERGENCE=FAIL_POST_DOWNLOAD_UNCLASSIFIED
INTER_DEVICE_SAME_ACCOUNT_SYNC=FAIL_OPEN
MVP_SYNC_ACCEPTANCE=NOT_PROMOTED
~~~

## Source reconciliation

- Product.identityKey excludes user code/raw display.
- Remote reconciliation currently rejects exact identity under another code.
- The applier rethrows unrecognized non-SQL exceptions.
- DownloadAndApplyEvents can skip local-apply declaration on apply or diagnostic failure.
- The coordinator catches only TimeoutException and StateError.
- NativeAuthClosureRunner replaces causal evidence with generic terminal state.
- The table stores sanitizedExceptionClass, but repository/application/UI projection drops it.

R02 claims narrow to:

~~~
PRODUCT_SELECTOR_IDENTITY=PASS_AUTOMATED_AND_HUMAN
REMOTE_PRODUCT_IDENTITY_RECONCILIATION=PASS_AUTOMATED_LIMITED
LOCAL_APPLY_CAUSAL_DIAGNOSTICS=PASS_TYPED_PATHS_ONLY
LOCAL_APPLY_CAUSAL_DIAGNOSTICS_UNCLASSIFIED_PATH=FAIL
LIVE_INTER_DEVICE_CONVERGENCE=FAIL_OPEN
~~~

## R03 directives

R03 shall implement asymmetric Product convergence, reference remapping, total after-rollback apply translation, diagnostic/core truth separation, pre-persistence causal snapshot, causal runner fallback, stored exception-class projection, atomic facts/inbox/cursor, acknowledgement ordering, and idempotent replay. Protocol v3, schema, provider, API, auth, enrollment, and dependencies remain unchanged.

D controls. E/F constrain. Codex must replace G/H/I and perform no live Sync.

## Current terminals

~~~
C10_GCM03_S10_R03=ACTIVE_CODEX_IMPLEMENTATION_AUTHORIZED
CONTINUITY_ALIAS=C10_GCM03_S09_R03
RENDER_SUBMISSION_RESPONSE=HTTP_200
RENDER_DOWNLOAD_RESPONSE=HTTP_200
RENDER_ACKNOWLEDGEMENT_REQUEST=ABSENT
WINDOWS_LAST_PROVED_PHASE=DOWNLOAD_PROVIDER_RESPONSE_RECEIVED
WINDOWS_TERMINAL_CLASSIFICATION=CONTRADICTS_CAUSAL_CHILD
WINDOWS_LOCAL_MUTATION=UNKNOWN
ANDROID_PRODUCT_CONFLICT=TYPED
INTER_DEVICE_CONVERGENCE=FAIL_OPEN
ANDROID_SYNC=HELD
WINDOWS_SYNC=HELD
RETRY_RECOVERY=HELD
NEW_PURCHASE_REGISTRATION=HELD
PROVIDER_MUTATION=NONE
~~~

---

# 2026-07-29 — Full handoff: C10-GCM03-S10-R03 corrective materialization launch

## Sequence Handoff Envelope

```text
Outgoing sequence: FLX-PRM-04 diagnostic reconciliation and FLX-ORD-01 staging
Receiving sequence: FLX-ORD-01 Codex corrective materialization
Outgoing role: Main Chat [M], exhausted-session closure
Receiving roles:
  1. fresh Main Chat [M] for continuity and later reconciliation
  2. Codex for the already-authorized corrective implementation
Primary unit: C10-GCM03-S10-R03
Human-assay continuity alias: C10-GCM03-S09-R03
Repository: gus-i-gu/markei
Existing GitHub branch: grm-guarded-provisioning-20260727
Pre-handoff authority commit: b9882118b543cc9637af31f8343935bee94300de
Required Codex starting head: the direct J-handoff descendant of b988211,
                              pinned by the launch prompt
Authority: human direction plus active D/E/F stage
Writable surface of this handoff publication: append-only J_MAIN_STAGE.md
Codex writable surface: exactly the source/test/G/H/I scope authorized by D
Evidence boundary: D/E/F/J/REC_DIAGNOSTICS.md at b988211 plus inspected
                   one-commit ancestry from 1975bf0
Live operation authority: NONE
```

This handoff closes only the exhausted conversation. It does not close R03,
GCM03 or Cycle 10, and it does not promote live synchronization acceptance.

## 1. Recovery instruction for the fresh Main Chat

Recover the project from repository memory rather than reconstructing the
exhausted conversation.

Read in this order:

1. root `AGENTS.md`;
2. `documentation/sketch_notebook/INDEX.md`;
3. notebook `AGENTS.md`;
4. the complete methodology route selected by `INDEX.md`:
   `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`,
   `CHAT_PROTOCOL.md`;
5. the newest section of this J file, including the R03 reconciliation
   immediately above and this handoff;
6. `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`;
7. `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`;
8. `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`;
9. `documentation/REC_DIAGNOSTICS.md`, Appendix G / Records 018–020;
10. G/H/I only after Codex publishes the R03 materialization.

Use hierarchical recovery. Earlier J/REC history remains available when a
claim requires provenance, but the current R03 sections are the controlling
low-cost recovery surface.

Do not redirect Codex through old A/B/C stages, prior R02 G/H/I reports,
conversation screenshots, or a reconstructed prompt that weakens D/E/F.

## 2. Authority and naming

The controlling implementation unit is:

```text
C10-GCM03-S10-R03
```

The manual-assay label used during the live failure chain is retained as:

```text
C10-GCM03-S09-R03
```

The alias must not be erased because it connects the human H02/Sync evidence
to the correction. It must not replace the primary S10 implementation unit in
source reports, validation terminals or the final implementation commit.

Authority order for the materialization is:

```text
D_OPS_STAGE.md = controlling operational scope and terminals
E_DDC_STAGE.md = evidence and interpretation constraints
F_DSN_STAGE.md = architecture and responsibility constraints
J_MAIN_STAGE.md = Main reconciliation, continuity and launch envelope
REC_DIAGNOSTICS.md = append-only sanitized human/provider evidence
G/H/I = post-materialization observations, not canonical truth
```

If D/E/F are contradictory, missing, or insufficient, Codex must stop. Codex
must not use J or REC_DIAGNOSTICS.md to expand the writable source scope.

## 3. State that the receiving chat must retain

R02 corrected and human-validated the Purchase Product-selector defect:

```text
PRODUCT_SELECTOR_IDENTITY=STABLE_PRODUCT_ID
FIND_ITEM_ASSERTION=ABSENT_HUMAN_ASSAY
PURCHASE_REVIEW=PASS
PURCHASE_REGISTRATION=PASS
```

The subsequent live assays proved both hosted transport and a still-open local
convergence defect:

```text
ANDROID_UPLOAD_PROVIDER=HTTP_200_TRUSTED
ANDROID_UPLOAD_RESULT_PERSISTENCE=COMMITTED
ANDROID_DOWNLOAD_PROVIDER=HTTP_200_TRUSTED
ANDROID_LOCAL_APPLY=REMOTE_PRODUCT_NATURAL_IDENTITY_CONFLICT

WINDOWS_UPLOAD_PROVIDER=SERVER_ACCEPTED
WINDOWS_UPLOAD_RESULT_PERSISTENCE=COMMITTED
WINDOWS_DOWNLOAD_PROVIDER=TRUSTED_RESPONSE_RECEIVED
WINDOWS_LOCAL_APPLY=NO_DURABLE_RESULT
WINDOWS_TERMINAL=CLOSURE_RUNNER_EXCEPTION

ACKNOWLEDGEMENT_AFTER_BOTH_FAILED_DOWNLOADS=NOT_STARTED
RENDER_REJECTION=FALSE
```

The Android page proves a Product reconciliation conflict. The Windows page
proves a trusted download response followed by an exception escaping the
typed local-apply boundary. The Windows terminal then incorrectly replaced
the already-proved trusted response with a generic not-received state.

The Android event and the later Windows event were already accepted by the
provider. Neither purchase may be registered again merely to repeat the test.

## 4. Evidence ceilings that must not be promoted

The supplied Windows evidence does not prove whether facts, inbox and cursor
committed or rolled back before diagnostic persistence or runner failure.

Retain:

```text
WINDOWS_TRANSACTION_TRUTH=UNKNOWN
WINDOWS_LOCAL_MUTATION=UNKNOWN
WINDOWS_FACTS_INBOX_CURSOR_COMMIT=UNKNOWN
```

Do not infer rollback from the absence of acknowledgement. Do not infer commit
from the successful provider download. Do not let diagnostic truth define
transaction truth.

R02 causal diagnostics are therefore classified as:

```text
LOCAL_APPLY_CAUSAL_DIAGNOSTICS=PASS_TYPED_PATHS_ONLY
LOCAL_APPLY_CAUSAL_DIAGNOSTICS_UNCLASSIFIED_PATH=FAIL
```

Automated R03 validation will not prove live convergence. A passing Flutter
suite or disposable local database test cannot promote GCM03 acceptance.

## 5. Corrective mission already authorized by D/E/F

Codex must implement the complete R03 correction, with D controlling exact
requirements.

The cohesive mission has six parts:

1. For a previously unseen incoming Product UUID, reuse the one coherent
   Account-scoped Product when exact semantic identity matches even if the two
   clients chose different user Product codes. Preserve the selected local
   code and display.
2. Preserve conflicts for same code/different identity, split natural keys,
   ambiguity, and established-UUID immutable mutation. Never use first-row
   wins and never rewrite hosted events or existing Product identities.
3. Maintain incoming-to-local Product identity mapping for Purchase Items and
   preserve the already-correct Store mapping/reconciliation contract.
4. Make the post-download local-apply boundary total: every exception must
   leave the Drift transaction first, allow full rollback, and then become a
   bounded sanitized result. No apply exception may escape into the UI runner.
5. Separate synchronization truth from diagnostic truth. Update an in-memory
   causal snapshot before fallible durable diagnostics; contain diagnostics
   persistence failure without reversing a committed core result; make the
   runner consume the strongest causal snapshot.
6. Project the existing stored sanitized exception class through repository,
   application summary and Closure UI without a migration or unsafe message,
   SQL, payload, identifier, stack, token, secret or full-hash disclosure.

The single page transaction must continue to own Product/Store reconciliation,
Purchases, Purchase Items, inbox records and Account cursor. Acknowledgement
may begin only from a committed cursor. Replay must remain idempotent.

## 6. Required implementation boundaries

Preserve:

```text
protocol payload version = 3
Flutter/Drift schema = unchanged
hosted API/server = unchanged
Auth0 authentication = unchanged
Device enrollment/binding = unchanged
Store identity rules = unchanged unless a source-proved minimal correction is
                       strictly required by D
Person/Payment Method v3 remote restriction = unchanged
dependencies = unchanged
GitHub branch = existing guarded branch
```

Prohibited during Codex execution:

```text
Android or Windows Sync
Retry, Recovery, Enroll or Query
new Purchase registration
acknowledgement or provider mutation
database surgery or application-data clearing
schema, migration, API, payload, authentication or dependency change
branch creation, rename, rebase, force push, reset or clean
methodology, permanent-domain, J or REC_DIAGNOSTICS edits
DB_MGMT.sql, G_SCRIPTS.md or I_SCRIPTS.ps1 edits
test weakening, exception swallowing or first-row-wins reconciliation
```

## 7. Codex validation and evidence return

Codex must implement the D test matrix, including:

- exact identity under another code for a new incoming UUID;
- same code/different identity, split-key, ambiguity and established UUID
  conflict cases;
- local code/display preservation and remote-to-local Item remapping;
- mixed Android/Windows cursor page convergence and poison-page recovery;
- generic non-SQL failure with full facts/inbox/cursor rollback;
- acknowledgement prohibition after failed or unproved apply;
- committed apply with diagnostic-persistence degradation;
- causal trusted-response preservation through apply/reporting/runner failures;
- sanitized exception-class projection to Closure UI;
- Product-selector, Store, queue, upload-result and v3 restriction regressions;
- idempotent replay and unchanged hosted protocol.

Required validation evidence is the exact D list: format, analysis, focused
tests, full Flutter test suite, debug Android and Windows builds, manifest
inspection where applicable, diff check, sensitive-content scan and exact
changed-file inventory.

Codex shall replace only:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

alongside the source/tests authorized by D.

The Codex return must include:

```text
final commit SHA and parent
remote branch read-back
exact changed-file list
implementation summary by D requirement
focused and full validation outcomes
skipped or environment-limited evidence
G/H/I terminal states
confirmation of zero live/client/provider mutation
```

## 8. Fresh Main Chat first responsibility

The fresh Main Chat should not reopen the completed diagnosis before Codex
starts. Its first responsibility is to verify the handoff publication at the
remote branch head and issue the exact Codex prompt pinned to that commit.

While Codex runs, Main may prepare the post-materialization reconciliation
frame, but it must not issue any live Sync authorization.

After Codex publishes:

1. verify the materialization is one non-forced fast-forward descendant of the
   handoff commit;
2. compare the changed paths against D;
3. read G/H/I as observational evidence;
4. reconcile source decisions, tests, builds, terminals and residual limits;
5. append the R03 post-Codex reconciliation to J;
6. authorize a preserved-state build/install and offline preflight only;
7. issue a new, separately numbered one-operation live assay only after the
   installed artifact and read-only baselines pass.

Neither the current handoff nor the future Codex success authorizes immediate
Sync.

## 9. Post-Codex human acceptance outline

The exact manual packet must be derived from the implemented commit rather
than copied blindly from R02. At minimum it must preserve existing Android and
Windows application data and verify:

1. both corrected binaries carry the reconciled R03 provenance;
2. authentication, enrollment, queues and Device sequences remain coherent;
3. no automatic Sync or acknowledgement occurred during installation/launch;
4. offline Find Item and Purchase projection remain correct;
5. current local/provider read-only baselines are frozen;
6. exactly one client ordinary Sync is authorized first;
7. UI, SQLite, Render and provider postflights agree before the other client
   can Sync;
8. one no-op replay proves idempotency and no duplicate Product, Store,
   Purchase or Purchase Item.

Retry and Recovery remain separate later decisions. They are not substitutes
for the first corrected ordinary-Sync assay.

## 10. Fresh-chat stop and escalation conditions

Stop and preserve evidence if:

- the remote head is not the handoff commit pinned by the prompt;
- the branch diverged or a force update is required;
- D/E/F disagree or their writable scope is insufficient;
- implementation requires schema/provider/API/auth/dependency change;
- unrelated work overlaps an authorized source or report file;
- a validation failure is hidden by skipped tests or swallowed exceptions;
- a secret, token, connection string, payload fact, SQL value or identifier
  appears in a proposed report;
- any live Sync, Retry, Recovery, Enroll, Query, acknowledgement or provider
  mutation would be needed to claim success.

Write a precise G/H/I blocker rather than improvising outside the envelope.

## 11. Handoff terminals

```text
CYCLE10=OPEN
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=ACTIVE_CORRECTIVE_MATERIALIZATION
C10_GCM03_S10_R03=CODEX_IMPLEMENTATION_AUTHORIZED_NOT_STARTED
C10_GCM03_S09_R03=HUMAN_ASSAY_CONTINUITY_ALIAS
R03_STAGE_COMMIT=b9882118b543cc9637af31f8343935bee94300de
R03_HANDOFF_COMMIT=PIN_FROM_PUBLICATION
PRODUCT_SELECTOR_REGRESSION=PASS_AUTOMATED_AND_HUMAN
ANDROID_PROVIDER_UPLOAD=PASS_TRUSTED
WINDOWS_PROVIDER_UPLOAD=PASS_TRUSTED
ANDROID_INBOUND_CONVERGENCE=FAIL_TYPED_PRODUCT_CONFLICT
WINDOWS_INBOUND_CONVERGENCE=FAIL_POST_DOWNLOAD_UNCLASSIFIED
WINDOWS_TRANSACTION_TRUTH=UNKNOWN
ACKNOWLEDGEMENT_AFTER_FAILED_OR_UNPROVED_APPLY=NOT_STARTED
RENDER_REJECTION=FALSE
INTER_DEVICE_SAME_ACCOUNT_SYNC=FAIL_OPEN
MVP_SYNC_ACCEPTANCE=NOT_PROMOTED
ANDROID_SYNC=HELD
WINDOWS_SYNC=HELD
RETRY_RECOVERY=HELD
NEW_PURCHASE_REGISTRATION=HELD
DIAGNOSTIC_HISTORY=PRESERVE
PROVIDER_MUTATION=NONE
NEXT_ACTION=PIN_HANDOFF_COMMIT_AND_LAUNCH_CODEX_R03
```

This section is the recovery bridge for the fresh Main Chat. Detailed human
evidence remains in `documentation/REC_DIAGNOSTICS.md`; executable correction
authority remains in D/E/F.


---

# 2026-07-29 — Post-Codex reconciliation: C10-GCM03-S10-R03

## 1. Reconciliation envelope

~~~text
Sequence: FLX-PRM-04 post-materialization reconciliation
Primary unit: C10-GCM03-S10-R03
Human-assay continuity alias: C10-GCM03-S09-R03
Repository: gus-i-gu/markei
Branch: grm-guarded-provisioning-20260727
Controlling handoff head: 8fb43654b3e93908530165c29e580a5f5c12c1f8
Materialization commit: 23cd872848ebc0654a4d9de6f41a9ba3c09fe92c
Materialization parent: 8fb43654b3e93908530165c29e580a5f5c12c1f8
Remote branch read-back before J publication: identical to 23cd872
Materialization distance: exactly one non-forced fast-forward commit
Live operation authority during reconciliation: NONE
~~~

This entry reconciles the published R03 implementation against D/E/F, the
actual source/test diff, G/H/I and the retained human/provider evidence. It does
not erase the R03 diagnosis or accept the Codex terminal merely because the
reported commands passed.

## 2. Publication and writable-scope guard

The materialization changed exactly fourteen paths:

~~~text
clients/markei_flutter/lib/app/native_auth_closure_runner.dart
clients/markei_flutter/lib/app/pages/native_closure_page.dart
clients/markei_flutter/lib/application/closure_diagnostics.dart
clients/markei_flutter/lib/application/sync/sync_ports.dart
clients/markei_flutter/lib/application/sync/sync_use_cases.dart
clients/markei_flutter/lib/infrastructure/local/closure_diagnostics_repository.dart
clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_event_applier.dart
clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_fact_writer.dart
clients/markei_flutter/test/app/native_closure_diagnostics_test.dart
clients/markei_flutter/test/infrastructure/closure_diagnostics_repository_test.dart
clients/markei_flutter/test/infrastructure/remote_purchase_event_applier_test.dart
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
~~~

Every changed path falls inside D's source/test/G/H/I writable envelope. No
D/E/F, J, REC_DIAGNOSTICS, methodology, permanent domain memory, GRIMOIRE
operator file, migration, schema, hosted API, authentication, enrollment,
dependency or provider-configuration path entered the materialization commit.

~~~text
R03_FAST_FORWARD_GUARD=PASS
R03_CHANGED_PATH_SCOPE=PASS
R03_BRANCH_TOPOLOGY=PASS
R03_LIVE_OPERATION_DURING_CODEX=NO_REPORTED
R03_PROVIDER_MUTATION_DURING_CODEX=NONE_REPORTED
~~~

## 3. Source decisions accepted at implementation scope

### Product identity and reference convergence

RemotePurchaseFactWriter now distinguishes an established incoming UUID from a
previously unseen incoming UUID.

For an established UUID, full immutable coherence still includes user code and
display fields. For a new UUID, resolution obtains all Account-scoped normalized
code matches and exact-identity matches, rejects ambiguity and split keys, rejects
same-code/different-identity, and reuses one exact-identity row despite another
client-chosen code. The selected local code and display are preserved.

The incoming Product UUID to selected local Product UUID map is then used for
dependent Purchase Items. The Store path remains the prior Account-scoped
incoming-UUID/display-identity rule.

The implementation therefore corrects the source mechanism that produced the
Android remote-product-natural-identity-conflict without introducing an alias
table, hosted rewrite, migration or global Product equality override.

### Page atomicity and local-apply translation

DriftRemoteEventApplier still places validation, Product/Store reconciliation,
Purchase facts, Purchase Items, inbox rows and Account cursor advancement inside
one Drift transaction.

RemoteIdentityConflict and every other thrown Object leave that transaction
before translation. The outer boundary now maps identity, typed SQLite/Drift,
payload-shape, local-invariant and residual unexpected failures to bounded
SyncResult categories. The residual catch no longer rethrows into the UI runner.

This is implementation evidence that the previously unclassified post-download
apply path now has a total source boundary. It is not evidence that the frozen
Windows operation rolled back, nor can it reconstruct that historical
transaction truth.

### Stored exception-class projection

The existing sanitizedExceptionClass field now flows through SyncResult,
diagnostic persistence, repository projection, application summary,
current-action mapping and the Closure technical-details UI. No migration was
introduced. The added repository and widget assertions establish the bounded
class projection at automated scope.

### Acknowledgement ordering

The coordinator still stops on a blocked download result before calling
AcknowledgeAppliedCursor. Acknowledgement eligibility still comes from the
greatest committed contiguous local cursor. Focused failure tests observe no
acknowledgement after SQLite and payload-shape apply failures.

These source decisions are accepted as implemented. Their live behavior remains
unproved.

## 4. Validation evidence reported by Codex

Codex reports:

~~~text
dart format check=PASS
flutter analyze=PASS
focused changed diagnostic/apply tests=48 PASS
local sync application tests=29 PASS
two-device local harness=1 PASS
v3 contract tests=2 PASS
catalogue/store identity tests=8 PASS
markei_app widget tests=26 PASS
full flutter test=215 PASS / 4 disposable labs skipped
debug Android APK build=PASS
Windows build=PASS after releasing a local executable lock
merged Android manifest inspection=PASS
git diff --check=PASS
changed-content sensitive scan=PASS reported
~~~

The Windows build's first failure was an environment lock, followed by a passing
retry. The disposable HTTP/PostgreSQL/provider labs were not run because
MARKEI_RUN_SYNC_LAB was unset. No live client/provider assay occurred.

Under PRC-01 this proves strong static, deterministic automated and packaging
evidence. It does not prove installed preserved-state behavior, provider
convergence, acknowledgement, inter-device usability or GCM03 acceptance.

## 5. D-matrix reconciliation gaps

Inspection of the actual test additions does not support every G/H/I terminal at
the strength reported.

The added remote-applier tests cover:

- new UUID plus exact identity under another code;
- same code plus different identity;
- split natural keys;
- two-event Item remapping;
- page rollback on typed conflict;
- SQLite failure with no acknowledgement;
- payload-shape failure with bounded class and rollback.

The R03 diff does not add direct tests for all D-required branches:

- ambiguous normalized-code match;
- ambiguous exact-identity match;
- established UUID immutable mutation;
- a mixed Android/Windows page reproducing distinct client codes and later
  cursor progression without duplicates;
- the previously rejected hosted event followed by later-page poison recovery;
- the residual unexpected-local-apply-failed category itself, rather than a
  TypeError translated as payload-shape failure;
- diagnostic-persistence failure before apply;
- diagnostic-persistence failure while recording a rolled-back result;
- diagnostic-persistence failure after a committed apply;
- committed apply remaining acknowledgement-eligible under diagnostic
  degradation;
- runner fallback after those injected persistence failures.

The full suite contains prior replay, cursor and acknowledgement tests, but those
do not substitute automatically for the precise R03 injection matrix.

Therefore:

~~~text
PRODUCT_EXACT_ID_DIFFERENT_CODE=PASS_IMPLEMENTED_AND_FOCUSED_TESTED
PRODUCT_CODE_DIFFERENT_IDENTITY_CONFLICT=PASS_IMPLEMENTED_AND_FOCUSED_TESTED
REMOTE_ITEM_ID_REMAP=PASS_IMPLEMENTED_AND_FOCUSED_TESTED
REMOTE_PAGE_ATOMICITY=PASS_IMPLEMENTED_AND_PARTIALLY_TESTED
UNEXPECTED_LOCAL_APPLY_TRANSLATION=IMPLEMENTED_NOT_DIRECTLY_TESTED
AMBIGUOUS_PRODUCT_MATCHES=IMPLEMENTED_NOT_DIRECTLY_TESTED
ESTABLISHED_UUID_MUTATION=IMPLEMENTED_NOT_DIRECTLY_TESTED
POISON_PAGE_RECOVERY=NOT_DIRECTLY_TESTED
DIAGNOSTIC_PERSISTENCE_CONTAINMENT=PARTIAL_EVIDENCE
SANITIZED_EXCEPTION_CLASS_UI=PASS_IMPLEMENTED_AND_FOCUSED_TESTED
ACKNOWLEDGEMENT_AFTER_UNPROVED_APPLY=NOT_STARTED_FOCUSED_TESTED
~~~

## 6. Residual causal-snapshot defect

The in-memory recorder updates its stored evidence before attempting a durable
diagnostic write and contains recordDiagnosticEvent failures. That is a real
improvement over R02.

However, the current _preferStrongestEvidence function is not a cumulative
operation snapshot. Except when the new candidate newly proves trusted response
received, newly proves local mutation committed, or is a generic terminal, it
replaces the previous evidence object.

A later acknowledgement-request phase is non-terminal and normally declares:

~~~text
trustedResponseState=not-received
localMutationState=none/default
providerContactState=request-started
~~~

It can therefore replace an earlier download-local-apply declaration that had
already proved:

~~~text
trustedResponseState=received
localMutationState=committed
lastProvedPhase=download-local-apply
~~~

If acknowledgement transport or later coordination then throws, the runner
fallback can consume the weaker acknowledgement-request object and lose the
proved committed local-apply/trusted-download facts. This conflicts with D
sections 5 and 7 and F sections 4 and 6, which require a snapshot retaining
provider, apply, local mutation and acknowledgement truth separately.

There is a second observability gap: beginDiagnosticAttempt failure sets
attemptId to null but does not mark diagnostic persistence degraded. Subsequent
phase calls skip durable writes without necessarily exposing
diagnostics-persistence-degraded, and the final operation lifecycle declaration
does not establish that the degradation became visible.

No added R03 test injects these exact sequences.

Consequently the G/H/I claims CAUSAL_EVIDENCE_PRESERVATION=PASS and
DIAGNOSTIC_PERSISTENCE_CONTAINMENT=PASS are not promoted by Main.

~~~text
CAUSAL_EVIDENCE_PRESERVATION=PARTIAL_FAIL_ACK_TRANSITION
DIAGNOSTIC_BEGIN_FAILURE_DEGRADATION=NOT_PROVED
DIAGNOSTIC_AFTER_COMMIT_DEGRADATION=NOT_PROVED
RUNNER_FALLBACK_STRONGEST_CAUSE=PARTIAL
~~~

## 7. PRC-01 disposition

~~~text
Claim: R03 was published as one scoped fast-forward commit
Result: ACCEPTED
Evidence ceiling: GitHub ancestry and changed-path comparison

Claim: exact Product identity under another client code is corrected
Result: ACCEPTED_AT_IMPLEMENTATION_AND_FOCUSED_TEST_SCOPE
Evidence ceiling: deterministic Flutter/Drift source and test; no live client

Claim: every apply exception has a bounded post-rollback source translation
Result: ACCEPTED_AT_SOURCE_SCOPE
Evidence ceiling: residual unexpected category lacks a direct injected test

Claim: transaction truth is independent of diagnostic persistence
Result: PARTIALLY_ACCEPTED
Evidence ceiling: production recorder contains row-write failures, but required
                  before/after-commit injection evidence is incomplete

Claim: the runner always preserves the strongest causal truth
Result: REJECTED_AS_COMPLETE
Evidence: later acknowledgement request can replace earlier committed apply state

Claim: R03 satisfies the complete controlling D test matrix
Result: REJECTED
Evidence: named required cases above are absent from the materialization diff

Claim: practical Android/Windows Sync is now solved
Result: REJECTED / NOT YET PROVED
Evidence: no corrected binaries were installed or exercised; one causal defect
          and multiple D validation gaps remain

Claim: the historical Windows transaction truth is now known
Result: REJECTED
Evidence: new source cannot retroactively classify the frozen operation
~~~

## 8. Main terminal and required corrective continuation

The Codex report's IMPLEMENTED_VALIDATED terminal is retained as a Codex
observation but is not promoted as the Main terminal.

~~~text
CYCLE10=OPEN
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=ACTIVE_CORRECTIVE_MATERIALIZATION
C10_GCM03_S10_R03=IMPLEMENTED_WITH_MAIN_RECONCILIATION_GAPS
C10_GCM03_S09_R03=HUMAN_ASSAY_CONTINUITY_ALIAS
R03_REMOTE_COMMIT=23cd872848ebc0654a4d9de6f41a9ba3c09fe92c
R03_SCOPE_RECONCILIATION=PASS
R03_D_MATRIX_RECONCILIATION=PARTIAL_FAIL
PRODUCT_CONVERGENCE_CORRECTION=IMPLEMENTED_FOCUSED_TESTED
TOTAL_APPLY_TRANSLATION=IMPLEMENTED_PARTIALLY_TESTED
CAUSAL_SNAPSHOT_ACK_TRANSITION=FAIL_OPEN
DIAGNOSTIC_DEGRADATION_VISIBILITY=FAIL_OPEN
INTER_DEVICE_SAME_ACCOUNT_SYNC=FAIL_OPEN
MVP_SYNC_ACCEPTANCE=NOT_PROMOTED
ANDROID_SYNC=HELD
WINDOWS_SYNC=HELD
RETRY_RECOVERY=HELD
NEW_PURCHASE_REGISTRATION=HELD
DIAGNOSTIC_HISTORY=PRESERVE
PROVIDER_MUTATION=NONE
NEXT_ACTION=STAGE_ONE_FOCUSED_R03_COMPLETION_ROUND
~~~

A new implementation authority should use a fresh revision identifier rather
than silently rewriting R03 success. Main's proposed identifier is:

~~~text
C10-GCM03-S10-R04
continuity: C10-GCM03-S09-R04
~~~

Its scope should be limited to:

1. replace the single strongest-evidence object with a cumulative causal state
   that preserves download trust, apply commit/rollback and acknowledgement
   state independently;
2. surface begin/row/complete diagnostic persistence failure as bounded
   degradation without changing core truth;
3. add the missing D decision/injection tests listed above;
4. preserve the R03 Product resolver, total transaction boundary, exception
   projection, protocol v3, schema, hosted API, auth/enrollment and provider
   immobility;
5. replace G/H/I and publish one scoped fast-forward commit;
6. perform no live Sync, Retry, Recovery, Query, Enroll, acknowledgement or new
   Purchase registration.

No preserved-state install or live S09 assay is authorized until this completion
round is materialized and reconciled.

## 9. Provisional S09 human-assay route after corrective closure

The former GCM03 human plan may be recovered for exact labels and client order,
but it is not needed to decide the present stop. After R04 passes Main
reconciliation, the human-assay route should be restaged from the actual R04
commit:

1. build/install corrected Android and Windows binaries while preserving both
   application data sets and diagnostic history;
2. prove build provenance, authenticated state, existing enrollment, local queue
   shape, Device sequences and absence of automatic Sync;
3. run offline Product/History projections only, registering no new Purchase;
4. capture fresh read-only Android SQLite, Windows SQLite and provider baselines;
5. authorize exactly one ordinary Sync on one named client;
6. reconcile UI, SQLite, Render and provider postflights before authorizing the
   other client;
7. prove acknowledgement only after committed cursor exposure;
8. run one separately authorized no-op replay to prove idempotency and absence of
   duplicate Product, Store, Purchase or Purchase Item.

The exact first client and the prior human record labels must be reconciled from
the former GCM03 plan or REC evidence before issuing the executable S09 packet.
They must not be guessed from this implementation report.

## 10. Answer to the overall Sync question

R03 materially corrects the Product exact-identity conflict and makes the local
apply boundary much safer. It does not yet establish the overall solution for
Sync.

The remaining layers are:

~~~text
source Product convergence: corrected at focused automated scope
source local-apply totality: implemented, incomplete direct validation
causal diagnostic continuity through acknowledgement: still defective
preserved-state Android/Windows installation: not performed
live provider-to-client convergence: not rerun
acknowledgement and postflight agreement: not observed
idempotent live replay: not observed
GCM03 acceptance: not promoted
~~~

Accordingly, no live control is released by this reconciliation.

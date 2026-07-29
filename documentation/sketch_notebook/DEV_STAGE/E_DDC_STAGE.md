# E_DDC_STAGE — Evidence contract for C10-GCM03-S10-R04

D_OPS_STAGE.md is operational authority. This file defines evidence meaning and
acceptance ceilings. F_DSN_STAGE.md assigns responsibilities.

Primary unit: C10-GCM03-S10-R04

Continuity alias: C10-GCM03-S09-R04

Pre-stage head: 5d7cd6c9784f0fa169a5ed6fb6ca8cb3db4037ce

## 1. R03 claims retained

At implementation and focused automated scope, R03 established:

- new remote UUID plus exact semantic identity under another code can converge;
- same-code/different-identity and split-key cases conflict;
- dependent Purchase Items receive the selected local Product UUID;
- page apply remains one Drift transaction;
- apply failures have an outer bounded translation path;
- the sanitized exception class reaches the Closure UI;
- acknowledgement stays behind committed cursor exposure.

These do not establish practical cross-device Sync. They are the regression
baseline for R04, not conclusions to re-litigate without contrary source proof.

## 2. R04 evidence deficit

R04 exists because R03 did not directly prove:

- cumulative causal truth through acknowledgement and terminal transitions;
- begin/row/complete diagnostic-persistence degradation;
- committed apply remaining acknowledgement-eligible under degradation;
- all Product ambiguity and established-UUID branches;
- the residual unexpected local-apply category;
- poison-page recovery and mixed-client replay without duplicates.

One passing full suite cannot substitute for these named injections.

## 3. Independent truth planes

| Plane | Question | Authority |
|---|---|---|
| Provider | Was a request/response accepted or received? | trusted transport result |
| Transaction | Did facts/inbox/cursor commit or roll back? | Drift transaction/result |
| Diagnostic | Was an attempt/event/completion record persisted? | recorder repository |
| Acknowledgement | Did ack start and receive a classified result? | coordinator/transport |
| Presentation | What bounded state reached lifecycle/UI? | application projection |

Failure or absence in one plane cannot invent or erase truth in another.

Examples:

- diagnostic begin failure does not imply transaction rollback;
- diagnostic completion success does not prove provider acceptance;
- acknowledgement-request does not erase a committed local apply;
- trusted HTTP response does not itself prove local convergence;
- a built binary does not prove preserved-state client behavior.

## 4. Cumulative evidence semantics

Evidence is cumulative when each authoritative phase contributes to independent
fields instead of replacing the entire operation snapshot.

The required proof is not merely that one “strongest” event is selected. Tests
must show that:

- trusted-response proof survives later weaker/default values;
- committed or rolled-back apply truth survives acknowledgement and terminal
  phases;
- acknowledgement state advances independently;
- latest entered phase can advance while latest proved phase and earlier facts
  remain available;
- diagnostic degradation is additive and never presented as transaction truth;
- contradictory authoritative core states are bounded explicitly.

Tests that assert only the final result string are insufficient. Assert the
separate provider, local mutation, persistence, acknowledgement, phase, and
sanitized-class fields.

## 5. Diagnostic degradation

`diagnostics-persistence-degraded` means core execution truth exists but some
authorized diagnostic persistence failed.

It may be established by:

- begin-attempt failure;
- phase/event-row failure;
- attempt-completion failure.

Required negative conclusions:

- it does not mean `rolled-back`;
- it does not mean `committed`;
- it does not mean provider response received;
- it does not authorize acknowledgement;
- it does not prohibit acknowledgement when committed cursor truth independently
  authorizes it;
- it does not convert a successful core Sync into a failed core Sync.

When durable storage is unavailable, a bounded in-memory/lifecycle declaration is
valid diagnostic evidence at runtime-observation scope only.

## 6. Product and replay evidence

Each Product decision-table branch needs a deterministic assertion over:

- selected/conflict result;
- local Product cardinality and preserved code/display;
- remote-to-local reference mapping;
- facts/inbox/cursor outcome;
- acknowledgement eligibility.

If ambiguity is structurally unreachable in the production database, prove the
constraint and test the resolver branch through a safe seam. Do not report an
unreachable branch as tested merely because ordinary insertion rejects the
fixture.

Poison-page recovery requires a sequence, not two isolated unit tests:

1. the formerly rejected exact-identity/different-code event is replayed;
2. it applies once;
3. a later event/page progresses;
4. replay creates no duplicate facts or cursor effects.

The two-device harness remains deterministic local evidence, not provider or live
Android/Windows evidence.

## 7. PRC-01 disposition rules

| Evidence | Maximum conclusion |
|---|---|
| Source inspection | implemented |
| Focused deterministic test | modeled branch validated |
| Full Flutter suite | repository regression evidence |
| APK/Windows build | package materialized |
| Disposable lab skipped | no lab conclusion |
| No live client/provider action | no practical Sync conclusion |
| Future preserved-state assay | only its prescribed client/provider scope |

Codex may conclude `IMPLEMENTED_VALIDATED` only if every D terminal has direct
evidence or is honestly marked partial/blocked. Main alone reconciles GCM03 and
MVP Sync acceptance.

## 8. Safety and sanitization evidence

Directly assert that diagnostic models, lifecycle output, repository projection,
and reports exclude:

- exception messages and `toString()` output;
- SQL and database values;
- Product/Purchase/Store/person/payment facts;
- UUIDs and raw operation/correlation identifiers;
- payloads, tokens, credentials, stacks, secrets, and full hashes.

Allow only bounded codes, allow-listed/sanitized class names, counts, sequence
numbers, short fingerprints, timing bands, and states already authorized by D.

## 9. Acceptance boundary

R04 automated success can authorize Main to inspect the diff and consider a
preserved-state build/install plus read-only preflight. It cannot authorize or
prove:

- Android or Windows live Sync;
- Retry, Recovery, Query, enrollment, or new Purchase registration;
- hosted acknowledgement;
- inter-device same-account convergence;
- idempotent provider replay;
- GCM03 closure or MVP Sync acceptance.

Both clients remain held until Main publishes a separate post-R04 operator
packet derived from the actual implementation commit and fresh read-only
baselines.

## 10. Review questions

- Is causal state merged field-by-field rather than replaced event-by-event?
- Can acknowledgement-request or terminal phases erase download/apply proof?
- Are begin, row, and completion persistence failures visible and contained?
- Can diagnostic degradation change the core result or ack eligibility?
- Are all missing Product/apply/replay branches directly tested?
- Does the poison-page sequence advance without duplicates?
- Are R03 Product, transaction, protocol, and UI properties preserved?
- Did any live/provider/schema/API/auth/dependency action occur?

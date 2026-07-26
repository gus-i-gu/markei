# E_DDC_STAGE — Gate 12.7 recovery meaning

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Didactic materialization authority
Unit: C10-GCM02-S12-REC-01
Branch: `cycle10-intermid-grimoire`
Required ancestry: `76540c45702b027d56b52fea05a8025f14496cdf`
Status: **ACTIVE — SOURCE MATERIALIZATION ONLY; GATE 12.7 HELD**

## 1. Accepted meaning

Preserve these distinctions:

- inspection is not execution;
- explicit human authorization is not implementation;
- implementation is not authorization;
- failed/notApplied recovery is not unknown-outcome Retry;
- bounded recovery-and-upload is not ordinary Sync;
- a sanitized fingerprint is evidence, not authoritative identity;
- request start is not provider application;
- provider outcome and local persistence outcome are separate.

The human-observed `MKS-UI-004 / failed-recovery-preflight` result proved that
the inspection remained local and non-mutating. Its safe action explicitly
held for Gate 12.7 reconciliation.

The state evidence is accepted, but the code meaning is not: the registry
still defines `MKS-UI-004` as “inspection action missing.” Keep that code for
the historical missing-action condition and use a precise REC code for an
eligible preflight. Do not redefine one code to mean both absence and success.

## 2. User-facing action model

The Closure UI must expose three unmistakably separate concepts:

```text
Inspect failed/notApplied recovery
    read-only; no network; no mutation

Recover failed/notApplied candidate
    separately confirmed bounded recovery plus one upload; Gate-controlled

Sync
    broad ordinary synchronization; not a substitute for recovery
```

`Retry unknown-outcome submission` remains separate and must not be presented
as applicable to the current failed/notApplied lineage.

Before confirmation, explain in plain language:

- exactly what candidate was found, using only sanitized fields;
- that the action will change local recovery state and attempt one provider
  upload;
- that it will not download, acknowledge, enroll, repair, or run ordinary
  Sync;
- that cancellation changes nothing;
- that no second action is permitted without reconciliation.

Do not imply that the button itself carries Main/human authorization.

## 3. Terminal explanations

Every terminal must say:

- last proved phase;
- whether local state changed;
- whether a provider request started;
- whether a trusted response arrived;
- whether provider application/rollback is proved or unknown;
- whether the local result persisted;
- whether another attempt is safe;
- the safe next action;
- bounded operation and correlation fingerprints.

Required language:

- `blocked-before-contact`: no provider conclusion;
- `unknown`: preserve evidence; do not retry;
- `rejected/notApplied`: trusted rejection/rollback, when proved;
- `duplicate-equivalent`: accepted only when the protocol proves equivalence;
- `applied`: provider acceptance and local persistence must be reported
  independently;
- `unexpected-local-failure`: do not infer provider failure.

Avoid blame by proximity. Do not label Auth0, Render, Neon, PostgreSQL, the
network, or the client as causal without detector-level evidence.

## 4. Documentation and tests

If diagnostic definitions change, update the machine registry and regenerate
Dart, TypeScript and Markdown projections. Do not hand-edit generated
documentation.

Tests must prove:

- labels and confirmation text preserve the three-action distinction;
- fingerprints and counts are sanitized;
- cancellation, blocked preflight, and execution terminals use accurate
  mutation/contact language;
- no terminal recommends automatic retry or ordinary Sync;
- generic summaries retain the causal child event;
- the prior Sync result remains visually distinct from the current action;
- an eligible preflight no longer displays the historical missing-action code;
- technical details omit forbidden identifiers and secrets.

H must report the runtime-visible meaning, confirmation copy, terminal
language, evidence distinctions, generated-documentation impact, and tests.

Do not edit permanent didactic memory.

Terminal markers:

```text
INSPECTION_EXECUTION_MEANING=SEPARATE_OR_BLOCKED
PREFLIGHT_CODE_MEANING=ALIGNED_OR_BLOCKED
FAILED_UNKNOWN_SYNC_ACTIONS=SEPARATE_OR_BLOCKED
TERMINAL_CAUSAL_LANGUAGE=VALIDATED_OR_BLOCKED
AUTHORIZATION_NOT_IMPLIED=VALIDATED_OR_BLOCKED
GATE_12_7=HELD
GCM02=OPEN
```

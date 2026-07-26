# E_DDC_STAGE — Step 12 Diagnostic Meaning Completion

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Didactic materialization authority
Unit: C10-GCM02-S12-ERR-02
Required ancestry: `0636c54e139fc92b16d1e11b2672d61f42f02f1b`
Status: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Accepted meaning baseline

Preserve:

- the 159-code machine registry as the single hand-maintained vocabulary;
- generated Dart, TypeScript, and `SYNC_DIAGNOSTICS.md` projections;
- the distinction between protocol code and native code;
- detector, cause domain, and causal confidence as separate concepts;
- the visible distinction between unknown Retry and read-only
  failed/notApplied inspection;
- the prohibition against exposing sensitive diagnostic material.

## 2. Meaning objective

Make ordinary Sync explainable without replacing precise evidence with the
generic phrase `sync-unavailable`.

Every user-visible blocked/error/unknown result must explain:

- what happened in plain language;
- the stable MKS code and title;
- the last phase actually proved;
- whether local state changed;
- whether a provider request started;
- whether a trusted response exists;
- whether provider application is proved, rolled back, or unknown;
- whether the local result was persisted;
- whether retry is safe;
- the safe next action;
- an operation fingerprint.

The generic summary may remain, but it must point to the causal event.

## 3. Causal language

Apply these rules consistently in registry projections, UI, logs, and tests:

- detection location is not automatically causal ownership;
- HTTP 500 does not prove PostgreSQL, Neon, Render, or Auth0 caused the failure;
- request start without trusted outcome means `unknown`;
- a trusted rejection with proved rollback means `not-applied`;
- a local preflight stop before mutation/contact means `blocked`;
- provider success plus local persistence failure must remain two facts;
- uncertainty must be stated as `boundary-only` or `unknown`.

Do not display speculative service blame.

## 4. Public and technical explanations

The primary UI explanation must be understandable without reading technical
details. Expandable details may show only sanitized closed values,
fingerprints, counts, phases, outcomes, ordinals, and safe status evidence.

Public API output must use a 12-hex correlation fingerprint. Full correlation
identity, exception class, SQLSTATE class, messages, stack traces, SQL,
payloads, raw IDs, and provider secrets are internal or forbidden.

Update generated `documentation/SYNC_DIAGNOSTICS.md` if schema/meaning changes
are necessary. It must remain generated from the registry and explain:

- parent operations and ordered child events;
- operation versus correlation identity;
- public fingerprint versus internal correlation;
- phase evidence and state precedence;
- detector versus cause;
- unknown-outcome safety;
- public/internal redaction;
- why a generic 500 is not automatically retryable.

## 5. Tests and report

Test that:

- the current causal event survives beneath a generic summary;
- all blocked/error/unknown UI states carry the required explanation;
- prior Sync, current action, last success, and timeline remain distinct;
- public response fixtures contain no internal-only diagnostic fields;
- unknown or boundary-only language is used where attribution is unproved;
- `MKS-UPL-012` retains its narrow meaning;
- registry, source lookup, UI, API, and Markdown agree on code meaning.

H must report what meanings became runtime-visible, the causal-language rules,
the public/internal split, generated-documentation changes, validation
evidence, and any meaning still not reachable in source.

Do not promote didactic canon or edit permanent didactic files.

Terminal markers:

```text
CAUSAL_DIAGNOSTIC_MEANING=IMPLEMENTED_OR_BLOCKED
GENERIC_SUMMARY_PRESERVES_CAUSE=VALIDATED_OR_BLOCKED
PUBLIC_DIAGNOSTIC_REDACTION=VALIDATED_OR_BLOCKED
GENERATED_DOCUMENTATION=ALIGNED_OR_BLOCKED
GATE_12_7=HELD
GCM02=OPEN
```

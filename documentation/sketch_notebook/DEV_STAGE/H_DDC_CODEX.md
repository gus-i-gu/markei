# H_DDC_CODEX - C10-GCM03-S10-R04

## Evidence Boundary

This report is Codex observational evidence for R04 materialization. It does not promote live Sync, close GCM03, or replace Main reconciliation.

D was implementation authority. E limited evidence interpretation. F defined architecture.

## Requirement-To-Test Mapping

- Cumulative causal state retention:
  - `acknowledgement request preserves trusted download and committed apply`
  - `acknowledgement exception keeps committed apply in runner fallback`
  - `diagnostic row failure is degraded without changing commit truth`
  - `diagnostic row failure while reporting rollback preserves rollback truth`
  - `diagnostic completion failure is degraded after committed apply`
- Diagnostic begin/row/completion containment:
  - `diagnostic begin failure is degraded while Sync continues`
  - `diagnostic row failure is degraded without changing commit truth`
  - `diagnostic row failure while reporting rollback preserves rollback truth`
  - `diagnostic completion failure is degraded after committed apply`
- Acknowledgement ordering and eligibility:
  - `acknowledgement request preserves trusted download and committed apply`
  - `diagnostic row failure is degraded without changing commit truth`
  - `unexpected apply exception rolls back and remains bounded`
  - existing local sync duplicate/acknowledgement regression tests.
- Product decision table:
  - `ambiguous normalized-code resolver branch is bounded`
  - `ambiguous exact-identity resolver branch is bounded`
  - `production Product uniqueness makes ambiguity unreachable by rows`
  - `established incoming UUID immutable mutation is bounded`
  - existing same-code/different-identity and split-key conflict tests.
  - existing exact-identity/different-code Product reuse tests.
  - existing dependent Purchase Item remap tests.
- Apply/replay completion:
  - `unexpected apply exception rolls back and remains bounded`
  - `exact-identity different-code replay unpoisons later progress`
  - `mixed two-client replay converges without duplicate facts`
  - existing idempotent duplicate-page tests.
- Regression:
  - focused catalogue/store/app suite
  - local sync application suite
  - two-device system harness
  - v3 contract suite
  - full Flutter suite.

## Separate Evidence Planes

- Provider/trusted-response evidence:
  - Tests assert `trustedResponseState=received` after a trusted download even when acknowledgement or diagnostics later fail.
  - Tests assert diagnostic success/failure does not create trusted provider success.
- Transaction evidence:
  - Tests assert committed apply stays `localMutationState=committed`.
  - Tests assert failed apply reports `localMutationState=rolled-back` and preserves unchanged facts.
  - Contradictory authoritative transaction states are bounded as diagnostic invariant conflicts.
- Diagnostic durability/degradation evidence:
  - Begin failure, row write failure, and completion failure are separately exercised.
  - Terminal lifecycle projection exposes `diagnostics-persistence-degraded`.
  - Degradation does not change committed versus rolled-back apply truth.
- Acknowledgement evidence:
  - Acknowledgement starts only after committed contiguous cursor proof.
  - Failed or unproved apply remains acknowledgement-ineligible.
  - Diagnostic degradation after committed apply remains acknowledgement-eligible.
  - A runner fallback acknowledgement exception preserves earlier trusted-response and local-commit proof.
- Presentation evidence:
  - Closure diagnostic repository and UI projection remain covered by existing focused and full Flutter tests.

## Negative Assertions

- No acknowledgement follows unexpected local apply failure.
- Facts, inbox, and cursor remain unchanged on failed pages.
- Replayed exact-identity/different-code event does not poison later cursor progress.
- Mixed two-client replay converges without duplicate Product, Store, Purchase, Purchase Item, inbox, or cursor effects.
- Diagnostic persistence failure does not manufacture provider success, acknowledgement success, or core Sync failure.
- Product ambiguity direct tests use a test-only seam because production uniqueness keeps the ambiguous row shape unreachable.

## Sensitive-Content Evidence

- Diagnostic tests assert sanitized exception-class projection rather than exception messages, stacks, payloads, SQL, tokens, secrets, or full hashes.
- Changed-content sensitive scan against the current diff reported no high-risk secret-pattern matches.
- Diagnostic fields retain bounded categories and already-authorized fingerprints/counts/sequences only.

## PRC-01 Ceiling

Evidence strength is deterministic local source/test/build evidence plus packaging inspection. It is not live provider evidence and does not prove preserved-state Android/Windows sync behavior.

The four disposable sync labs were skipped because `MARKEI_RUN_SYNC_LAB=1` was absent. They remain environment-gated and non-live in this R04 run.

## Gaps Or Partial Evidence

No required R04 test category is partial after this materialization. The only limit is evidence class: all proof is automated/local/build-time evidence, not Main promotion or human-assay evidence.

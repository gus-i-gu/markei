# H_DDC_CODEX - C10-GCM03-S10-R03

## Didactic Report

D_OPS_STAGE.md controlled operations. E_DDC_STAGE.md constrained interpretation. F_DSN_STAGE.md constrained architecture. J_MAIN_STAGE.md and REC_DIAGNOSTICS.md were read as reconciliation/evidence surfaces only.

The implemented Product rule is intentionally asymmetric. User Product code is not part of exact semantic identity for a previously unseen incoming UUID, so exact identity under a different code is a convergence candidate. The selected local Product keeps its code and display representation. The same code with different exact identity remains a conflict. Established UUID rows remain strict: they require complete immutable snapshot coherence including code and display fields.

The decision table is materialized as bounded outcomes:

- no code match and no exact-identity match: insert.
- code and exact identity select the same row: reuse and map.
- code match without exact identity: remote-product-same-code-different-identity.
- exact identity match without code: reuse exact row and preserve local code/display.
- code and exact identity select different rows: remote-product-split-key-conflict.
- ambiguous code: remote-product-ambiguous-code-match.
- ambiguous exact identity: remote-product-ambiguous-exact-identity-match.

The remote-to-local Product map is event-local apply knowledge, not a schema change. It teaches the dependent Purchase Item writer which local Product UUID was selected for each incoming Product UUID.

The transaction and diagnostic truths are separated. The Drift transaction decides facts/inbox/cursor commit or rollback. Diagnostics can describe that truth but cannot create it. Diagnostic persistence failures are contained and represented as degraded observability; they do not flip committed into rolled-back or rolled-back into committed.

The sanitized exception class is an allowed bounded class/category only. It is not an exception message, SQL text, value, payload fact, UUID, stack trace, token, secret, complete identifier, or full hash. It now reaches repository summaries and Closure current-action technical details.

Automated tests validate the materialized behavior, not live inter-device acceptance. Live Sync remains held for a later Main-authorized preserved-state assay.

## Evidence

Focused tests prove exact-identity/different-code convergence, same-code/different-identity conflict, split-key conflict, local code/display preservation, remote Item remapping, rollback of facts/inbox/cursor on local apply failure, no acknowledgement without a committed cursor, sanitized exception-class projection, Closure UI display, v3 restriction preservation, Store regression preservation, and Product selector regression preservation.

Full flutter test passed with the disposable live labs skipped by their explicit environment gate.

## Terminals

PRODUCT_IDENTITY_ASYMMETRY=VISIBLE
ESTABLISHED_UUID_STRICTNESS=VISIBLE
REMOTE_TO_LOCAL_ITEM_MAPPING=VISIBLE
TRANSACTION_TRUTH_SEPARATE_FROM_DIAGNOSTICS=VISIBLE
DIAGNOSTIC_DEGRADATION_NOT_CORE_FAILURE=VISIBLE
SANITIZED_EXCEPTION_CLASS_IS_BOUNDED=VISIBLE
LIVE_CONVERGENCE_ACCEPTANCE=HELD

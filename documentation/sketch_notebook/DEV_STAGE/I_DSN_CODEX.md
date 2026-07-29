# I_DSN_CODEX - C10-GCM03-S10-R03

## Design Report

Product semantic identity remains owned by the domain Product model and its identityKey. No global Product equality override was introduced. User Product code and raw display formatting remain outside exact semantic identity for new remote UUID convergence, but established UUID rows still require full immutable snapshot coherence.

Remote Product resolution is Account-scoped and local-apply scoped. The resolver checks incoming UUID first, then normalized code and exact identity. It selects, rejects, or inserts according to the D/F table and returns bounded protocol codes for conflict states. No alias table, migration, dependency, schema exception, or hosted event rewrite was added.

The remote Product UUID to local Product UUID mapping is held only inside the apply operation and is passed to Purchase Item writes. This preserves hosted event contents while letting local references converge on the selected row.

Remote Store behavior was not redesigned. It still uses the existing incoming UUID and Account-scoped stable display identity reconciliation path, and the selected Store ID is used by the Purchase row.

The page apply architecture remains one Drift transaction over catalogue reconciliation, Purchase facts, Purchase Items, inbox rows, and cursor advancement. Exceptions are not converted inside the transaction; they escape first so Drift can roll back. The outer apply boundary then translates to bounded SyncResult categories.

The diagnostic architecture now has a stronger in-memory causal layer. Diagnostic writes are best effort and cannot redefine transaction truth. NativeAuthClosureRunner consumes the strongest causal snapshot in its safety fallback, preserving trusted-response evidence when already proved.

The existing sanitizedExceptionClass column is projected through repository, application summary, current action, and Closure UI without a migration. The UI displays only bounded classes/categories.

Acknowledgement architecture remains unchanged: acknowledgement can start only after local apply exposes a committed greatest contiguous cursor. Failed, rejected, rolled-back, or unproved apply produces no acknowledgement cursor.

## Compatibility

Unchanged: protocol payload version 3, hosted API, Flutter/Drift schema, authentication, enrollment, Device binding, provider configuration, dependencies, Product selector domain equality, Store contract, Person/Payment Method v3 restrictions, upload-result persistence, retry/recovery boundaries, and branch topology.

## Terminals

PRODUCT_IDENTITY_OWNER=DOMAIN_PRODUCT_IDENTITY_KEY
PRODUCT_CODE_EXCLUDED_FROM_NEW_UUID_EXACT_IDENTITY=YES
ESTABLISHED_PRODUCT_UUID_MUTATION=CONFLICT
REMOTE_PRODUCT_CANONICALIZATION=ACCOUNT_SCOPED
REMOTE_PRODUCT_ID_MAP_OWNER=LOCAL_APPLY_OPERATION
STORE_CONTRACT_CHANGE=ABSENT
FACT_INBOX_CURSOR_TRANSACTION=ONE_DRIFT_TRANSACTION
APPLY_TRANSLATION_AFTER_ROLLBACK=YES
DIAGNOSTICS_PERSISTENCE_BEST_EFFORT=YES
RUNNER_FALLBACK_USES_CAUSAL_SNAPSHOT=YES
SANITIZED_EXCEPTION_CLASS_PROJECTION=NO_MIGRATION
ACK_REQUIRES_COMMITTED_CURSOR=YES
HOSTED_API_CHANGE=ABSENT
SCHEMA_CHANGE=ABSENT
DEPENDENCY_CHANGE=ABSENT

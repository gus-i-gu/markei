# I_DSN_CODEX - C10-GCM03-S10-R02

## Design Report

Purchase selection ownership now sits at the UI boundary as a stable Product ID.
The Product object remains a domain value without global equality redefinition.
The current Account-scoped Product projection is the only source used to
materialize immutable Product fields into the Purchase draft.

Remote Product canonicalization is Account-scoped and transaction-local:
incoming UUID is checked first, then normalized user code, then exact identity
key. A coherent existing local Product is selected when natural identity matches
under a different incoming UUID. The remote-to-local Product map exists only
inside the local apply operation and is used when writing Purchase Items.

Remote Store canonicalization is Account-scoped and uses incoming UUID plus the
existing stable display identity. The selected local Store ID is used for the
Purchase row. No Store normalization rule, mapping table, migration, or hosted
contract was added.

DriftRemoteEventApplier still places validation, fact writes, inbox writes, and
cursor advancement in one applyPage transaction. RemoteIdentityConflict and
SQLite write failures are thrown inside that transaction and translated after
rollback into bounded SyncResult values. Acknowledgement still depends on a
committed greatest contiguous applied cursor, so failed local apply cannot
produce an acknowledgement cursor.

Native/provider architecture did not expand. API routes, payload version,
schema, persistence model, synchronization protocol, authentication,
enrollment, provider configuration, and dependencies are unchanged.

## Terminals

PURCHASE_SELECTION_OWNER=STABLE_PRODUCT_ID
CURRENT_PRODUCT_PROJECTION=EXACTLY_ONE_OR_SAFE_INVALIDATION
REMOTE_PRODUCT_CANONICALIZATION=ACCOUNT_SCOPED
REMOTE_STORE_CANONICALIZATION=ACCOUNT_SCOPED
REMOTE_ID_MAP_OWNER=LOCAL_APPLY_TRANSACTION
FACT_INBOX_CURSOR_ATOMICITY=PRESERVED
CONFLICT_CAUSES_COMPLETE_ROLLBACK=YES
ACK_REQUIRES_COMMITTED_CURSOR=YES
HOSTED_CONTRACT_CHANGE=ABSENT
LOCAL_SCHEMA_CHANGE=ABSENT
AUTH_ENROLLMENT_CHANGE=ABSENT

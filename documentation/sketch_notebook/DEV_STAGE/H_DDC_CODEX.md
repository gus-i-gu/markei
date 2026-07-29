# H_DDC_CODEX - C10-GCM03-S10-R02

## Didactic Report

The Purchase dropdown failure was an object-identity problem, not proof of a
database duplicate. Flutter requires exactly one menu item equal to the current
Dropdown value. A Product returned by Find code can represent the same row as a
Product in the list while still being a different object instance. The repaired
UI uses the Product ID as the scalar selection value and resolves the current
Product object from the active projection only when exactly one row matches.

Zero matches and multiple matches mean different things. Zero means the prior
selection is no longer available in the Account projection and must be cleared.
Multiple means the projection is unsafe for Dropdown construction. Equivalent
repeated IDs can be collapsed; conflicting repeated IDs are rejected and surfaced
as bounded feedback rather than left for a Flutter assertion.

Remote synchronization has two identity layers. UUIDs are surrogate event
identifiers. Product code and exact identity key are natural Account-scoped
catalogue identities. When a remote UUID differs but both natural identities
match one coherent local Product, the local row is reused and the event-local
remote UUID maps to the local UUID for Purchase Items. If code and exact
identity point to different local rows, or immutable facts contradict, the page
is a typed notApplied conflict.

Store convergence follows the existing Account-scoped stable display identity.
No new Store normalization rule was introduced.

The trusted download response and the local commit are separate evidence steps.
A provider response can be received while local apply fails. The repaired
diagnostic path records download-local-apply with trustedResponseState=received
and localMutationState=rolled-back for local conflict/SQLite failure. That is
different from a transport failure where the trusted response was not received.

Unit tests validate the static/materialized behavior. Corrected live
inter-device convergence still requires a later, separately authorized human
assay and Main reconciliation.

## Terminals

UI_OBJECT_IDENTITY_VS_PRODUCT_ID=VISIBLE
ZERO_VS_MULTIPLE_DROPDOWN_MATCH=VISIBLE
SCREENSHOT_PROVES_DATABASE_DUPLICATE=NO
SURROGATE_VS_NATURAL_IDENTITY=VISIBLE
REMOTE_TO_LOCAL_REFERENCE_MAPPING=VISIBLE
TRUSTED_RESPONSE_VS_LOCAL_COMMIT=VISIBLE
PROVIDER_BRANCH_ALIAS_VS_GITHUB_BRANCH=VISIBLE
LIVE_CONVERGENCE_ACCEPTANCE=HELD

# E_DDC_STAGE — Store and Purchase Correction Semantics

> Authority marker: C10-MCG02-HOSTED-PURCHASE-CORRECTION_20260720T193745Z
> Status: **ACTIVE CODEX SEMANTIC AUTHORITY**

Retain these distinctions:

- `store-created` — one Store is durably available to the active Account;
- `store-required` — Purchase cannot register until an existing Store is selected;
- `purchase-registered-locally` — Purchase and one pending event committed atomically;
- `purchase-registration-not-applied` — transaction rolled back and in-memory draft remains;
- `purchase-registration-unknown` — unexpected failure; do not claim registration or discard draft;
- `provider-sync-completed` — later hosted upload/download/acknowledgement completed.

Catalogue must present Stores separately from Products. Empty or cross-Account Store selection is
invalid. Production UI may expose stable code, field and recovery but never exception text, SQL,
paths, UUIDs, tokens, credentials, payloads or stack traces. Local registration is not hosted sync,
and this correction does not close MCG-02 or activate MCG-03.

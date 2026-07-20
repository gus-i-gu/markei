# E_DDC_STAGE — Provider Convergence Semantics

> Authority marker: C10-MCG02-PROVIDER-CONVERGENCE_20260720T175006Z
> Status: **ACTIVE HUMAN-EVIDENCE SEMANTIC AUTHORITY**

Retain these distinctions:

- `native-authenticated` — provider callback and usable ephemeral credentials passed;
- `membership-active` — one explicit external identity maps to one active Account membership;
- `hosted-restart-required` — enrollment is durable but the current composition cannot sync;
- `hosted-binding-active` — restart selected the hosted Account/server Device;
- `provider-sync-completed` — one bound Device completed hosted upload/download/acknowledgement;
- `provider-converged` — both restarted Devices reopen with equal authoritative hosted facts;
- `device-revoked` — revoked Device is denied without hosted state advance;
- `provider-unavailable-local-pending` — local registration survives API unavailability;
- `signed-out` — protected operations require new authentication and no token is recovered.

Authentication is not membership, enrollment is not activation, one-Device sync is not convergence,
and Render/Neon row presence is not local reopen proof. Local-only history is neither failed nor
hosted. No success wording may close MCG-02 until every D gate is evidenced. MCG-03 remains inactive.

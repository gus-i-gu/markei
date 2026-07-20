# F_DSN_STAGE — Decisive Provider-Proof Design

> Authority marker: C10-MCG02-PROVIDER-CONVERGENCE_20260720T175006Z
> Status: **ACTIVE HUMAN-EVIDENCE DESIGN AUTHORITY**

## Selected topology

~~~text
Auth0 synthetic identity
  -> explicit Neon Account membership
  -> Windows installation / Device A
  -> restart-bound hosted lane
  -> Render HTTPS / Neon Account stream
  -> Android installation / Device B
  -> restart-bound hosted lane
~~~

The proof observes the production adapters already materialized at `e762b64`. It does not introduce
a new data model. Auth0 subject remains external identity; AccountId and DeviceId remain server-owned
UUIDs; each installation receives a distinct Device; both Devices share one explicit Account.

## Invariants

- private build inputs remain outside Git and are supplied separately to Dart and Android Gradle;
- Account membership exists before enrollment and is never inferred from token claims;
- enrollment completion cannot reuse the pre-enrollment composition;
- only post-restart hosted events enter the Account stream;
- local-only facts/events retain identity and never upload through hosted credentials;
- repeated upload/download/enrollment is duplicate-equivalent or no-new-events;
- revoke/outage/logout failure paths preserve local facts and do not advance forbidden state;
- evidence contains counts and states, never credentials, subjects, IDs, URLs with secrets or facts.

## Rollback and cleanup

Provider proof may revoke synthetic Devices, disable synthetic membership and remove residual
synthetic facts only through separately authorized cleanup after evidence capture. It must not delete
the development project/branch or production data. Failure stops at the affected gate and preserves
diagnostic state. No source rollback is implied by provider configuration failure.

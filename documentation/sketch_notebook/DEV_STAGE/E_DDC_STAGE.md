# E_DDC_STAGE — Hosted Device Header Semantics

> Authority marker: C10-MCG02-HOSTED-DEVICE-HEADER-CORRECTION_20260721T124452Z
> Status: **ACTIVE CODEX MATERIALIZATION AUTHORITY**

## Required semantic distinctions

- `authenticated` proves a usable Auth0 access token; it does not prove Device authorization.
- `device-enrolled` proves the active identity has an enrollment binding; it does not prove every
  later protected request carries that Device identity.
- `x-markei-device-id` identifies the active enrolled server Device to the hosted authorization
  fence. It is not the local installation ID, Account ID, token subject or submission Device field.
- `device-enrollment-required` in this incident means the protected request lacked the header; it
  does not mean a second Device is required or the existing enrollment row is absent.
- repeated submission membership for sequences `1,2` preserves retry history; it is not duplicate
  fact creation.

## User-visible behavior

The correction must not introduce a new UI flow or expose Device identifiers. Existing bounded
states remain authoritative: definite server rejection maps to `sync-unavailable`; unknown
transport outcome maps to `sync-interrupted`; success requires confirmed upload/download phases.

Tests and G/H/I may expose header presence, semantic mismatch states and aggregate counts only.
They must not expose raw Device IDs, tokens, Auth0 subjects, connection strings, payloads or hashes.

Provider success is not claimed by local materialization. A rebuilt Windows release and one later
human-controlled provider retry remain separately required.

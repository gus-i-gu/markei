# H_DDC_CODEX — C10-S01 Didactic Evidence

Sequence: FLX-ORD-01
Role: Codex materialization evidence
Source stages: `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
Learner maturity: unchanged

## Vocabulary Materialized

Implemented typed vocabulary in:

- `clients/markei_flutter/lib/domain/sync/sync_event.dart`
- `clients/markei_flutter/lib/application/sync/sync_ports.dart`
- `services/markei_sync_api/src/domain/protocol.ts`
- `contracts/shared_beta/v3/protocol_failure.schema.json`

Stable status vocabulary represented: `saved-local`, `waiting-upload`, `uploading`, `server-accepted`, `waiting-peer`, `downloaded-applied`, `duplicate-ignored`, `conflict`, `auth-required`, `device-revoked`, `cursor-expired`, `protocol-upgrade-required`, `unknown-outcome`.

Failure outcome vocabulary represented: `applied`, `duplicate-equivalent`, `not-applied`, `unknown`.

## Tests Proving State Distinctions

- `local registration works when transport is absent`: local save/outbox does not require API.
- `unknown outcome retries same submission`: unknown upload preserves retry identity.
- `duplicate event is applied once and can be acknowledged`: duplicate apply is not a second effect.
- `acknowledgement waits until local apply committed`: acknowledgement follows local cursor evidence.
- API tests prove fixture auth is direct-test injection only and normal verifier refuses runtime use.

## Privacy And Logging Evidence

No telemetry, analytics dependency, payload logging, Neon secret, token, password value or connection string was added. The scan found only variable names and ignored secret paths. Fixture data uses synthetic Account/Device/Purchase labels.

## Diagnostic Copy

No polished UI copy, dashboard, pairing page, navigation, settings redesign or Cycle 11 surface was added. Minimal diagnostics are limited to test names, fixture names, protocol codes and lab README text.

## Misleading Terms

The implementation avoids claiming that server acceptance means peer application, backup or export. Reports describe the API/Postgres slice as disposable local proof only.

## Skipped Semantics

Production authentication, live provider behavior, retention, rebootstrap, account deletion and learner maturity promotion were not implemented.

WAITING_FOR_MCG_01

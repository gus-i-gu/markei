# F_DSN_STAGE — Android target and authentication boundary repair

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Design materialization stage
> Unit: `C10-GCM03-ST04-R1-C2`
> Branch: `grm-guarded-provisioning-20260727`
> Required ancestry:
> `1af1d887e4fe8370ab988a80e4af16eafcd4699c`
> Authority: **ACTIVE WITHIN D**
> Evidence boundary: launcher and authentication responsibility inspection; no
> protocol, persistence, provider or synchronization expansion

## 1. Controlling responsibility correction

`GS-FLUTTER-AND` owns two distinct identities:

```text
stable target definition
  AndroidAvdName from reviewed public coordinates

transient runtime target
  exactly one supported Android Flutter object
  exactly one scalar ADB serial
  exact membership in the current ADB inventory
```

The AVD name must not be used as the serial. A collection of Flutter IDs must
not cross the ADB boundary.

Correct responsibility map:

```text
Flutter CLI
  emits public device inventory JSON

GS-FLUTTER-AND parser
  parses and enumerates member objects

GS-FLUTTER-AND selector
  filters supported Android targets and enforces cardinality

ADB inventory guard
  binds one selected Flutter ID to one current ADB serial

ADB invocation
  receives exactly one -s value
```

## 2. Authentication responsibility map

Keep the authentication scan separate:

```text
NS_COORDINATES
  reviewed non-secret public inputs

GS-FLUTTER-AND
  build-input propagation and environment restoration

Gradle / Android manifest
  package and callback placeholder materialization

NativeAuthConfiguration
  platform configuration validation and callback evidence

Auth0 native adapter
  interactive login/logout and sanitized exception mapping

NativeClosurePage
  operator action and sanitized result projection

Auth0 dashboard/provider
  external callback/logout/client acceptance; read-only human evidence only
```

A launcher correction must not change authentication architecture. An auth
source change is allowed only when a focused static/test failure proves the
owning layer defective.

## 3. Preserved boundaries

Preserve:

- one shared `NativeClosurePage`;
- package `com.gusigu.markei`;
- current public coordinate names and safe-display rules;
- application-data-preserving installation;
- build-provenance format and projection;
- local authentication/enrollment persistence boundaries;
- API, synchronization and provider protocols;
- Drift schema and local data;
- pending Windows sequence-2 event.

Do not add an Android-only Closure page, alternate auth stack, hard-coded ADB
serial, provider fallback or automatic retry.

## 4. Validation architecture

```text
selected Markdown fence
→ Windows PowerShell 5.1 parse
→ JSON member-enumeration fixtures
→ Android cardinality fixtures
→ exact Flutter-ID/ADB-serial binding
→ captured native argument vector

Auth history diff
→ public input graph
→ package/manifest/callback graph
→ native composition tests
→ generated artifact evidence
→ held human runtime assay
```

The first graph repairs a proved operational boundary. The second graph
classifies a separate observation without widening provider authority.

## 5. I report

Replace `I_DSN_CODEX.md`. Include:

- repaired collection-to-scalar ownership boundary;
- exact ADB identity binding;
- separate Auth0 responsibility graph;
- any evidence-backed owning-layer correction;
- proof that API/persistence/provider/synchronization architecture did not
  expand;
- held installed-runtime and provider acceptance.

Required terminals:

```text
FLUTTER_INVENTORY_TO_MEMBER_OBJECTS=CORRECTED_OR_BLOCKED
ANDROID_MEMBER_TO_ONE_ADB_SERIAL=CORRECTED_OR_BLOCKED
HARD_CODED_DEVICE_SERIAL=ABSENT
AUTH_RESPONSIBILITY_OWNER=CLASSIFIED_OR_UNRESOLVED
AUTH_PROVIDER_CONFIGURATION_MUTATION=ABSENT
SYNC_PERSISTENCE_SCHEMA_EXPANSION=ABSENT
ANDROID_RUNTIME_ACCEPTANCE=HELD
GCM03_ST05_AND_LATER=HELD
```

Do not edit permanent design memory.

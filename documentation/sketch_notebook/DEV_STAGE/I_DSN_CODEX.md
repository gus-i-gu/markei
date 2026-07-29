# I_DSN_CODEX - C10-GCM03-ST04-R1-C2

> Role: Codex design report
> Unit: `C10-GCM03-ST04-R1-C2`
> Evidence boundary: repository/static validation and non-mutating fixtures;
> no provider, persistence, API, synchronization or live Android mutation

## Launcher Responsibility Map

The intended ownership boundary is:

```text
Flutter device inventory
  owns raw machine JSON

PowerShell JSON parser
  owns exactly one parse operation

member enumeration
  owns conversion from top-level JSON array to individual device objects

Android selector
  owns platform/support/scalar-ID predicates

cardinality guard
  owns zero/one/multiple target decision

ADB inventory guard
  binds one selected Flutter ID to one current ADB serial

ADB invocation
  receives exactly one -s value through an explicit argument vector
```

The current repository procedure still violates the first collection-to-member
boundary because the updated human instruction protects `G_SCRIPTS.md`, where
the owning repair belongs. The equivalent fixture proved the target design:
member enumeration before filtering and one scalar ADB serial before invocation.

No hard-coded emulator serial was introduced. The stable AVD name remains a
definition, not a runtime serial.

## Auth0 Responsibility Map

The Auth0 contract remains layered:

```text
NS_COORDINATES
  reviewed public input names and values, not secrets

GS-FLUTTER-AND
  loads public coordinates and should pass Dart defines / Gradle property

Gradle manifest placeholders
  bind Android callback scheme/domain into merged manifest

Android package identity
  remains com.gusigu.markei

NativeAuthConfiguration
  validates public inputs and selects Android client ID on Android

Native Auth0 adapter
  owns interactive login/logout and sanitized exception mapping

NativeClosurePage
  exposes Sign in and diagnostics without owning provider configuration

Auth0 dashboard/provider
  owns external callback/logout/client acceptance and requires human evidence
```

No owning-layer Auth0 defect was proved. No Auth0 source, manifest, Gradle,
provider or public coordinate model was changed.

## Architecture Impact

The work did not add an Android-only Closure page, alternate auth stack,
provider fallback, retry path, database mutation, API route, schema migration,
RLS change or synchronization behavior. The only remaining required source
repair is the launcher/procedure boundary in a surface that is currently
protected by the latest human instruction.

## Terminals

```text
FLUTTER_INVENTORY_TO_MEMBER_OBJECTS=BLOCKED_BY_PROTECTED_G_SCRIPTS
ANDROID_MEMBER_TO_ONE_ADB_SERIAL=BLOCKED_BY_PROTECTED_G_SCRIPTS
HARD_CODED_DEVICE_SERIAL=ABSENT
AUTH_RESPONSIBILITY_OWNER=AUTHAND-06_RUNTIME_EVIDENCE_GAP
AUTH_PROVIDER_CONFIGURATION_MUTATION=ABSENT
API_PERSISTENCE_PROVIDER_SYNC_EXPANSION=ABSENT
ST04=BLOCKED_PENDING_MAIN_RESTAGING
GCM03_ST05_AND_LATER=HELD
```

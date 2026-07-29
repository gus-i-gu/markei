# F_DSN_STAGE — Main-owned GRM boundary and launcher verification

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Design validation stage
> Unit: `C10-GCM03-ST04-R1-C3`
> Branch: `grm-guarded-provisioning-20260727`
> Required published ancestry:
> `084e637e6771b8713b2504b155a82cd4d3bd792a`
> Authority: **ACTIVE WITHIN D — REPORT ONLY**
> Evidence boundary: protected-interface and launcher responsibility
> validation; no protocol, persistence, provider or synchronization expansion

## 1. GRM ownership boundary

The seven-file GRM set is one protected operational interface:

```text
human direction
→ Main synthesis and GRM materialization
→ immutable protected GRM input
→ Codex read/test/report
→ human runtime acceptance
```

Codex may not mutate a GRM file directly or indirectly. Any further GRM design
correction returns to Main.

This protection is parallel to methodology protection but does not reclassify
GRM as Sketch Notebook methodology.

## 2. Launcher responsibility map

Validate:

```text
Flutter CLI
  owns raw machine JSON

GS-FLUTTER-AND parser
  owns one parse and explicit member enumeration

GS-FLUTTER-AND selector
  owns per-member platform, support and scalar-ID predicates

cardinality guard
  owns zero/one/multiple target decisions

ADB inventory guard
  binds the chosen Flutter ID to exactly one ready current serial

ADB invocation
  receives one explicit argument vector with one -s value
```

Keep stable AVD definition separate from transient ADB identity. Preserve
package `com.gusigu.markei`, application data, public build provenance, the
shared Closure page and current Auth0 responsibility graph.

## 3. Preserved architecture

This unit must not add or change:

- Android-only Closure composition;
- authentication source or provider configuration;
- API routes or hosted behavior;
- enrollment or synchronization protocol;
- persistence, schema, migrations or RLS;
- retry/recovery behavior;
- the pending Windows event.

## 4. I report

Replace `I_DSN_CODEX.md`. Report:

- the protected GRM ownership map;
- actual collection-to-member and member-to-serial validation;
- captured proof that each ADB boundary receives one scalar serial;
- absence of hard-coded runtime serials;
- retained Auth0 ownership and `AUTHAND-06`;
- absence of API/persistence/provider/synchronization expansion.

Required terminals:

```text
GRM_MUTATION_OWNER=HUMAN_MAIN
CODEX_PROTECTED_INTERFACE_MUTATION=ABSENT_OR_STOP
FLUTTER_INVENTORY_TO_MEMBER_OBJECTS=CORRECTED_OR_BLOCKED
ANDROID_MEMBER_TO_ONE_ADB_SERIAL=CORRECTED_OR_BLOCKED
HARD_CODED_DEVICE_SERIAL=ABSENT
AUTH_RESPONSIBILITY_OWNER=UNCHANGED_AUTHAND-06
API_PERSISTENCE_PROVIDER_SYNC_EXPANSION=ABSENT
ANDROID_RUNTIME_ACCEPTANCE=HELD
GCM03_ST05_AND_LATER=HELD
```

Do not edit permanent design memory.

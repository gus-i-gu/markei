# E_DDC_STAGE — Android launcher and sign-in evidence semantics

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Didactic materialization stage
> Unit: `C10-GCM03-ST04-R1-C2`
> Branch: `grm-guarded-provisioning-20260727`
> Required ancestry:
> `1af1d887e4fe8370ab988a80e4af16eafcd4699c`
> Authority: **ACTIVE WITHIN D**
> Evidence boundary: operational comprehension and test evidence; no Android
> runtime or provider acceptance

## 1. Corrected meaning

Preserve these distinctions:

```text
Flutter reports one JSON array
  ≠ PowerShell enumerated each device object

an aggregate property contains android
  ≠ the selected object is an Android device

AVD process started
  ≠ ADB selected its serial

launcher failed before build/install
  ≠ the new APK has an Auth0 regression

Auth0 files were unchanged
  ≠ human sign-in necessarily works

static callback contract passes
  ≠ provider dashboard and live redirect are accepted
```

The shown ADB terminal is direct evidence of a launcher failure. The precise
PowerShell nesting cause remains a candidate until fixture-reproduced. The
sign-in report is a separate human observation until correlated with a
sanitized terminal, artifact fingerprint and callback/configuration evidence.

## 2. Device-enumeration contract

The operator model must become:

```text
JSON text
→ parse one top-level collection
→ enumerate collection members
→ validate each member
→ filter Android members
→ require cardinality exactly one
→ require one scalar ID
→ confirm exact ID in ADB inventory
→ invoke ADB with one -s value
```

PowerShell syntax, JSON parsing, member enumeration, platform filtering,
cardinality validation and ADB identity validation are distinct gates.

## 3. Sign-in evidence ladder

Codex should express Android sign-in evidence in this order:

```text
repository/history evidence
→ public build-input propagation
→ package/manifest/callback contract
→ Dart/native-client composition tests
→ generated artifact/manifest evidence
→ installed visible provenance
→ human-operated Sign in terminal
→ provider correlation when separately authorized
```

Only the first five may be established in this unit. Installed runtime,
interactive Sign in and provider acceptance remain human/held evidence.

Use sanitized outcome vocabulary such as:

```text
cancelled
provider-unavailable
callback-not-received
callback-state-rejected
authentication-rejected
configuration-invalid
```

Do not record raw callback URLs, tokens, account subjects or provider values.

## 4. H report

Replace `H_DDC_CODEX.md`. Include:

- why a top-level JSON array can become one aggregate PowerShell object;
- why exact cardinality and scalar identity are separate checks;
- why this invocation could not alter the installed app;
- the AUTHAND evidence ladder and selected classification;
- the difference between static validation and live acceptance;
- the exact human evidence still required.

Required terminals:

```text
JSON_PARSE_NOT_MEMBER_ENUMERATION=VISIBLE
ANDROID_CARDINALITY_AND_IDENTITY=VISIBLE
LAUNCHER_FAILURE_NOT_AUTH_FAILURE=VISIBLE
AUTH_HISTORY_AND_CONTRACT_SCAN=COMPLETE_OR_BLOCKED
AUTH_RUNTIME_ACCEPTANCE=HELD
ST04=BLOCKED_PENDING_HUMAN_RETEST
GCM03_ST05_AND_LATER=HELD
```

Do not edit permanent didactic memory.

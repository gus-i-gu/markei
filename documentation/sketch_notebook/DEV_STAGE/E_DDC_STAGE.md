# E_DDC_STAGE — Protected GRM validation semantics

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Didactic validation stage
> Unit: `C10-GCM03-ST04-R1-C3`
> Branch: `grm-guarded-provisioning-20260727`
> Required published ancestry:
> `084e637e6771b8713b2504b155a82cd4d3bd792a`
> Authority: **ACTIVE WITHIN D — REPORT ONLY**
> Evidence boundary: comprehension of Main-authored GRM input and validation
> evidence; no GRM, runtime or provider mutation

## 1. Authority meaning

The GRM set is operational canon controlled by human direction through Main
Chat. Codex is its reader and validator, not its materializer.

Preserve:

```text
D/E/F authorizes Codex validation
  ≠ D/E/F authorizes a GRM edit

Codex finds a GRM defect
  → report exact proposed correction
  → stop for Main

Main-authored GRM change
  → Codex may test the immutable input
  → human later accepts runtime behavior
```

Codex must not “repair” a protected file by restoring it. Restoration is also
a mutation.

## 2. Correct device-selection model

Keep the evidence chain visible:

```text
JSON parse
→ top-level member enumeration
→ per-member type and value predicates
→ Android cardinality
→ one scalar Flutter ID
→ exact ready ADB inventory membership
→ one explicit native argument vector
```

One selected aggregate is not one device. One scalar ID is not an accepted ADB
target until exact inventory membership is proved.

The actual extracted procedure must pass. An equivalent inline fixture alone
is insufficient evidence that the repository procedure is repaired.

## 3. Authentication meaning

Retain:

```text
AUTHAND-06=INSUFFICIENT_RUNTIME_SYMPTOM_EVIDENCE
```

The C2 scan found no static Auth0 defect. This unit must not reinterpret missing
runtime evidence as permission to change authentication source or provider
configuration.

Static validation may prove the build contract remains coherent. Only a later
human-operated Sign in can add runtime evidence.

## 4. H report

Replace `H_DDC_CODEX.md`. Explain:

- Main versus Codex authority over GRM;
- inspection/validation versus mutation;
- parsing, member enumeration, cardinality and identity as separate gates;
- why actual-fence fixtures supersede equivalent-only fixtures;
- why `AUTHAND-06` remains held rather than repaired;
- exact human runtime evidence still required.

Required terminals:

```text
GRM_AUTHORITY=HUMAN_MAIN_ONLY
CODEX_GRM_ROLE=READ_TEST_REPORT
JSON_PARSE_NOT_MEMBER_ENUMERATION=VISIBLE
ANDROID_CARDINALITY_AND_IDENTITY=VISIBLE
ACTUAL_FENCE_NOT_EQUIVALENT_ONLY=VISIBLE
AUTH_RUNTIME_ACCEPTANCE=HELD
ST04=BLOCKED_PENDING_HUMAN_RETEST
GCM03_ST05_AND_LATER=HELD
```

Do not edit permanent didactic memory.

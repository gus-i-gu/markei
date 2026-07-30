# E_DDC_STAGE — Evidence contract for C10-GCM03-S09-R06

## Envelope

Sequence: FLX-ORD-01

Role: Main evidence constraint

Round or unit: C10-GCM03-S09-R06

Branch: `grm-guarded-provisioning-20260727`

Baseline / inspected HEAD: `c321675325cc4d7358b96c1e125f2aa2c5e84e7f`

Authority: D is executable; E limits conclusions; F owns architecture.

Writable surfaces: only those named by D.

Evidence boundary: source identity and artifact attribution only.

## 1. Question being answered

R06 answers:

> Did the Android and Windows builds under test consume one identical committed
> Markei source identity, and can each running Closure surface report it?

R06 does not answer:

> Does inter-device Sync converge?

Those questions must remain separate.

## 2. Identity distinctions

| Evidence | Meaning | Expected cross-platform relation |
|---|---|---|
| Full Git revision | Exact committed source revision | identical |
| 12-character display revision | Human-readable abbreviation of full revision | identical |
| Source-tree SHA-256 | Deterministic digest bound to the Git tree | identical |
| APK SHA-256 | Exact Android artifact bytes | different from Windows |
| Windows executable SHA-256 | Exact Windows artifact bytes | different from Android |
| Visible Closure identity | Running application presents embedded source identity | identical source fields |

An artifact SHA-256 does not identify source by itself. A source-tree SHA-256
does not identify installed artifact bytes by itself. The build record connects
them.

## 3. Common source-tree digest evidence

The accepted algorithm is:

```text
SHA256(UTF8("markei-source-tree-v1\n" + gitTreeObjectId + "\n"))
```

Evidence passes only if:

- the Git revision is validated as 40 lowercase hexadecimal characters;
- the tree object is resolved from that same revision;
- the helper produces 64 lowercase hexadecimal characters;
- repeated resolution of the same clean HEAD is identical;
- both Android and Windows consume the same helper output;
- the app rejects malformed values without echoing them.

The digest is a source-tree identity fingerprint. Do not describe it as a hash
of the APK, executable, SQLite database, provider state, or runtime memory.

## 4. Boot and UI evidence

Source inspection may establish that identity is resolved once at shared Flutter
boot and passed to Closure.

Focused widget tests may establish:

- valid full revision becomes the expected 12-character label;
- valid source-tree SHA-256 is shown exactly;
- missing or invalid fields fail closed;
- unsafe raw input is not echoed;
- the same identity object reaches Closure through MarkeiApp;
- no platform branch or runtime external read is required.

These tests cannot establish what a future installed client displays.

The later human two-platform check may establish only:

- the exact running Windows client displays the expected R06 revision/tree
  digest;
- the exact running Android client displays the same revision/tree digest;
- the preserved History/Closure baseline remains visibly present;
- no operation was initiated merely by boot/navigation.

## 5. Artifact evidence

A successful platform build plus artifact inspection may establish:

- artifact exists;
- path and byte size were recorded;
- SHA-256 identifies those exact bytes;
- build command carried the common source identity.

It cannot establish installation or launch unless separately observed.

Android and Windows artifact hashes must not be expected to match. A mismatch is
normal because package formats and native outputs differ.

## 6. Validation economy

The user has already completed the broader R02–R05 automated and preserved-state
preparation. R06 must not restart that evidence collection.

Sufficient R06 evidence is:

```text
changed-source inspection
+ focused identity tests
+ focused boot/Closure propagation test
+ Flutter analysis
+ shared-helper determinism check
+ available Android/Windows package builds
+ artifact hash report
```

Insufficient substitutions:

- running every GRIMOIRE procedure;
- rerunning SQLite/Neon/provider baselines;
- using a fresh timestamp as provenance;
- using artifact SHA-256 alone as source identity;
- relying on operator memory that a build was fresh;
- showing only a short revision without the validated full revision behind it;
- showing the source-tree digest on only one platform.

## 7. PRC-01 ceilings

| Evidence | Maximum conclusion |
|---|---|
| Source inspection | common identity model implemented |
| Focused parser/identity test | validation and sanitization work at test scope |
| Focused boot/Closure test | shared application propagation works at widget scope |
| Helper determinism check | same clean source resolves to same source identity |
| Android build | Android artifact materialized with supplied identity |
| Windows build | Windows artifact materialized with supplied identity |
| Artifact SHA-256 | exact built bytes identified |
| Human visible Android Closure | running Android identity observed |
| Human visible Windows Closure | running Windows identity observed |
| Matching visible source fields | both running clients claim one common source identity |
| No live Sync | no convergence conclusion |

`IMPLEMENTED_VALIDATED` requires every non-host-specific direct R06 check to
pass. A platform unavailable on Codex's host is `host-unvalidated`, and the
later human Windows/Android build supplies that missing platform evidence.

## 8. Freeze and release rule

If Codex materialization passes and the later human check shows the same source
revision and source-tree SHA-256 on both clients:

```text
R06_SOURCE_ATTRIBUTION=PASS
R02_R05_CANDIDATE=FROZEN
MORE_INCIDENTAL_SOURCE_CHANGE=NO
NEXT_ACTION=SEPARATELY_AUTHORIZED_SERIALIZED_SYNC
```

Do not require another complete SQLite × Neon × UI baseline merely because R06
changed source identity presentation. Stop only if the focused human check
shows:

- different source identities;
- missing/invalid identity;
- build/install failure;
- preserved data visibly missing;
- automatic Sync or another unexpected mutation.

## 9. Non-promotion boundary

R06 cannot promote:

- practical Sync success;
- inbound Product reconciliation;
- cursor advancement;
- acknowledgement;
- two-device convergence;
- no-op replay;
- GCM03 closure;
- MVP Sync acceptance.

R06 merely makes the next live result attributable to one frozen source
candidate.

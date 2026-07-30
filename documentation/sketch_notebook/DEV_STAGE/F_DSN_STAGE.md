# F_DSN_STAGE - C10-GCM03-S09-R06-CR02

Sequence: FLX-ORD-01
Role: Main design stage
Round or unit: C10-GCM03-S09-R06-CR02
Branch: grm-guarded-provisioning-20260727
CR01 implementation baseline / required staging parent: 5fef8a51ccb61dff00e773b3c8759062560d27da
Codex starting HEAD: the final CR02 staging tip named by the seeding prompt
Authority: Human-supervised Main Chat
Architecture boundary: Windows preparation and verification procedure only

## 1. Design Correction

CR01 conflated three different kinds of evidence:

```text
process name
generated-state ownership
actual cleanup failure
```

CR02 must separate them:

```text
process observation
-> attributable owner classification
-> cleanup attempt
-> filesystem postcondition
-> package/plugin regeneration verification
-> analysis/test/build
```

A name match is an observation. It is not ownership.

An ownership claim requires an attributable relationship to the client, its
build output, or an active Flutter build/run command.

The filesystem postcondition remains the authoritative gate: if exact generated
targets cannot be removed or reappear, the procedure stops regardless of
process classification.

## 2. Windows Generated-State Topology

The procedure must preserve this distinction:

```text
clients/markei_flutter/
├── .dart_tool/                              generated; bounded cleanup target
├── build/windows/                           generated; bounded cleanup target
└── windows/flutter/
    ├── generated_plugins.cmake              generated manifest; verify here
    └── ephemeral/                           generated; bounded cleanup target
        └── .plugin_symlinks/
            └── auth0_flutter/               generated plugin target; verify here
```

`generated_plugins.cmake` must not be relocated conceptually into `ephemeral`.
The procedure verifies Flutter's output; it does not manually author generated
native state.

## 3. Process Attribution Contract

The classifier should expose at least:

```text
Candidate
DefiniteRelevantOwner
BenignAnalysisActivity
UnknownMetadata
```

Rules:

- `markei.exe` whose executable path is inside the client's Windows build output
  is a definite relevant owner;
- a Flutter/Dart process whose bounded command metadata connects it to this
  client and a build/run action may be a definite relevant owner;
- Dart analysis/language-server activity is not a definite owner merely because
  it analyzes the repository;
- missing metadata is unknown, not proof of ownership;
- unknown candidates may be reported after an actual cleanup failure but must
  not create a universal pre-clean veto;
- no raw full command line should be printed;
- no process may be terminated automatically.

If implementation needs platform-specific process inspection, it belongs
inside the canonical `GS-FLUTTER-WIN` body and must remain Windows-only,
read-only, bounded, and failure-tolerant.

## 4. Preparation State Machine

The corrected state machine is:

```text
coordinates and R06 identity validated
-> definite relevant-owner preflight
-> flutter clean
-> exact bounded cleanup
-> exact absence proof
-> flutter pub get
-> package_config auth0 entry proof
-> ephemeral auth0 symlink/CMake proof
-> non-ephemeral generated_plugins.cmake proof
-> analyze
-> tests
-> Windows Release build
-> artifact hash
-> callback registration
-> exact executable launch
```

Failure at any earlier stage must not be described as failure of a later stage.

## 5. Authority Boundaries

- Flutter owns dependency and generated-plugin materialization.
- `GS-FLUTTER-WIN` owns bounded orchestration and verification.
- The human owns manual closure of genuinely relevant activity.
- PowerShell process inspection supplies hints and attribution evidence, not
  transaction truth.
- Filesystem postconditions decide whether cleanup succeeded.
- The Windows scaffold owns the manifest location.
- R06 provenance owns source/artifact identity.
- Application, Auth0, Sync, database, provider, and R07 architectures are
  unchanged.

## 6. Safety Invariants

```text
AUTOMATIC_PROCESS_TERMINATION=NO
PROCESS_NAME_ALONE_PROVES_OWNERSHIP=NO
ANALYSIS_SERVER_REQUIRES_VSCODE_CLOSURE=NO
RAW_COMMAND_LINE_OUTPUT=NO
CLEANUP_OUTSIDE_CLIENT=NO
BROAD_WILDCARD_DELETION=NO
GENERATED_NATIVE_FILE_MANUAL_EDIT=NO
DEPENDENCY_UPGRADE=NO
SYNC_AUTHORIZATION=NO
```

## 7. Acceptance

CR02 architecture is accepted only if:

- process classification is evidence-backed;
- name-only Dart/Flutter false positives are removed;
- actual cleanup failure remains fail-closed;
- the plugin symlink and manifest use their distinct correct paths;
- all R06 identity and final build-tail responsibilities remain intact;
- G/H/I preserve evidence ceilings and name the remaining human rerun.

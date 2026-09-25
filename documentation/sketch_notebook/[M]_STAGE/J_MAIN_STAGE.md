# J_MAIN_STAGE — C12-S00-AS02-IS01 Git-state classification

> Sequence: FLX / Main bounded diagnosis
> Role: Main Chat [M]
> Cycle / Sprint / Alter-Sprint / Inner-Sprint: C12 / S00 / AS02 / IS01
> Repository: `gus-i-gu/markei`
> Required branch: `markei-season-02`
> Starting remote HEAD: `7b05f0427cda3e2ed3126b71c1b973d423e4866f`
> Authority: explicit human-directed Main staging, 2026-09-25
> Mutable surface: none
> Status: **ACTIVE — READ-ONLY CODEX DIAGNOSIS**

## 1. Recovery order

Read, in order:

```text
AGENTS.md
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
documentation/GRM.md
documentation/G_SCRIPTS.md
documentation/I_SCRIPTS.ps1
documentation/NS_COORDINATES.md
this J file
```

Then inspect only the source and Git paths named in §3. Do not expand the
inspection to unrelated application or provider surfaces.

## 2. Observed evidence

- C12-S00 repository checkpoint had a clean aligned `markei-season-02`
  branch at the starting HEAD.
- `GS-FLUTTER-WIN` previously completed. `GS-FLUTTER-AND` stopped before
  an Android artifact because its source-identity guard reported relevant
  inputs dirty.
- The only reported paths were:

```text
clients/markei_flutter/windows/flutter/generated_plugin_registrant.cc
clients/markei_flutter/windows/flutter/generated_plugin_registrant.h
clients/markei_flutter/windows/flutter/generated_plugins.cmake
```

- For those paths, no-textconv binary diff and raw diff were empty; all were
  `i/lf w/lf`; no relevant Git attributes were present.
- A targeted `git update-index --refresh` reported `needs update`. That is
  a diagnostic observation, not proof of a security breach and not authority
  to repair, stage, restore, or regenerate files.
- Subsequent exact `git hash-object --no-filters` worktree hashes matched
  their index blobs, and targeted `git status --short` produced no output.
  Codex must independently reverify rather than rely on this transcription.
- Toolchain discovery passes for Android; no Android runtime is connected.
  These facts are out of scope for this diagnosis.
- No secret, token, password, connection URL, or Device UUID is part of this
  round.

## 3. Codex task — read-only only

1. Re-establish the current local repository baseline: branch, full HEAD,
   upstream divergence, ordinary porcelain status, and the three named paths.
2. Independently verify exact index/worktree equivalence for the named paths,
   plus the relevant Git configuration and index/stat-refresh behavior.
3. Read
   `clients/markei_flutter/tool/resolve_markei_source_identity.ps1` and
   determine its exact guarded input set and clean-state precondition.
4. Classify the earlier transient report precisely: stable clean state,
   reproducible Git-state anomaly, or an unresolved discrepancy. State the
   evidence that distinguishes the classification.
5. Recommend the smallest next Main-authorizable action. It may be a
   baseline-preserving Inner-Sprint closure, or a narrowly scoped corrective
   proposal. Do not start a build.

## 4. Non-authority / prohibitions

This is not authority to:

- edit, stage, commit, restore, reset, clean, stash, regenerate, or reconfigure
  Git files;
- run `GS-FLUTTER-AND`, `GS-FLUTTER-WIN`, Flutter, Gradle, Android Studio,
  emulators, ADB, package resolution, or any build;
- alter application source, generated source, dependencies, documentation
  outside this J stage, providers, Auth0, Neon, Render, credentials, or devices;
- infer a compromise from a Git index refresh message alone.

Stop and hand back if the baseline is not clean, the branch/HEAD has changed
unexpectedly, or exact worktree/index equivalence cannot be established.

## 5. Required handback

Return to Main with a concise, evidence-backed report containing:

- repository checkpoint;
- each named path's classification;
- source-identity guard behavior;
- whether C12-S00-AS02-IS01 can close without mutation;
- one smallest proposed next action, with its scope and stop condition.

Do not write G/H/I, permanent records, provider logs, or a new Notebook file.
Main retains all transition and closure authority.

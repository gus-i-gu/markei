import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { existsSync, readFileSync } from "node:fs";
import test from "node:test";
import {
  syncDiagnosticRegistry,
  syncDiagnosticRegistryVersion,
} from "../src/domain/sync_diagnostic_registry.generated.js";

const registry = JSON.parse(
  readFileSync(
    "../../contracts/shared_beta/diagnostics_v1/diagnostics.registry.json",
    "utf8",
  ),
) as {
  version: number;
  diagnostics: Array<{
    code: string;
    detectorSourceRefs: string[];
    sensitiveFieldsForbidden: string[];
  }>;
};

test("sync diagnostics registry has exactly 159 unique schema-shaped codes", () => {
  const codes = registry.diagnostics.map((item) => item.code);
  assert.equal(registry.version, 1);
  assert.equal(codes.length, 159);
  assert.equal(new Set(codes).size, 159);
  for (const code of codes) {
    assert.match(code, /^MKS-[A-Z]+-[0-9]{3}$/);
  }
});

test("generated TypeScript, Dart and Markdown expose identical code sets", () => {
  const registryCodes = registry.diagnostics.map((item) => item.code).sort();
  const typeScriptCodes = Object.keys(syncDiagnosticRegistry).sort();
  const dart = readFileSync(
    "../../clients/markei_flutter/lib/domain/sync/sync_diagnostic_registry.g.dart",
    "utf8",
  );
  const markdown = readFileSync(
    "../../documentation/ERR_DIAGNOSTICS.md",
    "utf8",
  );
  const dartCodes = uniqueMatches(dart);
  const markdownCodes = uniqueMatches(markdown);

  assert.equal(syncDiagnosticRegistryVersion, registry.version);
  assert.deepEqual(typeScriptCodes, registryCodes);
  assert.deepEqual(dartCodes, registryCodes);
  assert.deepEqual(markdownCodes, registryCodes);
});

test("registry source references exist and sensitive fields remain rejected", () => {
  const forbidden = new Set([
    "token",
    "password",
    "payload_json",
    "payloadJson",
    "connectionString",
    "connection_string",
    "completeHash",
    "complete_hash",
    "privateUrl",
    "private_url",
    "stackTrace",
    "stack_trace",
    "sql",
  ]);
  for (const diagnostic of registry.diagnostics) {
    for (const ref of diagnostic.detectorSourceRefs) {
      assert.equal(
        existsSync(`../../${ref}`),
        true,
        `${diagnostic.code} ${ref}`,
      );
    }
    for (const field of diagnostic.sensitiveFieldsForbidden) {
      assert.equal(forbidden.has(field), true, `${diagnostic.code} ${field}`);
    }
  }
});

test("diagnostic generation check mode detects stale output", () => {
  execFileSync(
    "node",
    ["../../scripts/generate_sync_diagnostics.mjs", "--check"],
    {
      stdio: "pipe",
    },
  );
});

function uniqueMatches(value: string) {
  return [
    ...new Set(
      [...value.matchAll(/MKS-[A-Z]+-[0-9]{3}/g)].map((match) => match[0]),
    ),
  ].sort();
}

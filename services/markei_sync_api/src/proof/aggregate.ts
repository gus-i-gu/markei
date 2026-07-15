import { readFileSync } from "node:fs";
import {
  REQUIRED_PROOF_CASES,
  type ProofCaseResult,
  type ProofProducerName,
  type ProofProducerResult,
} from "./producer.js";

type AggregationResult = {
  passed: boolean;
  blockers: string[];
};

export function aggregateProofResults(
  records: readonly unknown[],
): AggregationResult {
  const blockers: string[] = [];
  const byProducer = new Map<ProofProducerName, ProofProducerResult>();
  for (const record of records) {
    const parsed = parseRecord(record, blockers);
    if (!parsed) continue;
    if (byProducer.has(parsed.producer)) {
      blockers.push(`duplicate-producer:${parsed.producer}`);
      continue;
    }
    byProducer.set(parsed.producer, parsed);
  }
  for (const producer of Object.keys(
    REQUIRED_PROOF_CASES,
  ) as ProofProducerName[]) {
    const record = byProducer.get(producer);
    if (!record) {
      blockers.push(`missing-producer:${producer}`);
      continue;
    }
    validateCases(record, blockers);
  }
  return { passed: blockers.length === 0, blockers };
}

function parseRecord(
  value: unknown,
  blockers: string[],
): ProofProducerResult | null {
  if (!value || typeof value !== "object") {
    blockers.push("malformed-record");
    return null;
  }
  const record = value as Partial<ProofProducerResult>;
  if (
    record.schemaVersion !== 1 ||
    typeof record.producer !== "string" ||
    !(record.producer in REQUIRED_PROOF_CASES) ||
    !Array.isArray(record.requiredCases) ||
    !record.resultsByCase ||
    typeof record.resultsByCase !== "object" ||
    typeof record.passed !== "boolean"
  ) {
    blockers.push("malformed-record");
    return null;
  }
  return record as ProofProducerResult;
}

function validateCases(record: ProofProducerResult, blockers: string[]) {
  const expected = [...REQUIRED_PROOF_CASES[record.producer]].sort();
  const declared = [...record.requiredCases].sort();
  if (JSON.stringify(expected) !== JSON.stringify(declared)) {
    blockers.push(`case-set-mismatch:${record.producer}`);
  }
  const resultKeys = Object.keys(record.resultsByCase).sort();
  if (JSON.stringify(expected) !== JSON.stringify(resultKeys)) {
    blockers.push(`case-results-mismatch:${record.producer}`);
  }
  for (const caseId of expected) {
    const result = (record.resultsByCase as Record<string, ProofCaseResult>)[
      caseId
    ];
    if (!result || typeof result.passed !== "boolean") {
      blockers.push(`malformed-case:${record.producer}:${caseId}`);
      continue;
    }
    if (!result.passed) {
      blockers.push(
        result.blocker ?? `false-case:${record.producer}:${caseId}`,
      );
    }
  }
  if (!record.passed) blockers.push(`producer-false:${record.producer}`);
}

if (process.argv[1]?.endsWith("aggregate.ts")) {
  const records = process.argv.slice(2).map((path) => {
    const parsed = JSON.parse(readFileSync(path, "utf8")) as unknown;
    return parsed;
  });
  const result = aggregateProofResults(records);
  for (const blocker of result.blockers) {
    process.stdout.write(`BLOCKER=${blocker}\n`);
  }
  process.stdout.write(`R3_LOCAL_SECURITY_PROVED=${result.passed}\n`);
  if (result.passed) {
    process.stdout.write("C10_S03A_R3C_LOCAL_SECURITY_PROVED=true\n");
  } else {
    process.stdout.write("C10_S03A_R3C_PARTIAL=true\n");
    process.exitCode = 1;
  }
}

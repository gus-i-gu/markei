import assert from "node:assert/strict";
import test from "node:test";
import { aggregateProofResults } from "../src/proof/aggregate.js";
import {
  makeProducerResult,
  REQUIRED_PROOF_CASES,
  type ProofProducerName,
} from "../src/proof/producer.js";

test("proof aggregator accepts a complete producer set", () => {
  const records = allProducerNames().map((producer) =>
    makeProducerResult(producer, allPassed(producer)),
  );

  assert.deepEqual(aggregateProofResults(records), {
    passed: true,
    blockers: [],
  });
});

test("proof aggregator rejects missing, duplicate, malformed and false inputs", () => {
  const complete = allProducerNames().map((producer) =>
    makeProducerResult(producer, allPassed(producer)),
  );
  const missing = aggregateProofResults(complete.slice(1));
  assert.equal(missing.passed, false);
  assert(missing.blockers.some((item) => item.startsWith("missing-producer:")));

  const duplicate = aggregateProofResults([complete[0], ...complete]);
  assert.equal(duplicate.passed, false);
  assert(
    duplicate.blockers.some((item) => item.startsWith("duplicate-producer:")),
  );

  const malformed = aggregateProofResults([{}, ...complete.slice(1)]);
  assert.equal(malformed.passed, false);
  assert(malformed.blockers.includes("malformed-record"));

  const falseRecord = makeProducerResult("authorization-race", {
    ...allPassed("authorization-race"),
    "denied-no-state-advance": {
      passed: false,
      blocker: "authorization-race:denied-no-state-advance",
    },
  });
  const falseAggregate = aggregateProofResults([
    falseRecord,
    ...complete.slice(1),
  ]);
  assert.equal(falseAggregate.passed, false);
  assert(
    falseAggregate.blockers.includes(
      "authorization-race:denied-no-state-advance",
    ),
  );
});

test("proof aggregator rejects unknown or incomplete case sets", () => {
  const complete = allProducerNames().map((producer) =>
    makeProducerResult(producer, allPassed(producer)),
  );
  const routeRecord = {
    ...complete.find((record) => record.producer === "route-inventory")!,
    requiredCases: ["valid-current-inventory"],
  };
  const result = aggregateProofResults([
    routeRecord,
    ...complete.filter((record) => record.producer !== "route-inventory"),
  ]);

  assert.equal(result.passed, false);
  assert(result.blockers.includes("case-set-mismatch:route-inventory"));
});

function allProducerNames(): ProofProducerName[] {
  return Object.keys(REQUIRED_PROOF_CASES) as ProofProducerName[];
}

function allPassed(producer: ProofProducerName) {
  return Object.fromEntries(
    REQUIRED_PROOF_CASES[producer].map((caseId) => [caseId, true]),
  );
}

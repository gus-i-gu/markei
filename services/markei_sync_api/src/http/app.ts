import sensible from "@fastify/sensible";
import Fastify from "fastify";
import type { AuthVerifier } from "../application/auth.js";
import { acceptSubmission } from "../application/sync_service.js";
import { inTransaction, type Database } from "../postgres/database.js";

export function buildApp(options: { auth: AuthVerifier; database?: Database }) {
  const app = Fastify({ logger: false });
  app.register(sensible);

  app.get("/health/live", async () => ({ status: "live" }));
  app.get("/health/ready", async () => ({
    status: options.database ? "ready" : "not-ready",
  }));

  app.post("/v1/sync/submissions", async (request, reply) => {
    if (!options.database) {
      return reply.code(503).send({
        code: "service-unavailable",
        operation: "upload-submission",
        outcome: "unknown",
        retryable: true,
        safeAction: "retry the same SubmissionId later",
        correlationId: request.id,
      });
    }
    const auth = await options.auth.verify(request);
    const result = await inTransaction(options.database, (client) =>
      acceptSubmission(client, auth, request.body as never, request.id),
    );
    return reply.send(result);
  });

  app.get("/v1/sync/events", async (request) => {
    const query = request.query as { after?: string; limit?: string };
    return { after: query.after ?? null, nextCursor: null, events: [] };
  });

  app.post("/v1/sync/acknowledgements", async () => ({
    status: "duplicate-ignored",
  }));

  return app;
}

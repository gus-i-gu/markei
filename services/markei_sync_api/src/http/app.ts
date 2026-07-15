import sensible from "@fastify/sensible";
import Fastify from "fastify";
import type { AuthVerifier } from "../application/auth.js";
import { HostedAuthError } from "../application/hosted_contracts.js";
import type { HostedIdentityService } from "../application/hosted_authorization.js";
import {
  acceptSubmission,
  acknowledgeCursor,
  downloadEvents,
} from "../application/sync_service.js";
import {
  completeRebootstrap,
  getCapabilities,
  getRebootstrapChunk,
  getRebootstrapStatus,
  startRebootstrap,
  type RecoveryComposition,
} from "../application/recovery_service.js";
import { inTransaction, type Database } from "../postgres/database.js";
import type { AuthContext } from "../domain/protocol.js";
import type { PoolClient } from "pg";

type TransactionScopedAuth = AuthVerifier & {
  authorizeOperation<T>(
    request: Parameters<AuthVerifier["verify"]>[0],
    operation: string,
    action: (client: PoolClient, auth: AuthContext) => Promise<T>,
  ): Promise<T>;
};

export const PROTECTED_ROUTE_POLICIES = [
  {
    method: "POST",
    path: "/v1/sync/submissions",
    operation: "upload-submission",
  },
  { method: "GET", path: "/v1/sync/events", operation: "download-events" },
  {
    method: "POST",
    path: "/v1/sync/acknowledgements",
    operation: "acknowledgement",
  },
  { method: "GET", path: "/v1/sync/capabilities", operation: "capabilities" },
  {
    method: "POST",
    path: "/v1/sync/rebootstrap",
    operation: "start-rebootstrap",
  },
  {
    method: "GET",
    path: "/v1/sync/rebootstrap/:sessionId",
    operation: "query-rebootstrap",
  },
  {
    method: "GET",
    path: "/v1/sync/rebootstrap/:sessionId/chunks/:index",
    operation: "download-rebootstrap-chunk",
  },
  {
    method: "POST",
    path: "/v1/sync/rebootstrap/:sessionId/complete",
    operation: "complete-rebootstrap",
  },
] as const;

export function buildApp(options: {
  auth: AuthVerifier;
  database?: Database;
  recovery?: RecoveryComposition;
  hosted?: HostedIdentityService;
}) {
  const app = Fastify({ logger: false });
  app.register(sensible);

  app.get("/health/live", async () => ({ status: "live" }));
  app.get("/health/ready", async () => ({
    status: await readyStatus(options.database),
  }));

  app.setErrorHandler((error, request, reply) => {
    if (error instanceof HostedAuthError) {
      return reply.code(error.statusCode).send({
        code: error.code,
        operation: "hosted-authorization",
        outcome: "not-applied",
        retryable: false,
        safeAction: "preserve local state",
        correlationId: request.id,
      });
    }
    return reply.code(500).send({
      code: "service-unavailable",
      operation: "server",
      outcome: "unknown",
      retryable: true,
      safeAction: "retry later",
      correlationId: request.id,
    });
  });

  if (options.hosted) {
    app.get("/v1/identity", async (request) =>
      options.hosted!.identity(request),
    );
    app.post("/v1/devices/enroll", async (request) =>
      options.hosted!.enroll(request, request.body as never),
    );
    app.get("/v1/devices/enrollments/:requestId", async (request) => {
      const params = request.params as { requestId: string };
      return options.hosted!.enrollmentStatus(request, params.requestId);
    });
    app.get("/v1/devices/:deviceId/status", async (request) => {
      const params = request.params as { deviceId: string };
      return options.hosted!.deviceStatus(request, params.deviceId);
    });
    app.post("/v1/devices/:deviceId/revoke", async (request) => {
      const params = request.params as { deviceId: string };
      return options.hosted!.revoke(request, params.deviceId);
    });
  }

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
    const result = await protectedOperation(
      options.database,
      options.auth,
      request,
      "upload-submission",
      (client, auth) =>
        acceptSubmission(client, auth, request.body as never, request.id),
    );
    return reply.send(result);
  });

  app.get("/v1/sync/events", async (request, reply) => {
    if (!options.database) {
      return reply.code(503).send({
        code: "service-unavailable",
        operation: "download-events",
        outcome: "unknown",
        retryable: true,
        safeAction: "retry later",
        correlationId: request.id,
      });
    }
    const query = request.query as { after?: string; limit?: string };
    const result = await protectedOperation(
      options.database,
      options.auth,
      request,
      "download-events",
      (client, auth) =>
        downloadEvents(client, auth, query.after, Number(query.limit ?? 25)),
    );
    return reply.send(result);
  });

  app.post("/v1/sync/acknowledgements", async (request, reply) => {
    if (!options.database) {
      return reply.code(503).send({
        code: "service-unavailable",
        operation: "acknowledgement",
        outcome: "unknown",
        retryable: true,
        safeAction: "retry later",
        correlationId: request.id,
      });
    }
    const body = request.body as { greatestContiguousCursor: string };
    const result = await protectedOperation(
      options.database,
      options.auth,
      request,
      "acknowledgement",
      (client, auth) =>
        acknowledgeCursor(client, auth, body.greatestContiguousCursor),
    );
    return reply.send(result);
  });

  app.get("/v1/sync/capabilities", async (request, reply) => {
    if (!options.database || !options.recovery) {
      return reply.code(503).send(unavailable("capabilities", request.id));
    }
    const result = await protectedOperation(
      options.database,
      options.auth,
      request,
      "capabilities",
      (client, auth) => getCapabilities(client, auth, options.recovery!),
    );
    return reply.send(result);
  });

  app.post("/v1/sync/rebootstrap", async (request, reply) => {
    if (!options.database || !options.recovery) {
      return reply.code(503).send(unavailable("start-rebootstrap", request.id));
    }
    const result = await protectedOperation(
      options.database,
      options.auth,
      request,
      "start-rebootstrap",
      (client, auth) =>
        startRebootstrap(
          client,
          auth,
          request.body as never,
          options.recovery!,
        ),
    );
    return reply.send(result);
  });

  app.get("/v1/sync/rebootstrap/:sessionId", async (request, reply) => {
    if (!options.database || !options.recovery) {
      return reply.code(503).send(unavailable("query-rebootstrap", request.id));
    }
    const params = request.params as { sessionId: string };
    const result = await protectedOperation(
      options.database,
      options.auth,
      request,
      "query-rebootstrap",
      (client, auth) =>
        getRebootstrapStatus(client, auth, params.sessionId, options.recovery!),
    );
    return reply.send(result);
  });

  app.get(
    "/v1/sync/rebootstrap/:sessionId/chunks/:index",
    async (request, reply) => {
      if (!options.database || !options.recovery) {
        return reply
          .code(503)
          .send(unavailable("download-rebootstrap-chunk", request.id));
      }
      const params = request.params as { sessionId: string; index: string };
      const result = await protectedOperation(
        options.database,
        options.auth,
        request,
        "download-rebootstrap-chunk",
        (client, auth) =>
          getRebootstrapChunk(
            client,
            auth,
            params.sessionId,
            Number(params.index),
            options.recovery!,
          ),
      );
      return reply.send(result);
    },
  );

  app.post(
    "/v1/sync/rebootstrap/:sessionId/complete",
    async (request, reply) => {
      if (!options.database || !options.recovery) {
        return reply
          .code(503)
          .send(unavailable("complete-rebootstrap", request.id));
      }
      const params = request.params as { sessionId: string };
      const body = request.body as Record<string, unknown>;
      const result = await protectedOperation(
        options.database,
        options.auth,
        request,
        "complete-rebootstrap",
        (client, auth) =>
          completeRebootstrap(
            client,
            auth,
            { ...body, recoverySessionId: params.sessionId } as never,
            options.recovery!,
          ),
      );
      return reply.send(result);
    },
  );

  return app;
}

async function protectedOperation<T>(
  database: Database,
  authVerifier: AuthVerifier,
  request: Parameters<AuthVerifier["verify"]>[0],
  operation: string,
  action: (client: PoolClient, auth: AuthContext) => Promise<T>,
): Promise<T> {
  if ("authorizeOperation" in authVerifier) {
    return (authVerifier as TransactionScopedAuth).authorizeOperation(
      request,
      operation,
      action,
    );
  }
  const auth = await authVerifier.verify(request);
  return inTransaction(database, auth, (client) => action(client, auth));
}

function unavailable(operation: string, correlationId: string) {
  return {
    code: "service-unavailable",
    operation,
    outcome: "unknown",
    retryable: true,
    safeAction: "retry later",
    correlationId,
  };
}

async function readyStatus(database: Database | undefined) {
  if (!database) return "not-ready";
  try {
    const result = await database.pool.query(
      "select 1 from migration_ledger where migration_id=$1",
      ["004_hosted_identity_enrollment"],
    );
    return result.rowCount ? "ready" : "not-ready";
  } catch {
    return "not-ready";
  }
}

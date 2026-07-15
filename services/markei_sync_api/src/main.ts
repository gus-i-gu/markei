import pg from "pg";
import { RefusingAuthVerifier } from "./application/auth.js";
import { buildApp } from "./http/app.js";

const connectionString = process.env.MARKEI_SYNC_DATABASE_URL;
if (!connectionString) {
  throw new Error("MARKEI_SYNC_DATABASE_URL is required");
}

const app = buildApp({
  auth: new RefusingAuthVerifier(),
  database: { pool: new pg.Pool({ connectionString }) },
});

await app.listen({ host: "127.0.0.1", port: Number(process.env.PORT ?? 3100) });

import type { FastifyRequest } from "fastify";
import type { AuthContext } from "../domain/protocol.js";

export interface AuthVerifier {
  verify(request: FastifyRequest): Promise<AuthContext>;
}

export class FixtureAuthVerifier implements AuthVerifier {
  constructor(private readonly claims: AuthContext) {}

  async verify(): Promise<AuthContext> {
    return this.claims;
  }
}

export class RefusingAuthVerifier implements AuthVerifier {
  async verify(): Promise<AuthContext> {
    throw new Error("normal runtime requires a non-fixture AuthVerifier");
  }
}

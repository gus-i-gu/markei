import type { FastifyRequest } from "fastify";
import {
  createLocalJWKSet,
  decodeProtectedHeader,
  errors,
  jwtVerify,
  type JWK,
  type JWTPayload,
} from "jose";
import {
  HostedAuthError,
  type Clock,
  type ExternalPrincipal,
  type PrincipalVerifier,
} from "./hosted_contracts.js";

export type JwtVerifierOptions = {
  issuer: string;
  audience: string;
  jwksUri: string;
  clock: Clock;
  skewSeconds?: number;
  timeoutMs?: number;
  cacheMaxAgeMs?: number;
  cooldownMs?: number;
  maxTokenBytes?: number;
  maxJwksBytes?: number;
  fetchJwks?: typeof fetch;
};

export class Auth0JwtVerifier implements PrincipalVerifier {
  private readonly jwks: BoundedJwksSource;
  private readonly maxTokenBytes: number;

  constructor(private readonly options: JwtVerifierOptions) {
    this.jwks = new BoundedJwksSource({
      uri: options.jwksUri,
      timeoutMs: options.timeoutMs ?? 1500,
      cacheMaxAgeMs: options.cacheMaxAgeMs ?? 300000,
      cooldownMs: options.cooldownMs ?? 1000,
      maxBytes: options.maxJwksBytes ?? 65536,
      clock: options.clock,
      fetchJwks: options.fetchJwks ?? fetch,
    });
    this.maxTokenBytes = options.maxTokenBytes ?? 8192;
  }

  async verify(request: FastifyRequest): Promise<ExternalPrincipal> {
    const token = bearer(request.headers.authorization);
    if (Buffer.byteLength(token, "utf8") > this.maxTokenBytes) {
      throw new HostedAuthError("token-rejected");
    }
    try {
      const header = decodeProtectedHeader(token);
      if (header.alg !== "RS256" || typeof header.kid !== "string") {
        throw new HostedAuthError("token-rejected");
      }
      const verified = await jwtVerify(
        token,
        (header, jwt) => this.jwks.getKey(header, jwt),
        {
          issuer: this.options.issuer,
          audience: this.options.audience,
          algorithms: ["RS256"],
          clockTolerance: this.options.skewSeconds ?? 30,
          currentDate: this.options.clock.now(),
        },
      );
      const subject = validSubject(verified.payload);
      return {
        issuer: this.options.issuer,
        subject,
        audience: this.options.audience,
        expiresAt: expiry(verified.payload),
      };
    } catch (error) {
      if (error instanceof HostedAuthError) throw error;
      if (error instanceof errors.JOSEError || error instanceof Error) {
        throw new HostedAuthError("token-rejected");
      }
      throw new HostedAuthError("token-rejected");
    }
  }
}

type BoundedJwksOptions = {
  uri: string;
  timeoutMs: number;
  cacheMaxAgeMs: number;
  cooldownMs: number;
  maxBytes: number;
  clock: Clock;
  fetchJwks: typeof fetch;
};

class BoundedJwksSource {
  private local: ReturnType<typeof createLocalJWKSet> | null = null;
  private expiresAt = 0;
  private nextRefreshAfter = 0;
  private refreshPromise: Promise<void> | null = null;
  private readonly uri: URL;

  constructor(private readonly options: BoundedJwksOptions) {
    this.uri = boundedUri(options.uri);
  }

  async getKey(
    header: Parameters<ReturnType<typeof createLocalJWKSet>>[0],
    token: Parameters<ReturnType<typeof createLocalJWKSet>>[1],
  ) {
    if (!this.local || this.options.clock.now().getTime() >= this.expiresAt) {
      await this.refresh();
    }
    try {
      return await this.local!(header, token);
    } catch (error) {
      if (!(error instanceof errors.JWKSNoMatchingKey)) throw error;
      await this.refresh();
      return this.local!(header, token);
    }
  }

  private async refresh() {
    const now = this.options.clock.now().getTime();
    if (this.refreshPromise) return this.refreshPromise;
    if (now < this.nextRefreshAfter) {
      if (this.local) return;
      throw new HostedAuthError("token-rejected");
    }
    this.refreshPromise = this.fetchAndCache()
      .catch((error) => {
        this.nextRefreshAfter = now + this.options.cooldownMs;
        if (this.local) return;
        throw error;
      })
      .finally(() => {
        this.refreshPromise = null;
      });
    return this.refreshPromise;
  }

  private async fetchAndCache() {
    const controller = new AbortController();
    const timeout = setTimeout(
      () => controller.abort(),
      this.options.timeoutMs,
    );
    try {
      const response = await this.options.fetchJwks(this.uri, {
        redirect: "manual",
        signal: controller.signal,
      });
      if (response.status < 200 || response.status >= 300) {
        throw new HostedAuthError("token-rejected");
      }
      const text = await boundedText(response, this.options.maxBytes);
      const parsed = JSON.parse(text) as unknown;
      const jwks = validateJwks(parsed);
      this.local = createLocalJWKSet(jwks);
      this.expiresAt =
        this.options.clock.now().getTime() + this.options.cacheMaxAgeMs;
      this.nextRefreshAfter = 0;
    } catch (error) {
      if (error instanceof HostedAuthError) throw error;
      throw new HostedAuthError("token-rejected");
    } finally {
      clearTimeout(timeout);
    }
  }
}

function boundedUri(value: string): URL {
  const uri = new URL(value);
  if (!["https:", "http:"].includes(uri.protocol)) {
    throw new HostedAuthError("token-rejected");
  }
  if (uri.username || uri.password || uri.hash) {
    throw new HostedAuthError("token-rejected");
  }
  return uri;
}

async function boundedText(response: Response, maxBytes: number) {
  if (!response.body) return "";
  const reader = response.body.getReader();
  const chunks: Uint8Array[] = [];
  let total = 0;
  for (;;) {
    const { done, value } = await reader.read();
    if (done) break;
    total += value.byteLength;
    if (total > maxBytes) {
      await reader.cancel().catch(() => undefined);
      throw new HostedAuthError("token-rejected");
    }
    chunks.push(value);
  }
  return Buffer.concat(chunks).toString("utf8");
}

function validateJwks(value: unknown): { keys: JWK[] } {
  if (
    !value ||
    typeof value !== "object" ||
    !Array.isArray((value as { keys?: unknown }).keys)
  ) {
    throw new HostedAuthError("token-rejected");
  }
  const seen = new Map<string, string>();
  const keys = (value as { keys: JWK[] }).keys;
  if (keys.length < 1 || keys.length > 16) {
    throw new HostedAuthError("token-rejected");
  }
  for (const key of keys) {
    if (!key || typeof key !== "object") {
      throw new HostedAuthError("token-rejected");
    }
    if (
      typeof key.kid !== "string" ||
      key.kid.length < 1 ||
      key.kid.length > 128
    ) {
      throw new HostedAuthError("token-rejected");
    }
    const fingerprint = JSON.stringify(key);
    const previous = seen.get(key.kid);
    if (previous && previous !== fingerprint) {
      throw new HostedAuthError("token-rejected");
    }
    seen.set(key.kid, fingerprint);
  }
  return { keys };
}

function bearer(value: string | string[] | undefined): string {
  if (Array.isArray(value))
    throw new HostedAuthError("authentication-required");
  if (!value) throw new HostedAuthError("authentication-required");
  const parts = value.trim().split(/\s+/);
  if (parts.length !== 2 || parts[0] !== "Bearer" || !parts[1]) {
    throw new HostedAuthError("authentication-required");
  }
  return parts[1];
}

function validSubject(payload: JWTPayload): string {
  if (typeof payload.sub !== "string")
    throw new HostedAuthError("token-rejected");
  if (payload.sub.length < 1 || payload.sub.length > 256) {
    throw new HostedAuthError("token-rejected");
  }
  return payload.sub;
}

function expiry(payload: JWTPayload): Date {
  if (typeof payload.exp !== "number")
    throw new HostedAuthError("token-rejected");
  return new Date(payload.exp * 1000);
}

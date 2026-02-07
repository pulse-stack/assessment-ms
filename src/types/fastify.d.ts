import { PrismaClient } from "../generated/prisma/client";

declare module "fastify" {
    interface FastifyInstance {
        prisma: PrismaClient;
    }

    interface FastifyReply {
        success<T = unknown>(data: T, message?: string): void;
        fail<T = unknown>(message: string, data?: T): void;
    }
}

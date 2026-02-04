import prismaPlugin from "./prisma";
import type { FastifyInstance } from "fastify";

export function registerPlugins(app: FastifyInstance) {
    app.register(prismaPlugin);
}

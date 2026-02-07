import type { FastifyInstance } from "fastify";

import prismaPlugin from "./prisma.plugin";
import { responsePlugin } from "./reply.plugin";
import schemasPlugin from "./schema.plugin";

export function registerPlugins(app: FastifyInstance) {
    app.register(prismaPlugin);
    app.register(responsePlugin);
    app.register(schemasPlugin);
}

import type { FastifyInstance, FastifyPluginAsync } from "fastify";

export const assessmentRoutes: FastifyPluginAsync = async (
    app: FastifyInstance,
) => {
    app.get("/", {}, () => {});
    app.get("/", {}, () => {});
};

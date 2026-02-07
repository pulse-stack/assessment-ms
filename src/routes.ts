import type { FastifyInstance } from "fastify";
import { assessmentRoutes } from "./modules/assessments/assessments.route";

export async function registerRoutes(app: FastifyInstance) {
    await app.register(assessmentRoutes, { prefix: "/assessments" });
}

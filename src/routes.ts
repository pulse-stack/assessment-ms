import type { FastifyInstance } from "fastify";
import assessmentsRoutes from "./modules/assessments/assessments.route";
import submissionRoutes from "./modules/submissions/submission.routes";

export async function registerRoutes(app: FastifyInstance) {
    await app.register(assessmentsRoutes, { prefix: "/assessments" });
    await app.register(submissionRoutes, { prefix: "/submissions" });
}

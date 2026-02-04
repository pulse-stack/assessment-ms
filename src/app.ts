import Fastify from "fastify";
import { registerPlugins } from "./plugins";
import { registerRoutes } from "./routes";

export const app = Fastify({
    logger: {
        level: "info",
    },
});

export async function buildApp() {
    await registerPlugins(app);
    await registerRoutes(app);

    return app;
}

registerPlugins(app);
registerRoutes(app);

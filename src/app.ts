import Fastify from "fastify";
import { registerPlugins } from "./plugins";
import { registerRoutes } from "./routes";
import { errorHandler } from "./shared/http/error-handler";

export const app = Fastify({
    logger: {
        level: "info",
    },
});

export function buildApp() {
    registerPlugins(app);
    registerRoutes(app);
    app.setErrorHandler(errorHandler);

    return app;
}

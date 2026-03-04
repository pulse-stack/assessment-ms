import Fastify from "fastify";
import { registerPlugins } from "./plugins";
import { registerRoutes } from "./routes";
import { errorHandler } from "./shared/http/error-handler";

export const app = Fastify({
    logger: {
        level: "info",
    },
    ajv: {
        customOptions: {
            removeAdditional: true,
            coerceTypes: true,
            useDefaults: true,
        },
    },
});

export function buildApp() {
    registerPlugins(app);
    registerRoutes(app);
    app.setErrorHandler(errorHandler);

    return app;
}

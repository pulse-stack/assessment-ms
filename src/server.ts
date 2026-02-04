import { buildApp } from "./app";

const start = async () => {
    try {
        const app = await buildApp();
        const PORT = Number(process.env.PORT) || 3000;
        const HOST = process.env.HOST || "0.0.0.0";

        await app.listen({ port: PORT, host: HOST });
        app.log.info(`🚀 Server running on port ${PORT}`);
    } catch (err) {
        console.error(err);
        process.exit(1);
    }
};

start();

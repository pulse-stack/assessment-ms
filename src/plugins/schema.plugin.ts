import type { FastifyInstance, FastifyPluginAsync } from "fastify";

const schemasPlugin: FastifyPluginAsync = async (fastify: FastifyInstance) => {
    [].forEach((schema) => fastify.addSchema(schema));
};

export default schemasPlugin;

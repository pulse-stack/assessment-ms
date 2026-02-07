import fp from "fastify-plugin";
import { PrismaPg } from "@prisma/adapter-pg";
import { PrismaClient } from "../generated/prisma/client";
import type { FastifyInstance } from "fastify";

export default fp(async (fastify: FastifyInstance) => {
    const connectionString = `${process.env.DATABASE_URL}`;
    const adapter = new PrismaPg({ connectionString });
    const prisma = new PrismaClient({ adapter });

    fastify.decorate("prisma", prisma);

    fastify.addHook("onClose", async () => {
        await prisma.$disconnect();
    });
});

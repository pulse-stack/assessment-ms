import type { Response } from "@/shared/interfaces/response.interface";
import type { FastifyPluginAsync, FastifyReply } from "fastify";

function successReply<T = unknown>(
    data: T,
    message: String = "Ok",
): Response<T> {
    return {
        success: true,
        message,
        data,
    };
}

function failReply<T = null>(message: String, data?: T): Response<T> {
    return {
        success: false,
        message,
        data,
    };
}

export const responsePlugin: FastifyPluginAsync = async (fastify) => {
    fastify.decorateReply("success", function <
        T,
    >(this: FastifyReply, data: T, message?: string) {
        return this.send(successReply(data, message));
    });

    fastify.decorateReply("fail", function <
        T,
    >(this: FastifyReply, message: string, data?: T) {
        return this.send(failReply(message, data));
    });
};

export const baseResponseSchema = {
    $id: "BaseResponse",
    type: "object",
    required: ["success", "message"],
    properties: {
        success: { type: "boolean" },
        message: { type: "string" },
        // Allows `data` to be any valid JSON value.
        // Intended to be specialized by route-level schemas.
        data: true,
    },
};

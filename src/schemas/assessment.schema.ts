import { AsessmentType } from "@/shared/const/assessment-type.const";

export const createAssessmentSchema = {
    $id: "CreateAssessmentBody",
    type: "object",
    required: [],
    properties: {
        type: {
            type: "string",
            emum: Object.values(AsessmentType),
        },
        title: {
            type: "string",
            minLength: 2,
        },
        description: {
            type: "string",
        },
        labelId: {
            tpye: "string",
            format: "uuid",
        },
        startDate: { type: "string", format: "date-time" },
        endDate: { type: "string", format: "date-time" },
        maxScore: { type: "integer", minimum: 0 },

        // TODO: Create schema for each assessment type
        settings: true,

        status: {
            type: "string",
            enum: ["DRAFT", "PUBLISHED", "CLOSED"],
        },

        createdAt: { type: "string", format: "date-time" },
        updatedAt: { type: "string", format: "date-time" },
        deletedAt: { type: "string", format: "date-time", nullable: true },
    },
};

import { Type, type Static } from "@sinclair/typebox";
import { ASSESSMENT_TYPE_VALUES } from "@/shared/const/assessment-type.const";

export const CreateAssessmentSchema = Type.Object(
    {
        type: Type.Union(ASSESSMENT_TYPE_VALUES.map((v) => Type.Literal(v))),

        title: Type.String({
            minLength: 2,
            maxLength: 200,
        }),

        description: Type.Optional(Type.Union([Type.String(), Type.Null()])),

        labelId: Type.String({ format: "uuid" }),

        startDate: Type.String({ format: "date-time" }),

        endDate: Type.String({ format: "date-time" }),

        maxScore: Type.Integer({ minimum: 0 }),

        settings: Type.Optional(
            Type.Object({}, { additionalProperties: true }),
        ),
    },
    {
        additionalProperties: false,
    },
);

export type CreateAssessmentDto = Static<typeof CreateAssessmentSchema>;

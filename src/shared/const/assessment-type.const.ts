import { defineEnum, type ValueOf } from "@pulse/primitives";

export const ASSESSMENT_TYPE_VALUES = [
    "EXAM",
    "QUIZZ",
    "TASK",
    "IMPROVEMENT_PLAN",
];

export const AsessmentType = defineEnum(ASSESSMENT_TYPE_VALUES);
export type AsessmentType = ValueOf<typeof AsessmentType>;

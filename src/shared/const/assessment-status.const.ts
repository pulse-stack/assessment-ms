import { defineEnum, type ValueOf } from "@pulse/primitives";

export const ASSESSMENT_STATUS_VALUES = [
    "DRAFT",
    "PUBLISHED",
    "INACTIVE",
    "DELETED",
];

export const AssessmentStatus = defineEnum(ASSESSMENT_STATUS_VALUES);
export type AssessmentStatus = ValueOf<typeof AssessmentStatus>;

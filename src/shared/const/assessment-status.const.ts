import { defineEnum, type TypeOf } from "../utils/define-enum";

const values = ["DRAFT", "PUBLISHED", "INACTIVE", "DELETED"];

export const AssessmentStatus = defineEnum(values);
export type AssessmentStatus = TypeOf<typeof AssessmentStatus>;

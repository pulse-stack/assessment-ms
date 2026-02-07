import { defineEnum, type TypeOf } from "../utils/define-enum";

const values = ["EXAM", "QUIZZ", "TASK", "IMPROVEMENT_PLAN"];

export const AsessmentType = defineEnum(values);
export type AsessmentType = TypeOf<typeof AsessmentType>;

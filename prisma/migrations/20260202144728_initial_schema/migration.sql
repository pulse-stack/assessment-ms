-- CreateEnum
CREATE TYPE "EvaluationActivityType" AS ENUM ('EXAM', 'QUIZZ', 'TASK', 'IMPROVEMENT_PLAN');

-- CreateEnum
CREATE TYPE "EvaluationActivityStatus" AS ENUM ('DRAFT', 'PUBLISHED', 'INACTIVE', 'DELETED');

-- CreateEnum
CREATE TYPE "QuestionType" AS ENUM ('SINGLE_CHOICE', 'MULTIPLE_CHOICE', 'TRUE_FALSE', 'SHORT_ANSWER', 'LONG_ANSWER', 'CODE', 'CANVAS');

-- CreateEnum
CREATE TYPE "SubmissionStatus" AS ENUM ('IN_PROGRESS', 'SUBMITTED', 'GRADED', 'INVALID');

-- CreateEnum
CREATE TYPE "ActivityAssignmentType" AS ENUM ('STUDENT', 'COHORT');

-- CreateEnum
CREATE TYPE "ActivityAssignmentStatus" AS ENUM ('ASSIGNED', 'COMPLETED', 'GRADED', 'CANCELED');

-- CreateEnum
CREATE TYPE "QuestionResourceType" AS ENUM ('TEXT', 'IMAGE', 'VIDEO', 'CODE', 'FILE', 'LINK');

-- CreateTable
CREATE TABLE "EvaluationActivity" (
    "id" TEXT NOT NULL,
    "type" "EvaluationActivityType" NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "instructorId" TEXT NOT NULL,
    "labelId" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "maxScore" INTEGER NOT NULL,
    "settings" JSONB NOT NULL,
    "status" "EvaluationActivityStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "EvaluationActivity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ActivityLabel" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "backgroundColor" TEXT,
    "icon" TEXT,
    "iconCode" TEXT,
    "instructorId" TEXT NOT NULL,

    CONSTRAINT "ActivityLabel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ActivityAssignment" (
    "id" TEXT NOT NULL,
    "activityId" TEXT NOT NULL,
    "type" "ActivityAssignmentType" NOT NULL,
    "cohortId" TEXT NOT NULL,
    "studentId" TEXT,
    "status" "ActivityAssignmentStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "ActivityAssignment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Question" (
    "id" TEXT NOT NULL,
    "activityId" TEXT NOT NULL,
    "type" "QuestionType" NOT NULL,
    "statement" TEXT NOT NULL,
    "score" INTEGER NOT NULL DEFAULT 0,
    "order" INTEGER NOT NULL,
    "hint" TEXT,
    "config" JSONB NOT NULL,

    CONSTRAINT "Question_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QuestionResource" (
    "id" TEXT NOT NULL,
    "title" TEXT,
    "description" TEXT,
    "questionId" TEXT NOT NULL,
    "type" "QuestionResourceType" NOT NULL,
    "content" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "QuestionResource_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Submission" (
    "id" TEXT NOT NULL,
    "activityId" TEXT NOT NULL,
    "studentId" TEXT NOT NULL,
    "startedAt" TIMESTAMP(3) NOT NULL,
    "submittedAt" TIMESTAMP(3),
    "score" INTEGER,
    "maxScore" INTEGER,
    "status" "SubmissionStatus" NOT NULL,
    "final" BOOLEAN NOT NULL DEFAULT true,
    "attempt" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Submission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubmissionItem" (
    "id" TEXT NOT NULL,
    "submissionId" TEXT NOT NULL,
    "questionId" TEXT,
    "text" TEXT,
    "json" JSONB,
    "fileUrl" TEXT,
    "score" INTEGER,
    "maxScore" INTEGER,

    CONSTRAINT "SubmissionItem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "EvaluationActivity_labelId_idx" ON "EvaluationActivity"("labelId");

-- CreateIndex
CREATE INDEX "EvaluationActivity_instructorId_idx" ON "EvaluationActivity"("instructorId");

-- CreateIndex
CREATE UNIQUE INDEX "ActivityLabel_name_instructorId_key" ON "ActivityLabel"("name", "instructorId");

-- CreateIndex
CREATE INDEX "Question_activityId_order_idx" ON "Question"("activityId", "order");

-- CreateIndex
CREATE INDEX "QuestionResource_questionId_idx" ON "QuestionResource"("questionId");

-- CreateIndex
CREATE INDEX "Submission_activityId_studentId_idx" ON "Submission"("activityId", "studentId");

-- CreateIndex
CREATE INDEX "Submission_id_idx" ON "Submission"("id");

-- CreateIndex
CREATE INDEX "SubmissionItem_submissionId_idx" ON "SubmissionItem"("submissionId");

-- AddForeignKey
ALTER TABLE "EvaluationActivity" ADD CONSTRAINT "EvaluationActivity_labelId_fkey" FOREIGN KEY ("labelId") REFERENCES "ActivityLabel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ActivityAssignment" ADD CONSTRAINT "ActivityAssignment_activityId_fkey" FOREIGN KEY ("activityId") REFERENCES "EvaluationActivity"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Question" ADD CONSTRAINT "Question_activityId_fkey" FOREIGN KEY ("activityId") REFERENCES "EvaluationActivity"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuestionResource" ADD CONSTRAINT "QuestionResource_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "Question"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Submission" ADD CONSTRAINT "Submission_activityId_fkey" FOREIGN KEY ("activityId") REFERENCES "EvaluationActivity"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubmissionItem" ADD CONSTRAINT "SubmissionItem_submissionId_fkey" FOREIGN KEY ("submissionId") REFERENCES "Submission"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

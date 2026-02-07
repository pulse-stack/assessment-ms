/*
  Warnings:

  - You are about to drop the `ActivityAssignment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ActivityLabel` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `EvaluationActivity` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "AssessmentType" AS ENUM ('EXAM', 'QUIZZ', 'TASK', 'IMPROVEMENT_PLAN');

-- CreateEnum
CREATE TYPE "AssessmentStatus" AS ENUM ('DRAFT', 'PUBLISHED', 'INACTIVE', 'DELETED');

-- CreateEnum
CREATE TYPE "AssessmentAssignmentType" AS ENUM ('STUDENT', 'COHORT');

-- CreateEnum
CREATE TYPE "AssessmentAssignmentStatus" AS ENUM ('ASSIGNED', 'COMPLETED', 'GRADED', 'CANCELED');

-- DropForeignKey
ALTER TABLE "ActivityAssignment" DROP CONSTRAINT "ActivityAssignment_activityId_fkey";

-- DropForeignKey
ALTER TABLE "EvaluationActivity" DROP CONSTRAINT "EvaluationActivity_labelId_fkey";

-- DropForeignKey
ALTER TABLE "Question" DROP CONSTRAINT "Question_activityId_fkey";

-- DropForeignKey
ALTER TABLE "Submission" DROP CONSTRAINT "Submission_activityId_fkey";

-- DropTable
DROP TABLE "ActivityAssignment";

-- DropTable
DROP TABLE "ActivityLabel";

-- DropTable
DROP TABLE "EvaluationActivity";

-- DropEnum
DROP TYPE "ActivityAssignmentStatus";

-- DropEnum
DROP TYPE "ActivityAssignmentType";

-- DropEnum
DROP TYPE "EvaluationActivityStatus";

-- DropEnum
DROP TYPE "EvaluationActivityType";

-- CreateTable
CREATE TABLE "Assessment" (
    "id" TEXT NOT NULL,
    "type" "AssessmentType" NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "instructorId" TEXT NOT NULL,
    "labelId" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "maxScore" INTEGER NOT NULL,
    "settings" JSONB NOT NULL,
    "status" "AssessmentStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "Assessment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AssessmentLabel" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "backgroundColor" TEXT,
    "icon" TEXT,
    "iconCode" TEXT,
    "instructorId" TEXT NOT NULL,

    CONSTRAINT "AssessmentLabel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AssessmentAssignment" (
    "id" TEXT NOT NULL,
    "activityId" TEXT NOT NULL,
    "type" "AssessmentAssignmentType" NOT NULL,
    "cohortId" TEXT NOT NULL,
    "studentId" TEXT,
    "status" "AssessmentAssignmentStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "AssessmentAssignment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Assessment_labelId_idx" ON "Assessment"("labelId");

-- CreateIndex
CREATE INDEX "Assessment_instructorId_idx" ON "Assessment"("instructorId");

-- CreateIndex
CREATE UNIQUE INDEX "AssessmentLabel_name_instructorId_key" ON "AssessmentLabel"("name", "instructorId");

-- AddForeignKey
ALTER TABLE "Assessment" ADD CONSTRAINT "Assessment_labelId_fkey" FOREIGN KEY ("labelId") REFERENCES "AssessmentLabel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AssessmentAssignment" ADD CONSTRAINT "AssessmentAssignment_activityId_fkey" FOREIGN KEY ("activityId") REFERENCES "Assessment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Question" ADD CONSTRAINT "Question_activityId_fkey" FOREIGN KEY ("activityId") REFERENCES "Assessment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Submission" ADD CONSTRAINT "Submission_activityId_fkey" FOREIGN KEY ("activityId") REFERENCES "Assessment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

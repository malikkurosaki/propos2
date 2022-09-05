/*
  Warnings:

  - The primary key for the `DefaultPrefByEmployee` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `DefaultPrefByEmployee` table. All the data in the column will be lost.
  - The primary key for the `DefaultPrefByUser` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `DefaultPrefByUser` table. All the data in the column will be lost.
  - Made the column `userId` on table `DefaultPrefByEmployee` required. This step will fail if there are existing NULL values in that column.
  - Made the column `userId` on table `DefaultPrefByUser` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `DefaultPrefByEmployee` DROP FOREIGN KEY `DefaultPrefByEmployee_userId_fkey`;

-- DropForeignKey
ALTER TABLE `DefaultPrefByUser` DROP FOREIGN KEY `DefaultPrefByUser_userId_fkey`;

-- AlterTable
ALTER TABLE `DefaultPrefByEmployee` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    MODIFY `userId` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`userId`);

-- AlterTable
ALTER TABLE `DefaultPrefByUser` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    MODIFY `userId` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`userId`);

-- AddForeignKey
ALTER TABLE `DefaultPrefByUser` ADD CONSTRAINT `DefaultPrefByUser_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DefaultPrefByEmployee` ADD CONSTRAINT `DefaultPrefByEmployee_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

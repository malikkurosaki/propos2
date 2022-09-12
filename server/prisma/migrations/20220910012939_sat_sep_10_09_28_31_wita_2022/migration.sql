/*
  Warnings:

  - The primary key for the `DefaultPreference` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `DefaultPreference` table. All the data in the column will be lost.
  - Made the column `deviceId` on table `DefaultPreference` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `DefaultPreference` DROP FOREIGN KEY `DefaultPreference_deviceId_fkey`;

-- AlterTable
ALTER TABLE `DefaultPreference` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    MODIFY `deviceId` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`deviceId`);

-- AddForeignKey
ALTER TABLE `DefaultPreference` ADD CONSTRAINT `DefaultPreference_deviceId_fkey` FOREIGN KEY (`deviceId`) REFERENCES `Device`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

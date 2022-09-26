/*
  Warnings:

  - You are about to drop the column `orderId` on the `OrderManual` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `OrderManual` DROP FOREIGN KEY `OrderManual_orderId_fkey`;

-- AlterTable
ALTER TABLE `OrderManual` DROP COLUMN `orderId`,
    ADD COLUMN `billId` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `OrderManual` ADD CONSTRAINT `OrderManual_billId_fkey` FOREIGN KEY (`billId`) REFERENCES `Bill`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

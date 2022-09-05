/*
  Warnings:

  - You are about to drop the column `price` on the `CustomPrice` table. All the data in the column will be lost.
  - You are about to drop the column `productId` on the `CustomPrice` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `CustomPrice` DROP FOREIGN KEY `CustomPrice_productId_fkey`;

-- AlterTable
ALTER TABLE `CustomPrice` DROP COLUMN `price`,
    DROP COLUMN `productId`;

-- CreateTable
CREATE TABLE `ProductCustomPrice` (
    `id` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NULL,
    `customPriceId` VARCHAR(191) NULL,
    `price` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `ProductCustomPrice` ADD CONSTRAINT `ProductCustomPrice_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProductCustomPrice` ADD CONSTRAINT `ProductCustomPrice_customPriceId_fkey` FOREIGN KEY (`customPriceId`) REFERENCES `CustomPrice`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

/*
  Warnings:

  - You are about to drop the column `name` on the `StockHistory` table. All the data in the column will be lost.
  - You are about to drop the `ProductStock` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `nameType` to the `StockHistory` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `ProductStock` DROP FOREIGN KEY `ProductStock_companyId_fkey`;

-- DropForeignKey
ALTER TABLE `ProductStock` DROP FOREIGN KEY `ProductStock_productId_fkey`;

-- DropForeignKey
ALTER TABLE `ProductStock` DROP FOREIGN KEY `ProductStock_userId_fkey`;

-- AlterTable
ALTER TABLE `Product` ADD COLUMN `img` VARCHAR(191) NULL,
    ADD COLUMN `minStock` INTEGER NULL,
    ADD COLUMN `stock` INTEGER NULL;

-- AlterTable
ALTER TABLE `StockHistory` DROP COLUMN `name`,
    ADD COLUMN `nameType` VARCHAR(191) NOT NULL;

-- DropTable
DROP TABLE `ProductStock`;

-- AlterTable
ALTER TABLE `Company` ADD COLUMN `isActive` BOOLEAN NULL DEFAULT true;

-- AlterTable
ALTER TABLE `ProductStock` MODIFY `stock` INTEGER NULL DEFAULT 0,
    MODIFY `minStock` INTEGER NULL DEFAULT 0,
    MODIFY `isActive` BOOLEAN NULL DEFAULT false;

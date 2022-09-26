-- AlterTable
ALTER TABLE `Order` ADD COLUMN `discountId` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `Order` ADD CONSTRAINT `Order_discountId_fkey` FOREIGN KEY (`discountId`) REFERENCES `Discount`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

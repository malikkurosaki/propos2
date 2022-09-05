-- AlterTable
ALTER TABLE `CustomPrice` ADD COLUMN `companyId` VARCHAR(191) NULL,
    ADD COLUMN `userId` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `CustomPrice` ADD CONSTRAINT `CustomPrice_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CustomPrice` ADD CONSTRAINT `CustomPrice_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `Company`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

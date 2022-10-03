-- AlterTable
ALTER TABLE `DefaultPrefByUser` ADD COLUMN `defaultPrefByDeviceId` VARCHAR(191) NULL;

-- CreateTable
CREATE TABLE `DefaultPrefByDevice` (
    `id` VARCHAR(191) NOT NULL,
    `deviceId` VARCHAR(191) NULL,
    `userId` VARCHAR(191) NULL,
    `companyId` VARCHAR(191) NULL,
    `outletId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `DefaultPrefByDevice_deviceId_key`(`deviceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `DefaultPrefByUser` ADD CONSTRAINT `DefaultPrefByUser_defaultPrefByDeviceId_fkey` FOREIGN KEY (`defaultPrefByDeviceId`) REFERENCES `DefaultPrefByDevice`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DefaultPrefByDevice` ADD CONSTRAINT `DefaultPrefByDevice_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DefaultPrefByDevice` ADD CONSTRAINT `DefaultPrefByDevice_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `Company`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DefaultPrefByDevice` ADD CONSTRAINT `DefaultPrefByDevice_deviceId_fkey` FOREIGN KEY (`deviceId`) REFERENCES `Device`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DefaultPrefByDevice` ADD CONSTRAINT `DefaultPrefByDevice_outletId_fkey` FOREIGN KEY (`outletId`) REFERENCES `Outlet`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- CreateTable
CREATE TABLE `OrderPaymentMethod` (
    `id` VARCHAR(191) NOT NULL,
    `paymentMethodId` VARCHAR(191) NULL,
    `orderId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `OrderPaymentMethod` ADD CONSTRAINT `OrderPaymentMethod_orderId_fkey` FOREIGN KEY (`orderId`) REFERENCES `Order`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderPaymentMethod` ADD CONSTRAINT `OrderPaymentMethod_paymentMethodId_fkey` FOREIGN KEY (`paymentMethodId`) REFERENCES `PaymentMethod`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

/*
  Warnings:

  - You are about to drop the `OrderPaymentMethod` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `OrderPaymentMethod` DROP FOREIGN KEY `OrderPaymentMethod_orderId_fkey`;

-- DropForeignKey
ALTER TABLE `OrderPaymentMethod` DROP FOREIGN KEY `OrderPaymentMethod_paymentMethodId_fkey`;

-- DropTable
DROP TABLE `OrderPaymentMethod`;

-- CreateTable
CREATE TABLE `BillPayment` (
    `id` VARCHAR(191) NOT NULL,
    `paymentMethodId` VARCHAR(191) NULL,
    `billId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `BillPayment` ADD CONSTRAINT `BillPayment_billId_fkey` FOREIGN KEY (`billId`) REFERENCES `Bill`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BillPayment` ADD CONSTRAINT `BillPayment_paymentMethodId_fkey` FOREIGN KEY (`paymentMethodId`) REFERENCES `PaymentMethod`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");

const getListPaymentMethod = expressAsyncHandler(async (req, res, next) => {

    const { companyId, userId, outletId } = req.query;

    const getListPaymentMethod = await prisma.paymentMethod.findMany({
        where: {
            companyId: companyId,
            userId: userId,
        },
        select: {
            id: true,
            name: true
        }
    });

    res.status(getListPaymentMethod ? 200 : 401).json(getListPaymentMethod);
});

const createPaymentMethod = expressAsyncHandler(async (req, res, next) => {

    const { companyId, userId, outletId } = req.query;
    const { name } = req.body;

    const ada = await prisma.paymentMethod.findFirst({
        where: {
            name: name,
            companyId: companyId,
            userId: userId,
        }
    });

    if (ada) return res.status(401).json({ message: "Payment Method already exist" });


    const createPaymentMethod = await prisma.paymentMethod.create({
        data: {
            name: name,
            companyId: companyId,
            userId: userId,
        }
    });

    res.status(createPaymentMethod ? 201 : 401).json(createPaymentMethod);
})

const PaymentMethod = { getListPaymentMethod, createPaymentMethod };
module.exports = PaymentMethod;
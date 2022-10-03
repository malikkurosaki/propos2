const expressAsyncHandler = require("express-async-handler");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

module.exports = expressAsyncHandler(async (req, res) => {
    const data = await prisma.bill.count({
        where: {
            outletId: req.outletId,
            createdAt: {
                gt: new Date(new Date().setDate(new Date().getDate() - 1)),
                lt: new Date()
            }
        }
    });

    res.status(200).json(data);
})

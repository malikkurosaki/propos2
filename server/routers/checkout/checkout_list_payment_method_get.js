const handler = require('express-async-handler');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();

module.exports = handler(async (req, res) => {
    const data = await prisma.paymentMethod.findMany({
        where: {
            userId: {
                equals: req.userId
            },
            isActive: true
        },
        select: {
            id: true,
            name: true
        }
    },)

    res.status(200).json(data);
},)
const handler = require('express-async-handler');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();

module.exports = handler(async (req, res) => {

    const data = await prisma.customPrice.findMany({
        where: {
            userId: req.userId
        },
        select: {
            id: true,
            name: true,
            des: true,
            isActive: true,
        }
    })

    res.status(200).json(data);
})
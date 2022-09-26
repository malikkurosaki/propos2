const handler = require('express-async-handler');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();

module.exports = handler(async (req, res) => {
    const cod = await prisma.defaultPrefByUser.findUnique({
        where: {
            token: req.token
        },
        select: {
            userId: true
        }
    })

    const data = await prisma.customPrice.findMany({
        where: {
            userId: cod.userId
        }
    })

    res.status(200).json(data);
})
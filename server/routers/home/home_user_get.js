const { PrismaClient } = require('@prisma/client');
const handler = require('express-async-handler');
const Pc = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();

module.exports = handler(async (req, res) => {
    const data = await prisma.user.findUnique({
        where: {
            id: req.userId,
        },
        select: {
            id: true,
            name: true
        }
    })

    res.status(200).json(data);
})
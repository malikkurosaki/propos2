const handler = require('express-async-handler');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();

module.exports = handler(async (req, res) => {
    const body = JSON.parse(req.body.data);

    const data = await prisma.paymentMethod.create({
        data: {
            userId: req.userId,
            ...body
        }
    })

    res.status(201).json(data)
})
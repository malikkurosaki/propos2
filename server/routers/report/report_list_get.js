const handler = require('express-async-handler');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const moment = require('moment')

// req.query.date [dateTime] [2022-09-26]
module.exports = handler(async (req, res) => {
    const data = await prisma.bill.findMany({
        where: {
            userId: req.userId,
            createdAt: {
                gt: req.query.date == null ? undefined : new Date(Date.parse(req.query.date) - (1000 * 60 * 60 * 24)),
                lt: req.query.date == null ? undefined : new Date(Date.parse(req.query.date) + (1000 * 60 * 60 * 24))
            }
        },
        orderBy: {
            number: "asc"
        },
        select: {
            number: true,
            id: true,
            totalPrice: true,
            totalQty: true,
            createdAt: true
        }
    })

    res.status(200).json(data);
});
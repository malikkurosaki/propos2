const handler = require('express-async-handler');
const prisma = new (require('@prisma/client').PrismaClient)();

module.exports = handler(async (req, res) => {
    const { start, end } = req.query;

    const data = await prisma.bill.findMany({
        where: {
            userId: req.userId,
            createdAt: {
                gt: new Date(Date.parse(start) - (1000 * 60 * 60 * 24)),
                lt: new Date(Date.parse(end) + (1000 * 60 * 60 * 24))

            }
        },
        orderBy: {
            createdAt: "desc"
        }
    },)

    res.status(200).json(data)
})

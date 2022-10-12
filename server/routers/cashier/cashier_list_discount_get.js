const handler = require('express-async-handler');
const pc = require('@prisma/client').PrismaClient;
const prisma = new pc();

module.exports = handler(async (req, res) => {
    // const { userid, companyid, outletid } = req.headers;
    const data = await prisma.discount.findMany({
        where: {
            companyId: req.companyId,
            isActive: true
        },
        select: {
            id: true,
            name: true,
            isPercentage: true,
            value: true,
            percentage: true
        }
    },)


    res.status(200).json(data);
})
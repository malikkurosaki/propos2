const handler = require('express-async-handler');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();

module.exports = handler(async (req, res) => {
    const getCompany = await prisma.defaultPrefByUser.findUnique({
        where: {
            token: req.token
        },
        select: {
            companyId: true
        }
    })

    const dataProduct = await prisma.product.findMany({
        where: {
            companyId: {
                equals: getCompany.companyId
            }
        }
    })

    res.status(200).json(dataProduct);
})
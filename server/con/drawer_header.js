const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const getName = expressAsyncHandler(async (req, res, next) => {
    const {userId, companyId, outletId} = req.query;

    const company = await prisma.company.findUnique({
        where: {
            id: companyId,
        },
        select: {
            name: true,
        }
    })

    const outlet = await prisma.outlet.findUnique({
        where: {
            id: outletId,
        },
        select: {
            name: true,
        }
    })

    const result = {
        companyName: company.name,
        outletName: outlet.name,
    }

    res.status(200).json(result);
}); 

const DrawerHeader = {getName}

module.exports = DrawerHeader
const expressAsyncHandler = require("express-async-handler");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

module.exports = expressAsyncHandler(async (req, res) => {
    const { userid, companyid, outletid } = req.headers;
    const data = await prisma.bill.count({
        where: {
            userId: userid,
            companyId: companyid,
            outletId: outletid
        }
    });

    res.status(200).json(data);
})

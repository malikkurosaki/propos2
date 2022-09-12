const expressAsyncHandler = require("express-async-handler");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

module.exports = expressAsyncHandler(async (req, res) => {
    const { companyId } = req.query;
    const { userid, companyid, outletid } = req.headers;
    if (!userid || !companyid || !outletid || !companyId) return res.status(401).json({ message: "unauthorized" });
    let data = await prisma.outlet.findMany({
        where: {
            companyId: companyId
        },
        select: {
            id: true,
            name: true
        }
    })

    res.status(200).json(data);
})
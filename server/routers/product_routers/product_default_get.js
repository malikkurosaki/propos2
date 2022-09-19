const expressAsyncHandler = require("express-async-handler");
const { ModelHeader } = require("../../utils");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

module.exports = expressAsyncHandler(async (req, res) => {
    const { userid, companyid, outletid } = Object.assign(ModelHeader, req.header);
    if (!userid || !companyid || !outletid) return res.status(401).send("bad request");

    const data = await prisma.product.findMany({
        where: {
            companyId: companyid
        }
    });

    res.status(200).json(data);
})
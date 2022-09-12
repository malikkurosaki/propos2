const expressAsyncHandler = require("express-async-handler");
const { ModelHeader } = require("../../utils");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();
const path = require('path');
const flName = path.parse(__filename).name

module.exports = expressAsyncHandler(async (req, res) => {
    const { userid, companyid } = Object.assign(ModelHeader, req.headers);
    if (!userid || !companyid) return res.status(401).json({ message: " Unauthorize " + flName});
    const data = await prisma.outlet.findMany({
        where: {
            companyId: companyid
        }
    });

    return res.status(200).json(data);
})
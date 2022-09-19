const expressAsyncHandler = require("express-async-handler");
const { ModelHeader } = require("../../utils");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

module.exports = expressAsyncHandler(async(req, res) => {
    const {companyId} = req.query;

    // console.log(companyId);

    const {userid, companyid, outletid} = Object.assign(ModelHeader, req.header);
    if(!userid || !companyid || !outletid || !companyId) return res.status(401).send("bad request");

    const data = await prisma.category.findMany({
        where: {
            userId: userid,
            companyId: companyId
        }
    });

    // console.log(data);

    res.status(200).json(data);

});
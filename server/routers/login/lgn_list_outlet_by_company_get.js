const expressAsyncHandler = require("express-async-handler");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

module.exports = expressAsyncHandler(async(req, res) => {
    const {companyId} = req.query;
    if(!companyId) return res.status(401).json({message: "bad request"});

    const data = await prisma.outlet.findMany({
        where: {
            companyId: {
                equals: companyId
            }
        },
        select: {
            id: true,
            name: true,
        }
    });

    res.status(200).json(data);
})
const expressAsyncHandler = require("express-async-handler");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

module.exports = expressAsyncHandler(async(req, res) => {
    const {outletId} = req.query;
    if(!outletId) return res.status(401).send("bad request");
    const data = await prisma.device.findMany({
        where: {
            outletId: {
                equals: outletId
            }
        }
    });

    res.status(200).json(data)
});
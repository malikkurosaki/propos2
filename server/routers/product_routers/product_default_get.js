const expressAsyncHandler = require("express-async-handler");
const { ModelHeader } = require("../../utils");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

module.exports = expressAsyncHandler(async (req, res) => {

    const dataCom = await prisma.defaultPrefByUser.findUnique({
        where: {
            token: req.token
        },
        select: {
            companyId: true
        }
    })

    console.log(dataCom);


    const data = await prisma.product.findMany({
        where: {
            companyId: {
                equals: dataCom.companyId
            }
        }
    });

    res.status(200).json(data);
})
const expressAsyncHandler = require("express-async-handler");
const { ModelHeader } = require("../../utils");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

module.exports = expressAsyncHandler(async (req, res) => {

    // const dataCom = await prisma.defaultPreference.findUnique({
    //     where: {
    //         deviceId: req.deviceId
    //     },
    //     select: {
    //         companyId: true
    //     }
    // })

    // console.log(dataCom);


    const data = await prisma.product.findMany({
        where: {
            companyId: {
                equals: req.companyId
            }
        },
        orderBy: {
            createdAt: "desc"
        },
        select: {
            id: true,
            name: true,
            createdAt: true,
            isActive: true,
            price: true,
            ProductImage: {
                select: {
                    id: true,
                    name: true,
                    url: true
                }
            },
            ProductStock: {
                select: {
                    id: true,
                    stock: true
                }
            },
        }
    },);

    res.status(200).json(data);
})
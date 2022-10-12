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
            companyId: req.companyId,
        },
        orderBy: {
            createdAt: "desc"
        },
        select: {
            id: true,
            name: true,
            price: true,
            companyId: true,
            // isActive: true,

            // ProductImage: {
            //     select: {
            //         id: true,
            //         name: true,
            //         url: true
            //     }
            // },
            ProductStock: {
                where: {
                    outletId: req.outletId
                },
                select: {
                    id: true,
                    stock: true
                }
            },
            ProductOutlet: {
                where: {
                    outletId: req.outletId,
                    isActive: true
                },
                select: {
                    id: true,
                    isActive: true,
                    outletId: true,
                    productId: true,
                    Outlet: {
                        select: {
                            id: true,
                            name: true,
                            companyId: true
                        }
                    }
                }
            },

        }
    },);

    res.status(200).json(data);
})
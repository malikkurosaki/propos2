const handler = require('express-async-handler');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();

module.exports = handler(async (req, res) => {
    // const getCompany = await prisma.defaultPrefByUser.findUnique({
    //     where: {
    //         token: req.token
    //     },
    //     select: {
    //         companyId: true
    //     }
    // })

    const dataProduct = await prisma.product.findMany({
        where: {
            companyId: req.companyId
        },
        select: {
            id: true,
            name: true,
            price: true,
            img: true,
            ProductImage: {
                select: {
                    name: true,
                    url: true,
                    id: true,
                }
            },
            ProductStock: {
                where: {
                    outletId: req.outletId
                },
                select: {
                    stock: true,
                    id: true
                }
            }
        }
    })

    res.status(200).json(dataProduct);
})
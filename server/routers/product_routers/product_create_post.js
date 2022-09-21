const expressAsyncHandler = require("express-async-handler");
const { ModelHeader } = require("../../utils");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

const ModelCreateProduct =
{
    name: undefined,
    price: undefined,
    description: undefined,
    barcodeId: undefined,
    categoryId: undefined,
    companyId: undefined,
    costOfCapital: undefined,
    discountId: undefined,
    img: undefined,
    isCustomPrice: undefined,
    isImage: undefined,
    isStock: undefined,
    minStock: undefined,
    productDimention: undefined,
    productImageId: undefined,
    productWeight: undefined,
    userId: undefined,
    sku: undefined,
    ProductStock: {
        create: {
            companyId: undefined,
            minStock: undefined,
            outletId: undefined,
            stock: undefined,
            userId: undefined,

        }
    },
    ProductCustomPrice: {
        createMany: {
            data: [
                {
                    customPriceId: undefined,
                    price: undefined
                }
            ]
        }
    },
    ProductOutlet: {
        createMany: {
            data: [
                {
                    companyId: undefined,
                    outletId: undefined,
                    userId: undefined
                }
            ]
        }
    },

};

module.exports = expressAsyncHandler(async (req, res) => {
    let body = req.body;
    let data = await prisma.product.create({
        data: JSON.parse(body.data)
    })

    res.status(data ? 201 : 400).json(data);
})
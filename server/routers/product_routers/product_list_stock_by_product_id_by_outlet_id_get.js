module.exports = require('express-async-handler')(async (req, res) => {
    const productId = req.query.productId;

    console.log(productId);

    if (!productId) return res.status(401).send('401');
    const data = await new (require('@prisma/client').PrismaClient)().product.findUnique({
        where: {
            id: productId
        },
        select: {
            id: true,
            name: true,
            ProductStock: {
                where: {
                    isActive: true
                },
                select: {
                    stock: true,
                    isActive: true,
                    minStock: true,
                    outletId: true,
                    productId: true,
                    id: true
                }
            }
        }
    })

    res.status(200).json(data)
})
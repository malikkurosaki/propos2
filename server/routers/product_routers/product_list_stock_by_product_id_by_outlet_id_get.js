module.exports = require('express-async-handler')(async (req, res) => {
    const productId = req.query.productId;
    const outletId = req.query.outletId;

    console.log(productId);
    console.log(outletId);
    
    if (!productId || !outletId) return res.status(401).send('401');
    const data = await new (require('@prisma/client').PrismaClient)().productStock.findMany({
        where: {
            productId: productId,
            outletId: outletId
        }
    })

    res.status(200).json(data)
})
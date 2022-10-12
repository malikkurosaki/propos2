module.exports = require('express-async-handler')(async(req, res) => {
    if(!req.query.id) return res.status(401).send('401');
    const data = await new (require('@prisma/client').PrismaClient)().productOutlet.findMany({
        where: {
            productId: req.query.id,
            isActive: true
        },
        select: {
            id: true,
            companyId: true,
            isActive: true,
            outletId: true,
            productId: true,
        }
    })

    res.status(200).json(data);
})
module.exports = require('express-async-handler')(async(req, res) => {
    if(!req.query.companyId) return res.status(401).send('401');
    const data = await new (require('@prisma/client').PrismaClient)().outlet.findMany({
        where: {
            companyId: req.query.companyId,
            isActive: true
        },
        select: {
            id: true,
            name: true,
            companyId: true
        }
    })

    res.status(200).json(data);
})
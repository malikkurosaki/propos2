module.exports = require('express-async-handler')(async (req, res) => {
    const companyId = req.query.companyId;
    if (!companyId) return res.status(401).send('401');
    const data = await new (require('@prisma/client').PrismaClient)().outlet.findMany({
        where: {
            companyId: companyId
        },
        select: {
            id: true,
            name: true,
            address: true,
            email: true,
            logoUrl: true,
            phone: true,
            isActive: true
        }
    })

    res.status(200).json(data);
})
module.exports = require('express-async-handler')(async (req, res) => {
    if (!req.query.companyId) return res.status(401).send('401');
    const data = await new (require('@prisma/client').PrismaClient)().employee.findMany({
        where: {
            companyId: req.query.companyId
        },
        select: {
            id: true,
            name: true,
            password: true,
            isActive: true
        }
    })

    res.status(200).json(data);
})
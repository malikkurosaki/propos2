module.exports = require('express-async-handler')(async (req, res) => {
    const data = await new (require('@prisma/client').PrismaClient)().outlet.findMany({
        where: {
            companyId: req.companyId
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
});
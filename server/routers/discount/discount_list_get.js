module.exports = require('express-async-handler')(async (req, res) => {
    const data = await new (require('@prisma/client').PrismaClient)().discount.findMany({
        where: {
            companyId: req.companyId
        }
    })

    res.status(200).json(data);
});
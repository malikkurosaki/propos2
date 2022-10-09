module.exports = require('express-async-handler')(async (req, res) => {
    const data = await new (require('@prisma/client').PrismaClient)().device.findMany({
        where: {
            companyId: req.companyId
        }
    })

    res.status(200).json(data);
});
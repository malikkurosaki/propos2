module.exports = require('express-async-handler')(async (req, res) => {
    const companyId = req.query.companyId;
    if (!companyId) return res.status(401).send('401')
    const data = await new (require('@prisma/client').PrismaClient)().customPrice.findMany({
        where: {
            companyId: companyId
        }
    })

    res.status(200).json(data);
})
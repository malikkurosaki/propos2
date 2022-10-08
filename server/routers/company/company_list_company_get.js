module.exports = require('express-async-handler')(async (req, res) => {
    const data = await new (require('@prisma/client').PrismaClient)().company.findMany({
        where: {
            userId: req.userId
        },
    });

    res.status(200).json(data)

})
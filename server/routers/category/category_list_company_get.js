const handler = require('express-async-handler');
const prisma = new (require('@prisma/client').PrismaClient)();

module.exports = handler(async (req, res) => {
    const data = await prisma.company.findMany({
        where: {
            userId: req.userId
        }
    })

    res.status(200).json(data)
})
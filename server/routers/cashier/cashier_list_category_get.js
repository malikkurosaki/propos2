const handler = require('express-async-handler');
const prisma = new (require('@prisma/client').PrismaClient)()

module.exports = handler(async (req, res) => {
    const data = await prisma.category.findMany({
        where: {
            companyId: req.companyId
        },
        select: {
            id: true,
            name: true
        }
    })

    res.status(200).json(data);
})
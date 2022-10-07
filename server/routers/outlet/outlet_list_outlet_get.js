module.exports = require('express-async-handler')(async (req, res) => {
    const data = await new (require('@prisma/client').PrismaClient)().outlet.findMany({
        where: {
            userId: req.userId
        },
        select: {
            id: true,
            name: true,
            address: true,
            email: true,
            logoUrl: true,
            phone: true,
        }
    })

    res.status(200).json(data);
});
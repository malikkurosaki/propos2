module.exports = require('express-async-handler')(async (req, res) => {
    const data = await new (require('@prisma/client').PrismaClient)().company.findMany({
        where: {
            userId: req.userId
        },
        select: {
            id: true,
            name: true,
            Outlet: {
                select: {
                    id: true,
                    name: true
                }
            }
        }
    })

    res.status(200).json(data);
});
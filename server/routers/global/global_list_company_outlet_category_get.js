module.exports = require('express-async-handler')(async (req, res) => {
    const data = await new (require('@prisma/client').PrismaClient)().company.findMany({
        where: {
            isActive: true,
            userId: req.userId,

        },
        select: {
            id: true,
            name: true,
            isActive: true,
            Outlet: {
                where: {
                    isActive: true
                },
                select: {
                    id: true,
                    name: true,
                    isActive: true
                }
            },
            Category: {
                where: {
                    isActive: true
                },
                select: {
                    id: true,
                    name: true,
                    isActive: true
                }
            }
        }
    })


    res.status(200).json(data);
})
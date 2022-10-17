module.exports = require('express-async-handler')(async(req, res) => {
    const data = await new(require('@prisma/client').PrismaClient)().company.findMany({
        where: {
            userId: req.userId,
            isActive: true
        },
        select: {
            id: true,
            name: true,
            Outlet: {
                where: {
                    isActive: true
                },
                select: {
                    id: true,
                    name: true,
                    Device: {
                        where: {
                            isActive: true
                        },
                        select: {
                            id: true,
                            name: true
                        }
                    }
                }
            }
        }
    })

    res.status(200).json(data);
})
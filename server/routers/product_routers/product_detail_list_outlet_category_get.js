module.exports = require('express-async-handler')(async (req, res) => {
    const data = await new (require('@prisma/client').PrismaClient)().company.findUnique({
        where: {
            id: req.companyId
        },
        select: {
            id: true,
            name: true,
            Outlet: {
                select: {
                    id: true,
                    name: true
                }
            },
            Category: {
                select: {
                    id: true,
                    name: true
                }
            }
        }
    })

    res.status(200).json(data)
})
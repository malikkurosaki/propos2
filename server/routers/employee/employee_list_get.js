module.exports = require('express-async-handler')(async (req, res) => {
    const data = await new (require('@prisma/client').PrismaClient)().employee.findMany({
        where: {
            userId: req.userId
        },
        select: {
            id: true,
            name: true,
            password: true,
            isActive: true
        }
    })

    res.status(200).json(data)
})
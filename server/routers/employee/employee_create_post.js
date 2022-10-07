module.exports = require('express-async-handler')(async (req, res) => {
    const body = JSON.parse(req.body.data);
    const data = await new (require('@prisma/client').PrismaClient)().employee.create({
        data: {
            ...body,
            userId: req.userId,

        }
    })

    res.status(200).json(data);
})
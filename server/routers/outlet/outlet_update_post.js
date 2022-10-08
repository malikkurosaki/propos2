module.exports = require('express-async-handler')(async (req, res) => {
    const body = JSON.parse(req.body.data);
    const data = await new (require('@prisma/client').PrismaClient)().outlet.update({
        data: body,
        where: {
            id: body.id
        }
    })

    res.status(201).json(data);
})
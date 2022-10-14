module.exports = require('express-async-handler')(async(req, res) => {
    const body = JSON.parse(req.body.data);
    const data = await new (require('@prisma/client').PrismaClient)().product.update({
        where: {
            id: body.id
        },
        data: body
    })

    res.status(201).json(data);
})
module.exports = require('express-async-handler')(async(req, res) => {
    const bd = JSON.parse(req.body.data);
    const data  = await new (require('@prisma/client').PrismaClient)().customPrice.update({
        where: {
            id: bd.id
        },
        data: bd
    })

    res.status(201).json(data);
})
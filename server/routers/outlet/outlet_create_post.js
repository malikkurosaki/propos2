module.exports = require('express-async-handler')(async (req, res) => {
    const body = JSON.parse(req.body.data);
    const data = await new (require('@prisma/client').PrismaClient)().outlet.create({
        data: {
            ...body,
            userId: req.userId
        }
    })

    res.status(201).json(data);
});
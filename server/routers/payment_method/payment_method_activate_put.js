module.exports = require('express-async-handler')(async (req, res) => {
    let body = JSON.parse(req.body.data);

    console.log(body);
    const data = await new (require('@prisma/client').PrismaClient)().paymentMethod.update({
        where: {
            id: req.query.id
        },
        data: {
            isActive: body.isActive
        }
    })

    res.status(201).json(data)
})
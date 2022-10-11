module.exports = require('express-async-handler')(async(req, res) => {
    let bd = JSON.parse(req.body.data);

    console.log(bd);
    const data = await new (require('@prisma/client').PrismaClient)().discount.create({
        data: {
            ...bd,
            userId: req.userId
        }
    })

    res.status(201).json(data);
})
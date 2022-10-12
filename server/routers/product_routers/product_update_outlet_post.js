module.exports = require('express-async-handler')(async (req, res) => {
    const body = JSON.parse(req.body.data);

    if (!body.id) {
        const data = await new (require('@prisma/client').PrismaClient)().productOutlet.create({
            data: body
        })

        return res.status(201).send(data);
    } else {
        const data = await new (require('@prisma/client').PrismaClient)().productOutlet.update({
            where: {
                id: body.id
            },
            data: body
        })

        return res.status(201).send(data);
    }

})
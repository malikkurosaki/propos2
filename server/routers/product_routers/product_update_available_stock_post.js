module.exports = require('express-async-handler')(async (req, res) => {
    const body = JSON.parse(req.body.data);

    if (body.id) {
        const data = await new (require('@prisma/client').PrismaClient)().productStock.update({
            where: {
                id: body.id,

            },
            data: body
        })
    } else {
        const cek = await new (require('@prisma/client').PrismaClient)().productStock.findFirst({
            where: {
                productId: body.productId,
                outletId: body.outletId
            }
        })

        console.log(cek);

        if (!cek) {
            const data = await new (require('@prisma/client').PrismaClient)().productStock.create({
                data: body
            })
        } else {
            const data = await new (require('@prisma/client').PrismaClient)().productStock.update({
                where: {
                    id: cek.id,

                },
                data: {
                    isActive: body.isActive
                }
            })
        }
    }

    res.status(201).send('success');
})
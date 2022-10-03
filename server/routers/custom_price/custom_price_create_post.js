const handler = require('express-async-handler');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
module.exports = handler(async (req, res) => {

    const body = JSON.parse(req.body.data)

    // const cod = await prisma.defaultPrefByUser.findUnique({
    //     where: {
    //         token: req.token
    //     },
    //     select: {
    //         userId: true,
    //         companyId: true,
    //         outletId: true,
    //         deviceId: true
    //     }
    // })

    // body['companyId'] = cod.companyId;
    // body['outletId'] = cod.outletId;
    body['userId'] = req.userId;

    const data = await prisma.customPrice.create({
        data: body
    });

    res.status(201).json(data)
});
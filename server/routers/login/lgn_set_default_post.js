const handler = require('express-async-handler');
const Pc = require('@prisma/client').PrismaClient;
const prisma = new Pc();

module.exports = handler(async (req, res) => {
    const body = JSON.parse(req.body.data);
    body['userId'] = req.userId;
    const data = await prisma.defaultPrefByUser.upsert({
        create: body,
        update: body,
        where: {
            token: body.token
        }
    })

    res.status(data ? 200 : 400).json(data);
})
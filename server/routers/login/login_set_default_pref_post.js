const handler = require('express-async-handler');
const prisma = new (require('@prisma/client').PrismaClient)();

module.exports = handler(async (req, res) => {
    const body = JSON.parse(req.body.data);
    const data = await prisma.defaultPreference.upsert({
        create: body,
        update: body,
        where: {
            deviceId: body.deviceId
        }
    })

    res.status(data ? 201 : 400).json(data);
})
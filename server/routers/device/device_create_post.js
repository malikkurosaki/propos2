module.exports = require('express-async-handler')(async(req, res) => {
    const body = JSON.parse(req.body.data);
    const data = await new (require('@prisma/client').PrismaClient)().device.create({
        data: {
            deviceId: require('uuid-int')(Math.random() * 500).uuid().toString(),
            ...body
        }
    })

    res.status(201).json(data);
})
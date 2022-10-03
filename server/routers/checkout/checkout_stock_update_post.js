const handler  = require('express-async-handler');
const prisma = new(require('@prisma/client').PrismaClient)();

module.exports = handler(async(req, res) => {
    const body = JSON.parse(req.body.data);
    const data = await prisma.productStock.update(body)
    res.status(201).json(data);

    
})
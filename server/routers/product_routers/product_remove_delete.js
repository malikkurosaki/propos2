const handler = require('express-async-handler');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();

module.exports = handler(async (req, res) => {
    const id = req.query.id;
    if (!id || id == "") return res.status(402).send('400 | bad request');
    const data = await prisma.product.delete({
        where: {
            id: id
        }
    })

    res.status(data ? 201 : 400).json(data)
})
const handler = require('express-async-handler');
const prisma = new (require('@prisma/client').PrismaClient)();

module.exports = handler(async (req, res) => {
    const id = req.query.id;
    const data = await prisma.category.delete({
        where: {
            id: id
        }
    })

    res.status(data ? 201 : 400).json(data);
})
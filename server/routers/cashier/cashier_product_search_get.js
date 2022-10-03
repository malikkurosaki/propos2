const handler = require('express-async-handler');
const prisma = new (require('@prisma/client').PrismaClient)();

module.exports = handler(async (req, res) => {
    let q = req.query.q;
    if (!q) return res.status(400).send('Missing query')

    const data = await prisma.product.findMany({
        where: {
            userId: req.userId,
            companyId: req.companyId,
            name: {
                contains: req.query.q == "kosong" ? undefined : req.query.q
            }
        }
    })

    res.status(200).json(data);
})
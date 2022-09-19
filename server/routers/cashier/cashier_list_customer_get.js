const handler = require('express-async-handler');
const Pc = require('@prisma/client').PrismaClient;
const prisma = new Pc();

module.exports = handler(async(req,res) => {
    const {userid, companyid, outletid} = req.headers;
    const data = await prisma.customer.findMany({
        where: {
            companyId: companyid
        },
        select: {
            id: true,
            name: true
        }
    })

    res.status(200).json(data);
})
module.exports = require('express-async-handler')(async(req, res) => {
    const data = await new (require('@prisma/client').PrismaClient)().company.findMany({
        where: {
            userId: req.userId,
            isActive: true
        },
        select: {
            id: true,
            name: true,
            Outlet: {
                select: {
                    id: true,
                    name: true
                }
            }
        }
    })
    
    console.log(data);

    res.status(200).json(data);
})
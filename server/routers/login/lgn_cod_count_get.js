const handler = require('express-async-handler');
const prisma = new (require('@prisma/client').PrismaClient)();

module.exports = handler(async (req, res) => {

    console.log(req.userId);

    const data = await prisma.company.findMany({
        where: {
            userId: req.userId
        },
        select: {
            id: true,
            Outlet: {
                select: {
                    id: true,
                    Device: {
                        select: {
                            id: true
                        }
                    }
                }
            }
        }
    })

    console.log(JSON.stringify(data))

    res.status(200).json(data);
})
const expressAsyncHandler = require("express-async-handler");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

module.exports = expressAsyncHandler(async (req, res) => {

    const data = await prisma.company.findMany({
        where: {
            userId: {
                equals: req.query.userId,

            },
            isActive: true
        },
        select: {
            id: true,
            name: true,
            Outlet: {
                where: {
                    isActive: true
                },
                select: {
                    id: true,
                    name: true,
                    Device: {
                        where: {
                            isActive: true
                        },
                        select: {
                            id: true,
                            name: true
                        }
                    }
                }
            }
        }
    });

    console.log(data)

    res.status(200).json(data);
})
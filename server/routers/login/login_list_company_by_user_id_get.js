const expressAsyncHandler = require("express-async-handler");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

module.exports = expressAsyncHandler(async (req, res) => {

    const data = await prisma.company.findMany({
        where: {
            userId: {
                equals: req.query.userId
            }
        },
        select: {
            id: true,
            name: true,
            Outlet: {
                select: {
                    id: true,
                    name: true,
                    Device: {
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
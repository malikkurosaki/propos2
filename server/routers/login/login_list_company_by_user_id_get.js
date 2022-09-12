const expressAsyncHandler = require("express-async-handler");
const Prisma = require('@prisma/client').PrismaClient;
const prisma = new Prisma();

module.exports = expressAsyncHandler(async (req, res) => {
    console.log(req.query);
    const { userId } = req.query;
    if (!userId) return res.status(400).send("bad request");
    const data = await prisma.company.findMany({
        where: {
            userId: {
                equals: userId
            }
        },
        select: {
            id: true,
            name: true
        }
    });

    res.status(200).json(data);
})
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const getList = expressAsyncHandler(async (req, res) => {
    const { userId, companyId, outletId } = req.query;

    if (userId == undefined || companyId == undefined || outletId == undefined) return res.status(401).send("401");
    const data = await prisma.discount.findMany({
        where: {
            userId: userId,
            companyId: companyId,
        },
        select: {
            id: true,
            name: true
        }
    })

    res.status(data ? 200 : 401).json(data);
});

const create = expressAsyncHandler(async (req, res) => {
    const { userId, companyId, outletId } = req.query;

    if (userId == undefined || companyId == undefined || outletId == undefined) return res.status(401).send("401");
    const body = req.body;

    const data = await prisma.discount.create({
        data: {
            userId: userId,
            companyId: body.companyId,
            name: body.name,
            des: body.des,
            value: Number(body.value),
            isPercentage: Boolean(body.isPercentage)
        }
    })

    res.status(201).json(data)
})

const Discount = { getList, create }
module.exports = Discount;
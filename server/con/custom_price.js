const PrismaClient = require('@prisma/client').PrismaClient
const prisma = new PrismaClient();
const expresAsyncHandler = require('express-async-handler');


const create = expresAsyncHandler(async (req, res) => {
    const { userId, companyId, outletId } = req.query;
    if (!userId || !companyId || !outletId) return res.status(400).send({ message: 'Invalid Request' });
    const body = req.body;

    const data = await prisma.customPrice.create({
        data: {
            name: body.name,
            userId: userId,
            companyId: companyId
        }
    })

    res.status(201).json(data);
})

const getList = expresAsyncHandler(async (req, res) => {
    const { userId, companyId, outletId } = req.query;
    if (!userId || !companyId || !outletId) return res.status(400).send("invalid request");
    const data = await prisma.company.findMany({
        where: {
            userId: userId
        },
        select: {
            id: true,
            name: true,
            CustomPrice: {
                select: {
                    id: true,
                    name: true
                }
            }
        }
    })

    res.status(200).json(data);
})

const getDataSelect = expresAsyncHandler(async (req, res) => {
    const { userId, companyId, outletId } = req.query;
    if (!userId || !companyId || !outletId) return res.status(400).send("invalid request");
    const data = await prisma.customPrice.findMany({
        where: {
            userId: userId,
            companyId: companyId
        },
        select: {
            id: true,
            name: true
        }
    })

    res.status(200).json(data)
})

const CustomPrice = { create, getList, getDataSelect }
module.exports = CustomPrice
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const userCreate = expressAsyncHandler(async (req, res) => {
    const { userId, companyId, outletId } = req.body;
    const data = await prisma.defaultPrefByUser.upsert({
        where: {
            userId: userId
        },
        create: {
            userId: userId,
            companyId: companyId,
            outletId: outletId,
        },
        update: {
            userId: userId,
            companyId: companyId,
            outletId: outletId
        }
    });

    res.json(data ? 201 : 401).json(data);


});

const employeeCreate = expressAsyncHandler(async (req, res) => {
    const { userId, companyId, outletId } = req.body;
    const data = await prisma.defaultPrefByEmployee.upsert({
        where: {
            userId: userId
        },
        create: {
            userId: userId,
            companyId: companyId,
            outletId: outletId
        }
    })

    res.json(data ? 201 : 401).json(data);
})


const getDefaultUser = expressAsyncHandler(async (req, res) => {
    const { userId } = req.query;
    const data = await prisma.defaultPrefByUser.findUnique({
        where: {
            userId: userId
        }
    })

    res.status(data ? 200 : 401).json(data)
})

const getDefaultEmployee = expressAsyncHandler(async (req, res) => {
    const { userId } = req.query
    const data = await prisma.defaultPrefByEmployee.findUnique({
        where: {
            userId: userId
        }
    })

    res.status(data ? 200 : 401).json(data)
})

const DefaultPref = { userCreate, employeeCreate, getDefaultUser, getDefaultEmployee }
module.exports = DefaultPref
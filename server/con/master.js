const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');


const jenisUsaha = expressAsyncHandler(async (req, res, next) => {

    const getJenisUsaha = await prisma.mJenisUsaha.findMany({
        select: {
            id: true,
            name: true,
        }
    });

    res.status(getJenisUsaha ? 200 : 401).json(getJenisUsaha);
});

const orderStatus = expressAsyncHandler(async (req, res, next) => {
    const getOrderStatus = await prisma.mOrderStatus.findMany({
        select: {
            id: true,
            name: true,
        }
    });

    res.status(getOrderStatus ? 200 : 401).json(getOrderStatus);
});

const Master = { jenisUsaha, orderStatus };

module.exports = Master;
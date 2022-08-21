const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const uuidInt = require('uuid-int');

const getDeviceList = expressAsyncHandler(async (req, res, next) => {
    const userId = req.query.userId;
    if (userId == undefined) return res.status(401).send("user id tidak boleh kosong");
    const getDevice = await prisma.device.findMany({
        where: {
            userId: userId
        },
        select: {
            id: true,
            deviceId: true,
            name: true,
            Company: {
                select: {
                    id: true,
                    name: true,
                },
            },
            Outlet: {
                select: {
                    id: true,
                    name: true,
                },
            }
        }
    });

    res.status(getDevice ? 200 : 401).json(getDevice);
});

const createDevice = expressAsyncHandler(async (req, res, next) => {
    const userId = req.query.userId;
    const {
        name,
        companyId,
        outletId
    } = req.body;

    if (userId == undefined) return res.status(401).send("user id tidak boleh kosong");
    const generator = uuidInt(Number.parseInt(`${userId}${companyId}${outletId}`));
    const createDevice = await prisma.device.create({
        data: {
            deviceId: generator.uuid().toString(),
            name: name,
            userId: userId,
            companyId: companyId,
            outletId: outletId
        }
    });

    res.status(createDevice ? 201 : 401).json(createDevice);
});

const deleteDevice = expressAsyncHandler(async (req, res, next) => {
    const id = req.body.id;
    if (id == undefined) return res.status(401).send("device id tidak boleh kosong");
    const deleteDevice = await prisma.device.delete({
        where: {
            id: id
        }
    });

    res.status(deleteDevice ? 201 : 401).json(deleteDevice);
});

const deviceByUser = expressAsyncHandler(async (req, res, next) => {
    const { userId } = req.query;
    const data = await prisma.company.findMany({
        where: {
            userId: userId
        },
        orderBy: {
            idx: 'asc',
        },
        select: {
            id: true,
            name: true,
            Outlet: {
                orderBy: {
                    idx: 'asc',
                },
                select: {
                    id: true,
                    name: true,
                    Device: {
                        orderBy: {
                            idx: 'asc',
                        },
                        select: {
                            id: true,
                            deviceId: true,
                            name: true,
                        }

                    }
                },
            }
        }
    })

    res.status(data ? 200 : 401).json(data);
})

const Device = { getDeviceList, createDevice, deleteDevice, deviceByUser };
module.exports = Device;
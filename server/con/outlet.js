const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const getOutletByCompany = expressAsyncHandler(async (req, res, next) => {
    const companyId = req.query.companyId;
    const userId = req.query.userId;
    const getOutletByCompany = await prisma.outlet.findMany({
        where: {
            userId: userId,
            companyId: companyId
        },
    });

    res.status(getOutletByCompany ? 200 : 401).json(getOutletByCompany);
});

const getListOutlet = expressAsyncHandler(async (req, res, next) => {
    const userId = req.query.userId;
    const companyId = req.query.companyId;

    if (userId == undefined) return res.status(401).send("user id tidak boleh kosong");
    const getListOutlet = await prisma.outlet.findMany({
        where: {
            userId: userId,
            companyId: companyId
        },
        select: {
            id: true,
            name: true,
        }
    });

    res.status(getListOutlet ? 200 : 401).json(getListOutlet);
});

const createOutlet = expressAsyncHandler(async (req, res, next) => {
    const { name, companyId } = req.body;
    const { userId } = req.query;

    const createOutlet = await prisma.outlet.create({
        data: {
            userId: userId,
            companyId: companyId,
            name: name,
        }
    });

    res.status(createOutlet ? 201 : 401).json(createOutlet);

});

const updateOutlet = expressAsyncHandler(async (req, res, next) => {
    const body = req.body;

    const updateOutlet = await prisma.outlet.update({
        where: {
            id: body.id,
        },
        data: {
            name: body.name,
        }
    });

    res.status(updateOutlet ? 201 : 401).json(updateOutlet);
});

const deleteOutlet = expressAsyncHandler(async (req, res, next) => {
    const id = req.body.id;

    const deleteOutlet = await prisma.outlet.delete({
        where: {
            id: id,
        }
    });

    res.status(deleteOutlet ? 201 : 401).json(deleteOutlet);
});

const getListOutletCompany = expressAsyncHandler(async (req, res, next) => {
    const { userId } = req.query;
    const data = await prisma.company.findMany({
        where: {
            userId: userId,
        },
        orderBy: {
            createdAt: 'asc',
        },
        select: {
            id: true,
            name: true,
            Outlet: {
                select: {
                    id: true,
                    name: true,
                }
            }
        }
    })

    res.status(data ? 200 : 401).json(data);

});

const outletByCompanyId = expressAsyncHandler(async (req, res, next) => {
    const { cusCompanyId, userId } = req.query;
    if (cusCompanyId == undefined) return res.status(401).send("company id tidak boleh kosong");

    const data = await prisma.outlet.findMany({
        where: {
            companyId: cusCompanyId,
        },
        orderBy: {
            createdAt: 'asc',
        },
        select: {
            id: true,
            name: true,
        }
    })

    res.status(data ? 200 : 401).json(data);

})

const outletSingle = expressAsyncHandler(async (req, res, next) => {
    const { userId, companyId, outletId } = req.query;
    const data = await prisma.outlet.findUnique({
        where: {
            id: outletId,
        },
        select: {
            id: true,
            name: true,
        }

    })

    res.status(data ? 200 : 401).json(data);
})


const Outlet = { getOutletByCompany, getListOutlet, createOutlet, updateOutlet, deleteOutlet, getListOutletCompany, outletByCompanyId, outletSingle };
module.exports = Outlet;
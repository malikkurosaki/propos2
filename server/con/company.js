const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const getListCompany = expressAsyncHandler(async (req, res, next) => {
    const { userId } = req.query;
    if (userId == undefined) return res.status(401).send("user id tidak boleh kosong");
    const getListCompany = await prisma.company.findMany({
        where: {
            userId: userId
        },
        select: {
            id: true,
            name: true
        }
    });

    res.status(getListCompany ? 200 : 401).json(getListCompany);
});

const create = expressAsyncHandler(async (req, res, next) => {
    const userId = req.query.userId;
    if (userId == undefined) return res.status(401).send("user id tidak boleh kosong");
    const create = await prisma.company.create({
        data: {
            name: req.body.name,
            userId: userId,
        }
    });

    res.status(create ? 201 : 401).json(create);
})

const companySingle = expressAsyncHandler(async (req, res, next) => {
    const { userId, companyId, outletId } = req.query;
    const companySingle = await prisma.company.findUnique({
        where: {
            id: companyId,
        },
        select: {
            id: true,
            name: true,
        },
    })

    res.status(companySingle ? 200 : 401).json(companySingle);

})

const Company = { getListCompany, create, companySingle };
module.exports = Company;
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const _ = require('lodash')

const getListCategory = expressAsyncHandler(async (req, res, next) => {
    const { userId, companyId, outletId } = req.query;

    if (userId == undefined) return res.status(401).send("user id tidak boleh kosong");
    const gCategory = await prisma.category.findMany({
        where: {
            userId: userId,
            companyId: companyId,
            outletId: outletId
        },
    });

    res.status(gCategory ? 200 : 401).json(gCategory);
})

const createCategory = expressAsyncHandler(async (req, res, next) => {
    const { name, companyId } = req.body;

    const { userId } = req.query;
    const cCategory = await prisma.category.create({
        data: {
            userId: userId,
            companyId: companyId,
            name: name,
        }
    });

    res.status(cCategory ? 201 : 401).json(cCategory);
})

const updateCategory = expressAsyncHandler(async (req, res, next) => {
    const body = req.body;

    const uCategory = await prisma.category.update({
        where: {
            id: body.id
        },
        data: {
            name: body.name,
        }
    });

    res.status(uCategory ? 201 : 401).json(uCategory);
})

const deleteCategory = expressAsyncHandler(async (req, res, next) => {
    const body = req.body;

    const dCategory = await prisma.category.delete({
        where: {
            id: body.id,
        }
    });

    res.status(dCategory ? 201 : 401).json(dCategory);
})

const getAllCategoryByCompany = expressAsyncHandler(async (req, res) => {
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
            Category: {
                select: {
                    id: true,
                    name: true,
                }
            }
        }
    });

    res.status(data ? 200 : 401).json(data);
})

const categoryByCompanyId = expressAsyncHandler(async (req, res) => {
    const { cusCompanyId, userId } = req.query;
    if (cusCompanyId == undefined) return res.status(401).send("outlet id tidak boleh kosong");
    const data = await prisma.category.findMany({
        where: {
            companyId: cusCompanyId,
        },
        select: {
            id: true,
            name: true,
        }
    })

    res.status(data ? 200 : 401).json(data);
})

const Category = { getListCategory, createCategory, updateCategory, deleteCategory, getAllCategoryByCompany, categoryByCompanyId };
module.exports = Category;
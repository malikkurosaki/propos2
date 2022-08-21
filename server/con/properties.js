const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');



const selectCompanyOutlet = expressAsyncHandler(async (req, res, next) => {
    const data = await prisma.company.findMany({
        where: {
            userId: req.query.userId,
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

    res.status(200).json(data);
});

const getCategoryOutletCompany = expressAsyncHandler(async (req, res, next) => {
    const { userId } = req.query;
    const data = await prisma.company.findMany({
        where: {
            userId: userId,
        },
        select: {
            id: true,
            name: true,
            Outlet: {
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
            }
        }

    })

    res.status(200).json(data);

});

const getAllCategoryWithOrNullOutlet = expressAsyncHandler(async (req, res) => {
    const { cusCompanyid, cusOutletId, userId } = req.query;
    const data = await prisma.category.findMany({
        where: {
            OR: [
                {
                    outletId: {
                        equals: cusOutletId
                    }
                },
                {
                    outletId: null
                }
            ]

        },
        select: {
            id: true,
            name: true
        }
    })

    res.status(data ? 200 : 401).json(data)
});


const Properties = { selectCompanyOutlet, getCategoryOutletCompany, getAllCategoryWithOrNullOutlet};
module.exports = Properties;
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const getName = expressAsyncHandler(async (req, res, next) => {
    const { userId, companyId, outletId } = req.query;

    const company = await prisma.company.findUnique({
        where: {
            id: companyId,
        },
        select: {
            name: true,
        }
    })

    const outlet = await prisma.outlet.findUnique({
        where: {
            id: outletId,
        },
        select: {
            name: true,
        }
    })

    const result = {
        companyName: company.name,
        outletName: outlet.name,
    }

    res.status(200).json(result);
});

const drawerHeaderEmployee = expressAsyncHandler(async (req, res) => {
    const { userId, companyId, outletId, employeeId } = req.query;

    if (userId == undefined || companyId == undefined || outletId == undefined || employeeId == undefined) return res.status(400).json({ message: 'Bad Request' });

   

    const data = await prisma.user.findUnique({
        where: {
            id: userId
        },
        select: {
            Company: {
                where: {
                    id: companyId
                },
                select: {
                    id: true,
                    name: true
                }
            },
            Outlet: {
                where: {
                    id: outletId
                },
                select: {
                    id: true,
                    name: true
                }
            },
            Employee: {
                where: {
                    id: employeeId
                },
                select: {
                    id: true,
                    name: true
                }
            }
        }
    })

    res.status(data ? 200 : 401).json(data)
});

const DrawerHeader = { getName, drawerHeaderEmployee }

module.exports = DrawerHeader
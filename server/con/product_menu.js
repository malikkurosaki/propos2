const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const _ = require('lodash');


const getPropertyByCompany = expressAsyncHandler(async (req, res, next) => {
    const userId = req.query.userId;
    if (userId == undefined) return res.status(403).send(403);
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
})

const ProductMenu = { getPropertyByCompany };
module.exports = ProductMenu;
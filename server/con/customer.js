const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const create = expressAsyncHandler(async (req, res) => {
    const { userId, companyId, outletId } = req.query;
    const { listCompany, body } = req.body;

    let bd = JSON.parse(body)

    const data = await prisma.customer.create({
        data: {
            name: bd.name,
            address: bd.address ?? undefined,
            phone: bd.phone ?? undefined,
            whatsapp: bd.whatsapp ?? undefined,
            userId: userId,
            CustomerCompany: {
                createMany: {
                    data: [
                        ...JSON.parse(listCompany).map((e) => {
                            return {
                                companyId: e,
                                userId: userId
                            }
                        })
                    ]
                }
            }
        }
    })

    res.status(201).json(data);
});

const getList = expressAsyncHandler(async (req, res) => {
    const { userId } = req.query;
    const data = await prisma.customer.findMany({
        where: {
            userId: {
                equals: userId
            }
        },
        orderBy: {
            createdAt: "asc"
        },
        select: {
            id: true,
            name: true,
            whatsapp: true,
            CustomerCompany: {
                orderBy: {
                    createdAt: "asc"
                },
                select: {
                    Company: {
                        select: {
                            id: true,
                            name: true
                        }
                    }
                }
            }
        }
    })

    res.status(200).json(data)
})


const Customer = { create, getList }
module.exports = Customer
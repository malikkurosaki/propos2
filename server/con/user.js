const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const getUserDataById = expressAsyncHandler(async (req, res, next) => {
    const userId = req.query.userId;
    if (userId == undefined) return res.status(401).send("user id tidak boleh kosong");
    const getUserDataById = await prisma.user.findUnique({
        where: {
            id: userId
        },
        select: {
            Company: {
                select: {
                    createdAt: true,
                    name: true,
                    DetailCompany: {
                        select: {
                            nameOwner: true,
                            address: true,
                            MJeniUsaha: {
                                select: {
                                    name: true,
                                    id: true,
                                }
                            },
                            phone: true,
                            numberEmployees: true,
                        }
                    },
                    Outlet: {
                        select: {
                            name: true,
                            id: true
                        },

                    },

                }
            }
        }
    })

    res.status(getUserDataById != null ? 200 : 401).json(getUserDataById)
});

const getUser = expressAsyncHandler(async (req, res, next) => {
    const userId = req.query.userId;
    if (userId == undefined) return res.status(401).send("user id tidak boleh kosong");

    const user = await prisma.user.findUnique({
        where: {
            id: userId
        },
        select: {
            email: true,
            name: true,
            id: true,
        }
    })

    res.status(user != null ? 200 : 401).json(user)
});

const User = { getUserDataById, getUser };

module.exports = User;
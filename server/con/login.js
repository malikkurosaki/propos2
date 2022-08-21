const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const sekarang = expressAsyncHandler(async (req, res, next) => {
    const body = req.body;

    const getUser = await prisma.user.findFirst({
        where: {
            AND: {
                email: {
                    equals: body.email
                },
                password: {
                    equals: body.password
                }
            }
        },
        select: {
            id: true,
            Company: {
                where: {
                    idx: 1
                },
                select: {
                    id: true,
                    idx: true,
                    Outlet: {
                        where: {
                            idx: 1
                        },
                        select: {
                            id: true,
                            idx: true,
                        }
                    }
                }
            },
        }

    });

    if (getUser) {

        const result = {
            "userId": getUser.id,
            "companyId": getUser.Company[0]["id"],
            "outletId": getUser.Company[0]["Outlet"][0]["id"],
        }

        res.status(200).json(result);
    } else {
        res.status(401).send("email atau password salah");
    }



});

const Login = { sekarang };
module.exports = Login;
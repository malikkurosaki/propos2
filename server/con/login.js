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
            name: true,
            Company: {
                where: {
                    id: {
                        not: {
                            equals: undefined
                        }
                    }
                },
                select: {
                    id: true,
                    name: true,
                    createdAt: true,
                    Outlet: {
                        where: {
                            id: {
                                not: {
                                    equals: undefined
                                }
                            }
                        },
                        select: {
                            id: true,
                            name: true,
                            createdAt: true,
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
            "user": {
                "id": getUser.id,
                "name": getUser.name
            },
            "company": {
                "id": getUser.Company[0].id,
                "name": getUser.Company[0].name
            },
            "outlet": {
                "id": getUser.Company[0]["Outlet"][0].id,
                "name": getUser.Company[0]["Outlet"][0].name
            }
        }

        res.status(200).json(result);
    } else {
        res.status(401).send("email atau password salah");
    }

});

const device = expressAsyncHandler(async (req, res) => {

    const { deviceId } = req.body;
    const data = await prisma.device.findUnique({
        where: {
            deviceId: deviceId
        },
        select: {
            User: {
                select: {
                    Employee: {
                        select: {
                            id: true,
                            name: true
                        }
                    }
                }
            }
        }
    })

    res.status(data ? 200 : 403).json(data);
});


const Login = { sekarang, device };
module.exports = Login;
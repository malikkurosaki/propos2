const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const sekarang = expressAsyncHandler(async (req, res, next) => {
    const { email, password } = req.body;
    if (email == undefined || password == undefined) return res.status(404).send("403");

    const getUser = await prisma.user.findFirst({
        where: {
            AND: {
                email: {
                    equals: email
                },
                password: {
                    equals: password
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
    if (deviceId == undefined) return res.status(403).send("403")
    const data = await prisma.device.findUnique({
        where: {
            deviceId: deviceId
        },
        select: {
            Outlet: {
                select: {
                    id: true,
                    name: true,
                    Employee: {
                        select: {
                            id: true,
                            name: true
                        }
                    }
                }
            },
            Company: {
                select: {
                    id: true,
                    name: true
                }
            }
        }
    })

    res.status(data ? 200 : 403).json(data);
});


const loginCashier = expressAsyncHandler(async (req, res) => {
    const { id, name, password } = req.body;
    if (id == undefined || name == undefined || password == undefined) return res.status(403).send('403')
    
    const data = await prisma.employee.findFirst({
        where: {
            id: {
                equals: id
            },
            name: {
                equals: name
            },
            password: {
                equals: password
            }
        },
        select: {
            id: true,
            name: true,
            userId: true,
            outletId: true,
            companyId: true
        }
    })

    res.status(data ? 200 : 403).json(data)
});

const Login = { sekarang, device, loginCashier };
module.exports = Login;
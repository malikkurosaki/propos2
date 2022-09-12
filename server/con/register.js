const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const uuidInt = require('uuid-int');

const sekarang = expressAsyncHandler(async (req, res, next) => {
    const { name, email, password, namaUsaha } = req.body;
    const generator = uuidInt(Math.floor(Math.random() * 500));

    try {
        const daftar = await prisma.user.create({
            data: {
                name: name,
                email: email,
                password: password,
                Company: {
                    create: {
                        name: namaUsaha,
                        Outlet: {
                            create: {
                                name: namaUsaha,
                                Device: {
                                    create: {
                                        name: namaUsaha,
                                        deviceId: generator.uuid().toString(),
                                    }
                                }
                            }
                        }
                    }
                },
            },
            select: {
                id: true,
                Company: {
                    select: {
                        id: true,
                        Outlet: {
                            select: {
                                id: true,
                                Device: {
                                    select: {
                                        id: true
                                    }
                                }
                            },

                        }
                    }
                }
            }
        });

        const dataDaftar = {
            "userId": daftar.id,
            "companyId": daftar.Company[0].id,
            "outletId": daftar.Company[0].Outlet[0].id,
            "deviceId": daftar.Company[0].Outlet[0].Device[0].id,
        }

        let dataDefault =  await prisma.defaultPreference.create({
            data: {
                deviceId: dataDaftar.deviceId,
                userId: dataDaftar.userId,
                companyId: dataDaftar.companyId,
                outletId: dataDaftar.outletId
            }
        },)

        res.status(201).json(dataDefault);
    } catch (error) {
        console.log(error);
        res.status(401).send("Email Has Been Used");
    }

    // const getUser = await prisma.user.findUnique({
    //     where: {
    //         email: body.email
    //     }
    // })

    // if (!getUser) {


    //     res.status(201).json(daftar);
    // } else {
    //     res.status(401).send("email sudah terdaftar");
    // }

});

const Register = { sekarang };
module.exports = Register;
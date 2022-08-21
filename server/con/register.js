const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const sekarang = expressAsyncHandler(async (req, res, next) => {
    const { name, email, password, namaUsaha } = req.body;

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
                            }
                        }
                    }
                }
            },
            select: {
                id: true,
                Company: {
                    select: {
                        id: true,
                        Outlet: {
                            select: {
                                id: true,
                            }
                        }
                    }
                }
            }
        });

        res.status(201).json(daftar);
    } catch (error) {
        res.status(401).send(error);
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
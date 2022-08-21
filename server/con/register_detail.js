const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const response = {
    "nameBusiness": "ssdsds",
    "nameOutlet": "dsdsds",
    "nameOwner": "dsdsdsds",
    "address": "dsdsdsds",
    "phone": "0897989",
    "numberEmployees": "10",
    "mJenisUsahaId": "10",
    "userId": "e906d071 - a8a8- 48bf-9c49 - c545b577335f"
}

const sekarang = expressAsyncHandler(async (req, res, next) => {
    const body = req.body;

    const company = await prisma.company.create({
        data: {
            name: body.nameBusiness,
            userId: body.userId,
            DetailCompany: {
                create: {
                    address: body.address,
                    nameOwner: body.nameOwner,
                    numberEmployees: Number(body.numberEmployees),
                    mJenisUsahaId: body.mJenisUsahaId,
                    phone: body.phone,
                    userId: body.userId,
                }
            },
            Outlet: {
                create: {
                    name: body.nameOutlet,
                    userId: body.userId,
                }
            }
        },
    });

    res.status(company ? 201 : 401).send(body.userId);

});

const RegisterDetail = { sekarang };
module.exports = RegisterDetail;
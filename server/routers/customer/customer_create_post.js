const expressAsyncHandler = require("express-async-handler");
const Pc = require('@prisma/client').PrismaClient;
const prisma = new Pc();

let modelCustomer = {
    name: null,
    address: undefined,
    phone: undefined,
    email: undefined,
    companyId: undefined,
    userId: undefined,
    whatsapp: undefined,
}

module.exports = expressAsyncHandler(async (req, res) => {
    let body = JSON.parse(req.body.data);
    body['userId'] = req.userId;
    const resData = await prisma.customer.create({ data: body })

    res.status(201).json(resData);
},)
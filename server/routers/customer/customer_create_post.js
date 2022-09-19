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

    const data = Object.assign(modelCustomer, JSON.parse(req.body.data))
    const result = await prisma.customer.create({ data })
    res.status(201).json(result);
})
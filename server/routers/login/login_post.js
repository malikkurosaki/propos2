const expressAsyncHandler = require("express-async-handler");
const Pc = require('@prisma/client').PrismaClient;
const prisma = new Pc();
var CryptoJS = require("crypto-js");

module.exports = expressAsyncHandler(async (req, res) => {

    const { email, password } = JSON.parse(req.body.data);
    if (!email || !password) return res.status(403).send('ops! pertama')
    const data = await prisma.user.findUnique({
        where: {
            email: email,
        },
        select: {
            password: true,
            id: true,
            isActive: true
        }
    })

    if (data && password == data.password && data.isActive) {
        // const token = CryptoJS.AES.encrypt(data.id, "123456").toString();
        res.status(201).send(data.id);
    } else {
        res.status(403).send('ops! wrong email or password')
    }

})
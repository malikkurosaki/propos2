const expressAsyncHandler = require("express-async-handler");
const { ModelHeader } = require("../../utils");
const PrismaClient = require("@prisma/client").PrismaClient
const prisma = new PrismaClient();

const path = require('path');
const flName = path.parse(__filename).name

module.exports = expressAsyncHandler(async (req, res) => {
    // const { userid, companyid } = Object.assign(ModelHeader, req.headers);

    // if (!userid || !companyid) return res.status(401).send({ message: "Unauthorized " + flName});
    const data = await prisma.company.findMany({
        where: {
            userId: req.userId
        }
    })

    res.status(200).send(data);
});
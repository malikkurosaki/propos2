const handler = require('express-async-handler');
const Pc = require('@prisma/client').PrismaClient;
const prisma = new Pc();

module.exports = handler(async (req, res) => {
    const data = await prisma.defaultPrefByUser.findUnique({
        where: {
            token: req.token
        },
        select: {
            User: {
                select: {
                    name: true
                }
            },
            Company: {
                select: {
                    name: true
                }
            },
            Outlet: {
                select: {
                    name: true
                }
            },
            Device: {
                select: {
                    name: true
                }
            }
        }
    })

    res.status(200).json(data);
})
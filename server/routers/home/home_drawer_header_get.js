const handler = require('express-async-handler');
const Pc = require('@prisma/client').PrismaClient;
const prisma = new Pc();

module.exports = handler(async (req, res) => {
    const data = await prisma.defaultPreference.findUnique({
        where: {
            deviceId: req.deviceId
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
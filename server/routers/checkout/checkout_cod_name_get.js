const handler = require('express-async-handler');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();

module.exports = handler(async (req, res) => {
    const data = await prisma.defaultPreference.findUnique({
        where: {
            deviceId: req.deviceId
        },
        select: {
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
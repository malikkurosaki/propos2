module.exports = require('express-async-handler')(async (req, res) => {
    const data = await new (require('@prisma/client').PrismaClient)().defaultPreference.findUnique({
        where: {
            deviceId: req.deviceId
        },
        select: {
            Company: {
                select: {
                    id: true,
                    name: true
                }
            },
            Outlet: {
                select: {
                    id: true,
                    name: true
                }
            },
            Device: {
                select: {
                    id: true,
                    name: true
                }
            }
        }
    })

    res.status(200).json(data)
})
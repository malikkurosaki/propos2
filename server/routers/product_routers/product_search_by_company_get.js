module.exports = require('express-async-handler')(async(req, res)=> {
    const {name} = req.query; 
    const data = await new (require('@prisma/client').PrismaClient)().product.findMany({
        where: {
            companyId: req.companyId,
            name: {
                contains: name
            }
        }, orderBy: {
            createdAt: "desc"
        },
        select: {
            id: true,
            name: true,
            price: true,
            companyId: true,
            ProductStock: {
                where: {
                    outletId: req.outletId
                },
                select: {
                    id: true,
                    stock: true
                }
            },
            ProductOutlet: {
                where: {
                    outletId: req.outletId,
                    isActive: true
                },
                select: {
                    id: true,
                    isActive: true,
                    outletId: true,
                    productId: true,
                    Outlet: {
                        select: {
                            id: true,
                            name: true,
                            companyId: true
                        }
                    }
                }
            },

        }
    })

    res.status(200).json(data);
})
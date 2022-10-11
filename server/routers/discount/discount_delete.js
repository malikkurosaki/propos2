module.exports  = require('express-async-handler')(async(req, res) => {
    const id = req.query.id;
    if(!id) return res.status(401).send("401");
    
    const data = await new (require('@prisma/client').PrismaClient)().discount.delete({
        where: {
            id: id
        }
    })

    res.status(201).json(data);
});
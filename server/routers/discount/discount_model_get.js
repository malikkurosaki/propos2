const { Prisma } = require('@prisma/client');

module.exports = require('express-async-handler')(async (req, res) => {

    let data = { ...Prisma.DiscountScalarFieldEnum };
    for(let itm of Object.keys(data)){
        data[itm] = null
    }

    res.status(200).json(data);
},)
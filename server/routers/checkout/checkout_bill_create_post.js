const handler = require('express-async-handler');
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();

const model = {
    "cashierId": "undefined",
    "change": "null",
    "companyId": "null",
    "customerId": "undefined",
    "deviceId": "null",
    "discountId": "undefined",
    "employeeId": "undefined",
    "outletId": "undefined",
    "tax": "undefined",
    "totalPrice": "null",
    "totalQty": "null",
    "userId": "null",
    "BillPayment": {
        "createMany": {
            "data": [
                {
                    "paymentMethodId": "null"
                }
            ]
        }
    },
    "Order": {
        "createMany": {
            "data": [
                {
                    "note": "undefined",
                    "number": "null",
                    "tax": "undefined",
                    "productId": "null",
                    "total": "null",
                    "quantity": "null",
                    "discountId": "undefined",


                }
            ]
        }
    },


};

module.exports = handler(async (req, res) => {
    const body = JSON.parse(req.body.data);

    const data = await prisma.bill.create({ data: body });

    res.status(data ? 201 : 401).json(data);

    // const data = await prisma.bill.create({
    //     data:
    //     {

    //         cashierId: undefined,
    //         change: null,
    //         companyId: null,
    //         customerId: undefined,
    //         deviceId: null,
    //         discountId: undefined,
    //         employeeId: undefined,
    //         outletId: undefined,
    //         tax: undefined,
    //         totalPrice: null,
    //         totalQty: null,
    //         userId: null,
    //         number: null,
    //         BillPayment: {
    //             createMany: {
    //                 data: [
    //                     {
    //                         paymentMethodId: null
    //                     }
    //                 ]
    //             }
    //         },
    //         OrderManual: {
    //             createMany: {
    //                 data: [
    //                     {
    //                         name: null,
    //                         price: null,
    //                         companyId: null,
    //                         note: null,
    //                         total: null,
    //                         userId: null
    //                     }
    //                 ]
    //             }
    //         },
    //         Order: {
    //             createMany: {
    //                 data: [
    //                     {
    //                         note: undefined,
    //                         number: null,
    //                         tax: undefined,
    //                         productId: null,
    //                         total: null,
    //                         quantity: null,
    //                         discountId: undefined,


    //                     }
    //                 ]
    //             }
    //         },


    //     }
    // })
});
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');


let bdy = {
    "id": "",
    "totalQty": "",
    "totalPrice": "",
    "userId": "",
    "companyId": "",
    "outletId": "",
    "employeeId": "",
    "cashierId": "",
    "discount": "",
    "tax": "",
    "payment": "",
    "change": "",
    "customerId": ""
};

let listOrder = {
    "quantity": "",
    "note": "",
    "total": "",
    "discount": "",
    "tax": "",
    "productId": "",
    "billId": ""
};

const payment = expressAsyncHandler(async (req, res, next) => {

    let bill = JSON.parse(req.body['bill']);
    let listOrder = JSON.parse(req.body['listOrder']);

    listOrder = listOrder.map(e => {
        return {
            "quantity": Number(e.quantity),
            "note": e.note,
            "total": `${e.total}`,
            "discount": e.discount ?? undefined,
            "tax": e.tax ?? undefined,
            "productId": e.productId
        }
    });


    const payment = await prisma.bill.create({
        data: {
            "id": bill.id,
            "totalQty": Number(bill.totalQty),
            "totalPrice": Number(bill.totalPrice),
            "userId": bill.userId,
            "companyId": bill.companyId,
            "outletId": bill.outletId,
            "employeeId": bill.employeeId ?? undefined,
            "cashierId": bill.cashierId ?? undefined,
            "discount": bill.discount ?? undefined,
            "tax": bill.tax ?? undefined,
            "payment": Number(bill.payment),
            "change": Number(bill.change),
            "customerId": bill.customerId??undefined,
            Order: {
                createMany: {
                    data: [...listOrder]
                }
            }
        },

    });

    res.status(payment ? 201 : 401).json(payment);
});

const Bill = { payment };
module.exports = Bill;
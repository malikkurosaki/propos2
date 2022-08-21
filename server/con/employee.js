const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');

const getEmployeeByuserId = expressAsyncHandler(async (req, res, next) => {
    const userid = req.query.userId;
    if (userid == undefined) return res.status(401).send("userid tidak boleh kosong");
    const employee = await prisma.employee.findMany({
        where: {
            userId: userid,

        },
        select: {
            id: true,
            name: true,
            password: true,
        }
    })

    res.status(employee != null ? 200 : 401).json(employee)

});

const createEmployee = expressAsyncHandler(async (req, res, next) => {
    const { userId } = req.query;
    const body = req.body;

    console.log(req.query);

    if (userId == undefined) return res.status(401).send("userid tidak boleh kosong");
    let employee = await prisma.employee.create({
        data: {
            userId: userId,
            name: body.name,
            password: body.password,
            companyId: body.companyId,
            outletId: body.outletId,
        }
    })

    res.status(employee != null ? 201 : 401).json(employee)
});

const deleteEmployee = expressAsyncHandler(async (req, res, next) => {
    const id = req.body.id;
    if (id == undefined) return res.status(401).send("id tidak boleh kosong");
    const employee = await prisma.employee.delete({
        where: {
            id: id,
        }
    })

    res.status(employee != null ? 201 : 401).json(employee)

});

const upadteEmployee = expressAsyncHandler(async (req, res, next) => {
    const id = req.body.id;
    const body = req.body;
    if (id == undefined) return res.status(401).send("id tidak boleh kosong");
    const employee = await prisma.employee.update({
        where: {
            id: id,
        },
        data: {
            name: body.name,
            password: body.password,
        }
    })

    res.status(employee != null ? 201 : 401).json(employee)

})

const employeeByUser = expressAsyncHandler(async (req, res, next) => {

    const { userId, companyId, outletId } = req.query;
    const data = await prisma.company.findMany({
        where: {
            userId: userId
        },
        orderBy: {
            idx: 'asc',
        },
        select: {
            id: true,
            name: true,
            Outlet: {
                orderBy: {
                    idx: 'asc',
                },
                select: {
                    id: true,
                    name: true,
                    Employee: {
                        orderBy: {
                            idx: 'asc',
                        },
                        select: {
                            id: true,
                            name: true,
                            password: true,
                        }
                    }
                }
            }
        }
    })

    res.status(data != null ? 200 : 401).json(data)
})

const Employee = { getEmployeeByuserId, createEmployee, deleteEmployee, upadteEmployee, employeeByUser };
module.exports = Employee;
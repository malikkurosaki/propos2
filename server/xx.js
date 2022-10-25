const prisma = new (require('@prisma/client').PrismaClient)();
const { Prisma, PrismaClient } = require('@prisma/client')

async function main() {

    await prisma.product.create({
        data: {
            ProductStock: {
                createMany: {
                    data: {

                        outletId: "",
                        isActive: true,
                        minStock: 0,
                        stock: 0,
                    }
                }
            },
            ProductCustomPrice: {
                createMany: {
                    data: [
                        {
                            price: 0,
                            customPriceId: "",
                            isActive: true
                        }
                    ]
                }
            },
            
        }
    })

    // /**@type {any[]} */
    // let pro = await prisma.$queryRaw`describe product`
    // let table = pro.map((e) => {
    //     let data = `{"${e.Field}": ""}`

    //     return JSON.parse(data)
    // })

    // console.log(table)

    let p = Prisma.ProductScalarFieldEnum

    console.log(p)


}

main()


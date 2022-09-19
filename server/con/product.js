const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler');
const _ = require('lodash');

const getListProduct = expressAsyncHandler(async (req, res, next) => {
    const { userId, companyId, outletId } = req.query;

    if (userId == undefined) return res.status(401).send("user id tidak boleh kosong");
    const getListProduct = await prisma.product.findMany({
        where: {
            userId: {
                equals: userId
            },
            companyId: {
                equals: companyId
            },
            ProductOutlet: {
                every: {
                    outletId: {
                        equals: outletId
                    }
                }
            }
        },
        select: {
            id: true,
            name: true,
            price: true,
            ProductImage: {
                select: {
                    url: true,
                    name: true,
                    id: true
                },
            },
        }
    });

    res.status(getListProduct ? 200 : 401).json(getListProduct);
});


const getProduct = expressAsyncHandler(async (req, res, next) => {
    const productId = req.query.productId;
    if (productId == undefined) return res.status(401).send("product id tidak boleh kosong");
    const getProduct = await prisma.product.findOne({
        where: {
            id: productId
        },
    });

    res.status(getProduct ? 200 : 401).json(getProduct);
});


// menyediakan produk saat catagory di pilih
const getProductByCategory = expressAsyncHandler(async (req, res, next) => {
    const { categoryId, userId, companyId, outletId } = req.query;
    // console.log(categoryId == "");

    const getProductByCategory = await prisma.product.findMany({
        where: {
            categoryId: categoryId ?? undefined,
            userId: userId,
            companyId: companyId,
            // ProductOutlet: {
            //     every: {
            //         outletId: {
            //             equals: outletId
            //         }
            //     }
            // }
        },
        select: {
            id: true,
            name: true,
            price: true,
            ProductImage: {
                select: {
                    url: true,
                    name: true,
                    id: true
                },
            },
            Category: {
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
            }
        }
    });

    res.status(getProductByCategory ? 200 : 401).json(getProductByCategory);
});


let ModelProduct = {
    "name": null,
    "price": null,
    "listCustomPrice": undefined,
    "productImageId": undefined,
    "productImageName": undefined,
    "stock": undefined,
    "minStock": undefined,
    "companyId": undefined,
    "categoryId": undefined,
    "listOutlet": undefined,
    "des": undefined,
    "modal": undefined,
    "sku": undefined,
    "barcodeId": undefined,
    "berat": undefined,
    "dimensi": undefined,
    "isCustomPrice": undefined,
    "isStock": undefined,
    "isImage": undefined
}


// const ModelProduct2 = {
//     "name": "dsdsdsds",
//     "price": 33334,
//     "listCustomPrice": [
//         {
//             "customPriceId": "3a6bf7d3-41f3-4c63-b9c1-46ccc2152b90",
//             "price": 23232
//         }
//     ],
//     "productImageId": "a4792846-dcad-4777-8c9f-3a1d10b2e329",
//     "productImageName": "c9a1d5a6-bd0a-496f-84b3-05b6e7c42d91_scaled_download-1.jpg.png",
//     "stock": 1,
//     "ninStock": sear0,
//     "companyId": "314510a8-f2bb-4792-ab9a-f2a82821a9af",
//     "listOutlet": [
//         {
//             "outletId": "a37d306d-f5a5-43cf-9b92-282f23d40fc3",
//             "companyId": "314510a8-f2bb-4792-ab9a-f2a82821a9af",
//             "userId": "2081b6cd-8728-4a50-a1d7-6a24812d0309"
//         }
//     ],
//     "des": "dsdsds",
//     "modal": 3333,
//     "barcodeId": "dsdsdsds",
//     "sku": "dfssdss",
//     "berat": 333,
//     "categoryId": "f5539660-b852-4292-850f-db8afbdecf44",
//     "dimensi": "3,4,5",
//     "isImage": true,
//     "isStock": true,
//     "isDetail": true
// }

// menambahkan product baru
const createProduct = expressAsyncHandler(async (req, res, next) => {
    const { userId, companyId, outletId } = req.query;
    if (!userId || !companyId || !outletId) return res.status(401).send("401")

    let dataBody = JSON.parse(req.body.data);

    /**@type {ModelProduct} */
    const body = Object.assign(ModelProduct, dataBody);

    try {
        const data = await prisma.product.create({
            data: {
                name: body.name,
                price: Number(body.price),
                categoryId: body.categoryId,
                description: body.des,
                userId: userId,
                companyId: body.companyId,
                productImageId: body.productImageId,
                img: body.productImageName,
                stock: body.stock,
                minStock: body.minStock,
                barcodeId: body.barcodeId,
                isStock: body.isStock,
                isImage: body.isImage,
                isCustomPrice: body.isCustomPrice,
                costOfCapital: body.modal,
                ProductCustomPrice: body.listCustomPrice == undefined ? undefined : {
                    createMany: {
                        data: body.listCustomPrice
                    }
                },
                ProductOutlet: _.isEmpty(body.listOutlet) ? undefined : {
                    createMany: {
                        data: body.listOutlet
                    }
                }
            }
        },);
        res.status(201).json(data)
    } catch (error) {
        return res.status(401).send(error)
    }
});



const updateProduct = expressAsyncHandler(async (req, res, next) => {
    const {
        productId,
        name,
        price,
        description,
        userId
    } = req.body;

    const updateProduct = await prisma.product.update({

        where: {
            id: productId
        },
        data: {
            name: name,
            price: price,
            description: description,
            userId: userId
        }
    });

    res.status(updateProduct ? 201 : 401).json(updateProduct);
});

const deleteProduct = expressAsyncHandler(async (req, res, next) => {
    const productId = req.query.productId;
    if (productId == undefined) return res.status(401).send("productId tidak boleh kosong");
    const deleteProduct = await prisma.product.delete({
        where: {
            id: productId
        }
    });

    res.status(deleteProduct ? 201 : 401).json(deleteProduct);
});

const search = expressAsyncHandler(async (req, res, next) => {
    // const search = req.query.search;
    // const userId = req.query.userId;
    const { userId, search, companyId, outletId } = req.query;

    if (search == undefined || userId == undefined) return res.status(401).send("401");
    const getProductSearch = await prisma.product.findMany({
        where: {
            name: {
                contains: search
            },
            userId: {
                equals: userId
            },
            companyId: {
                equals: companyId
            },
            // outletId: {
            //     equals: outletId
            // }
        },
    });

    res.status(getProductSearch ? 200 : 401).json(getProductSearch);
});

const productCreateSelect = expressAsyncHandler(async (req, res, next) => {
    const { userId } = req.query;
    const data = await prisma.company.findMany({
        where: {
            userId: userId
        },
        select: {
            id: true,
            name: true,
            Outlet: {
                select: {
                    id: true,
                    name: true
                }
            },
            Category: {
                select: {
                    id: true,
                    name: true
                }
            }
        }
    })

    res.status(data ? 200 : 401).json(data)
})

const productbyUserId = expressAsyncHandler(async (req, res, next) => {
    const { userId } = req.query;
    const data = await prisma.company.findMany({
        where: {
            userId: userId
        },
        orderBy: {
            createdAt: "asc"
        },
        select: {
            id: true,
            name: true,
            Product: {
                select: {
                    id: true,
                    name: true,
                    price: true,
                    description: true,
                    stock: true,
                    isStock: true,
                    minStock: true,
                    img: true,
                    isImage: true,
                    barcodeId: true,
                    isCustomPrice: true,
                    sku: true,
                    productDimention: true,
                    productWeight: true,
                    ProductImage: {
                        select: {
                            url: true,
                            name: true,
                            id: true
                        }
                    },
                    ProductOutlet: {
                        select: {
                            Outlet: {
                                select: {
                                    id: true,
                                    name: true
                                }
                            }
                        }
                    },
                    Category: {
                        select: {
                            id: true,
                            name: true
                        }
                    }
                }
            },
        }
    })

    res.status(data ? 200 : 401).json(data)
})

const productCashier = expressAsyncHandler(async (req, res, next) => {
    const { userId, companyId, outletId } = req.query;
    if (!userId || !companyId || !outletId) return res.status(401).send("bad request");
    const data = await prisma.product.findMany({
        where: {
            userId: userId,
            companyId: companyId,
            // outletId: outletId
        },
        select: {
            id: true,
            name: true,
            price: true,
            description: true,
            ProductImage: {
                select: {
                    url: true,
                    name: true,
                    id: true
                }
            },
        }
    })

    res.status(data ? 200 : 401).json(data)
});

const productGetByCompanyId = expressAsyncHandler(async (req, res) => {
    const { userId, cusCompanyId } = req.query;
    if (!userId || !cusCompanyId) return res.status(401).send("401 | bad request");
    const data = await prisma.product.findMany({
        orderBy: {
            createdAt: "desc"
        },
        where: {
            userId: userId,
            companyId: cusCompanyId
        },
        select: {
            id: true,
            img: true,
            name: true,
            price: true,
            barcodeId: true,
            costOfCapital: true,
            createdAt: true,
            sku: true,
            description: true,
            productDimention: true,
            minStock: true,
            productWeight: true,
            stock: true,
            isCustomPrice: true,
            ProductOutlet: {
                select: {
                    Outlet: {
                        select: {
                            name: true
                        }
                    }
                }
            }

        }
    })

    res.status(200).send(data)
})

const Product = {
    getListProduct,
    getProduct,
    createProduct,
    updateProduct,
    deleteProduct,
    getProductByCategory,
    search,
    productCreateSelect,
    productbyUserId,
    productGetByCompanyId,
    productCashier
};
module.exports = Product;
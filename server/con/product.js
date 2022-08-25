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
    const getProductByCategory = await prisma.product.findMany({
        where: {
            categoryId: categoryId ?? undefined,
            userId: userId,
            companyId: companyId,
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

// menambahkan product baru
const createProduct = expressAsyncHandler(async (req, res, next) => {
    const userId = req.query.userId;
    const compId = req.query.companyId;
    const {
        name,
        price,
        description,
        categoryId,
        outletList,
        companyId,
        productImageId,
    } = req.body;

    console.log(outletList)

    // [{ "id": "235d21e5-fd30-4a83-a166-fdcfc9803f36", "name": "baru tiga" }, { "id": "2d1c6cec-b8ad-48f5-b8fb-f4b2314d7967", "name": "baru nih" }, { "id": "7b60b369-584f-4aaf-a7a9-7791b214212c", "name": "baru dua" }, { "id": "db2dce47-d655-4fe4-a4f0-96bb53d06b2f", "name": "usahaku" }]

    const createProduct = await prisma.product.create({
        data: {
            name: name,
            price: Number(price),
            categoryId: categoryId,
            description: description,
            userId: userId,
            companyId: companyId,
            productImageId: productImageId == "null" ? undefined : productImageId,
            ProductOutlet: {
                createMany: {
                    data: JSON.parse(outletList).map(outlet => ({
                        outletId: outlet,
                        userId: userId,
                        companyId: companyId,
                    }
                    ))

                }
            }

        }
    });

    res.status(createProduct ? 201 : 401).json(createProduct);
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
            outletId: {
                equals: outletId
            }
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
    const data = await prisma.product.findMany({
        where: {
            userId: userId,
            companyId: companyId,
            outletId: outletId
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

const Product = {
    getListProduct,
    getProduct,
    createProduct,
    updateProduct,
    deleteProduct,
    getProductByCategory,
    search,
    productCreateSelect,
    productbyUserId
};
module.exports = Product;
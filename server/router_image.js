const path = require('path')
const fs = require('fs');
const uuid = require('uuid');
const routerImg = require('express').Router();
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();
const multer = require('multer');
const expressAsyncHandler = require('express-async-handler');
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        if (!fs.existsSync('./uploads/')) {
            fs.mkdirSync('./uploads/');
        }
        cb(null, './uploads/');
    },
    filename: function (req, file, cb) {
        cb(null, uuid.v4() + "_" + file.originalname);
    }
});

// upload image with multer
routerImg.post('/upload', multer({ storage: storage }).single('image'), expressAsyncHandler(async (req, res) => {

    let img = await prisma.productImage.create({
        data: {
            url: "/uploads/" + req.file.filename,
            name: req.file.filename,
            userId: req.query.userId
        }
    })

    console.log(img);

    res.status(img != null ? 201 : 401).json(img);
}))

routerImg.get("/:type/:name", (req, res) => {
    let params = req.params;
    const target = path.join(__dirname, `./assets/${params.type}/${params.name}`)
    if (fs.existsSync(target)) {
        res.type('image/png').sendFile(target);
    } else {
        res
            .type("image/png")
            .sendFile(path.join(__dirname, `./assets/${params.type}/no_image.png`));
    }
});



module.exports = routerImg;
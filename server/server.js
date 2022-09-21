const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const cors = require('cors');
const colors = require('colors');
const routerImg = require('./router_image');
const routerApi = require('./router_api');
const routerMaster = require('./router_master');
const routerAuth = require('./router_auth');
const routerGambar = require('./router_gambar');
const routers = require('./routers');
const Pc = require('@prisma/client').PrismaClient
const prisma = new Pc();
var CryptoJS = require("crypto-js");

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'))

app.use("/auth", routerAuth)
app.use('/img', routerImg);
app.use('/api', routerApi);
app.use('/master', routerMaster)
app.use(routerGambar);

// new custom router beta
app.use(async (req, res, next) => {
    if (req.url.includes('login')) {
        return routers(req, res, next);
    } else {
        const token = req.headers.token;
        if (!token || token == "") return res.status(401).json({ message: 'Unauthorized' });
        var bytes = CryptoJS.AES.decrypt(token, '123456');
        var id = bytes.toString(CryptoJS.enc.Utf8);
        const user = await prisma.user.findUnique({
            where: {
                id: id
            },
            select: {
                id: true,
                isActive: true
            }
        });

        if (!user || !user.isActive) return res.status(401).json({ message: 'Unauthorized' });
        req.userId = user.id;
        req.token = token;
        return routers(req, res, next);
    }
});

app.use((req, res, next) => {
    res.status(404).send("404 | not found")
});

app.use((req, res, nex) => {
    res.status(500).send("500 | server error")
})

app.listen(port, () => {
    console.log(`server berjalan di port ${port}`.yellow);
})

const Server = { app }
module.exports = Server
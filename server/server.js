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
        const deviceId = req.headers.deviceid;
        if (!deviceId || deviceId == "") {
            console.log("Unauthorized A");
            return res.status(401).json({ message: 'Unauthorized A' });
        }
        // var bytes = CryptoJS.AES.decrypt(token, '123456');
        // var devId = bytes.toString(CryptoJS.enc.Utf8);
        const dev = await prisma.defaultPreference.findUnique({
            where: {
                deviceId: deviceId
            },
            select: {
                userId: true,
                companyId: true,
                outletId: true,
                deviceId: true
            }
        })

        if (!dev) {
            console.log("Unauthorized B");

            return res.status(401).json({ message: 'Unauthorized B' });
        }

        req.userId = dev.userId;
        req.companyId = dev.companyId;
        req.outletId = dev.outletId;
        req.deviceId = dev.deviceId;

        req.token = deviceId;
        req.cod = {
            userId: dev.userId,
            companyId: dev.companyId,
            outletId: dev.outletId,
            deviceId: dev.deviceId
        };
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
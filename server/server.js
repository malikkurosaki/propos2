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
app.use((req, res, next) => {
    if (req.url.includes('login')) {
        return routers(req, res, next);
    } else {
        const { userid, companyid, outletid } = req.headers;
        if (!userid || !companyid || !outletid) {

            let info = {
                userId: userid,
                companyid: companyid,
                outletid: outletid,
                url: req.url
            }

            console.log(info);
            return res.status(401).send('401 | unauthorized');
        }
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
const routerGambar = require('express').Router();
const path = require('path');
const fs = require('fs');

routerGambar.get("/product-image/:name", (req, res) => {
    let name = req.params.name;
    const target = path.join(__dirname, `./uploads/${name}`)

    // console.log(target);
    if (fs.existsSync(target)) {
        res.type('image/png').sendFile(target);
    } else {
        // console.log("ini ada dimana");
        res
            .type("image/png")
            .sendFile(path.join(__dirname, `./assets/def/no_image.png`));
    }
});

module.exports = routerGambar;
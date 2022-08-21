#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;

require('prompts')({
    type: "text",
    name: "nama",
    message: "masukkan nama menu yang ingin anda buat"
}).then(({ nama }) => {
    if (nama == undefined || _.isEmpty(nama)) return console.log("anda tidak memasukkan nama menu".red);

    const target = path.join(__dirname, `./../con/${_.snakeCase(nama)}.js`);
    if (fs.existsSync(target)) return console.log("menu sudah ada".red);

    const template = `
    #!/usr/bin/env node
    const fs = require('fs');
    const path = require('path');
    const colors = require('colors');
    const execSync = require('child_process').execSync;
    const _ = require('lodash');
    const beautify = require('js-beautify').js_beautify;
    const prompts = require("prompts");
    `;

    fs.writeFileSync(target, beautify(template, { indent_size: 2 }));
    console.log(`menu ${nama} berhasil dibuat`.green);

})
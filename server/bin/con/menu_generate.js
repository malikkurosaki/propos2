#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;
const prompts = require("prompts");

// static final listMenu[\S\s]*?;

const target = fs.readdirSync(path.join(__dirname, "./../../../client/lib/menus"), 'utf8');
const targetFile = fs.readFileSync(path.join(__dirname, "./../../../client/lib/menus.dart"), 'utf8').toString();
const regex = /static final listMenu[\S\s]*?;/g;

const listItem = [];
const listImport = [];

for (let itm of target) {

    if (!targetFile.includes(_.upperFirst(_.camelCase(itm.split('.')[0])))) {

        listItem.push(`
        {
            "title": "${_.upperFirst(_.camelCase(itm.split('.')[0]))}",
            "display": ${_.upperFirst(_.camelCase(itm.split('.')[0]))}(),
            "icon": Icons.pix_rounded,
        }
    `);

        listImport.push(`import './${itm.split('.')[0]}';`);
    }
}

let cari = targetFile.match(regex);
let hasil = cari[0].replace('];', `,${listItem.join(',')}];`);
let maka = targetFile.replace(cari[0], hasil);

fs.writeFileSync(path.join(__dirname, "./../../../client/lib/menus.dart"), beautify(maka));

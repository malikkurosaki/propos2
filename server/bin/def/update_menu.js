#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;

const targetnya = fs.readdirSync(path.join(__dirname, './../con'));

require('prompts')({
    type: "select",
    name: "menu",
    message: "pilih menu yang ingin anda update",
    choices: targetnya.map(e => {
        return {
            title: e.replace('.js', '').replace('_', ' '),
            value: e
        }
    }
    )
}).then(({ menu }) => {
    if (menu == undefined) return console.log("anda tidak memilih apapun".red);
    require('prompts')({
        type: "text",
        name: "nama",
        message: "masukkan nama menu yang ingin anda buat"
    }).then(({ nama }) => {
        if (nama == undefined || _.isEmpty(nama)) return console.log("anda tidak memasukkan nama menu".red);

        const target = path.join(__dirname, `./../con/${_.snakeCase(nama)}.js`);
        if (fs.existsSync(target)) return console.log("menu sudah ada".red);

        execSync(`mv ${path.join(__dirname, `./../con/${menu}`)} ${target}`);
        console.log(`menu ${menu.replace('.js', '')} berhasil diupdate ke ${nama}`.green);

    })
})
#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;

const targetnya = fs.readdirSync(path.join(__dirname, './../con'));

require('prompts')({
    type: "multiselect",
    name: "targets",
    message: "pilih menu yang ingin anda hapus",
    choices: targetnya.map(e => {
        return {
            title: e.replace('.js', '').replace('_', ' '),
            value: e
        }
    })
}).then(({ targets }) => {
    if (targets == undefined) return console.log("anda tidak memilih apapun".red);
    targets.forEach(e => {
        fs.unlinkSync(path.join(__dirname, `./../con/${e}`));
        console.log(`${e.replace('.js', '')} berhasil dihapus`.green);
    });
    
})

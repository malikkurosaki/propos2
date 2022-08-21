#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');


require('prompts')({
    type: "text",
    name: "perintah",
    message: "masukkan perintahnya"
}).then(({ perintah }) => {
    if (perintah == undefined || _.isEmpty(perintah)) return console.log("tidak bisa kosong".red)
    execSync(perintah, { stdio: "inherit", cwd: path.join(__dirname, './../../../client') })
})
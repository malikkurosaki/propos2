#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify

// DATABASE_URL="postgresql://johndoe:randompassword@localhost:5432/mydb?schema=public"

require('prompts')([
    {
        type: "text",
        name: "user",
        message: "user name"
    },
    {
        type: "text",
        name: "password",
        message: "password"
    },
    {
        type: "text",
        name: "database",
        message: "database"
    }
]).then((data) => {
    if(Object.values(data).includes("")) return console.log("jangan ada yang kosong".red)
    const template = `DATABASE_URL="mysql://${data.user}:${data.password}@localhost:3306/${data.database}"`
    fs.writeFileSync(path.join(__dirname, './../../.env'), beautify(template))
})
#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;
const prompts = require("prompts");

let tem = `
class Conf {
    static
    const host = "http://192.168.43.112:3000";
}
`

fs.writeFileSync(path.join(__dirname, '../../../client/lib/utils/conf.dart'), beautify(tem, { indent_size: 2 }));
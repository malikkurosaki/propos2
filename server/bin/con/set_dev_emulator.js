#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;
const prompts = require("prompts");

// 10.0.2.2

let tem = `
class Conf {
    static
    const host = "http://10.0.2.2:3000";
}
`

fs.writeFileSync(path.join(__dirname, '../../../client/lib/utils/conf.dart'), beautify(tem, { indent_size: 2 }));
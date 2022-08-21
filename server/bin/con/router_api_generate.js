#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;
const prompts = require("prompts");


const regex = /'\/[\S\s]*?'/g;
const regex2 = /\/\/.start.*[\S\s]*\/\/.end/g;
const target = fs.readFileSync(path.join(__dirname, "./../../router_api.js"), 'utf8').toString();
const target2 = fs.readFileSync(path.join(__dirname, "./../../../client/lib/utils/router_api.dart"), 'utf8').toString();
const hasil = target.match(regex).map(itm => itm.replace(/'/g, '')).map(itm => {
    let con = "${Conf.host}"
    let qy = "${query ?? ''}"
    let userId = "${Vl.userId.val}"
    let company = "${Vl.companyId.val}"
    let outlet = "${Vl.outletId.val}"
    return `RouterApi.${_.camelCase(itm)}({String? query}) : _uri = Uri.parse("${con}/api${itm}?userId=${userId}&companyId=${company}&outletId=${outlet}&${qy}");`
});

let template = target2.replace(regex2, `// start \n ${hasil.join('')} \n // end`);



fs.writeFileSync(path.join(__dirname, "./../../../client/lib/utils/router_api.dart"), beautify(template));
console.log('RouterApi has been created'.green);


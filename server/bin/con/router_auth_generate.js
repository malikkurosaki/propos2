#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;
const prompts = require("prompts");


const regex = /'\/[\S\s]*?'/g;
const target = fs.readFileSync(path.join(__dirname, "./../../router_auth.js"), 'utf8').toString();
const hasil = target.match(regex).map(itm => itm.replace(/'/g, '')).map(itm => {
    let con = "${Conf.host}"
    return `
    static Future<http.Response> ${_.camelCase(itm)}(Map body) => http.post(Uri.parse("${con}/auth${itm}"),body: body);
    `
});

let template = `
import 'package:http/http.dart' as http;
import 'package:propos/utils/conf.dart';

class RouterAuth{
  ${hasil.join('')}
}
`;

fs.writeFileSync(path.join(__dirname, "./../../../client/lib/utils/router_auth.dart"), beautify(template));
console.log('RouterAuth has been created'.green);


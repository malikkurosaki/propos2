#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;
const prompts = require("prompts");

const target = fs.readdirSync(path.join(__dirname, './../../../client/lib/pages'));

let listItm = [];
let listImport = [];
let listWidget = [];
for (let itm of target.map(e => e.split('.')[0])) {
    if (itm.includes('root')) {
        listItm.push(`Pages.${_.camelCase(itm)}() : route = "/";`)
        listWidget.push(`GetPage(
            name: "/",
            page: () => ${_.upperFirst(_.camelCase(itm))}(),
        )`)
    } else {
        listItm.push(`Pages.${_.camelCase(itm)}() : route = "/${itm}";`)

        listWidget.push(`GetPage(
            name: "/${itm}",
            page: () => ${_.upperFirst(_.camelCase(itm))}(),
        )`)
    }

    listImport.push(`import './pages/${itm}.dart';`)

}

let template = `
import 'package:get/route_manager.dart';
${listImport.join('\n')}

${listImport.join('\n')}
class Pages {
  late String route;

  ${listItm.join('\n')}

  static final listPage = <GetPage>[
    ${listWidget.join(',\n')}
  ];
  
}
`

fs.writeFileSync(path.join(__dirname, `./../../../client/lib/pages.dart`), beautify(template, { indent_size: 2 }));
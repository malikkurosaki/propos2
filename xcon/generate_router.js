
const fs = require('fs');
const path = require('path');
const _ = require('lodash');
const beautify = require('js-beautify');

const sourceDir = path.join(__dirname, "./../server/routers");
const listSource = fs.readdirSync(sourceDir);

const targetFile = path.join(__dirname, "../client/lib/rot.dart")

let listRouter = [];

for (let itm of listSource) {
  let dir = path.join(sourceDir, itm);
  let listDir = fs.readdirSync(dir);
  for (let itmDir of listDir) {
    let name = path.parse(itmDir).name;
    let method = path.parse(itmDir).name.split('_').splice(-1);
    let host = "${Config.host}"
    let query = "${query??''}";
    let body = "body: body"
    let data = `static Future<http.Response> ${_.camelCase(name)}({String? query, String? body}) => http.${method}(Uri.parse("${host}/${_.kebabCase(name)}?${query}"), headers: Vl.headers, ${method != 'get' ? body : ''});`
    listRouter.push(data);
  }

}

let tmp = `
import 'package:http/http.dart' as http;
import 'package:propos/utils/config.dart';
import 'package:propos/utils/vl.dart';

class Rot{
  ${listRouter.join('')}
}
`

fs.writeFileSync(targetFile, beautify(tmp));
console.log("generate router completed")
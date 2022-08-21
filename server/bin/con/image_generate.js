#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;
const prompts = require("prompts");

const target = fs.readdirSync(path.join(__dirname, './../../assets/def'));
const result = path.join(__dirname, './../../../client/lib/utils/img_def.dart');

let hasil = [];
for (let e of target) {
    let conf = "${Conf.host}";
    hasil.push(`
     static Widget ${_.camelCase(e.split('.')[0])}({double? width, double? height, BoxFit? fit}){
        return CachedNetworkImage(imageUrl: "${conf}/img/def/${e}", width: width, height: height, fit: fit);
     }
    `)
}

const template =
    `
import 'package:cached_network_image/cached_network_image.dart';
import 'package:propos/utils/conf.dart';
import 'package:flutter/material.dart';

class ImgDef {
  ${hasil.join('\n')}

}

`

fs.writeFileSync(result, beautify(template))
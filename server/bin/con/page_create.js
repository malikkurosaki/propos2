#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;
const prompts = require("prompts");

const target = fs.readdirSync(path.join(__dirname, './../../../client/lib/pages'))

prompts({
    type: "text",
    name: "name",
    message: "masukkan nama page yang ingin anda buat"
}).then(({ name }) => {
    if (name == undefined) return console.log("anda tidak memasukkan nama page".red);
    if (target.includes(_.snakeCase(name) + "_page.dart")) return console.log("nama page yang anda masukkan sudah ada".red);

    let template = `
    import 'package:flutter/material.dart';
    import 'package:responsive_builder/responsive_builder.dart';

    class ${_.upperFirst(_.camelCase(name))}Page extends StatelessWidget {
    const ${_.upperFirst(_.camelCase(name))}Page({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return ResponsiveBuilder(builder: (context, media) {
        return SafeArea(
            child: ListView(
            children: [
                Text('Hello World'),
            ],
            ),
        );
        });
    }
    }

`

    fs.writeFileSync(path.join(__dirname, `./../../../client/lib/pages/${_.snakeCase(name)}_page.dart`), beautify(template, { indent_size: 2 }));
    execSync(`node page_generate.js`, { stdio: "inherit", cwd: path.join(__dirname, './../con/') });
    console.log("page berhasil dibuat".green);
})
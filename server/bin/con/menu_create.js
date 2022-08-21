#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;
const prompts = require("prompts");

prompts({
    type: 'text',
    name: 'name',
    message: 'What is the name of the menu?',
}).then(({ name }) => {

    if (name == undefined) return console.log('Name is required'.red);
    let target = path.join(__dirname, `../../../client/lib/menus/${name}.dart`);
    if (fs.existsSync(target)) return console.log(`Menu ${name} already exists`.red);

    const template = `
    import 'package:flutter/material.dart';
    import 'package:responsive_builder/responsive_builder.dart';

    class ${_.upperFirst(_.camelCase(name))} extends StatelessWidget {
    const ${_.upperFirst(_.camelCase(name))}({
        Key ? key
    }): super(key: key);

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
    fs.writeFileSync(path.join(__dirname, `../../../client/lib/menus/${name}.dart`), beautify(template))
    execSync(`node menu_generate.js`, { stdio: 'inherit' , cwd: path.join(__dirname, './')});
    console.log(`Menu ${name} has been created`.green);
})
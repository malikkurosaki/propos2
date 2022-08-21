#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const def = fs.readdirSync(path.join(__dirname, './def'));
const con = fs.readdirSync(path.join(__dirname, './con'));
var figlet = require('figlet');

figlet('Xpropos', {
    font: 'Swan',
}, function (err, data) {
    if (err) {
        console.log('Something went wrong...');
        console.dir(err);
        return;
    }
    console.log(`
${data}
==================================
@malikkurosaki              v1.0.0
    `.green);


    // console.log(`                     
    //  _____                     
    // |  _  |___ ___ ___ ___ ___ 
    // |   __|  _| . | . | . |_ -|
    // |__|  |_| |___|  _|___|___|
    //               |_|          
    // ===========================
    // @malikkurosaki      v1.0.0
    // `.cyan)

    require('prompts')({
        "type": "autocomplete",
        "name": "menu",
        "message": "pilih alah satu menunya",
        choices: [
            ...def.map(e => {
                return {
                    title: `${e.replace('.js', '').replace('_', ' ').toUpperCase()}`.red,
                    value: {
                        title: `${e.replace('.js', '').replace('_', ' ').toUpperCase()}`,
                        type: 'def',
                        value: e
                    }
                }
            }),
            ...con.map(e => {
                return {
                    title: e.replace('.js', '').replace('_', ' ').toLowerCase(),
                    value: {
                        title: e.replace('.js', '').replace('_', ' ').toLowerCase(),
                        type: 'con',
                        value: e
                    }
                }
            })
        ]
    }).then(({ menu }) => {
        if (menu == undefined) return console.log("anda tidak memilih apapun".red);

        figlet(menu.title,{
            font: "Calvin S"
        }, function (err, data) {
            console.log(data);

            execSync(`node ${menu.value}`, { stdio: 'inherit', cwd: path.join(__dirname, `./${menu.type}`) });
        })
    });

})
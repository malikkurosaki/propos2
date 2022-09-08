#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const exec = require('child_process').execSync;
const _ = require('lodash');


const ini = exec(`git branch`).toString().split("\n").find((e) => e.indexOf('*') === 0).toString().split(' ')[1].trim();
exec(`git add . && git commit -m "update && git push origin ${ini}"`);
console.log("git push completed");


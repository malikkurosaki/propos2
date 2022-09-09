#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const exec = require('child_process').execSync;
const _ = require('lodash');

const branch = exec(`git branch`).toString().split("\n").find((e) => e.indexOf('*') === 0).toString().split(' ')[1].trim();
exec(`git add . && git commit -m "update && git push origin ${branch}"`, { stdio: "inherit", cwd: path.resolve(__dirname, '../') });
console.log(`git push completed branch ${branch}`);

#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;


console.log(`

┌┬┐┬┌─┐┬─┐┌─┐┌┬┐┌─┐
│││││ ┬├┬┘├─┤ │ ├┤ 
┴ ┴┴└─┘┴└─┴ ┴ ┴ └─┘

`.yellow)
execSync('npx prisma migrate dev --name "$(date)"', { stdio: 'inherit' , cwd: path.join(__dirname, '../../')});
#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');

execSync(`nodemon .`, { stdio: 'inherit', cwd: path.join(__dirname, './../../../server') });
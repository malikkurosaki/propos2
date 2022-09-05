// .*\sProduct\s\{[\s\S]+?\}$
const path = require('path');
const fs = require('fs');
const rx = 'model Product \{[\n]';

const target = fs.readFileSync(path.join(__dirname, "./../server/prisma/schema.prisma")).toString();
const filter = target.match(/model\sProduct\s{[\s\S]+?\}/g)
const filter2 = filter[0].replace(/\{|\}/g, '');

console.log(filter2[0]);
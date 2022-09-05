const _ = require('lodash');
const b = require('js-beautify')
const fs = require('fs');

let model = {
    "nama": "",
    "umur": 2,
    "alamat": {},
    "pekerjaan": [],
    "wanita": false
}

let data = [];
let keys = Object.keys(model);
let comper = []
for (let m of keys) {
    if (_.isString(model[m])) {
        data.push(`String? ${m};`)
    } else if (_.isArray(model[m])) {
        data.push(`List? ${m};`)
    } else if (_.isObject(model[m])) {
        data.push(`Map? ${m};`)
    } else if (_.isInteger(model[m])) {
        data.push(`int? ${m};`)
    } else if (_.isBoolean(model[m])) {
        data.push(`bool? ${m};`)
    }

    comper.push(`
        if(${m} != null) data['${m}'] = ${m};
    `)
}

let hasil = `
class Model {
    ${data.join('\n')}
    Model({
        ${keys.map(e => `this.${e}`).join(',')}
    });

    toJson(){
        final data = {};
        ${comper.join("")}
        return data;
    }
}
`;

fs.writeFileSync('./model.dart', b.js(hasil));


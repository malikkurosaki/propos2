const exec = require('child_process').execSync;
const path = require('path');
const prompts = require('prompts');
const _ = require('lodash');

prompts({
    type: "text",
    name: "branch",
    message: "masukkan nama branchnya"
}).then(({ branch }) => {
    if (!branch || _.isEmpty(branch)) return console.log("ok dah");
    exec(`git checkout -b ${branch}`, { stdio: "inherit", cwd: path.join(__dirname, "./../../") })
})
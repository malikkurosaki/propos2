const exec = require('child_process').execSync
const path = require("path");

exec(`git add . && git commit -m "update" && git push origin alfa/1`, { stdio: "inherit", cwd: path.resolve(__dirname, '../') });
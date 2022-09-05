const exec =require('child_process').execSync
exec(`git add . && git commit -m "update" && git push`);
const admin = require("firebase-admin");
const path = require('path');
const serviceAccount = require(path.join(__dirname, "./key.json"));
const app = admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://malikkurosaki1985.firebaseio.com"
});

const db = app.database();

module.exports = db;
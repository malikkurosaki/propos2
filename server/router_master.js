const Master = require('./con/master');
const routerMaster = require('express').Router();

routerMaster.get('/jenis-usaha', Master.jenisUsaha);
routerMaster.get('/order-status', Master.orderStatus);

module.exports = routerMaster;
const Login = require('./con/login');
const Register = require('./con/register');
const RegisterDetail = require('./con/register_detail');
const routerAuth = require('express').Router();

routerAuth.post('/register', Register.sekarang);
routerAuth.post('/login', Login.sekarang);
routerAuth.post('/register-detail', RegisterDetail.sekarang);

module.exports = routerAuth;
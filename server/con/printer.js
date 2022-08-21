const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const expressAsyncHandler = require("express-async-handler");
const escpos = require('escpos');
escpos.Serial = require('escpos-serialport');
escpos.USB = require('escpos-usb');

const bluetooth = expressAsyncHandler(async (req, res, next) => {

 

    res.status(200).json({
        success: true,
    });
});

const Printer = { bluetooth };
module.exports = Printer;
#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const colors = require('colors');
const execSync = require('child_process').execSync;
const _ = require('lodash');
const beautify = require('js-beautify').js_beautify;
const prompts = require("prompts");
const PrismaClient = require('@prisma/client').PrismaClient;
const prisma = new PrismaClient();

let mRole = ["owner", "employee", "admin", "superuser"];
let mJenisUsaha = [
    "warung",
    "restoran",
    "hotel",
    "kafe",
    "barber shop",
    "beauty salon",
    "spa",
    "klinik",
    "laundry",
    "toko",
    "bengkel",
    "konter hp",
    "lainnya"
];

let mOrderStatus = [
    "pending",
    "on progress",
    "done",
    "cancel"
];

async function generateMrole() {
    let idUsrRole = 1;

    for (let itm of mRole) {
        await prisma.mRole.upsert({
            where: {
                id: idUsrRole.toString()
            },
            update: {
                name: itm
            },
            create: {
                id: idUsrRole.toString(),
                name: itm
            }
        });

        idUsrRole++;
    }

    console.log("seed userRole success".green);
}

async function generateMjenisUsaha() {
    let idUsrJenisUsaha = 1;
    for (let itm of mJenisUsaha) {
        await prisma.mJenisUsaha.upsert({
            where: {
                id: idUsrJenisUsaha.toString()
            },
            update: {
                name: itm
            },
            create: {
                id: idUsrJenisUsaha.toString(),
                name: itm
            }
        });

        idUsrJenisUsaha++;
    }

    console.log("seed userJenisUsaha success".green);
}

async function generateMorderStatus() {
    let idUsrOrderStatus = 1;
    for (let itm of mOrderStatus) {
        await prisma.mOrderStatus.upsert({
            where: {
                id: idUsrOrderStatus.toString()
            },
            update: {
                name: itm
            },
            create: {
                id: idUsrOrderStatus.toString(),
                name: itm
            }
        });

        idUsrOrderStatus++;
    }

    console.log("seed userOrderStatus success".green);
}


async function main() {
    await generateMrole();
    await generateMjenisUsaha();
    await generateMorderStatus();
}
main();
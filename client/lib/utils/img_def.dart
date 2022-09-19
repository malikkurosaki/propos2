import 'package:cached_network_image/cached_network_image.dart';
import 'package:propos/utils/config.dart';
import 'package:flutter/material.dart';

class ImgDef {

    static Widget bgLogin({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/bg_login.jpeg", width: width, height: height, fit: fit);
    }


    static Widget cartEmpty({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/cart_empty.png", width: width, height: height, fit: fit);
    }


    static Widget empty({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/empty.png", width: width, height: height, fit: fit);
    }


    static Widget forgotPasswordIllustration65141418({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/forgot-password-illustration_65141-418.png", width: width, height: height, fit: fit);
    }


    static Widget homeHeader({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/home_header.png", width: width, height: height, fit: fit);
    }


    static Widget loading({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/loading.png", width: width, height: height, fit: fit);
    }


    static Widget login({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/login.png", width: width, height: height, fit: fit);
    }


    static Widget noImage({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/no_image.png", width: width, height: height, fit: fit);
    }


    static Widget probusSystem({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/probus_system.png", width: width, height: height, fit: fit);
    }


    static Widget register({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/register.png", width: width, height: height, fit: fit);
    }


    static Widget registrationDetail({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/registration_detail.png", width: width, height: height, fit: fit);
    }


    static Widget signupPage({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/signup-page.png", width: width, height: height, fit: fit);
    }


    static Widget wellcome({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Config.host}/img/def/wellcome.png", width: width, height: height, fit: fit);
    }


}
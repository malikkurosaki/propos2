import 'package:cached_network_image/cached_network_image.dart';
import 'package:propos/utils/conf.dart';
import 'package:flutter/material.dart';

class ImgDef {

    static Widget forgotPasswordIllustration65141418({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Conf.host}/img/def/forgot-password-illustration_65141-418.png", width: width, height: height, fit: fit);
    }


    static Widget login({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Conf.host}/img/def/login.png", width: width, height: height, fit: fit);
    }


    static Widget noImage({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Conf.host}/img/def/no_image.png", width: width, height: height, fit: fit);
    }


    static Widget probusSystem({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Conf.host}/img/def/probus_system.png", width: width, height: height, fit: fit);
    }


    static Widget register({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Conf.host}/img/def/register.png", width: width, height: height, fit: fit);
    }


    static Widget registrationDetail({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Conf.host}/img/def/registration_detail.png", width: width, height: height, fit: fit);
    }


    static Widget signupPage({
        double ? width,
        double ? height,
        BoxFit ? fit
    }) {
        return CachedNetworkImage(imageUrl: "${Conf.host}/img/def/signup-page.png", width: width, height: height, fit: fit);
    }


}
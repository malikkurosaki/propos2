import 'package:http/http.dart'
as http;

import 'package:propos/utils/config.dart';

class RouterAuth {

    static Future < http.Response > register(Map body) => http.post(Uri.parse("${Config.host}/auth/register"), body: body);

    static Future < http.Response > login(Map body) => http.post(Uri.parse("${Config.host}/auth/login"), body: body);

    static Future < http.Response > registerDetail(Map body) => http.post(Uri.parse("${Config.host}/auth/register-detail"), body: body);

    static Future < http.Response > loginDevice(Map body) => http.post(Uri.parse("${Config.host}/auth/login-device"), body: body);

    static Future < http.Response > loginCashier(Map body) => http.post(Uri.parse("${Config.host}/auth/login-cashier"), body: body);

}
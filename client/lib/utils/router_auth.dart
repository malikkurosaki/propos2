import 'package:http/http.dart'
as http;
import 'package:propos/utils/conf.dart';

class RouterAuth {

    static Future < http.Response > register(Map body) => http.post(Uri.parse("${Conf.host}/auth/register"), body: body);

    static Future < http.Response > login(Map body) => http.post(Uri.parse("${Conf.host}/auth/login"), body: body);

    static Future < http.Response > registerDetail(Map body) => http.post(Uri.parse("${Conf.host}/auth/register-detail"), body: body);

    static Future < http.Response > loginDevice(Map body) => http.post(Uri.parse("${Conf.host}/auth/login-device"), body: body);

}
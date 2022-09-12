import 'package:http/http.dart'
as http;

import 'package:propos/utils/config.dart';

class RouterMaster {

    static Future < http.Response > jenisUsaha() => http.get(Uri.parse("${Config.host}/master/jenis-usaha"));

    static Future < http.Response > orderStatus() => http.get(Uri.parse("${Config.host}/master/order-status"));

}
import 'package:http/http.dart'
as http;
import 'package:propos/utils/conf.dart';

class RouterMaster {

    static Future < http.Response > jenisUsaha() => http.get(Uri.parse("${Conf.host}/master/jenis-usaha"));

    static Future < http.Response > orderStatus() => http.get(Uri.parse("${Conf.host}/master/order-status"));

}
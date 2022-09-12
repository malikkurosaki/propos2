import 'package:http/http.dart'
as http;
import 'package:propos/utils/config.dart';
import 'package:propos/utils/vl.dart';

class Rot {
    static Future < http.Response > loginListCompanyByUserIdGet({
        String ? query
    }) => http.get(Uri.parse("${Config.host}/login-list-company-by-user-id-get?${query??''}"), headers: Vl.headers);
    static Future < http.Response > productListCompanyGet({
        String ? query
    }) => http.get(Uri.parse("${Config.host}/product-list-company-get?${query??''}"), headers: Vl.headers);
    static Future < http.Response > productListOutletByCompanyIdGet({
        String ? query
    }) => http.get(Uri.parse("${Config.host}/product-list-outlet-by-company-id-get?${query??''}"), headers: Vl.headers);
    static Future < http.Response > productListOutletGet({
        String ? query
    }) => http.get(Uri.parse("${Config.host}/product-list-outlet-get?${query??''}"), headers: Vl.headers);
}
import 'package:http/http.dart'
as http;
import 'package:propos/utils/config.dart';
import 'package:propos/utils/vl.dart';

class Rot {
    static Future < http.Response > billNumberGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/bill-number-get?${query??''}"), headers: Vl.headers, );
    static Future < http.Response > customerCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/customer-create-post?${query??''}"), headers: Vl.headers, body: body);
    static Future < http.Response > loginListCompanyByUserIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/login-list-company-by-user-id-get?${query??''}"), headers: Vl.headers, );
    static Future < http.Response > loginListDeviceByOutletGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/login-list-device-by-outlet-get?${query??''}"), headers: Vl.headers, );
    static Future < http.Response > loginListOutletByCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/login-list-outlet-by-company-get?${query??''}"), headers: Vl.headers, );
    static Future < http.Response > productCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/product-create-post?${query??''}"), headers: Vl.headers, body: body);
    static Future < http.Response > productDefaultGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-default-get?${query??''}"), headers: Vl.headers, );
    static Future < http.Response > productListCategoryByCompanyIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-category-by-company-id-get?${query??''}"), headers: Vl.headers, );
    static Future < http.Response > productListCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-company-get?${query??''}"), headers: Vl.headers, );
    static Future < http.Response > productListOutletByCompanyIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-outlet-by-company-id-get?${query??''}"), headers: Vl.headers, );
    static Future < http.Response > productListOutletGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-outlet-get?${query??''}"), headers: Vl.headers, );
}
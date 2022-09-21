import 'package:http/http.dart'
as http;
import 'package:propos/utils/config.dart';
import 'package:propos/utils/vl.dart';

class Rot {
    static Future < http.Response > cashierListCustomerGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/cashier-list-customer-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > cashierListDiscountGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/cashier-list-discount-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > billNumberGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/bill-number-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > customerCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/customer-create-post?${query??''}"), headers: {
        "token": Vl.token.val
    }, body: body);
    static Future < http.Response > homeCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/home-company-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > homeDrawerHeaderGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/home-drawer-header-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > homeUserGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/home-user-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > lgnListCompanyByUserIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/lgn-list-company-by-user-id-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > lgnListDeviceByOutletGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/lgn-list-device-by-outlet-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > lgnListOutletByCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/lgn-list-outlet-by-company-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > lgnSetDefaultPost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/lgn-set-default-post?${query??''}"), headers: {
        "token": Vl.token.val
    }, body: body);
    static Future < http.Response > loginPost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/login-post?${query??''}"), headers: {
        "token": Vl.token.val
    }, body: body);
    static Future < http.Response > productCreateIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-create-id-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > productCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/product-create-post?${query??''}"), headers: {
        "token": Vl.token.val
    }, body: body);
    static Future < http.Response > productDefaultGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-default-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > productListCategoryByCompanyIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-category-by-company-id-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > productListCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-company-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > productListOutletByCompanyIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-outlet-by-company-id-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
    static Future < http.Response > productListOutletGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-outlet-get?${query??''}"), headers: {
        "token": Vl.token.val
    }, );
}
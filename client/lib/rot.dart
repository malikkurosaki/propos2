import 'package:http/http.dart'
as http;
import 'package:propos/utils/config.dart';
import 'package:propos/utils/vl.dart';

class Rot {
    static Future < http.Response > cashierListCategoryGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/cashier-list-category-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > cashierListCustomerGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/cashier-list-customer-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > cashierListDiscountGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/cashier-list-discount-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > cashierListProductGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/cashier-list-product-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > cashierProductSearchGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/cashier-product-search-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > categoryCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/category-create-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > categoryListCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/category-list-company-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > categoryListGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/category-list-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > categoryRemoveDelete({
        String ? query,
        Map ? body
    }) => http.delete(Uri.parse("${Config.host}/category-remove-delete?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > billNumberGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/bill-number-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > checkoutBillCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/checkout-bill-create-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > checkoutCashGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/checkout-cash-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > checkoutCodGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/checkout-cod-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > checkoutCodNameGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/checkout-cod-name-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > checkoutListPaymentMethodGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/checkout-list-payment-method-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > checkoutStockUpdatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/checkout-stock-update-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > customPriceCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/custom-price-create-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > customPriceListCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/custom-price-list-company-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > customPriceListGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/custom-price-list-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > customerCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/customer-create-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > customerListCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/customer-list-company-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > customerListCustomerGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/customer-list-customer-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > homeCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/home-company-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > homeDrawerHeaderGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/home-drawer-header-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > homeUserGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/home-user-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > lgnCodCountGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/lgn-cod-count-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > lgnListDeviceByOutletGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/lgn-list-device-by-outlet-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > lgnListOutletByCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/lgn-list-outlet-by-company-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > lgnSetDefaultPost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/lgn-set-default-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > loginListCompanyByUserIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/login-list-company-by-user-id-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > loginPost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/login-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > loginSetDefaultPrefPost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/login-set-default-pref-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > paymentMethodCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/payment-method-create-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > paymentMethodListPaymentMethodGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/payment-method-list-payment-method-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > paymentMethothListCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/payment-methoth-list-company-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > productCreateIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-create-id-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > productCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/product-create-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > productDefaultGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-default-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > productListCategoryByCompanyIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-category-by-company-id-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > productListCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-company-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > productListOutletByCompanyIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-outlet-by-company-id-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > productListOutletGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-outlet-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > productRemoveDelete({
        String ? query,
        Map ? body
    }) => http.delete(Uri.parse("${Config.host}/product-remove-delete?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > reportListGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/report-list-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > reportRangeDateGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/report-range-date-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
}
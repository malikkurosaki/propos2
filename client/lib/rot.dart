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
    static Future < http.Response > categoryListByCompanyIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/category-list-by-company-id-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
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
    static Future < http.Response > categoryUpdatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/category-update-post?${query??''}"), headers: {
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
    static Future < http.Response > companyCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/company-create-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > companyListCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/company-list-company-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > companyUpdatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/company-update-post?${query??''}"), headers: {
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
    static Future < http.Response > customPriceUpdatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/custom-price-update-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
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
    static Future < http.Response > customerUpdatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/customer-update-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > deviceCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/device-create-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > deviceListGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/device-list-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > deviceUpdatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/device-update-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > discountCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/discount-create-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > discountDelete({
        String ? query,
        Map ? body
    }) => http.delete(Uri.parse("${Config.host}/discount-delete?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > discountListGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/discount-list-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > discountModelGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/discount-model-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > discountUpdatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/discount-update-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > employeeCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/employee-create-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > employeeListByCompanyIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/employee-list-by-company-id-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > employeeListGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/employee-list-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > employeeUpdatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/employee-update-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > globalCodGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/global-cod-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > globalListCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/global-list-company-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > globalListOutletByProductIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/global-list-outlet-by-product-id-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > globalOutletListByCompanyIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/global-outlet-list-by-company-id-get?${query??''}"), headers: {
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
    static Future < http.Response > outletCreatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/outlet-create-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > outletListOutletByBompanyIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/outlet-list-outlet-by-bompany-id-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > outletListOutletGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/outlet-list-outlet-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > outletUpdatePost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/outlet-update-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > paymentMethodActivatePut({
        String ? query,
        Map ? body
    }) => http.put(Uri.parse("${Config.host}/payment-method-activate-put?${query??''}"), headers: {
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
    static Future < http.Response > productListStockByProductIdByOutletIdGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-list-stock-by-product-id-by-outlet-id-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > productRemoveDelete({
        String ? query,
        Map ? body
    }) => http.delete(Uri.parse("${Config.host}/product-remove-delete?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > productSearchByCompanyGet({
        String ? query,
        Map ? body
    }) => http.get(Uri.parse("${Config.host}/product-search-by-company-get?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, );
    static Future < http.Response > productUpdateAvailableStockPost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/product-update-available-stock-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > productUpdateDefaultPost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/product-update-default-post?${query??''}"), headers: {
        "deviceId": Vl.deviceId.val
    }, body: body);
    static Future < http.Response > productUpdateOutletPost({
        String ? query,
        Map ? body
    }) => http.post(Uri.parse("${Config.host}/product-update-outlet-post?${query??''}"), headers: {
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
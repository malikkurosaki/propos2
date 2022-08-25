import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart'
as http;
import 'package:propos/utils/conf.dart';
import 'package:propos/utils/vl.dart';

class RouterApi {
    late Uri _uri;

    // start 
    RouterApi.getUserDataById({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/get-user-data-by-id?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.getUser({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/get-user?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.listCompany({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/list-company?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.companyCreate({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/company-create?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.companySingle({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/company-single?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.listOutlet({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/list-outlet?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.outletCreate({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/outlet-create?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.outletDelete({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/outlet-delete?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.outletUpdate({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/outlet-update?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.outletGetByCompany({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/outlet-get-by-company?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.outletCompanyList({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/outlet-company-list?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.outletByCompanyId({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/outlet-by-company-id?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.outletSingle({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/outlet-single?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.listCategory({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/list-category?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.createCategory({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/create-category?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.categoryDelete({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/category-delete?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.categoryUpdate({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/category-update?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.categoryGetByCompany({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/category-get-by-company?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.categoryByCompanyId({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/category-by-company-id?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.productList({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/product-list?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.productCreate({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/product-create?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.productDelete({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/product-delete?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.productUpdate({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/product-update?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.productGetByCategory({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/product-get-by-category?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.productSearch({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/product-search?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.productCreateSelect({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/product-create-select?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.productByUserId({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/product-by-user-id?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.listProduct({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/list-product?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.paymentMethodList({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/payment-method-list?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.paymentMethodCreate({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/payment-method-create?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.billCreate({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/bill-create?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.printerBluetooth({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/printer-bluetooth?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.deviceList({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/device-list?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.deviceCreate({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/device-create?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.deviceDelete({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/device-delete?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.deviceByUser({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/device-by-user?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.productMenuGetPropertyByCompany({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/product-menu/get-property-by-company?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.propertiesCompanyOutlet({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/properties-company-outlet?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.propertiesCompanyOutletCategory({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/properties-company-outlet-category?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.propertiesCategoryWithOutletOrNull({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/properties-category-with-outlet-or-null?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.drawerHeader({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/drawer-header?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.listEmployee({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/list-employee?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.employeeDelete({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/employee-delete?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.createEmployee({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/create-employee?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.employeeUpdate({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/employee-update?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.employeeByUser({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/employee-by-user?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.customerCreate({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/customer-create?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    RouterApi.custoemerGetList({
        String ? query
    }): _uri = Uri.parse("${Conf.host}/api/custoemer-getList?userId=${Vl.userId.val}&companyId=${Vl.companyId.val}&outletId=${Vl.outletId.val}&${query ?? ''}");
    // end

    // Future < String > getData() async {
    //     final data = await http.get(_uri);
    //     if (data.statusCode == 200) {
    //         return data.body;
    //     } else {
    //         SmartDialog.showToast(data.body);
    //         debugPrint(data.body);
    //         throw Exception('Failed to load get ${_uri.toString()}');
    //     }
    // }
    Future < http.Response > getData() => http.get(_uri);

    Future < http.Response > postData(Map ? body) => http.post(_uri, body: body);

    Future < http.Response > putData(Map ? body) => http.put(_uri, body: body);

    Future < http.Response > deleteData(Map ? body) => http.delete(_uri, body: body);

    Future < dynamic > isOk(Future < http.Response > source) async {
        final data = await source;
        if (data.statusCode == 200 || data.statusCode == 201) {
            return jsonDecode(data.body);
        } else {
            SmartDialog.showToast(data.body);
            debugPrint(data.body);
            throw Exception('Failed to load get ${_uri.toString()}');
        }
    }
}
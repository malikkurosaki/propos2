import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propos/utils/router_api.dart';

class CashierVal {
  static final conSearch = TextEditingController();
  static final restoreOrderName = "".val('Cashier.restoreOrderName').obs;
  // final _listProduct = List.from(ValDef.productList.value.val).val('Cashier.listProduct').obs;
  // final _listCategory = [].obs;
  static final listProduct = [].val("Cashier.lsProduct").obs;
  static final tmpListProduct = [].val("Cashier._tmpListProduct").obs;

  static final isMultipleSelect = false.obs;
  static final lsTampungan = [].obs;

  static final listManualProduct = [].val("CashierVal.listManualProduct").obs;

  static final listCustomer = [].obs;
  static final selectedCustomer = {}.obs;


  static loadProduct() async {
    // final list = await RouterApi.listProduct().getData();
    final listPro = await RouterApi.productCashier().getData();

    if (listPro.statusCode == 200) {
      final lsData = jsonDecode(listPro.body);
      CashierVal.listProduct.value.val = lsData;
      CashierVal.tmpListProduct.value.val = lsData;

      CashierVal.listProduct.refresh();
    }
  }
}

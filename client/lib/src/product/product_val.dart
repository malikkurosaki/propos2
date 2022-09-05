import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propos/src/product/product_model.dart';
import 'package:propos/utils/router_api.dart';

class ProductVal {
  static final keyForm = GlobalKey<FormState>();
  static final productImage = <String, dynamic>{"id": "null", "name": "null"}.obs;
  static final editVal = "".obs;
  static final listPropertyCreate = [].obs;
  static final listCompanyProduct = [].obs;
  static final lsCompany = [].obs;
  static final lsCategory = [].obs;
  static final isCustomPrice = false.obs;
  static final dataCustomPrice = {}.obs;
  static final listCustomPriwce = [].obs;
  static final isLoadingCreateButton = false.obs;
  static final dataStock = ProductModelStock();
  static final dataImage = ProductModelImage();
  static final primary = ProductModelPrimary();
  static final dataDetail = ProductModelDetail();

  static final isCheckAll = false.obs;
  static final listSelected = [].obs;
  static final lsProduct = [];
  static final isShowChecked = false.obs;
  static final company = {};


  static loadProduct() async {
    final data = await RouterApi.productByUserId().getData();
    if (data.statusCode == 200) {
      ProductVal.listCompanyProduct.value = jsonDecode(data.body);
    }
  }

  static onLoad() async {
    loadProduct();
    // final data = await RouterApi.productMenuGetPropertyByCompany().getData();
    // if (data.statusCode == 200) _listPropertyCreate.assignAll(jsonDecode(data.body));
  }


}

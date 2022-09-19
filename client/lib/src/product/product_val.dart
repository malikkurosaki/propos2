import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/product/product_model.dart';
import 'package:propos/utils/router_api.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propos/utils/vl.dart';

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

  static final listCompany = [].val("ProductVal.listCompany").obs;
  static final selectedCompany = {}.val("ProductVal.selectedCompany2").obs;
  static final listProduct = [].obs;

  static final listoutlet = [].obs;
  static final selectedOutlet = {}.obs;

  // new here
  static final listSelectCompany = [].obs;
  static final listSelectOutlet = [].obs;
  static final listSelectCategory = [].obs;

  static final selectCompany = {}.obs;
  static final selectOutlet = {}.obs;
  static final selectedCategory = {}.obs;

  static final listSelectProduct = [].obs;

  // static Future<void> loadListCompany() async {
  //   final res = await Rot.productListCompanyGet();
  //   if (res.statusCode == 200) listCompany.value.val = jsonDecode(res.body);
  //   if (!listCompany.value.val.contains(selectedCompany.value.val)) {
  //     selectedCompany.value.val = listCompany.value.val.where((element) => element['id'] == Vl.companyId.val).first;
  //   }
  // }

  //  static Future<void> loadSelectCompanyList() async {
  //   final res = await Rot.productListCompanyGet();
  //   if (res.statusCode == 200) {
  //     listSelectCompany.value.val = jsonDecode(res.body);
  //     listSelectCompany.refresh();
  //   }
  // }

  static Future<void> loadListOutlet() async {
    final data = await Rot.productListOutletGet();
    // if (data.statusCode == 200) listoutlet.assignAll(jsonDecode(data.body));
    // if (!listoutlet.contains(selectedOutlet)) {
    //   selectedOutlet.assignAll(listoutlet.where((p0) => p0['id'] == Vl.outletId.val).first);
    // }
  }


  static Future<void> loadDefaultProduct() async {
    final data = await Rot.productDefaultGet();
    if (data.statusCode == 200) listSelectProduct.assignAll(jsonDecode((data.body)));
  }

  // static loadProduct() async {
  //   final data = await RouterApi.productByUserId().getData();
  //   if (data.statusCode == 200) {
  //     ProductVal.listCompanyProduct.value = jsonDecode(data.body);
  //   }
  // }

  // static onLoad() async {
  //   loadProduct();
  //   // final data = await RouterApi.productMenuGetPropertyByCompany().getData();
  //   // if (data.statusCode == 200) _listPropertyCreate.assignAll(jsonDecode(data.body));
  // }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/product/product_model.dart';
import 'package:propos/utils/router_api.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propos/utils/vl.dart';

class ProductVal {
  static final isReloadProduct = false.obs;

  // static final keyForm = GlobalKey<FormState>();
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
  // static final lsProduct = [];
  static final isShowChecked = false.obs;
  static final company = {};

  static final listCompany = [].val("ProductVal.listCompany").obs;
  static final selectedCompany = {}.val("ProductVal.selectedCompany2").obs;
  // static final listProduct = [].val("ProductVal.listProduct").obs;

  static final listoutlet = [].obs;
  static final selectedOutlet = {}.obs;

  // new here
  static final listSelectCompany = [].obs;
  static final listSelectOutlet = [].obs;
  static final listSelectCategory = [].obs;

  static final selectCompany = {}.obs;
  static final selectOutlet = {}.obs;
  static final selectedCategory = {}.obs;

  static final listProduct = [].val("ProductVal.listProduct").obs;

  static final mapData = {}.val("ProductVal.mapData").obs;

  // static Future<void> loadListOutlet() async {
  //   final data = await Rot.productListOutletGet();

  // }

  // static Future<void> loadDefaultProduct() async {
  //   final data = await Rot.productDefaultGet();
  //   if (data.statusCode == 200) listSelectProduct.assignAll(jsonDecode((data.body)));
  // }

}

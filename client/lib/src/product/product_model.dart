import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductModelPrimary {
  final conName = TextEditingController();
  final conPrice = TextEditingController();
}

class ProductModelStock {
  final isInclude = false.obs;
  TextEditingController stock = TextEditingController(text: "1");
  TextEditingController minStock = TextEditingController(text: "0");
}

class ProductModelDetail {
  final isInclude = false.obs;
  final companyId = "".obs;
  final categoryId = "".obs;
  final listoutlet = [].obs;
  final des = TextEditingController();
  final modal = TextEditingController();
  final sku = TextEditingController();
  final barcodeId = TextEditingController();
  final berat = TextEditingController();
  final dimensi = TextEditingController();
}

class ProductModelImage {
  final isInclude = false.obs;
  final imageId = "".obs;
  String imageName = "";
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:propos/utils/val.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:short_uuids/short_uuids.dart';

class CheckoutVal {
  static final toPay = "0".val("CheckoutPage.haveToPay2").obs;

  static final listHotKey = ["1000", "5000", "10000", "20000", "50000", "100000", "uang pas"];

  static final totalPrice = Val.listorder.value.val
      .fold(0, (prev, element) => int.parse(prev.toString()) + element['qty'] * element['price']);

  static final totalQty =
      Val.listorder.value.val.fold(0, (prev, element) => int.parse(prev.toString()) + element['qty']);

  static final GlobalKey globalKey = GlobalKey();

  static final gambarStruk = <Uint8List>[].obs;

  static String Function() get change =>
      () => (int.parse(toPay.value.val.toString()) - int.parse(totalPrice.toString())).toString();

  static final paymentMethod = {}.obs;

  static onload() async {
    Val.billId.value.val = const ShortUuid().generate();
    Val.billId.refresh();
  }
}

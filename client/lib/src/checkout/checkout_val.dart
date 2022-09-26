import 'dart:typed_data';
import 'package:propos/utils/val.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class CheckoutVal {
  static final totalPayment = "0".val("CheckoutPage.haveToPay2").obs;

  static final totalBill = Val.listorder.value.val
      .fold(0, (prev, element) => int.parse(prev.toString()) + element['qty'] * element['price']);
  static final totalQty =
      Val.listorder.value.val.fold(0, (prev, element) => int.parse(prev.toString()) + element['qty']);

  // static final GlobalKey globalKey = GlobalKey();
  static final gambarStruk = <Uint8List>[].obs;
  static final billNumber = 0.obs;
  static final listPaymentMethod = [].obs;
  static final listPaymentWidget = [].val("CheckoutVal.listPaymentWidget").obs;
  // static final selectedIndex = 0.obs;

  static final codName = {}.obs;

  // static final paymentMethod = {}.obs;

  static reset() {
    totalPayment.value.val = "0";
  }

  // static onload() async {
  //   Val.billId.value.val = const ShortUuid().generate();
  //   Val.billId.refresh();
  // }
}

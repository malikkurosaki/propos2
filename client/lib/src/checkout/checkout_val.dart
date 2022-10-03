import 'dart:typed_data';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/src/printers/print_struk_model.dart';
import 'package:propos/utils/val.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:short_uuids/short_uuids.dart';

class CheckoutVal {
  static final totalPayment = "0".val("CheckoutPage.haveToPay4").obs;

  // static get totalBill => int.parse(CashierVal.totalPrice.value.toString());
  // Val.listorder.value.val
  //     .fold(0, (prev, element) => int.parse(prev.toString()) + element['qty'] * element['price']);

  static get totalQty => int.parse(CashierVal.totalQty.toString());
  // Val.listorder.value.val.fold(0, (prev, element) => int.parse(prev.toString()) + element['qty']);

  // static final GlobalKey globalKey = GlobalKey();
  static final gambarStruk = <Uint8List>[].obs;
  static final billNumber = 0.obs;
  static final listPaymentMethod = [].obs;
  static final listPaymentWidget = [].val("CheckoutVal.listPaymentWidget2").obs;
  static final change = "0".val("CheckoutVal.change").obs;
  // static final selectedIndex = 0.obs;

  static final codName = {}.obs;
  static final billId = "".val("CheckoutVal.billId").obs;
  static final printerModel = PrinterStrukModel().val("CheckoutVal.printerModel").obs;
  static final printerModelMap = {}.val("CheckoutVal.printerModelMap").obs;

  // static final paymentMethod = {}.obs;

  static reset() {
    totalPayment.value.val = "0";
  }

  static onload() async {
    billId.value.val = const ShortUuid().generate();
    billId.refresh();
  }
}

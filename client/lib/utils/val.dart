import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class Val {
  static final user = {}.val('Val.user').obs;
  // static final userId = "".val('Val.userId');
  static final userIdTmp = "".val('Val.tmpUserId');

  static final listorder = [].val("Val.listorder").obs;
  static final listSavedOrder = [].val("Val.listSavedOrder").obs;
  static final cashierlistProduct = [].val("Val.cashierlistProduct").obs;
  // static final listPrinter = [].val("Val.listPrinter2").obs;
  // static final printerDevice = {}.val("Val.printer2").obs;
  static final change = "".val("Val.change").obs;
  static final billId = "".val("Val.billId").obs;
  static final cashier = {}.val("Val.cashier").obs;

  static get totalOrder => Val.listorder.value.val
      .fold(0, (prev, element) => int.parse(prev.toString()) + element['qty'] * element['price']);
  static final printerWeb = <PrinterBluetooth>[].val("Val.printer").obs;

  // static final struk = <String>[].first.val("Val.total").obs;

  static clear() {
    Val.user.value.val = {};
    // Val.userId.val = "";
    Val.userIdTmp.val = "";

    Val.listorder.value.val = [];
    Val.listSavedOrder.value.val = [];
    Val.cashierlistProduct.value.val = [];
    // Val.listPrinter.value.val = [];
    // Val.printerDevice.value.val = {};
    Val.printerWeb.value.val = [];
    Val.change.value.val = "";
    Val.billId.value.val = "";
    Val.cashier.value.val = {};
  }
}

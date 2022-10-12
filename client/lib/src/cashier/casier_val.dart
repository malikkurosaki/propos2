import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propos/utils/val.dart';

class CashierVal {
  static final conSearch = TextEditingController();
  static final restoreOrderName = "".val('Cashier.restoreOrderName').obs;
  // final _listProduct = List.from(ValDef.productList.value.val).val('Cashier.listProduct').obs;
  // final _listCategory = [].obs;
  static final listProduct = [].val("CashierVal.listProduct").obs;
  static final tmpListProduct = [].val("Cashier._tmpListProduct").obs;

  // static final isMultipleSelect = false.obs;
  static final lsTampungan = [].obs;

  // static final listManualProduct = [].val("CashierVal.listManualProduct").obs;

  static final listCustomer = [].obs;
  static final selectedCustomer = {}.val("CashirVal.seletctedCustomer").obs;

  static final pax = 1.val("CashierVal.pax").obs;

  static final totalPrice = 0.val("CashierVal.totalPriwce").obs;
  static final totalQty = 0.obs;

  static final listorder = [].val("CashierVal.listOrder").obs;

  static final listCategory = [].obs;
  static final orderDetail = {}.val("CashierVal.orderDetail").obs;

  static orderAdd(Map prod) {
    final data = List.from(Val.listorder.value.val);
    final idx = data.indexWhere((element) => element['id'] == prod['id']);

     if ((prod['ProductStock'] as List).isNotEmpty) {
      // prod['sisaStock'] = prod['ProductStock'][0]['stock'] - prod['qty'];
      if (prod['ProductStock'][0]['stock'] == 0) {
        SmartDialog.showToast("empty product");
        return;
      }
    }

    if (idx == -1) {
      prod['qty'] = 1;
      prod['note'] = '';
      prod['total'] = prod['qty'] * prod['price'];
      prod['isManual'] = false;

      data.add(prod);
      SmartDialog.showToast("Added to cart", animationTime: Duration(milliseconds: 500));

      if ((prod['ProductStock'] as List).isNotEmpty) {
        prod['sisaStock'] = prod['ProductStock'][0]['stock'] - prod['qty'];
        if (prod['ProductStock'][0]['stock'] == 0) {
          SmartDialog.showToast("empty product");
          return;
        }
      }
    } else {
      if ((data[idx]['ProductStock'] as List).isNotEmpty) {
        data[idx]['stock'] = data[idx]['ProductStock'][0]['stock'];
        data[idx]['sisaStock'] = data[idx]['ProductStock'][0]['stock'] - data[idx]['qty'];
        
        if ((data[idx]['qty'] + 1) > data[idx]['stock']) {
          SmartDialog.showToast("error stock");
          return;
        }
      }

      data[idx]['qty']++;
      data[idx]['total'] = data[idx]['qty'] * data[idx]['price'];
    }

    Val.listorder.value.val = data;
    Val.listorder.refresh();
  }

  static orderSubstract(Map itm) {
    final data = List.from(Val.listorder.value.val);
    final idx = data.indexWhere((element) => element['id'] == itm['id']);

    if ((itm['ProductStock'] as List).isNotEmpty) {
      itm['sisaStock'] = itm['ProductStock'][0]['stock'] - itm['qty'];
    }

    if (idx != -1) {
      if (data[idx]['qty'] > 1) {
        data[idx]['qty']--;
        data[idx]['total'] = data[idx]['qty'] * data[idx]['price'];
      } else {
        Get.dialog(
          AlertDialog(
            title: Text("Warning"),
            content: Text("Are you sure want to delete this item?"),
            actions: [
              MaterialButton(
                child: Text("Yes"),
                onPressed: () {
                  data.removeAt(idx);
                  Val.listorder.value.val = data;
                  Val.listorder.refresh();
                  Get.back();
                },
              ),
              MaterialButton(
                child: Text("No"),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      }
    }
    Val.listorder.value.val = data;
    Val.listorder.refresh();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/rot.dart';
import 'package:get/get.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/src/checkout/checkout_change.dart';
import 'package:propos/src/checkout/checkout_val.dart';
import 'package:propos/utils/val.dart';

class CheckoutAction {
  final _payLoading = false.obs;

  Future<void> pay() async {
    _payLoading.value = true;
    Future.delayed(const Duration(seconds: 6), () => _payLoading.value = false);
    final mapCash = {};

    final cashData = await Rot.checkoutCashGet();
    if (cashData.statusCode == 200) mapCash.assignAll(jsonDecode(cashData.body));

    final cod = {};
    final resCod = await Rot.checkoutCodGet();
    if (resCod.statusCode == 200) cod.assignAll(jsonDecode(resCod.body));

    final productManual = Val.listorder.value.val
        .where((element) => element['isManual'] == true)
        .toList()
        .map(
          (e) => {
            "name": e['name'],
            "price": e['price'],
            "companyId": cod['companyId'],
            "note": e['note'],
            "total": e['total'],
            "userId": cod['userId']
          },
        )
        .toList();

    final productAuto = Val.listorder.value.val
        .where((element) => element['isManual'] == false)
        .toList()
        .map(
          (e) => {
            "note": e['note'],
            // "number": "null",
            // "tax": "undefined",
            "productId": e['productId'],
            "total": e['total'],
            "quantity": e['qty'],
            // "discountId": "undefined",
          },
        )
        .toList();

    // debugPrint(JsonEncoder.withIndent("   ").convert(productManual));
    // debugPrint(JsonEncoder.withIndent("   ").convert(productManual));

    final model = {
      "number": CheckoutVal.billNumber.value,
      "cashierId": "",
      "change": int.parse(CheckoutChange.change.value),
      "companyId": cod['companyId'],
      "customerId": CashierVal.selectedCustomer.value.val.isEmpty ? "" : CashierVal.selectedCustomer.value.val['id'],
      "deviceId": cod['deviceId'],
      "discountId": "",
      "employeeId": "",
      "outletId": cod['outletId'],
      "tax": "",
      "totalPrice": CheckoutVal.totalBill,
      "totalQty": CashierVal.totalQty.value,
      "userId": cod['userId'],
      "BillPayment": {
        "createMany": {
          "data": CheckoutVal.listPaymentWidget.value.val.isEmpty
              ? [
                  {"paymentMethodId": mapCash['id'], "value": CheckoutVal.totalBill}
                ]
              : [
                  ...CheckoutVal.listPaymentWidget.value.val.map(
                    (e) => {
                      "paymentMethodId": e['paymentId'],
                      "value": int.parse(e['value'].toString()),
                    },
                  )
                ]
        }
      },
      "OrderManual": productManual.isEmpty
          ? ""
          : {
              "createMany": {
                "data": [...productManual]
              }
            },
      "Order": {
        "createMany": {
          "data": [...productAuto]
        }
      },
      "pax": CashierVal.pax.value
    };

    model.removeWhere((key, value) => value.toString().isEmpty);
    final body = {"data": jsonEncode(model)};

    final res = await Rot.checkoutBillCreatePost(body: body);
    if (res.statusCode == 201) {
      SmartDialog.showToast("success");
      Val.listorder.value.val = [];
      Val.listorder.refresh();
      CashierVal.pax.value = 1;
      CashierVal.selectedCustomer.value.val = {};
      CashierVal.totalPrice.value = 0;

      Get.back();
    } else {
      SmartDialog.showToast(res.body);
    }

    _payLoading.value = false;
  }
}

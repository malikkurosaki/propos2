import 'dart:convert';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/menus/cashier.dart';
import 'package:propos/pages.dart';
import 'package:propos/rot.dart';
import 'package:get/get.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/src/checkout/checkout_change.dart';
import 'package:propos/src/checkout/checkout_val.dart';
import 'package:propos/src/printers/print_struk_model.dart';
import 'package:propos/src/printers/printer_print_now.dart';
import 'package:propos/utils/val.dart';

class CheckoutAction {
  static final payLoading = false.obs;

  static Future<void> pay() async {
    payLoading.value = true;
    Future.delayed(const Duration(seconds: 6), () => payLoading.value = false);
    final mapCash = {};

    final cashData = await Rot.checkoutCashGet();
    if (cashData.statusCode == 200) mapCash.assignAll(jsonDecode(cashData.body));

    final cod = {};
    final resCod = await Rot.checkoutCodGet();
    if (resCod.statusCode == 200) cod.assignAll(jsonDecode(resCod.body));

    final codName = {};
    final resCodName = await Rot.checkoutCodNameGet();
    if (resCodName.statusCode == 200) codName.assignAll(jsonDecode(resCodName.body));

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
            "productId": e['id'],
            "total": e['total'],
            "quantity": e['qty'],
            // "discountId": "undefined",
          },
        )
        .toList();

    // debugPrint(JsonEncoder.withIndent("   ").convert(productManual));
    // debugPrint(JsonEncoder.withIndent("   ").convert(productManual));

    final List<Map> listPaymentMethod = CheckoutVal.listPaymentWidget.value.val.isEmpty
        ? [
            {"method": "cash", "value": CashierVal.totalPrice.value.val.toString()}
          ]
        : [...CheckoutVal.listPaymentWidget.value.val];

    final listProduct = Val.listorder.value.val
        .map((data) => PrinterProduct(
            qty: data['qty'].toString(),
            name: data['name'],
            note: data['note'],
            price: data['price'].toString(),
            total: data['total'].toString()))
        .toList();

    final printerModel = PrinterStrukModel(
        address: "jalan x",
        change: int.parse(CheckoutVal.change.value.val).toString(),
        company: codName['Company']['name'],
        outlet: codName['Outlet']['name'],
        device: codName['Device']['name'],
        customer: CashierVal.selectedCustomer.value.val.isEmpty ? "-" : CashierVal.selectedCustomer.value.val['name'],
        pax: CashierVal.pax.value.val.toString(),
        totalPay: CheckoutVal.totalPayment.value.val.toString(),
        totalBill: CashierVal.totalPrice.value.val.toString(),
        totalQty: CashierVal.totalQty.value.toString(),
        lisProduct: listProduct,
        billId: CheckoutVal.billId.value.val.toString(),
        billNumber: CheckoutVal.billNumber.value.toString(),
        paymentMethod: listPaymentMethod);

    CheckoutVal.printerModel.value.val = printerModel;
    CheckoutVal.printerModelMap.value.val = printerModel.toJson();
    CheckoutVal.printerModel.refresh();
    CheckoutVal.printerModelMap.refresh();

    final model = {
      "number": CheckoutVal.billNumber.value,
      "cashierId": "",
      "change": int.parse(CheckoutVal.change.value.val),
      "companyId": cod['companyId'],
      "customerId": CashierVal.selectedCustomer.value.val.isEmpty ? "" : CashierVal.selectedCustomer.value.val['id'],
      "deviceId": cod['deviceId'],
      "discountId": "",
      "employeeId": "",
      "outletId": cod['outletId'],
      "tax": "",
      "totalPay": int.parse(CheckoutVal.totalPayment.value.val),
      "totalPrice": CashierVal.totalPrice.value.val,
      "totalQty": CashierVal.totalQty.value,
      "userId": cod['userId'],
      "BillPayment": {
        "createMany": {
          "data": CheckoutVal.listPaymentWidget.value.val.isEmpty
              ? [
                  {"paymentMethodId": mapCash['id'], "value": CashierVal.totalPrice.value.val}
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
      "pax": CashierVal.pax.value.val
    };

    model.removeWhere((key, value) => value.toString().isEmpty);
    final body = {"data": jsonEncode(model)};

    final res = await Rot.checkoutBillCreatePost(body: body);
    if (res.statusCode == 201) {
      SmartDialog.showToast("success");
      Val.listorder.value.val = [];
      CashierVal.pax.value.val = 1;
      CashierVal.selectedCustomer.value.val = {};
      CashierVal.totalPrice.value.val = 0;
      CheckoutVal.listPaymentWidget.value.val = [];
      CheckoutVal.totalPayment.value.val = '0';
      CashierVal.selectedCustomer.value.val = {};
      CashierVal.pax.value.val = 1;
      Val.listorder.refresh();

      // Get.toNamed(Pages.homePage().route);
      Get.offNamed(Pages.paymentSuccessPage().route);
    } else {
      SmartDialog.showToast(res.body);
    }

    payLoading.value = false;
  }
}

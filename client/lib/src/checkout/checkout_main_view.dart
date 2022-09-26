import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/src/checkout/checkout_action.dart';
import 'package:propos/src/checkout/checkout_calculator_pad.dart';
import 'package:propos/src/checkout/checkout_change.dart';
import 'package:propos/src/checkout/checkout_hot_pad.dart';
import 'package:propos/src/checkout/checkout_payment_method.dart';
import 'package:propos/src/checkout/checkout_val.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CheckoutMainView extends StatelessWidget {
  const CheckoutMainView({Key? key}) : super(key: key);

  _onLoad() {
    RouterApi.paymentMethodList().getData().then(
      (res) {
        if (res.statusCode == 200) {
          CheckoutVal.listPaymentMethod.assignAll(jsonDecode(res.body));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();

    return ResponsiveBuilder(
      builder: (context, media) => Card(
        elevation: 0,
        child: Column(
          children: [
            Flexible(
              child: ListView(
                controller: ScrollController(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // bill id
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Bill ID: ",
                                  ),
                                  Text(
                                    Val.billId.value.val.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text("Bill No"),
                                  FutureBuilder<http.Response>(
                                      future: Rot.billNumberGet(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState != ConnectionState.done) {
                                          return Text("...");
                                        }
                                        final nom = int.tryParse(snapshot.data!.body).toString() == "null";
                                        if (nom) return Text("Error");

                                        final angkanya = (int.parse(snapshot.data!.body) + 1);
                                        const panjangnya = 10;
                                        final rangka =
                                            List.generate(panjangnya - angkanya.toString().length, (index) => "0");

                                        CheckoutVal.billNumber.value = angkanya;
                                        return Text(
                                          "${rangka.join('')}$angkanya",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                        );
                                      })
                                  // const Text(
                                  //   "00001",
                                  //   style: TextStyle(
                                  //     fontSize: 20,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        DottedLine(dashColor: Colors.grey),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Total Bill: "),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: '',
                                      decimalDigits: 0,
                                    ).format(CheckoutVal.totalBill),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Total Payment: "),
                                  Obx(
                                    () => Text(
                                      NumberFormat.currency(
                                        locale: 'id_ID',
                                        symbol: '',
                                        decimalDigits: 0,
                                      ).format(int.parse(CheckoutVal.totalPayment.value.val)),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CheckoutChange()
                          ],
                        ),
                        DottedLine(dashColor: Colors.grey),
                        CheckoutPaymentMethod(),
                        DottedLine(dashColor: Colors.grey)
                      ],
                    ),
                  ),
                  CheckoutHotPad(
                    onChanged: (value) {
                      if (CheckoutVal.listPaymentWidget.value.val.isNotEmpty) {
                        CheckoutVal.listPaymentWidget.value.val
                            .where(
                              (p0) => (p0['selected'] as bool),
                            )
                            .first['value'] = value;
                        final total = CheckoutVal.listPaymentWidget.value.val.fold<int>(
                            0,
                            (previousValue, element) =>
                                int.parse(previousValue.toString()) + int.parse(element['value']));

                        CheckoutChange.change.value = (total - CheckoutVal.totalBill).toString();
                        CheckoutVal.listPaymentWidget.refresh();

                        CheckoutVal.totalPayment.value.val = total.toString();
                        CheckoutVal.totalPayment.refresh();
                      } else {
                        CheckoutVal.totalPayment.value.val = value;
                        CheckoutVal.totalPayment.refresh();
                        CheckoutChange.calculateChange();
                      }
                    },
                  ),
                  Visibility(
                    visible: media.isMobile,
                    child: CheckoutCalculatorPad(
                      onChanged: (value) {
                        if (CheckoutVal.listPaymentWidget.value.val.isNotEmpty) {
                          CheckoutVal.listPaymentWidget.value.val
                              .where(
                                (p0) => (p0['selected'] as bool),
                              )
                              .first['value'] = value;
                          final total = CheckoutVal.listPaymentWidget.value.val.fold<int>(
                              0,
                              (previousValue, element) =>
                                  int.parse(previousValue.toString()) + int.parse(element['value']));

                          CheckoutChange.change.value = (total - CheckoutVal.totalBill).toString();
                          CheckoutVal.listPaymentWidget.refresh();

                          CheckoutVal.totalPayment.value.val = total.toString();
                          CheckoutVal.totalPayment.refresh();
                        } else {
                          CheckoutVal.totalPayment.value.val = value;
                          CheckoutVal.totalPayment.refresh();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                final loading = false.obs;
                return Obx(
                  () => Column(
                    children: [
                      Visibility(
                        visible: int.parse(CheckoutVal.totalPayment.value.val) >= CheckoutVal.totalBill,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: loading.value
                              ? const Text("loading ...")
                              : MaterialButton(
                                  color: Colors.blue,
                                  onPressed: CheckoutAction().pay,
                                  // () async {
                                  //   loading.value = true;
                                  //   final mapCash = {};

                                  //   final cashData = await Rot.checkoutCashGet();
                                  //   if (cashData.statusCode == 200) mapCash.assignAll(jsonDecode(cashData.body));

                                  //   final cod = {};
                                  //   final resCod = await Rot.checkoutCodGet();
                                  //   if (resCod.statusCode == 200) cod.assignAll(jsonDecode(resCod.body));

                                  //   final productManual = Val.listorder.value.val
                                  //       .where((element) => element['isManual'] == true)
                                  //       .toList()
                                  //       .map(
                                  //         (e) => {
                                  //           "name": e['name'],
                                  //           "price": e['price'],
                                  //           "companyId": cod['companyId'],
                                  //           "note": e['note'],
                                  //           "total": e['total'],
                                  //           "userId": cod['userId']
                                  //         },
                                  //       )
                                  //       .toList();

                                  //   final productAuto = Val.listorder.value.val
                                  //       .where((element) => element['isManual'] == false)
                                  //       .toList()
                                  //       .map(
                                  //         (e) => {
                                  //           "note": e['note'],
                                  //           // "number": "null",
                                  //           // "tax": "undefined",
                                  //           "productId": e['productId'],
                                  //           "total": e['total'],
                                  //           "quantity": e['qty'],
                                  //           // "discountId": "undefined",
                                  //         },
                                  //       )
                                  //       .toList();

                                  //   // debugPrint(JsonEncoder.withIndent("   ").convert(productManual));
                                  //   // debugPrint(JsonEncoder.withIndent("   ").convert(productManual));

                                  //   final model = {
                                  //     "number": CheckoutVal.billNumber.value,
                                  //     "cashierId": "",
                                  //     "change": int.parse(CheckoutChange.change.value),
                                  //     "companyId": cod['companyId'],
                                  //     "customerId": CashierVal.selectedCustomer.value.val.isEmpty
                                  //         ? ""
                                  //         : CashierVal.selectedCustomer.value.val['id'],
                                  //     "deviceId": cod['deviceId'],
                                  //     "discountId": "",
                                  //     "employeeId": "",
                                  //     "outletId": cod['outletId'],
                                  //     "tax": "",
                                  //     "totalPrice": CheckoutVal.totalBill,
                                  //     "totalQty": CashierVal.totalQty.value,
                                  //     "userId": cod['userId'],
                                  //     "BillPayment": {
                                  //       "createMany": {
                                  //         "data": CheckoutVal.listPaymentWidget.isEmpty
                                  //             ? [
                                  //                 {"paymentMethodId": mapCash['id'], "value": CheckoutVal.totalBill}
                                  //               ]
                                  //             : [
                                  //                 ...CheckoutVal.listPaymentWidget.map(
                                  //                   (e) => {
                                  //                     "paymentMethodId": e['paymentId'],
                                  //                     "value": e['value'],
                                  //                   },
                                  //                 )
                                  //               ]
                                  //       }
                                  //     },
                                  //     "OrderManual": productManual.isEmpty
                                  //         ? ""
                                  //         : {
                                  //             "createMany": {
                                  //               "data": [...productManual]
                                  //             }
                                  //           },
                                  //     "Order": {
                                  //       "createMany": {
                                  //         "data": [...productAuto]
                                  //       }
                                  //     },
                                  //     "pax": CashierVal.pax.value
                                  //   };

                                  //   model.removeWhere((key, value) => value.toString().isEmpty);
                                  //   final body = {"data": jsonEncode(model)};

                                  //   final res = await Rot.checkoutBillCreatePost(body: body);
                                  //   if (res.statusCode == 201) {
                                  //     SmartDialog.showToast("success");
                                  //     Val.listorder.value.val = [];
                                  //     Val.listorder.refresh();
                                  //     Get.back();
                                  //   } else {
                                  //     SmartDialog.showToast(res.body);
                                  //   }

                                  //   // final bill = <String, String>{
                                  //   //   "id": Val.billId.value.val.toString(),
                                  //   //   "totalQty": CheckoutVal.totalQty.toString(),
                                  //   //   "totalPrice": CheckoutVal.totalBill.toString(),
                                  //   //   "userId": Vl.userId.val.toString(),
                                  //   //   "companyId": Vl.companyId.val.toString(),
                                  //   //   "outletId": Vl.outletId.val.toString(),
                                  //   //   // "employeeId": "",
                                  //   //   // "cashierId": "",
                                  //   //   // "discount": "",
                                  //   //   // "tax": "",
                                  //   //   "payment": CheckoutVal.totalPayment.value.val,
                                  //   //   "change": CheckoutChange.change.value,
                                  //   //   // "customerId": ""
                                  //   // };

                                  //   // final listOrder = [];
                                  //   // for (final itm in Val.listorder.value.val) {
                                  //   //   final order = {
                                  //   //     "quantity": itm['qty'],
                                  //   //     "note": itm['note'],
                                  //   //     "total": itm['total'],
                                  //   //     // "discount": "",
                                  //   //     // "tax": "",
                                  //   //     "productId ": itm['productId'],
                                  //   //     "billId": Val.billId.value.val.toString(),
                                  //   //   };

                                  //   //   listOrder.add(order);
                                  //   // }

                                  //   // final body = <String, String>{
                                  //   //   "bill": jsonEncode(bill),
                                  //   //   "listOrder": jsonEncode(listOrder)
                                  //   // };

                                  //   // debugPrint(CheckoutVal.listPaymentWidget.toString());

                                  //   // try {
                                  //   //   final pay = await RouterApi.billCreate().postData(body);
                                  //   //   await SmartDialog.showToast("Payment Success");
                                  //   //   Val.change.value.val = CheckoutChange.change.value;
                                  //   //   // Val.billId.value.val = Val.billId.value.val;

                                  //   //   // Val.struk.value.val = _struk(media).toString();
                                  //   //   Get.offAllNamed(Pages.paymentSuccessPage().route);
                                  //   //   loading.value = false;
                                  //   // } catch (e) {
                                  //   //   debugPrint(e.toString());
                                  //   //   SmartDialog.showToast(e.toString());
                                  //   // }

                                  //   loading.value = false;
                                  // },
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text(
                                        "Pay",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

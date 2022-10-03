import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/src/checkout/checkout_calculator_pad.dart';
import 'package:propos/src/checkout/checkout_change.dart';
import 'package:propos/src/checkout/checkout_val.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckoutPaymentMethod extends StatelessWidget {
  const CheckoutPaymentMethod({Key? key}) : super(key: key);

  static onDelete() {
    if (CheckoutVal.listPaymentWidget.value.val.isNotEmpty) {
      final total = CheckoutVal.listPaymentWidget.value.val
          .fold<int>(0, (previousValue, element) => int.parse(previousValue.toString()) + int.parse(element['value']));

      CheckoutVal.change.value.val = (total - CashierVal.totalPrice.value.val).isNegative
          ? "0"
          : (total - CashierVal.totalPrice.value.val).toString();
      CheckoutVal.totalPayment.value.val = total.toString();
      CheckoutVal.totalPayment.refresh();
      CheckoutVal.change.refresh();
    } else {
      CheckoutVal.totalPayment.value.val = "0";
      CheckoutVal.totalPayment.refresh();

      final nilai = (int.parse(CheckoutVal.totalPayment.value.val.toString()) - CashierVal.totalPrice.value.val);
      CheckoutVal.change.value.val = nilai.isNegative ? "0" : nilai.toString();
      CheckoutVal.change.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => CheckoutVal.listPaymentWidget.value.val.isNotEmpty
              ? SizedBox.shrink()
              : ListTile(
                  title: Text("Payment Method"),
                  subtitle: Text(
                    "Cash",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
        ),
        FutureBuilder<http.Response>(
          future: Rot.paymentMethodListPaymentMethodGet(),
          builder: (con, snap) {
            if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();
            if (snap.data!.statusCode == 200) {
              final lsData = jsonDecode(snap.data!.body);
              Future.delayed(Duration(milliseconds: 100), () => CheckoutVal.listPaymentMethod.assignAll(lsData));
            }
            return SizedBox.shrink();
          },
        ),
        Obx(
          () => Column(
            children: [
              ...CheckoutVal.listPaymentWidget.value.val.map(
                (element) => ListTile(
                  leading: Icon(Icons.payment),
                  title: Row(
                    children: [
                      Expanded(
                        child: DropdownSearch<Map>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  filled: true, border: InputBorder.none, hintText: "Select Payment Method")),
                          items: [...CheckoutVal.listPaymentMethod],
                          itemAsString: (value) => value['name'],
                          onChanged: (value) {
                            element['method'] = value!['name'];
                            element['paymentId'] = value['id'];

                            CheckoutVal.listPaymentWidget.refresh();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            for (final itm in CheckoutVal.listPaymentWidget.value.val) {
                              if (itm['id'] == element['id']) {
                                itm['selected'] = true;
                              } else {
                                itm['selected'] = false;
                              }
                              CheckoutVal.listPaymentWidget.refresh();
                            }

                            CheckoutVal.totalPayment.value.val = element['value'];
                          },
                          child: Container(
                            color: (element['selected'] as bool) ? Colors.blue.shade100 : Colors.grey.shade100,
                            padding: EdgeInsets.all(16),
                            child: Text(
                              NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0).format(
                                int.parse(
                                  element['value'],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      CheckoutVal.listPaymentWidget.value.val.removeWhere((el) => element['id'] == el['id']);
                      CheckoutVal.listPaymentWidget.refresh();
                      onDelete();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Add Payment Method"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                onPressed: () {
                  final lsData = [...CheckoutVal.listPaymentWidget.value.val];
                  lsData.add(
                    {
                      "id": "${CheckoutVal.listPaymentWidget.value.val.length}-${DateTime.now().toString()}",
                      "paymentId": "",
                      "method": "",
                      "value": "0",
                      "selected": false,
                    },
                  );

                  CheckoutVal.listPaymentWidget.value.val = lsData;
                  CheckoutVal.listPaymentWidget.refresh();
                },
                icon: Icon(
                  Icons.add_box,
                  size: 32,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/payment_method/payment_method_val.dart';
import 'package:get/get.dart';

class PaymentMethodDisplay extends StatelessWidget {
  const PaymentMethodDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Column(
            children: [
              Visibility(
                visible: false,
                child: Text(
                  PaymentMethodVal.reaload.value.toString(),
                ),
              ),
              FutureBuilder<http.Response>(
                future: Rot.paymentMethodListPaymentMethodGet(),
                builder: (con, snap) {
                  if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();
                  if (snap.data!.statusCode == 200) {
                    final lsData = jsonDecode(snap.data!.body);
                    Future.delayed(
                        Duration(milliseconds: 100), () => PaymentMethodVal.listPaymentMethod.assignAll(lsData));
                  }
                  return SizedBox.shrink();
                },
              )
            ],
          ),
        ),
        Flexible(
          child: Obx(
            () => ListView(
              children: [
                ...PaymentMethodVal.listPaymentMethod.map(
                  (element) => ListTile(
                    title: Text(element['name'].toString()),
                    trailing: PopupMenuButton(
                      itemBuilder: (con) => [
                        PopupMenuItem(
                          value: "del",
                          child: Text("Delete"),
                        ),
                        PopupMenuItem(
                          value: "edit",
                          child: Text("Edit"),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

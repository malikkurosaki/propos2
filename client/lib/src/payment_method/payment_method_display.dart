import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/payment_method/payment_method_val.dart';
import 'package:get/get.dart';

class PaymentMethodDisplay extends StatelessWidget {
  PaymentMethodDisplay({Key? key}) : super(key: key);

  final _ls = <Map<String, dynamic>>[
    {"title": "No", "wid": 40.0, "fid": "no"},
    {"title": "Name", "wid": 200.0, "fid": "name"},
    {"title": "Active", "wid": 70.0, "fid": "isActive"},
    {"title": "Action", "wid": 70.0, "fid": "act"}
  ];

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
              SizedBox(
                height: 2,
                child: FutureBuilder<http.Response>(
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
                ),
              )
            ],
          ),
        ),
        Flexible(
          child: Obx(
            () {
              PaymentMethodVal.listPaymentMethod.value;
              return Card(
                child: ListView(
                  children: [
                    Ink(
                      color: Colors.grey.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ..._ls.map(
                              (e) => SizedBox(
                                width: e['wid'],
                                child: Text(
                                  e['title'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    ...PaymentMethodVal.listPaymentMethod.map(
                      (el) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ..._ls.map(
                              (e) => SizedBox(
                                width: e['wid'],
                                child: e['fid'] == 'no'
                                    ? Text((PaymentMethodVal.listPaymentMethod.indexOf(el) + 1).toString())
                                    : e['fid'] == 'isActive'
                                        ? Icon(
                                            Icons.circle,
                                            color: el['isActive'] ? Colors.green : Colors.grey,
                                          )
                                        : e['fid'] == 'act'
                                            ? PopupMenuButton(
                                                itemBuilder: (con) => [
                                                  PopupMenuItem(
                                                    child: Text("Edit"),
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text("Activete"),
                                                    onTap: () async {
                                                      final body = {"isActive": true};

                                                      final res = await Rot.paymentMethodActivatePut(
                                                          query: 'id=${el["id"]}', body: {"data": jsonEncode(body)});

                                                      if (res.statusCode == 201) {
                                                        PaymentMethodVal.reaload.toggle();
                                                      }
                                                    },
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text("Deactivate"),
                                                    onTap: () async {
                                                      final body = {"isActive": false};

                                                      final res = await Rot.paymentMethodActivatePut(
                                                          query: 'id=${el["id"]}', body: {"data": jsonEncode(body)});
                                                      if (res.statusCode == 201) {
                                                        PaymentMethodVal.reaload.toggle();
                                                      }

                                                      debugPrint(res.body);
                                                    },
                                                  )
                                                ],
                                              )
                                            : Text(el[e['fid']] ?? ""),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

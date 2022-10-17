import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/payment_method/payment_method_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PaymentMethodCreate extends StatelessWidget {
  const PaymentMethodCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: media.isMobile ? BackButton() : null,
            title: Text(
              "Create payment Method",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            leading: Icon(Icons.business),
            title: Column(
              children: [
                FutureBuilder<http.Response>(
                  future: Rot.paymentMethothListCompanyGet(),
                  builder: (c, s) {
                    if (s.connectionState != ConnectionState.done) return LinearProgressIndicator();
                    if (s.data!.statusCode == 200) {
                      final lsData = jsonDecode(s.data!.body);
                      Future.delayed(
                          Duration(microseconds: 100), () => PaymentMethodVal.listComapany.assignAll(lsData));
                    }
                    return SizedBox.shrink();
                  },
                ),
                Obx(
                  () => PaymentMethodVal.listComapany.isEmpty
                      ? Text("Select Company")
                      : DropdownSearch<Map>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  InputDecoration(filled: true, border: InputBorder.none, hintText: 'select company')),
                          items: [...PaymentMethodVal.listComapany],
                          itemAsString: (value) => value['name'].toString(),
                          onChanged: (value) {
                            PaymentMethodVal.selectedCompany.assignAll(value!);
                          },
                        ),
                )
              ],
            ),
          ),
          ListTile(
            title: TextFormField(
              onChanged: (value) => PaymentMethodVal.name.value = value,
              controller: TextEditingController(text: PaymentMethodVal.name.value),
              decoration: InputDecoration(hintText: "Name", filled: true, border: InputBorder.none),
            ),
          ),
          ListTile(
            title: TextFormField(
              onChanged: (value) => PaymentMethodVal.des.value = value,
              controller: TextEditingController(text: PaymentMethodVal.des.value),
              decoration: InputDecoration(hintText: "Description", filled: true, border: InputBorder.none),
            ),
          ),
          ListTile(
            title: MaterialButton(
              color: Colors.blue,
              onPressed: () async {
                final body = {
                  "name": PaymentMethodVal.name.value,
                  "description": PaymentMethodVal.des.value,
                  "companyId": PaymentMethodVal.selectedCompany['id'] ?? "",
                };

                if (body['name'].toString().isEmpty) {
                  SmartDialog.showToast("name no empty please");
                  return;
                }

                body.removeWhere((key, value) => value.toString().isEmpty);

                // debugPrint(body.toString());

                final data = await Rot.paymentMethodCreatePost(body: {"data": jsonEncode(body)});
                if (data.statusCode == 201) {
                  SmartDialog.showToast("success");
                  PaymentMethodVal.reaload.toggle();
                  return;
                }

                SmartDialog.showToast(data.body);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}

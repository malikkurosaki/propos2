import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:propos/rot.dart';
import 'package:propos/utils/vl.dart';

class CashierAddCustomer extends StatelessWidget {
  CashierAddCustomer({Key? key}) : super(key: key);

  final listFoeld = [
    {"title": "name", "value": ""},
    {"title": "email", "value": ""},
    {"title": "phone", "value": ""},
    {"title": "address", "value": ""},
    {"title": "gender", "value": ""}
  ].obs;

  final lsData = <String, dynamic>{
    "name": "",
    "address": "",
    "phone": "",
    "email": "",
    "whatsapp": "",
  }.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [BackButton(), Text("Add Customer")],
        ),
        ...lsData.keys
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) => lsData[e] = value,
                  controller: TextEditingController(text: lsData[e]),
                  decoration: InputDecoration(
                    filled: true,
                    hintText: e,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            )
            .toList(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            onPressed: () {
              lsData["companyId"] = Vl.companyId.val;
              lsData["userId"] = Vl.userId.val;
              lsData.removeWhere((key, value) => value.toString().isEmpty);
              Rot.customerCreatePost(body: {"data": jsonEncode(lsData)}).then(
                (res) {
                  if (res.statusCode == 201) {
                    SmartDialog.showToast("Data Success Create");
                    Get.back();
                  } else {
                    SmartDialog.show(builder: (context) => Text(res.body));
                  }
                },
              );
            },
          ),
        )
      ],
    );
  }
}

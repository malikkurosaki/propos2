import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/company/company_val.dart';
import 'package:get/get.dart';

class CompanyEdit extends StatelessWidget {
  const CompanyEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            // Container(
            //   color: Colors.grey.shade100,
            //   padding: EdgeInsets.all(8),
            //   child: Row(
            //     children: [BackButton(), Text("Edit Company")],
            //   ),
            // ),
            ListTile(
              leading: BackButton(),
              title: Text(
                "Edit Company",
                style: TextStyle(fontSize: 18),
              ),
            ),
            ...CompanyVal.mapData.keys.map(
              (e) => !['name', 'address', 'phone', 'logoUrl', 'isActive'].contains(e)
                  ? SizedBox.shrink()
                  : e == 'isActive'
                      ? Obx(
                          () => ListTile(
                            title: CheckboxListTile(
                              title: Text("Is Active ?"),
                              onChanged: (val) {
                                CompanyVal.mapData['isActive'] = val;
                                CompanyVal.mapData.refresh();
                              },
                              value: CompanyVal.mapData[e],
                            ),
                          ),
                        )
                      : ListTile(
                          title: TextFormField(
                            onChanged: (val) => CompanyVal.mapData[e] = val,
                            controller: TextEditingController(text: CompanyVal.mapData[e] ?? ""),
                            decoration:
                                InputDecoration(filled: true, border: InputBorder.none, labelText: e.toString()),
                          ),
                        ),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: MaterialButton(
                      color: Colors.pink,
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: MaterialButton(
                      color: Colors.orange,
                      onPressed: () async {
                        CompanyVal.mapData.removeWhere((key, value) => value == null);
                        final res = await Rot.companyUpdatePost(body: {"data": jsonEncode(CompanyVal.mapData)});
                        if (res.statusCode == 201) {
                          SmartDialog.showToast("success");
                          CompanyVal.reload.toggle();
                          Get.back();
                        } else {
                          SmartDialog.showToast(res.body);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

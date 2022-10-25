import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/employee/employee_val.dart';
import 'package:get/get.dart';

class EmployeeEdit extends StatelessWidget {
  const EmployeeEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange.shade50,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            ListTile(
              leading: BackButton(),
              title: Text(
                "Edit Employee",
                style: TextStyle(fontSize: 18),
              ),
            ),
            // Container(
            //   color: Colors.grey.shade100,
            //   padding: EdgeInsets.all(8),
            //   child: Row(
            //     children: [BackButton(), Text("Edit Employee")],
            //   ),
            // ),
            ...EmployeeVal.mapData.keys.map(
              (e) => !['name', 'password', 'isActive'].contains(e)
                  ? SizedBox.shrink()
                  : e == 'isActive'
                      ? Obx(
                          () => ListTile(
                            title: CheckboxListTile(
                              title: Text("Is Active ?"),
                              value: EmployeeVal.mapData['isActive'],
                              onChanged: (val) {
                                EmployeeVal.mapData['isActive'] = val;
                                EmployeeVal.mapData.refresh();
                              },
                            ),
                          ),
                        )
                      : ListTile(
                          title: TextFormField(
                            onChanged: (val) => EmployeeVal.mapData[e] = val,
                            controller: TextEditingController(
                              text: EmployeeVal.mapData[e].toString(),
                            ),
                            decoration: InputDecoration(filled: true, border: InputBorder.none, labelText: e),
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
                        final body = Map.from(EmployeeVal.mapData);
                        body.removeWhere((key, value) => value == null);
                        final res = await Rot.employeeUpdatePost(body: {"data": jsonEncode(body)});
                        if (res.statusCode == 201) {
                          SmartDialog.showToast("success");
                          EmployeeVal.reload.toggle();
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

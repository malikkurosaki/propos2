import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/category/category_val.dart';
import 'package:get/get.dart';

class CategoryEdit extends StatelessWidget {
  const CategoryEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            ListTile(
              leading: BackButton(),
              title: Text(
                "Edit Category",
                style: TextStyle(fontSize: 18),
              ),
            ),
            // Ink(
            //   color: Colors.grey.shade100,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       children: [BackButton(), Text("Edit")],
            //     ),
            //   ),
            // ),
            ...CategoryVal.mapData.keys.map(
              (e) => !['name', 'isActive'].contains(e)
                  ? SizedBox.shrink()
                  : e == 'isActive'
                      ? Obx(
                          () => ListTile(
                            title: CheckboxListTile(
                              title: Text("Is Active ?"),
                              value: CategoryVal.mapData['isActive'],
                              onChanged: (val) {
                                CategoryVal.mapData['isActive'] = val;
                                // CategoryVal.mapData.refresh();
                              },
                            ),
                          ),
                        )
                      : ListTile(
                          title: TextFormField(
                            onChanged: (value) => CategoryVal.mapData[e] = value,
                            controller: TextEditingController(text: CategoryVal.mapData[e]),
                            decoration: InputDecoration(filled: true, border: InputBorder.none, labelText: 'Name'),
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
                )),
                Expanded(
                  child: ListTile(
                    title: MaterialButton(
                      color: Colors.orange,
                      onPressed: () async {
                        final res = await Rot.categoryUpdatePost(body: {"data": jsonEncode(CategoryVal.mapData)});
                        if (res.statusCode == 201) {
                          SmartDialog.showToast("success");
                          CategoryVal.reload.toggle();
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

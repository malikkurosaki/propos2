import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/category/category_val.dart';
import 'package:get/get.dart';

class CategoryDisplay extends StatelessWidget {
  const CategoryDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Card(
          child: Column(
            children: [
              Obx(
                () {
                  CategoryVal.reload.value;
                  return SizedBox(
                    height: 4,
                    child: FutureBuilder<http.Response>(
                      future: Rot.categoryListGet(),
                      builder: (con, snap) {
                        if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();

                        if (snap.data!.statusCode == 200) {
                          Future.delayed(
                            Duration(microseconds: 1),
                            () => CategoryVal.listCategory.value.val = jsonDecode(snap.data!.body),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  );
                },
              ),
              Flexible(
                child: Obx(
                  () => ListView(
                    children: [
                      ...CategoryVal.listCategory.value.val.map(
                        (element) => ListTile(
                          onTap: () {
                            debugPrint(element.toString());

                            // CategoryVal.bodyUpdate.value = CategoryModel.fromJson(element);
                            // final mapData = Map.from(element);
                            // todo : benerin dulu ini
                            CategoryVal.mapData.assignAll(element);
                            showBottomSheet(
                              context: context,
                              builder: (context) => Material(
                                child: ListView(
                                  children: [
                                    Ink(
                                      color: Colors.grey.shade100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [BackButton(), Text("Edit")],
                                        ),
                                      ),
                                    ),
                                    ...CategoryVal.mapData.keys.map(
                                      (e) => !['name', 'isActive'].contains(e)
                                          ? SizedBox.shrink()
                                          : e == 'isActive'
                                              ? ListTile(
                                                  title: CheckboxListTile(
                                                    value: CategoryVal.mapData['isActive'],
                                                    onChanged: (val) {},
                                                  ),
                                                )
                                              : ListTile(
                                                  title: TextFormField(
                                                    onChanged: (value) => CategoryVal.mapData[e] = value,
                                                    controller: TextEditingController(text: CategoryVal.mapData[e]),
                                                    decoration: InputDecoration(
                                                        filled: true, border: InputBorder.none, labelText: 'Name'),
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
                                              final res = await Rot.categoryUpdatePost(
                                                  body: {"data": jsonEncode(CategoryVal.mapData)});
                                              if (res.statusCode == 201) {
                                                SmartDialog.showToast("success");
                                                CategoryVal.reload.toggle();
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
                                        ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          leading: Text((CategoryVal.listCategory.value.val.indexOf(element) + 1).toString()),
                          title: Text(
                            element['name'].toString(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

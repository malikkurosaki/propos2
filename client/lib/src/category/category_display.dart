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
                  CategoryVal.isReload.value;
                  return FutureBuilder<http.Response>(
                    future: Rot.categoryListGet(),
                    builder: (con, snap) {
                      if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();

                      if (snap.data!.statusCode == 200) {
                        Future.delayed(
                          Duration(microseconds: 1),
                          () => CategoryVal.listCategory.assignAll(
                            jsonDecode(snap.data!.body),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  );
                },
              ),
              Flexible(
                child: Obx(
                  () => ListView(
                    children: [
                      ...CategoryVal.listCategory.map(
                        (element) => ListTile(
                          onTap: () {
                            debugPrint(element.toString());

                            CategoryVal.bodyUpdate.value = CategoryModel.fromJson(element);

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
                                    ListTile(
                                      title: TextFormField(
                                        onChanged: (value) => CategoryVal.bodyUpdate.value.name = value,
                                        controller: TextEditingController(text: CategoryVal.bodyUpdate.value.name),
                                        decoration:
                                            InputDecoration(filled: true, border: InputBorder.none, labelText: 'Name'),
                                      ),
                                    ),
                                    ListTile(
                                      title: MaterialButton(
                                        color: Colors.blue,
                                        onPressed: () {
                                          debugPrint(CategoryVal.bodyUpdate.value.toJson().toString());
                                          
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            "Save",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          leading: Text((CategoryVal.listCategory.indexOf(element) + 1).toString()),
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

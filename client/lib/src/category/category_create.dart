import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/category/category_val.dart';
import 'package:get/get.dart';

class CategoryCreate extends StatelessWidget {
  const CategoryCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text("Create Category"),
        ),
        FutureBuilder<http.Response>(
          future: Rot.categoryListCompanyGet(),
          builder: (ctx, snp) {
            if (snp.connectionState != ConnectionState.done) return LinearProgressIndicator();
            if (snp.data!.statusCode == 200) {
              Future.delayed(
                Duration(microseconds: 1),
                () => CategoryVal.listCompany.assignAll(
                  jsonDecode(snp.data!.body),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: false,
                child: Text(
                  CategoryVal.listCompany.toString(),
                ),
              ),
              ListTile(
                title: DropdownSearch<Map>(
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration:
                          InputDecoration(filled: true, border: InputBorder.none, hintText: 'Select Company')),
                  items: [...CategoryVal.listCompany],
                  itemAsString: (value) => value['name'].toString(),
                  onChanged: (value) {
                    CategoryVal.bodyCreate.value.val['companyId'] = value!['id'];
                  },
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => ListTile(
            title: TextFormField(
              onChanged: (value) => CategoryVal.bodyCreate.value.val['name'] = value,
              controller: TextEditingController(text: CategoryVal.bodyCreate.value.val['name']),
              decoration: InputDecoration(filled: true, border: InputBorder.none, hintText: "Name Category"),
            ),
          ),
        ),
        ListTile(
          title: MaterialButton(
            color: Colors.blue,
            onPressed: () async {
              final body = {
                "name": CategoryVal.bodyCreate.value.val['name'],
                "companyId": CategoryVal.bodyCreate.value.val['companyId']
              };

              if (body.values.contains("")) {
                SmartDialog.showToast("no empty please");
                return;
              }

              final data = await Rot.categoryCreatePost(body: {"data": jsonEncode(body)});
              if (data.statusCode == 201) {
                CategoryVal.bodyCreate.value.val['name'] = "";
                CategoryVal.bodyCreate.refresh();
                SmartDialog.showToast("Success");
                CategoryVal.isReload.toggle();
              } else {
                SmartDialog.showToast("failed");
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
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
  }
}

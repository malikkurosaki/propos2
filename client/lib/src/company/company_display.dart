import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/company/company_val.dart';

class CompanyDisplay extends StatelessWidget {
  const CompanyDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Card(
          child: ListView(
            children: [
              Obx(
                () {
                  CompanyVal.reload.value;
                  return SizedBox(
                    height: 4,
                    child: FutureBuilder<http.Response>(
                      future: Rot.companyListCompanyGet(),
                      builder: (con, snap) {
                        if (!snap.hasData) return LinearProgressIndicator();
                        () async {
                          if (snap.data!.statusCode == 200) {
                            await 0.1.delay();
                            CompanyVal.listCompany.value.val = jsonDecode(snap.data!.body);
                            CompanyVal.listCompany.refresh();
                          }
                        }();
                        return Container();
                      },
                    ),
                  );
                },
              ),
              Obx(
                () => CompanyVal.listCompany.value.val.isEmpty
                    ? Text("loading")
                    : Column(
                        children: [
                          ...CompanyVal.listCompany.value.val.map(
                            (e) => ListTile(
                              onTap: () {
                                CompanyVal.mapData.assignAll(e);
                                showBottomSheet(
                                  context: context,
                                  builder: (context) => Material(
                                    child: ListView(
                                      children: [
                                        Container(
                                          color: Colors.grey.shade100,
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            children: [BackButton(), Text("Edit Company")],
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
                                                        controller:
                                                            TextEditingController(text: CompanyVal.mapData[e] ?? ""),
                                                        decoration: InputDecoration(
                                                            filled: true,
                                                            border: InputBorder.none,
                                                            labelText: e.toString()),
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
                                                    final res = await Rot.companyUpdatePost(
                                                        body: {"data": jsonEncode(CompanyVal.mapData)});
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
                              },
                              leading: Text((CompanyVal.listCompany.value.val.indexOf(e) + 1).toString()),
                              title: Row(
                                children: [
                                  Text(e['name'].toString()),
                                ],
                              ),
                              trailing: Icon(
                                Icons.check_box,
                                color: e['isActive'] ? Colors.green : Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

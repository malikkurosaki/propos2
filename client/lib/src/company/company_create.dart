import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/rot.dart';
import 'package:http/http.dart' as http;
import 'package:propos/src/company/company_val.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CompanyCreate extends StatelessWidget {
  const CompanyCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => Material(
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              ListTile(
                leading: media.isMobile ? BackButton() : null,
                title: Text(
                  "Create Company",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              // SizedBox(
              //   height: 4,
              //   child: FutureBuilder<http.Response>(
              //     future: Rot.globalListCompanyGet(),
              //     builder: (con, snap) {
              //       if (!snap.hasData) return LinearProgressIndicator();
              //       () async {
              //         if (snap.data!.statusCode == 200) {
              //           await 0.1.delay();
              //           CompanyVal.listCompany.value.val = jsonDecode(snap.data!.body);
              //         }
              //       }();
              //       return SizedBox.shrink();
              //     },
              //   ),
              // ),
              // Flexible(
              //   child: Obx(() => ListTile(
              //         title: CompanyVal.listCompany.value.val.isEmpty
              //             ? Text("Select Company ...")
              //             : DropdownSearch<Map>(
              //                 dropdownDecoratorProps: DropDownDecoratorProps(
              //                     dropdownSearchDecoration: InputDecoration(
              //                         filled: true, border: InputBorder.none, hintText: 'Select Company')),
              //                 itemAsString: (val) => val['name'].toString(),
              //                 items: [...CompanyVal.listCompany.value.val],
              //                 onChanged: (val) {},
              //               ),
              //       )),
              // ),
              // ListTile(
              //   title: TextFormField(
              //     controller: TextEditingController(),
              //     decoration: InputDecoration(filled: true, border: InputBorder.none, labelText: 'Company'),
              //   ),
              // )
              ...CompanyVal.bodyCreate.value.toJson().keys.map(
                    (e) => e.toString() == 'id'
                        ? SizedBox.shrink()
                        : ListTile(
                            title: TextFormField(
                              onChanged: (val) {
                                final data = CompanyVal.bodyCreate.value.toJson();
                                data[e] = val;
                                CompanyVal.bodyCreate.value = CompanyModel.froJson(data);
                              },
                              controller: TextEditingController(),
                              decoration: InputDecoration(
                                  filled: true, border: InputBorder.none, labelText: e.toString().paramCase.toString()),
                            ),
                          ),
                  ),
              ListTile(
                title: MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    if (CompanyVal.bodyCreate.value.name == null || CompanyVal.bodyCreate.value.name!.isEmpty) {
                      SmartDialog.showToast("name not be empty");
                      return;
                    }
      
                    final data = Map.from(CompanyVal.bodyCreate.value.toJson());
                    data.removeWhere((key, value) => value == null);
      
                    final res = await Rot.companyCreatePost(body: {"data": jsonEncode(data)});
                    if (res.statusCode == 201) {
                      SmartDialog.showToast("success");
                    } else {
                      SmartDialog.showToast(res.body);
                    }
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
      ),
    );
  }
}

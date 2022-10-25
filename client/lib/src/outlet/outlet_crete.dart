import 'dart:convert';
import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:get/get.dart';
import 'package:propos/src/outlet/outlet_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OutletCreate extends StatelessWidget {
  OutletCreate({Key? key}) : super(key: key);

  final _listInput = <Map<String, dynamic>>[
    {"title": "name", "value": ""},
    {"title": "address", "value": ""},
    // { "title": "companyId", "value": OutletVal.bodyCreate.value.companyId},
    {"title": "email", "value": ""},
    {"title": "phone", "value": ""},
    {"title": "logoUrl", "value": ""},
    // { "title": "userId", "value": OutletVal.bodyCreate.value.userId},
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return Material(
        color: Colors.blue.shade50,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              ListTile(
                leading: media.isMobile ? BackButton() : null,
                title: Text(
                  "Create Outlet",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(
                height: 4,
                child: FutureBuilder<http.Response>(
                  future: Rot.globalListCompanyGet(),
                  builder: (con, snap) {
                    if (!snap.hasData) return LinearProgressIndicator();
                    () async {
                      if (snap.data!.statusCode == 200) {
                        await 0.1.delay();
                        OutletVal.listCompanyCreate.assignAll(jsonDecode(snap.data!.body));
                      }
                    }();
                    return SizedBox.shrink();
                  },
                ),
              ),
              Obx(
                () {
                  return ListTile(
                    title: OutletVal.listCompanyCreate.isEmpty
                        ? Text("Select Company")
                        : DropdownSearch<Map>(
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration:
                                    InputDecoration(filled: true, border: InputBorder.none, hintText: 'Select Company')),
                            items: [...OutletVal.listCompanyCreate],
                            itemAsString: (value) => value['name'].toString(),
                            onChanged: (val) {
                              OutletVal.companyId = val!['id'];
                            },
                          ),
                  );
                },
              ),
              ..._listInput.map(
                (e) => ListTile(
                  title: TextFormField(
                    onChanged: (value) {
                      e['value'] = value;
                    },
                    controller: TextEditingController(text: e['value']),
                    decoration: InputDecoration(
                      labelText: e['title'],
                      filled: true,
                      border: InputBorder.none,
                      hintText: e['title'],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    final data = {};
                    for (final itm in _listInput) {
                      data[itm['title']] = itm['value'];
                    }
      
                    final bodyData = OutletModel.fromJson(data);
                    bodyData.companyId = OutletVal.companyId;
      
                    if (bodyData.companyId!.isEmpty) {
                      SmartDialog.showToast("company no emplty please");
                      return;
                    }
      
                    if (bodyData.name!.isEmpty) {
                      SmartDialog.showToast("name no empty");
                      return;
                    }
      
                    final res = await Rot.outletCreatePost(body: {"data": jsonEncode(bodyData.toJson())});
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
      );
    });
  }
}

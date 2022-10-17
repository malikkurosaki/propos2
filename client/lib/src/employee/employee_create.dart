import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/employee/employee_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EmployeeCreate extends StatelessWidget {
  const EmployeeCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) {
        return Material(
          child: Column(
            children: [
              ListTile(
                leading: media.isMobile? BackButton(): null,
                title: Text(
                  "Create Employee",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(
                height: 2,
                child: FutureBuilder<http.Response>(
                  future: Rot.globalListCompanyGet(),
                  builder: (con, snap) {
                    if (!snap.hasData) return LinearProgressIndicator();
                    () async {
                      if (snap.data!.statusCode == 200) {
                        await 0.1.delay();
                        EmployeeVal.listCompanyCreate.assignAll(jsonDecode(snap.data!.body));
                      }
                    }();
                    return SizedBox.shrink();
                  },
                ),
              ),
              Obx(
                () => ListTile(
                  title: EmployeeVal.listCompanyCreate.isEmpty
                      ? Text("Select Company")
                      : DropdownSearch<Map>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  InputDecoration(filled: true, border: InputBorder.none, hintText: 'Select Company')),
                          items: [...EmployeeVal.listCompanyCreate],
                          itemAsString: (value) => value['name'].toString(),
                          onChanged: (value) {
                            EmployeeVal.bodyCreate.value.companyId = value!['id'];
                            EmployeeVal.listOutlet.assignAll(value['Outlet']);
                          },
                        ),
                ),
              ),
              Obx(
                () => ListTile(
                  title: EmployeeVal.listOutlet.isEmpty
                      ? Text("Select Outlet")
                      : DropdownSearch<Map>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  InputDecoration(filled: true, border: InputBorder.none, hintText: 'Select Outlet')),
                          items: [...EmployeeVal.listOutlet],
                          itemAsString: (value) => value['name'].toString(),
                          onChanged: (value) {
                            EmployeeVal.bodyCreate.value.outletId = value!['id'];
                          },
                        ),
                ),
              ),
              ListTile(
                title: TextField(
                  onChanged: (val) => EmployeeVal.bodyCreate.value.name = val,
                  controller: TextEditingController(text: EmployeeVal.bodyCreate.value.name),
                  decoration: InputDecoration(filled: true, border: InputBorder.none, hintText: 'Employee Name'),
                ),
              ),
              ListTile(
                title: TextField(
                  onChanged: (val) => EmployeeVal.bodyCreate.value.password = val,
                  controller: TextEditingController(text: EmployeeVal.bodyCreate.value.password),
                  decoration: InputDecoration(filled: true, border: InputBorder.none, hintText: 'Employee Password'),
                ),
              ),
              ListTile(
                title: MaterialButton(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final data = EmployeeVal.bodyCreate.value.toJson();
                    data.removeWhere((key, value) => value == null);

                    final res = await Rot.employeeCreatePost(body: {"data": jsonEncode(data)});
                    if (res.statusCode == 200) {
                      SmartDialog.showToast("success");
                      EmployeeVal.reload.toggle();
                    } else {
                      SmartDialog.showToast(res.body);
                    }
                  },
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

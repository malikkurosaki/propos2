import 'dart:convert';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/components/select_company.dart';
import 'package:propos/components/select_outlet_by_company.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/val_def.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Employee extends StatelessWidget {
  Employee({Key? key}) : super(key: key);
  final _conName = TextEditingController();
  final _conPassword = TextEditingController();

  final _editVal = "".obs;
  final _listEmployee = [].obs;

  _loadListEmployee() async {
    RouterApi.employeeByUser().getData().then((value) {
      debugPrint("value.body");
      if (value.statusCode == 200) _listEmployee.assignAll(jsonDecode(value.body));
    });
  }

  _onload() async {
    _loadListEmployee();
    // final data = await RouterApi.listEmployee().getData();
    // if (data.statusCode == 200) _listEmployee.assignAll(jsonDecode(data.body));
  }

  @override
  Widget build(BuildContext context) {
    _onload();

    return ResponsiveBuilder(builder: (context, media) {
      return SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: _listUser(),
                  ),
                  Visibility(visible: media.isDesktop, child: Card(child: _createEmployee(media)))
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _listUser() {
    return Obx(
      () => _listEmployee.isEmpty
          ? Center(child: Text("User empty ...?"))
          : ContainedTabBarView(
              tabs: [
                ..._listEmployee.map(
                  (e) => ListTile(title: Text(e['name'].toString())),
                )
              ],
              views: [
                ..._listEmployee.map(
                  (e) => (e['Outlet'] as List).isEmpty
                      ? Text("empty")
                      : Builder(
                          builder: (context) {
                            final lsOutlet = (e['Outlet'] as List);
                            return ContainedTabBarView(
                              tabs: [
                                ...lsOutlet.map(
                                  (e) => ListTile(title: Text(e['name'].toString())),
                                )
                              ],
                              views: [
                                ...lsOutlet.map(
                                  (e) => Builder(
                                    builder: (context) {
                                      final lsEmployee = (e['Employee'] as List);
                                      return Column(
                                        children: [
                                          ListTile(
                                            leading: Checkbox(value: false, onChanged: (value) {}),
                                            title: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.search),
                                                  suffixIcon: IconButton(icon: Icon(Icons.close), onPressed: () {}),
                                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                                  filled: true,
                                                  hintText: "Search",
                                                  isDense: true
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView(
                                              controller: ScrollController(),
                                              children: [
                                                ...lsEmployee.map(
                                                  (e) => ListTile(
                                                    leading: Checkbox(value: false, onChanged: (value) {}),
                                                    trailing: PopupMenuButton(
                                                      itemBuilder: (context) => [
                                                        PopupMenuItem(
                                                          value: "edit",
                                                          child: Text("Edit"),
                                                        ),
                                                        PopupMenuItem(
                                                          value: "delete",
                                                          child: Text("Delete"),
                                                        ),
                                                      ],
                                                    ),
                                                    title: Text(e['name'].toString()),
                                                    onTap: () {},
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                )
              ],
            ),
    );
  }

  Widget _createEmployee(SizingInformation media) {
    final selectCompanyId = "".obs;
    final selectOutletId = "".obs;
    final name = TextEditingController();
    final password = TextEditingController();

    return SizedBox(
      width: media.isMobile ? Get.width : 360,
      height: media.isMobile ? Get.height / 2 : Get.height * 0.92,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Create Employee",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: ListView(
              controller: ScrollController(),
              children: [
                SelectCompany(onSelectCompany: (cosmpanyId) {
                  selectCompanyId.value = cosmpanyId;
                }),
                Obx(
                  () => SelectOoutletByCompany(
                      onSelectOutlet: (value) {
                        selectOutletId.value = value;
                      },
                      companyId: selectCompanyId.value),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                        labelText: "Name", filled: true, border: OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                        labelText: "Password", filled: true, border: OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: Colors.cyan,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "Create",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final body = {
                        "name": name.text,
                        "password": password.text,
                        "companyId": selectCompanyId.value,
                        "outletId": selectOutletId.value,
                      };

                      if (body.values.contains("")) {
                        SmartDialog.showToast('Please fill all the fields');
                        return;
                      }

                      final createEmplyee = await RouterApi.createEmployee().postData(body);

                      if (createEmplyee.statusCode == 201) {
                        SmartDialog.showToast("Employee Created");
                        _loadListEmployee();
                      } else {
                        debugPrint(createEmplyee.body);
                        SmartDialog.showToast("Error");
                      }

                      if (media.isMobile) Get.back();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

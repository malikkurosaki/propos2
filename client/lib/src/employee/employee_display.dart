import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/developer/developer_val.dart';
import 'package:propos/src/employee/employee_create.dart';
import 'package:propos/src/employee/employee_edit.dart';
import 'package:propos/src/employee/employee_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EmployeeDisplay extends StatelessWidget {
  EmployeeDisplay({Key? key}) : super(key: key);

  final _ls = [
    {"tit": "No", "wid": 40, "fid": 'no'},
    {"tit": "Name", "wid": 300, "fid": 'name'},
    // {"tit": "Password", "wid": 100, "fid": 'password'},
    // {"tit": "Is Active", "wid": 100, "fid": 'isActive'},
    // {"tit": "Action", "wid": 100, "fid": 'act'},
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => Scaffold(
        floatingActionButton: !media.isMobile
            ? null
            : FloatingActionButton(
                onPressed: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) => EmployeeCreate(),
                  );
                },
                child: Icon(Icons.add),
              ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                SizedBox(
                  height: 4,
                  child: FutureBuilder<http.Response>(
                    future: Rot.globalListCompanyGet(),
                    builder: (con, snap) {
                      if (!snap.hasData) return LinearProgressIndicator();
                      if (snap.data!.statusCode == 200) {
                        () async {
                          await 0.1.delay();
                          EmployeeVal.listCompanyDisplay.assignAll(jsonDecode(snap.data!.body));
                        }();
                      }
                      return Container();
                    },
                  ),
                ),
                Obx(
                  () => ListTile(
                    title: DropdownSearch<Map>(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration:
                              InputDecoration(filled: true, border: InputBorder.none, hintText: 'Select Company')),
                      items: [...EmployeeVal.listCompanyDisplay],
                      itemAsString: (val) => val['name'].toString(),
                      onChanged: (val) async {
                        final res = await Rot.employeeListByCompanyIdGet(query: "companyId=${val!['id']}");
                        if (res.statusCode == 200) {
                          EmployeeVal.listEmployee.value.val = jsonDecode(res.body);
                          EmployeeVal.listEmployee.refresh();
                        } else {
                          SmartDialog.showToast(res.body);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                  child: Obx(
                    () {
                      EmployeeVal.reload.value;
                      return SizedBox(
                        height: 4,
                        child: FutureBuilder<http.Response>(
                          future: Rot.employeeListGet(),
                          builder: (con, snap) {
                            if (!snap.hasData) return LinearProgressIndicator();
                            () async {
                              if (snap.data!.statusCode == 200) {
                                await 0.1.delay();
                                EmployeeVal.listEmployee.value.val = jsonDecode(snap.data!.body);
                                EmployeeVal.listEmployee.refresh();
                              }
                            }();
                            return Container();
                          },
                        ),
                      );
                    },
                  ),
                ),
                Obx(
                  () {
                    return Column(
                      children: [
                        ...EmployeeVal.listEmployee.value.val.map((el) => ListTile(
                                  leading: Text((EmployeeVal.listEmployee.value.val.indexOf(el) + 1).toString()),
                                  trailing: Icon(
                                    Icons.check_box,
                                    color: el['isActive'] ? Colors.green : Colors.grey,
                                  ),
                                  title: Text(el['name'].toString()),
                                  subtitle: !DeveloperVal.showId.value.val ? null : Text(el['id'].toString()),
                                  onTap: () {
                                    EmployeeVal.mapData.assignAll(el);
                                    showBottomSheet(
                                      context: context,
                                      builder: (context) => EmployeeEdit(),
                                    );
                                  },
                                )
                            // InkWell(
                            //   onTap: () {
                            //     EmployeeVal.bodyEdit.value = EmployeeModel.fromJson(el);
                            //     showBottomSheet(
                            //       context: context,
                            //       builder: (context) => Material(
                            //         child: ListView(
                            //           children: [
                            //             Container(
                            //               padding: EdgeInsets.all(8),
                            //               color: Colors.grey.shade100,
                            //               child: Row(
                            //                 children: [BackButton(), Text("Edit Employee")],
                            //               ),
                            //             ),
                            //             ListTile(
                            //               title: TextFormField(
                            //                 controller: TextEditingController(text: EmployeeVal.bodyEdit.value.name),
                            //                 decoration: InputDecoration(
                            //                   labelText: 'Name',
                            //                   filled: true,
                            //                   border: InputBorder.none,
                            //                 ),
                            //               ),
                            //             ),
                            //             ListTile(
                            //               title: TextFormField(
                            //                 controller:
                            //                     TextEditingController(text: EmployeeVal.bodyEdit.value.password),
                            //                 decoration: InputDecoration(
                            //                   labelText: 'Password',
                            //                   filled: true,
                            //                   border: InputBorder.none,
                            //                 ),
                            //               ),
                            //             ),
                            //             Obx(() => ListTile(
                            //                   title: CheckboxListTile(
                            //                     title: Text("Active"),
                            //                     value: EmployeeVal.bodyEdit.value.isActive,
                            //                     onChanged: (value) {
                            //                       EmployeeVal.bodyEdit.value.isActive = value;
                            //                       EmployeeVal.bodyEdit.refresh();
                            //                     },
                            //                   ),
                            //                 )),
                            //             ListTile(
                            //               title: MaterialButton(
                            //                 color: Colors.blue,
                            //                 onPressed: () {},
                            //                 child: Padding(
                            //                   padding: const EdgeInsets.all(10.0),
                            //                   child: Text(
                            //                     "Save",
                            //                     style: TextStyle(color: Colors.white),
                            //                   ),
                            //                 ),
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //       ),
                            //     );
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Row(
                            //       children: [
                            //         ..._ls.map(
                            //           (e) => SizedBox(
                            //             width: e['wid'] as double,
                            //             child: (e['fid'] as String) == "no"
                            //                 ? Text((EmployeeVal.listEmployee.value.val.indexOf(el) + 1).toString())
                            //                 : Text(el[e['fid']] ?? ""),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            )
                      ],
                    );
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

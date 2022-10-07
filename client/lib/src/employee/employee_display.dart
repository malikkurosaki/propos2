import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
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
        body: Builder(builder: (context) {
          return Column(
            children: [
              Obx(
                () {
                  EmployeeVal.isReloadList.value;
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
              Flexible(
                child: Obx(
                  () {
                    return Card(
                      child: ListView(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     children: [
                          //       ..._ls.map(
                          //         (e) => SizedBox(
                          //           width: e['wid'] as double,
                          //           child: Text(
                          //             e['tit'] as String,
                          //             style: TextStyle(fontWeight: FontWeight.bold),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          ...EmployeeVal.listEmployee.value.val.map(
                            (el) => InkWell(
                              onTap: () {
                                EmployeeVal.bodyEdit.value = EmployeeModel.fromJson(el);
                                showBottomSheet(
                                  context: context,
                                  builder: (context) => Material(
                                    child: ListView(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          color: Colors.grey.shade100,
                                          child: Row(
                                            children: [BackButton(), Text("Edit Employee")],
                                          ),
                                        ),
                                        ListTile(
                                          title: TextFormField(
                                            controller: TextEditingController(text: EmployeeVal.bodyEdit.value.name),
                                            decoration: InputDecoration(
                                              labelText: 'Name',
                                              filled: true,
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          title: TextFormField(
                                            controller:
                                                TextEditingController(text: EmployeeVal.bodyEdit.value.password),
                                            decoration: InputDecoration(
                                              labelText: 'Password',
                                              filled: true,
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        Obx(() => ListTile(
                                              title: CheckboxListTile(
                                                title: Text("Active"),
                                                value: EmployeeVal.bodyEdit.value.isActive,
                                                onChanged: (value) {
                                                  EmployeeVal.bodyEdit.value.isActive = value;
                                                  EmployeeVal.bodyEdit.refresh();
                                                },
                                              ),
                                            )),
                                        ListTile(
                                          title: MaterialButton(
                                            color: Colors.blue,
                                            onPressed: () {},
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ..._ls.map(
                                      (e) => SizedBox(
                                        width: e['wid'] as double,
                                        child: (e['fid'] as String) == "no"
                                            ? Text((EmployeeVal.listEmployee.value.val.indexOf(el) + 1).toString())
                                            : Text(el[e['fid']] ?? ""),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

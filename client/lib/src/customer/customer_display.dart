import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:propos/menus/customer.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/customer/customer_val.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CustomerDisplay extends StatelessWidget {
  const CustomerDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Card(
          child: ListView(
            children: [
              FutureBuilder<http.Response>(
                future: Rot.globalListCompanyGet(),
                builder: (con, snap) {
                  if (!snap.hasData) return LinearProgressIndicator();
                  () async {
                    if (snap.data!.statusCode == 200) {
                      await 0.1.delay();
                      CustomerVal.listCompanyDisplay.assignAll(jsonDecode(snap.data!.body));
                    }
                  }();
                  return Container();
                },
              ),
              Obx(
                () => ListTile(
                  title: DropdownSearch<Map>(
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Select Customer',
                            labelText: 'customer')),
                    items: [...CustomerVal.listCompanyDisplay],
                    itemAsString: (val) => val['name'],
                  ),
                ),
              ),
              Obx(() {
                CustomerVal.reload.value;
                return SizedBox(
                  child: FutureBuilder<http.Response>(
                    future: Rot.customerListCustomerGet(),
                    builder: (context, snap) {
                      if (!snap.hasData) return LinearProgressIndicator();
                      () async {
                        await 0.1.delay();
                        CustomerVal.listCustomer.value.val = jsonDecode(snap.data!.body);
                        CustomerVal.listCustomer.refresh();
                      }();
                      return Container();
                    },
                  ),
                );
              }),
              Obx(
                () => Column(
                  children: [
                    ...CustomerVal.listCustomer.value.val.map(
                      (element) => ListTile(
                        leading: Text((CustomerVal.listCustomer.value.val.indexOf(element) + 1).toString()),
                        trailing: Icon(
                          Icons.check_box,
                          color: element['isActive'] ? Colors.green : Colors.grey,
                        ),
                        title: Text(
                          element['name'].toString(),
                        ),
                        onTap: () {
                          CustomerVal.mapData.assignAll(element);
                          showBottomSheet(
                            context: context,
                            builder: (context) => Material(
                              child: ListView(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.grey.shade100,
                                    child: Row(
                                      children: [BackButton(), Text("Edit Customr")],
                                    ),
                                  ),
                                  ...CustomerVal.mapData.keys.map(
                                    (e) => !['name', 'address', 'phone', 'email', 'whatsapp', 'isActive'].contains(e)
                                        ? SizedBox.shrink()
                                        : e == 'isActive'
                                            ? Obx(() => ListTile(
                                                  title: CheckboxListTile(
                                                    title: Text("Is Active ?"),
                                                    value: CustomerVal.mapData['isActive'],
                                                    onChanged: (val) {
                                                      CustomerVal.mapData['isActive'] = val;
                                                    },
                                                  ),
                                                ))
                                            : ListTile(
                                                title: TextFormField(
                                                  onChanged: (val) => CustomerVal.mapData[e] = val,
                                                  controller: TextEditingController(text: element[e] ?? ""),
                                                  decoration: InputDecoration(
                                                      filled: true, border: InputBorder.none, labelText: e.toString()),
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
                                              child: Center(
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(color: Colors.white),
                                                ),
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
                                              final data = Map.from(CustomerVal.mapData);
                                              data.removeWhere((key, value) => value == null);
                                              final res =
                                                  await Rot.customerUpdatePost(body: {"data": jsonEncode(data)});
                                              if (res.statusCode == 201) {
                                                CustomerVal.reload.toggle();
                                                SmartDialog.showToast("success");
                                                Get.back();
                                              } else {
                                                SmartDialog.showToast(res.body);
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Center(
                                                child: Text(
                                                  "Update",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
              // Obx(
              //   () => Column(
              //     children: [
              //       Visibility(visible: false, child: Text(CustomerVal.reload.value.toString())),
              //       FutureBuilder<http.Response>(
              //         future: Rot.customerListCustomerGet(),
              //         builder: (context, snap) {
              //           if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();

              //           if (snap.data!.statusCode == 200) {
              //             final lsDat = jsonDecode(snap.data!.body);
              //             Future.delayed(Duration(microseconds: 100), () => CustomerVal.listCustomer.assignAll(lsDat));
              //           }
              //           return SizedBox.shrink();
              //         },
              //       ),
              //       FutureBuilder<http.Response>(
              //         future: Rot.customerListCompanyGet(),
              //         builder: (ctx, snap) {
              //           if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();
              //           if (snap.data!.statusCode == 200) {
              //             final lsdata = jsonDecode(snap.data!.body);
              //             Future.delayed(Duration(microseconds: 100), () => CustomerVal.listCompany.assign(lsdata));
              //           }
              //           return SizedBox.shrink();
              //         },
              //       )
              //     ],
              //   ),
              // ),
              // Obx(
              //   () => ListTile(
              //     title: DropdownSearch<Map>(
              //       items: [...CustomerVal.listCompany],
              //       itemAsString: (value) => value['name'].toString(),
              //       dropdownDecoratorProps: DropDownDecoratorProps(
              //         dropdownSearchDecoration:
              //             InputDecoration(filled: true, border: InputBorder.none, hintText: 'select company'),
              //       ),
              //       onChanged: (value) {},
              //     ),
              //   ),
              // ),
              // Flexible(
              //   child: Obx(
              //     () => ListView(
              //       children: [
              //         ...CustomerVal.listCustomer.map(
              //           (element) => Column(
              //             children: [
              //               ListTile(
              //                 title: Text(element['name'].toString()),
              //               ),
              //               DottedLine()
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        );
      }),
    );
  }
}

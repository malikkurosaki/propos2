import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/outlet/outlet_val.dart';

class OutletDisplay extends StatelessWidget {
  const OutletDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Card(
          child: ListView(
            children: [
              SizedBox(
                height: 4,
                child: FutureBuilder<http.Response>(
                  future: Rot.globalListCompanyGet(),
                  builder: (con, snap) {
                    if (!snap.hasData) return LinearProgressIndicator();
                    () async {
                      if (snap.data!.statusCode == 200) {
                        () async {
                          if (snap.data!.statusCode == 200) {
                            await 0.1.delay();
                            OutletVal.listCompanyDisplay.assignAll(jsonDecode(snap.data!.body));
                          }
                        }();
                      }
                    }();
                    return Container();
                  },
                ),
              ),
              Obx(
                () => ListTile(
                  title: OutletVal.listCompanyDisplay.isEmpty
                      ? Text("Select Company")
                      : DropdownSearch<Map>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  InputDecoration(filled: true, border: InputBorder.none, hintText: 'Select Company')),
                          items: [...OutletVal.listCompanyDisplay],
                          itemAsString: (val) => val['name'].toString(),
                          onChanged: (val) async {
                            final res = await Rot.outletListOutletByBompanyIdGet(query: 'companyId=${val!["id"]}');
                            if (res.statusCode == 200) {
                              // debugPrint(res.body);
                              OutletVal.listoutlet.value.val = jsonDecode(res.body);
                              OutletVal.listoutlet.refresh();
                            } else {
                              SmartDialog.showToast(res.body);
                            }
                          },
                        ),
                ),
              ),
              Obx(() {
                OutletVal.reload.value;
                return SizedBox(
                  height: 4,
                  child: FutureBuilder<http.Response>(
                    future: Rot.outletListOutletGet(),
                    builder: (con, snap) {
                      if (!snap.hasData) return LinearProgressIndicator();
                      if (snap.data!.statusCode == 200) {
                        () async {
                          await 0.1.delay();
                          final ls = List<Map<String, dynamic>>.from(jsonDecode(snap.data!.body));
                          OutletVal.listoutlet.value.val = ls;
                          OutletVal.listoutlet.refresh();
                        }();
                      }
                      return Container();
                    },
                  ),
                );
              }),
              Obx(
                () => Column(
                  children: [
                    ...OutletVal.listoutlet.value.val.map(
                      (e) => ListTile(
                        leading: Text((OutletVal.listoutlet.value.val.indexOf(e) + 1).toString()),
                        title: Text(e['name'].toString()),
                        trailing: Icon(
                          Icons.check_box,
                          color: e['isActive'] ? Colors.green : Colors.grey,
                        ),
                        onTap: () {
                          // final mapData = Map.from(e);
                          OutletVal.mapData.assignAll(e);
                          showBottomSheet(
                            context: context,
                            builder: (context) => Material(
                              child: Obx(() {
                                return ListView(
                                  children: [
                                    Container(
                                      color: Colors.grey.shade100,
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: [BackButton(), Text("Edit Outlet")],
                                      ),
                                    ),
                                    ...OutletVal.mapData.keys.map(
                                      (el) => !['name', 'address', 'email', 'phone', 'logoUrl', 'isActive'].contains(el)
                                          ? SizedBox.shrink()
                                          : el.toString() == 'isActive'
                                              ? ListTile(
                                                  title: CheckboxListTile(
                                                    title: Text("Is Active ?"),
                                                    onChanged: (val) {
                                                      OutletVal.mapData[el] = val;
                                                    },
                                                    value: OutletVal.mapData[el],
                                                  ),
                                                )
                                              : ListTile(
                                                  title: TextFormField(
                                                    onChanged: (val) => OutletVal.mapData[el] = val,
                                                    controller: TextEditingController(text: e[el] ?? ""),
                                                    decoration: InputDecoration(
                                                      labelText: el,
                                                      filled: true,
                                                      border: InputBorder.none,
                                                    ),
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
                                                final res = await Rot.outletUpdatePost(
                                                    body: {"data": jsonEncode(OutletVal.mapData)});
                                                if (res.statusCode == 201) {
                                                  SmartDialog.showToast("success");
                                                  OutletVal.reload.toggle();
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
                                        )
                                      ],
                                    )
                                  ],
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    )
                    // ...OutletVal.listoutlet.value.val.map(
                    //   (element) => Card(
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Column(
                    //         children: [
                    //           ...element.keys.map(
                    //             (e) => Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: e == 'id'
                    //                   ? SizedBox.shrink()
                    //                   : Row(
                    //                       children: [
                    //                         Expanded(
                    //                           flex: 1,
                    //                           child: Text(
                    //                             e.toString(),
                    //                           ),
                    //                         ),
                    //                         Expanded(
                    //                           flex: 4,
                    //                           child: e == 'id'
                    //                               ? SizedBox.shrink()
                    //                               : Text(
                    //                                   element[e] ?? "",
                    //                                 ),
                    //                         )
                    //                       ],
                    //                     ),
                    //             ),
                    //           ),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.end,
                    //             children: [
                    //               IconButton(
                    //                   onPressed: () {
                    //                     final dataUpdate = OutletModel.fromJson(element);

                    //                     showBottomSheet(
                    //                       context: context,
                    //                       builder: (context) => Material(
                    //                         child: ListView(
                    //                           children: [
                    //                             Container(
                    //                               color: Colors.grey.shade100,
                    //                               padding: EdgeInsets.all(8),
                    //                               child: Row(
                    //                                 children: [BackButton(), Text("Edit Outlet")],
                    //                               ),
                    //                             ),
                    //                             ...dataUpdate.toJson().keys.map(
                    //                                   (e) => ['id', 'userId', 'companyId'].contains(e.toString())
                    //                                       ? Container()
                    //                                       : ListTile(
                    //                                           title: TextFormField(
                    //                                             controller: TextEditingController(text: element[e]),
                    //                                             decoration: InputDecoration(
                    //                                                 filled: true,
                    //                                                 border: InputBorder.none,
                    //                                                 label: Text(e.toString())),
                    //                                           ),
                    //                                         ),
                    //                                 ),
                    //                                 Row(
                    //                                   children: [
                    //                                     Expanded(
                    //                                       child: ListTile(
                    //                                         title: MaterialButton(
                    //                                           color: Colors.pink,
                    //                                           onPressed: (){

                    //                                           }, child: Padding(
                    //                                           padding: const EdgeInsets.all(10),
                    //                                           child: Text("Delete", style: TextStyle(
                    //                                             color: Colors.white
                    //                                           ),),
                    //                                         ),),
                    //                                       ),
                    //                                     ),
                    //                                     Expanded(
                    //                                       child: ListTile(
                    //                                         title: MaterialButton(
                    //                                           color: Colors.orange,
                    //                                           onPressed: (){

                    //                                           }, child: Padding(
                    //                                           padding: const EdgeInsets.all(10),
                    //                                           child: Text("Update", style: TextStyle(
                    //                                             color: Colors.white
                    //                                           ),),
                    //                                         ),),
                    //                                       ),
                    //                                     ),
                    //                                   ],
                    //                                 )
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     );
                    //                   },
                    //                   icon: Icon(
                    //                     Icons.edit,
                    //                     color: Colors.blue,
                    //                   ))
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // )
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

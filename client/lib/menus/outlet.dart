import 'dart:convert';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/val_def.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class Outlet extends StatelessWidget {
  Outlet({Key? key}) : super(key: key);
  final _eidtVal = "".obs;
  final _listOutlet = [].obs;

  _loadOutlet() async {
    final data = await RouterApi.outletCompanyList().getData();
    if (data.statusCode == 200) _listOutlet.assignAll(jsonDecode(data.body));
  }

  @override
  Widget build(BuildContext context) {
    _loadOutlet();
    debugPrint('Outlet.build');
    return ResponsiveBuilder(
      builder: (context, media) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Expanded(
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Text(
                                //       'List Outlet',
                                //       style: TextStyle(
                                //         fontSize: 16,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Visibility(
                                  visible: media.isMobile,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: Colors.cyan,
                                      ),
                                      onPressed: () {
                                        Get.dialog(
                                          SimpleDialog(
                                            children: [_create(media)],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Obx(() => _listOutlet.isEmpty
                                  ? Text("empty")
                                  : SizedBox(
                                      width: double.infinity,
                                      child: ContainedTabBarView(
                                        tabs: [
                                          ..._listOutlet.map(
                                            (e) {
                                              return Tab(
                                                child: Text(e['name'].toString()),
                                              );
                                            },
                                          ),
                                        ],
                                        views: [
                                          ..._listOutlet.map(
                                            (e) {
                                              return Container(
                                                child: ListView(
                                                  children: [
                                                    ...(e['Outlet'] as List).map(
                                                      (e) {
                                                        return ListTile(
                                                          leading: Icon(Icons.shopping_bag_outlined),
                                                          title: Text(e['name']),
                                                          trailing: PopupMenuButton(itemBuilder: (context) => [
                                                            PopupMenuItem(child: Text('Edit'), value: 'edit'),
                                                            PopupMenuItem(child: Text('Delete'), value: 'delete'),
                                                          ],),
                                                        );
                                                      },
                                                    ).toList(),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    )),
                            )
                            // Flexible(
                            //   child: Obx(
                            //     () => ListView(
                            //       children: [
                            //         for (final outlet in _listOutlet)
                            //           _eidtVal.value == outlet['id']
                            //               ? Builder(builder: (context) {
                            //                   final conName = TextEditingController(text: outlet['name']);
                            //                   return Card(
                            //                     child: ListTile(
                            //                       leading: IconButton(
                            //                           onPressed: () {
                            //                             _eidtVal.value = "";
                            //                           },
                            //                           icon: Icon(
                            //                             Icons.close,
                            //                             color: Colors.pink,
                            //                           )),
                            //                       title: TextFormField(
                            //                         controller: conName,
                            //                         decoration: InputDecoration(
                            //                           filled: true,
                            //                           border: OutlineInputBorder(
                            //                             borderSide: BorderSide.none,
                            //                           ),
                            //                           labelText: 'Nama Outlet',
                            //                         ),
                            //                       ),
                            //                       trailing: IconButton(
                            //                           onPressed: () async {
                            //                             final body = {
                            //                               'id': outlet['id'],
                            //                               'name': conName.value.text,
                            //                             };

                            //                             if (body.values.contains("")) {
                            //                               SmartDialog.showToast("Data tidak boleh kosong");
                            //                               return;
                            //                             }

                            //                             await RouterApi.outletUpdate().putData(body);
                            //                             await _loadOutlet();
                            //                           },
                            //                           icon: Icon(
                            //                             Icons.save,
                            //                             color: Colors.green,
                            //                           )),
                            //                     ),
                            //                   );
                            //                 })
                            //               : ListTile(
                            //                   leading: IconButton(
                            //                     onPressed: () {
                            //                       _eidtVal.value = outlet['id'];
                            //                     },
                            //                     icon: Icon(Icons.edit, color: Colors.cyan),
                            //                   ),
                            //                   title: Text(outlet['name'].toString()),
                            //                   trailing: IconButton(
                            //                     onPressed: () async {
                            //                       Get.dialog(
                            //                         AlertDialog(
                            //                           content: Text('Are you sure?'),
                            //                           actions: [
                            //                             MaterialButton(
                            //                               child: Text('Yes'),
                            //                               onPressed: () async {
                            //                                 final body = {
                            //                                   "id": outlet['id'],
                            //                                 };
                            //                                 await RouterApi.outletDelete().deleteData(body);
                            //                                 await _loadOutlet();
                            //                                 Get.back();
                            //                               },
                            //                             ),
                            //                             MaterialButton(
                            //                               child: Text('No'),
                            //                               onPressed: () {
                            //                                 Get.back();
                            //                               },
                            //                             ),
                            //                           ],
                            //                         ),
                            //                       );
                            //                     },
                            //                     icon: Icon(
                            //                       Icons.delete,
                            //                       color: Colors.pink,
                            //                     ),
                            //                   ),
                            //                 ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(visible: !media.isMobile, child: Card(child: _create(media)))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _create(SizingInformation media) {
    final conName = TextEditingController();
    final conCompanyId = TextEditingController();

    return SizedBox(
      width: media.isMobile ? Get.width : 360,
      height: media.isMobile ? 360 : Get.height * 0.92,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Create outlet",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(
              builder: (context) {
                final lsCompany = [].obs;
                RouterApi.listCompany().getData().then((data) {
                  if (data.statusCode == 200) lsCompany.assignAll(jsonDecode(data.body));
                });
                return Obx(
                  () => DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: "Company",
                        isDense: true,
                        filled: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none)),
                    items: [
                      ...lsCompany
                          .map((element) => DropdownMenuItem(value: element, child: Text(element['name'])))
                          .toList()
                    ],
                    onChanged: (value) {
                      conCompanyId.text = (value as Map)['id'];
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: conName,
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Colors.cyan,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "CREATE",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onPressed: () async {
                final body = {"name": conName.text, "companyId": conCompanyId.text};

                if (body.values.contains("")) {
                  SmartDialog.showToast("Please fill all field");
                  return;
                }

                await RouterApi.outletCreate().postData(body);

                await _loadOutlet();
                conName.clear();

                if (media.isMobile) {
                  Get.back();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

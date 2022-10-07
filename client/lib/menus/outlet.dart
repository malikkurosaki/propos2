import 'dart:convert';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/components/app_bar_image.dart';
import 'package:propos/src/outlet/outlet_crete.dart';
import 'package:propos/src/outlet/outlet_display.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/val_def.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class Outlet extends StatelessWidget {
  Outlet({Key? key}) : super(key: key);
  final _eidtVal = "".obs;
  final _listCompany = [].obs;

  _loadOutlet() async {
    final data = await RouterApi.outletCompanyList().getData();
    if (data.statusCode == 200) _listCompany.assignAll(jsonDecode(data.body));
  }

  @override
  Widget build(BuildContext context) {
    // _loadOutlet();
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
                      child: OutletDisplay(),
                    ),
                    Visibility(
                      visible: !media.isMobile,
                      child: SizedBox(
                        width: media.isMobile ? Get.width : 460,
                        child: OutletCreate(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _listDisplay(SizingInformation media) {
    return Scaffold(
      floatingActionButton: !media.isMobile
          ? null
          : FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Get.dialog(
                  SimpleDialog(
                    children: [_create(media)],
                  ),
                );
              },
            ),
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarImage(),
            // Row(
            //   children: [
            //     Visibility(
            //       visible: media.isMobile,
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: IconButton(
            //           icon: Icon(
            //             Icons.add_circle,
            //             color: Colors.cyan,
            //           ),
            //           onPressed: () {
            //             Get.dialog(
            //               SimpleDialog(
            //                 children: [_create(media)],
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Flexible(
              child: Obx(() => _listCompany.isEmpty
                  ? Text("empty")
                  : SizedBox(
                      width: double.infinity,
                      child: ContainedTabBarView(
                        tabs: [
                          ..._listCompany.map(
                            (e) {
                              return Tab(
                                child: Text(e['name'].toString()),
                              );
                            },
                          ),
                        ],
                        views: [
                          ..._listCompany.map(
                            (e) {
                              return Container(
                                child: ListView(
                                  children: [
                                    ListTile(
                                        leading: Checkbox(value: false, onChanged: (value) {}),
                                        title: TextField(
                                          decoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              hintText: 'Search',
                                              prefixIcon: Icon(Icons.search),
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: () {},
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              )),
                                        )),
                                    ...(e['Outlet'] as List).map(
                                      (e) {
                                        return ListTile(
                                          leading: Checkbox(
                                            value: false,
                                            onChanged: (v) {},
                                          ),
                                          title: Text(e['name']),
                                          trailing: PopupMenuButton(
                                            itemBuilder: (context) => [
                                              PopupMenuItem(child: Text('Edit'), value: 'edit'),
                                              PopupMenuItem(child: Text('Delete'), value: 'delete'),
                                            ],
                                          ),
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
          ],
        ),
      ),
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

                final res = await RouterApi.outletCreate().postData(body);

                if (res.statusCode == 201) {
                  await _loadOutlet();
                  conName.clear();

                  if (media.isMobile) {
                    Get.back();
                  }
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
}

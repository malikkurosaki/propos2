import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:propos/menus/cashier.dart';
import 'package:propos/pages.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EmpHomePage extends StatelessWidget {
  EmpHomePage({Key? key}) : super(key: key);
  final _showDrawer = false.val('EmpHomePage.showdrawer').obs;
  final _selectedMenu = "apa".val("EmpHomePage.lesectedMenu").obs;

  _onload() async {}

  final _listMenu = [
    {"title": "apa", "target": Cashier(), "idon": Icons.home},
    {"title": "dimana", "target": Text("ini apa ya"), "idon": Icons.home}
  ];

  @override
  Widget build(BuildContext context) {
    _onload();
    return ResponsiveBuilder(
      builder: (context, media) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            _showDrawer.value.val = !_showDrawer.value.val;
                            _showDrawer.refresh();
                          },
                          icon: Icon(Icons.menu))
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      Obx(() => Visibility(
                            visible: _showDrawer.value.val,
                            child: _drawer(media),
                          )),
                      Expanded(
                        child: Obx(
                          () => Stack(
                            children: [
                              ..._listMenu.map(
                                (e) => Visibility(
                                  visible: _selectedMenu.value.val == e['title'].toString(),
                                  child: (e['target'] as Widget),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _drawer(SizingInformation media) {
    final drawerHeader = {}.obs;
    RouterApi.drawerHeaderEmployee(query: "employeeId=${Vl.employeeId.val}").getData().then(
      (data) {
        if (data.statusCode == 200) drawerHeader.assignAll(jsonDecode(data.body));
      },
    );

    return SizedBox(
      width: media.isMobile ? Get.width : 320,
      child: Card(
        child: ListView(
          children: [
            Obx(
              () => DrawerHeader(
                child: Column(
                  children: [
                    Text(
                      drawerHeader.toString(),
                    ),
                  ],
                ),
              ),
            ),
            ..._listMenu.map(
              (e) => ListTile(
                onTap: () {
                  _selectedMenu.value.val = e['title'].toString();
                  _selectedMenu.refresh();
                },
                title: Text(e['title'].toString()),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Get.dialog(
                  AlertDialog(
                    title: Text("Logout"),
                    content: Text("Are You Sure ?"),
                    actions: [
                      MaterialButton(
                        child: Text("Yes"),
                        onPressed: () {
                          Vl.clear();
                          Get.offAllNamed(Pages.rootPage().route);
                        },
                      ),
                      MaterialButton(child: Text("No"), onPressed: () {
                        Get.back();
                      })
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

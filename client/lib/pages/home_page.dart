import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:propos/menus.dart';
import 'package:propos/pages.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/val_def.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _drawerOpen = true.val("HomePage.drawerOpen").obs;
  final _userData = {}.obs;

  _onLoad() async {}

  @override
  Widget build(BuildContext context) {
    _onLoad();

    return ResponsiveBuilder(
      builder: (context, media) {
        return Scaffold(
          appBar: media.isMobile
              ? AppBar(
                  foregroundColor: Colors.black,
                  // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu, color: Colors.black,)),
                  elevation: 0,
                  backgroundColor: Colors.grey[50],
                  title: Obx(
                    () => Text(
                      Menus.visible.value.val.toString(),
                    ),
                  ),
                )
              : null,
          drawer: media.isMobile ? _drawer(media) : null,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: !media.isMobile,
                  child: AppBar(
                    title: Obx(() => Text(Menus.visible.value.val.toString())),
                    elevation: 0,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[50],
                    leading: IconButton(
                        onPressed: () {
                          _drawerOpen.value.val = !_drawerOpen.value.val;
                          _drawerOpen.refresh();
                        },
                        icon: Icon(Icons.menu)),
                  ),
                ),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Visibility(
                          visible: !media.isMobile && _drawerOpen.value.val,
                          child: Column(
                            children: [
                              Visibility(visible: false, child: Text(_drawerOpen.value.val.toString())),
                              Flexible(child: _drawer(media)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Menus.display(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _drawer(SizingInformation media) => Builder(builder: (context) {
        final _drawerHeader = {}.obs;
        RouterApi.drawerHeader().getData().then((data) {
          if (data.statusCode == 200) _drawerHeader.value = jsonDecode(data.body);
        });

        return Drawer(
          backgroundColor: Colors.white,
          elevation: 0,
          child: ListView(
            controller: ScrollController(),
            children: [
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      Vl.defCompany.val['name'].toString(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      Vl.defOutlet.val['name'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Probus System'),
                    Text('Version 1.0.0'),
                    // Text(Val.userId.val),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            Get.toNamed(Pages.businessDetailPage().route, arguments: _userData);
                          },
                          child: Text("Detail")),
                    )
                  ],
                ),
              ),
              Menus.listButton(media),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  Get.dialog(AlertDialog(
                    content: Text("Are you sure want to logout?"),
                    actions: [
                      MaterialButton(
                        child: Text("No"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      MaterialButton(
                        child: Text("Yes"),
                        onPressed: () {
                          Val.clear();
                          ValDef.clear();
                          Get.offAllNamed(Pages.rootPage().route);
                        },
                      ),
                    ],
                  ));
                },
                title: Text("Logout"),
              )
            ],
          ),
        );
      });
}

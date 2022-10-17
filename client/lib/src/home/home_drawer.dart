import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propos/menus.dart';
import 'package:propos/pages.dart';
import 'package:propos/rot.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/val_def.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);
  final mapData = <String, List>{
    "Company": [],
    "Outlet": [],
    "Device": [],
  }.obs;
  final selectedData = {
    "companyId": "",
    "outletId": "",
    "deviceId": "",
  }.obs;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => Drawer(
        backgroundColor: Colors.white,
        elevation: 0,
        child: Scaffold(
          body: Builder(
            builder: (context) => ListView(
              controller: ScrollController(),
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Obx(
                      //   () => Vl.cod.value.val.isEmpty
                      //       ? Text("loading ...")
                      //       : Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(Vl.cod.value.val['Company']['name'].toString()),
                      //             Text(Vl.cod.value.val['Outlet']['name'].toString()),
                      //             Text(Vl.cod.value.val['Device']['name'].toString()),
                      //           ],
                      //         ),
                      // ),
                      // SizedBox(
                      //   height: 4,
                      //   child: FutureBuilder<http.Response>(
                      //     future: Rot.homeDrawerHeaderGet(),
                      //     builder: (con, snap) {
                      //       if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();
                      //       if (snap.data!.statusCode == 200) {
                      //         () async {
                      //           await 0.1.delay();
                      //           final data = jsonDecode(snap.data!.body);
                      //           HomeVal.headerDrawer.assignAll(data);
                      //         }();
                      //       }

                      //       return SizedBox.shrink();
                      //     },
                      //   ),
                      // ),
                      Obx(
                        () => Vl.cod.value.val.isEmpty
                            ? Container()
                            : ListTile(
                                onTap: () {
                                  showBottomSheet(
                                    context: context,
                                    builder: (context) => Material(
                                      child: Column(
                                        children: [
                                          SingleChildScrollView(
                                            controller: ScrollController(),
                                            child: Column(
                                              children: [
                                                Container(
                                                  color: Colors.grey.shade100,
                                                  padding: EdgeInsets.all(8),
                                                  child: Row(
                                                    children: [
                                                      BackButton(),
                                                      Text(
                                                        "Switch Property",
                                                        style: TextStyle(fontSize: 18),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                FutureBuilder<http.Response>(
                                                  future: Rot.homeCodGet(),
                                                  builder: (con, snap) {
                                                    if (!snap.hasData) return LinearProgressIndicator();
                                                    if (snap.data!.statusCode == 200) {
                                                      () async {
                                                        await 0.1.delay();
                                                        mapData['Company']?.assignAll(jsonDecode(snap.data!.body));
                                                        mapData.refresh();
                                                      }();
                                                    }
                                                    return Container();
                                                  },
                                                ),
                                                Obx(
                                                  () => mapData.isEmpty
                                                      ? Container()
                                                      : ListTile(
                                                          title: DropdownSearch<Map>(
                                                            dropdownDecoratorProps: DropDownDecoratorProps(
                                                              dropdownSearchDecoration: InputDecoration(
                                                                  filled: true,
                                                                  border: InputBorder.none,
                                                                  labelText: 'select company'),
                                                            ),
                                                            items: [...?mapData['Company']],
                                                            itemAsString: (val) => val['name'].toString(),
                                                            onChanged: (val) {
                                                              selectedData['companyId'] = val!['id'];
                                                              mapData['Outlet'] = val['Outlet'];
                                                              mapData.refresh();
                                                            },
                                                          ),
                                                        ),
                                                ),
                                                ListTile(
                                                  title: Obx(
                                                    () => mapData['Outlet']!.isEmpty
                                                        ? Text("select outlet ...")
                                                        : DropdownSearch<Map>(
                                                            items: [...?mapData['Outlet']],
                                                            itemAsString: (val) => val['name'].toString(),
                                                            dropdownDecoratorProps: DropDownDecoratorProps(
                                                                dropdownSearchDecoration: InputDecoration(
                                                                    filled: true,
                                                                    border: InputBorder.none,
                                                                    labelText: 'outlet')),
                                                            onChanged: (val) {
                                                              selectedData['outletId'] = val!['id'];
                                                              mapData['Device'] = val['Device'];
                                                              mapData.refresh();
                                                            },
                                                          ),
                                                  ),
                                                ),
                                                // todo: disini lanjutkan buat dropdown search untuk device
                                                ListTile(
                                                  title: Obx(
                                                    () => mapData['Device']!.isEmpty? Text("select device"):
                                                    DropdownSearch()
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                leading: Icon(
                                  Icons.store,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  Vl.cod.value.val['Outlet']['name'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ),
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
                            Vl.clear();
                            Val.clear();
                            ValDef.clear();
                            Get.offAllNamed(Pages.rootPage().route);
                          },
                        ),
                      ],
                    ));
                  },
                  title: Text("Logout"),
                ),
                ListTile(
                  title: Text("Developer"),
                  onTap: () => Get.toNamed(Pages.developerPage().route),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

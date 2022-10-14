import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propos/menus.dart';
import 'package:propos/pages.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/home/home_val.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/val_def.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => Drawer(
        backgroundColor: Colors.white,
        elevation: 0,
        child: ListView(
          controller: ScrollController(),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Vl.cod.value.val.isEmpty
                        ? Text("loading ...")
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Vl.cod.value.val['Company']['name'].toString()),
                              Text(Vl.cod.value.val['Outlet']['name'].toString()),
                              Text(Vl.cod.value.val['Device']['name'].toString()),
                            ],
                          ),
                  ),
                  SizedBox(
                    height: 4,
                    child: FutureBuilder<http.Response>(
                      future: Rot.homeDrawerHeaderGet(),
                      builder: (con, snap) {
                        if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();
                        if (snap.data!.statusCode == 200) {
                          () async {
                            await 0.1.delay();
                            final data = jsonDecode(snap.data!.body);
                            HomeVal.headerDrawer.assignAll(data);
                          }();
                        }

                        return SizedBox.shrink();
                      },
                    ),
                  ),
                  Obx(
                    () => HomeVal.headerDrawer.isEmpty
                        ? SizedBox.shrink()
                        : Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.store,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                HomeVal.headerDrawer['Outlet']['name']!.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                  )
                ],
              ),
            ),
            // FutureBuilder<http.Response>(
            //   future: Rot.homeDrawerHeaderGet(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState != ConnectionState.done) {
            //       return DrawerHeader(
            //         decoration: BoxDecoration(color: Colors.blue),
            //         child: Text(""),
            //       );
            //     }
            //     final data = jsonDecode(snapshot.data!.body);
            //     return Container(
            //       decoration: BoxDecoration(
            //         color: Colors.blue,
            //       ),
            //       child: Column(
            //         children: [
            //           ListTile(
            //             trailing: Icon(
            //               Icons.arrow_forward_ios_outlined,
            //               color: Colors.white,
            //             ),
            //             dense: true,
            //             leading: Icon(Icons.account_circle, color: Colors.white),
            //             title: Text(
            //               data['User']['name'].toString().toUpperCase(),
            //               overflow: TextOverflow.ellipsis,
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           ),
            //           ListTile(
            //             trailing: Icon(
            //               Icons.arrow_forward_ios_outlined,
            //               color: Colors.white,
            //             ),
            //             dense: true,
            //             leading: Icon(Icons.business, color: Colors.white),
            //             title: Text(
            //               data['Company']['name'].toString().toUpperCase(),
            //               overflow: TextOverflow.ellipsis,
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           ),
            //           ListTile(
            //             trailing: Icon(
            //               Icons.arrow_forward_ios_outlined,
            //               color: Colors.white,
            //             ),
            //             dense: true,
            //             leading: Icon(Icons.store_mall_directory, color: Colors.white),
            //             title: Text(
            //               data['Outlet']['name'].toString().toUpperCase(),
            //               overflow: TextOverflow.ellipsis,
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           ),
            //           ListTile(
            //             trailing: Icon(
            //               Icons.arrow_forward_ios_outlined,
            //               color: Colors.white,
            //             ),
            //             dense: true,
            //             leading: Icon(Icons.devices, color: Colors.white),
            //             title: Text(
            //               data['Device']['name'].toString().toUpperCase(),
            //               overflow: TextOverflow.ellipsis,
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           )
            //         ],
            //       ),
            //     );
            //   },
            // ),
            // DrawerHeader(
            //   decoration: BoxDecoration(color: Colors.blue),
            //   padding: EdgeInsets.zero,
            //   child: Stack(
            //     children: [
            //       // Card(
            //       //   child: SizedBox(
            //       //     width: double.infinity,
            //       //     child: ImgDef.homeHeader(fit: BoxFit.cover, width: double.infinity),
            //       //   ),
            //       // ),
            //       // BackdropFilter(
            //       //   filter: ImageFilter.blur(sigmaX: 2,sigmaY: 2),
            //       //   child: Container(
            //       //     color: Colors.white30,
            //       //   ),
            //       // ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisSize: MainAxisSize.max,
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           ListTile(
            //             trailing: Icon(
            //               Icons.arrow_forward_ios_outlined,
            //               color: Colors.white,
            //             ),
            //             dense: true,
            //             leading: Icon(
            //               Icons.account_circle,
            //               color: Colors.white,
            //             ),
            //             title: FutureBuilder<http.Response>(
            //               future: Rot.homeUserGet(),
            //               builder: (context, snapshot) {
            //                 if (snapshot.connectionState != ConnectionState.done) return Text("...");
            //                 final data = jsonDecode(snapshot.data!.body);
            //                 return Text(
            //                   data['name'].toString().toUpperCase(),
            //                   overflow: TextOverflow.ellipsis,
            //                   style: TextStyle(color: Colors.white),
            //                 );
            //               },
            //             ),
            //           ),
            //           ListTile(
            //             trailing: Icon(
            //               Icons.arrow_forward_ios_outlined,
            //               color: Colors.white,
            //             ),
            //             dense: true,
            //             leading: Icon(Icons.business, color: Colors.white),
            //             title: FutureBuilder<http.Response>(
            //               future: Rot.homeUserGet(),
            //               builder: (context, snapshot) {
            //                 if (snapshot.connectionState != ConnectionState.done) return Text("...");
            //                 final data = jsonDecode(snapshot.data!.body);
            //                 return Text(
            //                   data['name'].toString().toUpperCase(),
            //                   overflow: TextOverflow.ellipsis,
            //                   style: TextStyle(color: Colors.white),
            //                 );
            //               },
            //             ),
            //           ),
            //           ListTile(
            //             trailing: Icon(
            //               Icons.arrow_forward_ios_outlined,
            //               color: Colors.white,
            //             ),
            //             dense: true,
            //             leading: Icon(Icons.store, color: Colors.white),
            //             title: Text(
            //               Vl.defOutlet.val['name'].toString().toUpperCase(),
            //               overflow: TextOverflow.ellipsis,
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           ),
            //           ListTile(
            //             trailing: Icon(
            //               Icons.arrow_forward_ios_outlined,
            //               color: Colors.white,
            //             ),
            //             dense: true,
            //             leading: Icon(Icons.tablet_android, color: Colors.white),
            //             title: Text(
            //               Vl.defDevice.val['name'].toString().toUpperCase(),
            //               overflow: TextOverflow.ellipsis,
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           )
            //           // Text(
            //           //   Vl.defCompany.val['name'].toString(),
            //           //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, backgroundColor: Colors.white),
            //           // ),
            //           // Text(
            //           //   Vl.defOutlet.val['name'].toString(),
            //           //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, backgroundColor: Colors.white),
            //           // ),
            //           // Text('Probus System', style: TextStyle(
            //           //   backgroundColor: Colors.white
            //           // ),),
            //           // Text('Version 1.0.0',
            //           //   style: TextStyle(
            //           //     backgroundColor: Colors.white
            //           //   ),
            //           // ),
            //           // Text(Val.userId.val),
            //           // Align(
            //           //   alignment: Alignment.bottomRight,
            //           //   child: TextButton(
            //           //       onPressed: () {
            //           //         Get.toNamed(Pages.businessDetailPage().route, arguments: _userData);
            //           //       },
            //           //       child: Text("Detail")),
            //           // )
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
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
            )
          ],
        ),
      ),
    );
  }
}

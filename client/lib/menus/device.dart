import 'dart:convert';
import 'package:clipboard/clipboard.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
// import 'package:flutter_web_bluetooth/web/js/js_supported.dart';
import 'package:get/get.dart';
import 'package:propos/components/company_select.dart';
import 'package:propos/components/search_view_with_checkbox.dart';
import 'package:propos/components/select_outlet_by_company.dart';
import 'package:propos/src/device/device_create.dart';
import 'package:propos/src/device/device_display.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/router_api.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Device extends StatelessWidget {
  const Device({Key? key}) : super(key: key);

  // final listDevice = [].obs;
  // _loadListDevice() {
  //   RouterApi.deviceByUser().getData().then((value) {
  //     if (value.statusCode == 200) listDevice.assignAll(jsonDecode(value.body));
  //   });
  // }

  // _onLoad() async {
  //   _loadListDevice();
  // }

  @override
  Widget build(BuildContext context) {
    // _onLoad();
    return ResponsiveBuilder(
      builder: (context, media) {
        return Material(
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: DeviceDisplay(),
                ),
                Visibility(
                  visible: !media.isMobile,
                  child: DeviceCreate(),
                )
                // _create(media)
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget _listDevice(SizingInformation media) {
  //   final isCheckAll = false.obs;
  //   return Scaffold(
  //     body: Obx(
  //       () => listDevice.isEmpty
  //           ? ImgDef.empty(width: 100)
  //           : ContainedTabBarView(
  //               tabs: [
  //                 ...listDevice.map(
  //                   (e) => ListTile(
  //                     title: Text(e['name'].toString()),
  //                   ),
  //                 ),
  //               ],
  //               views: [
  //                 ...listDevice.map(
  //                   (e) => (e['Outlet'] as List).isEmpty
  //                       ? ImgDef.empty(width: 100, fit: BoxFit.contain)
  //                       : ContainedTabBarView(
  //                           tabs: [
  //                             ...(e['Outlet'] as List).map(
  //                               (e) => ListTile(
  //                                 title: Text(e['name'].toString()),
  //                               ),
  //                             ),
  //                           ],
  //                           views: [
  //                             ...(e['Outlet'] as List).map(
  //                               (e) => Column(
  //                                 children: [
  //                                   SearchViewWithCheckbox(
  //                                     onChanged: (searchValue) {},
  //                                     checkValue: isCheckAll,
  //                                     onCheckChanged: (value) {
  //                                       isCheckAll.toggle();
  //                                     },
  //                                   ),
  //                                   Flexible(
  //                                     child: Builder(builder: (context) {
  //                                       return ListView(
  //                                         controller: ScrollController(),
  //                                         children: [
  //                                           ...(e['Device'] as List).map(
  //                                             (e) => ListTile(
  //                                               leading: Checkbox(
  //                                                 value: false,
  //                                                 onChanged: (value) {},
  //                                               ),
  //                                               title: Text(e['name'].toString()),
  //                                               subtitle: Column(
  //                                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                                 children: [
  //                                                   Text(e['deviceId'].toString()),
  //                                                   Wrap(
  //                                                     children: [
  //                                                       IconButton(
  //                                                           tooltip: "share to whatsapp",
  //                                                           onPressed: () {},
  //                                                           icon: Icon(Icons.whatsapp, color: Colors.green)),
  //                                                       IconButton(
  //                                                           tooltip: "share to message",
  //                                                           onPressed: () {},
  //                                                           icon: Icon(Icons.message, color: Colors.orange)),
  //                                                       IconButton(
  //                                                           tooltip: "share to email",
  //                                                           onPressed: () {},
  //                                                           icon: Icon(Icons.email, color: Colors.red)),
  //                                                       IconButton(
  //                                                         tooltip: "share to barcode",
  //                                                         onPressed: () {
  //                                                           showBottomSheet(
  //                                                             backgroundColor: Colors.transparent,
  //                                                             enableDrag: true,
  //                                                             context: context,
  //                                                             builder: (c) => SizedBox(
  //                                                               width: double.infinity,
  //                                                               height: Get.height * 0.8,
  //                                                               child: Card(
  //                                                                 margin: EdgeInsets.symmetric(horizontal: 32),
  //                                                                 child: Column(
  //                                                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                                                   children: [
  //                                                                     Padding(
  //                                                                       padding: const EdgeInsets.all(8.0),
  //                                                                       child: Row(
  //                                                                         children: [BackButton()],
  //                                                                       ),
  //                                                                     ),
  //                                                                     Center(
  //                                                                       child: Column(
  //                                                                         children: [
  //                                                                           QrImage(
  //                                                                             data: "1234567890",
  //                                                                             version: QrVersions.auto,
  //                                                                             size: 200.0,
  //                                                                           ),
  //                                                                           Text(
  //                                                                             e['deviceId'].toString(),
  //                                                                             style: TextStyle(fontSize: 16),
  //                                                                           )
  //                                                                         ],
  //                                                                       ),
  //                                                                     ),
  //                                                                   ],
  //                                                                 ),
  //                                                               ),
  //                                                             ),
  //                                                           );
  //                                                         },
  //                                                         icon: Icon(Icons.qr_code, color: Colors.blue),
  //                                                       ),
  //                                                       IconButton(
  //                                                         tooltip: "copy",
  //                                                         onPressed: (){
  //                                                           FlutterClipboard.copy(e['deviceId'])
  //                                                                 .then((value) => SmartDialog.showToast(e['deviceId']));
  //                                                         },
  //                                                         icon: Icon(Icons.copy)
  //                                                       )
  //                                                     ],
  //                                                   )
  //                                                 ],
  //                                               ),
  //                                               trailing: PopupMenuButton(
  //                                                 itemBuilder: (context) => [
  //                                                   PopupMenuItem(
  //                                                     value: 1,
  //                                                     child: Text("edit"),
  //                                                   ),
  //                                                   PopupMenuItem(
  //                                                     value: 2,
  //                                                     child: Text("Delete"),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       );
  //                                     }),
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                 ),
  //               ],
  //             ),
  //     ),
  //   );
  // }

  // Widget _create(SizingInformation media) {
  //   final selectedCompanyId = "".obs;
  //   final body = <String, dynamic>{
  //     "name": TextEditingController(),
  //     "outletId": "",
  //     "companyId": "",
  //   };
  //   return Visibility(
  //     visible: media.isDesktop,
  //     child: SizedBox(
  //       width: media.isMobile ? Get.width : 360,
  //       child: Card(
  //         child: ListView(
  //           controller: ScrollController(),
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text('Create Device', style: TextStyle(fontSize: 24)),
  //             ),
  //             CompanySelect(onSelectCompany: (value) {
  //               selectedCompanyId.value = value;
  //               body['companyId'] = value;
  //             }),
  //             Obx(
  //               () => OutletSelectByCompany(
  //                   companyId: selectedCompanyId.value,
  //                   onSelectOutlet: (value) {
  //                     body['outletId'] = value;
  //                   }),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: TextField(
  //                 controller: body['name'],
  //                 decoration: InputDecoration(
  //                   prefixIcon: Icon(Icons.devices),
  //                   hintText: "device name",
  //                   border: OutlineInputBorder(borderSide: BorderSide.none),
  //                   filled: true,
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: MaterialButton(
  //                 color: Colors.blue,
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: Center(
  //                     child: Text(
  //                       'Create',
  //                       style: TextStyle(color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //                 onPressed: () async {
  //                   final b = {
  //                     "name": (body['name'] as TextEditingController).text,
  //                     "outletId": body['outletId'],
  //                     "companyId": body['companyId'],
  //                   };

  //                   if (b.values.contains("")) {
  //                     SmartDialog.showToast("Please fill all field");
  //                     return;
  //                   }

  //                   final crt = await RouterApi.deviceCreate().postData(b);
  //                   await _loadListDevice();
  //                 },
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

}

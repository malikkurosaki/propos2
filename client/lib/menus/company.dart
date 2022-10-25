import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/components/app_bar_image.dart';
import 'package:propos/src/company/company_create.dart';
import 'package:propos/src/company/company_display.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/router_api.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class Company extends StatelessWidget {
  const Company({Key? key}) : super(key: key);
  // final _conName = TextEditingController();
  // final _companyList = [].obs;

  // final _popMenu = [
  //   {
  //     "title": "Edit",
  //     "icon": Icons.edit,
  //     "action": () {},
  //   },
  //   {
  //     "title": "Delete",
  //     "icon": Icons.delete,
  //     "action": () {},
  //   },
  // ];

  // _loadCompany() async {
  //   final data = await RouterApi.listCompany().getData();
  //   if (data.statusCode == 200) _companyList.assignAll(jsonDecode(data.body));
  // }

  // _onLoad() async {
  //   _loadCompany();
  // }

  @override
  Widget build(BuildContext context) {
    // _onLoad();
    return ResponsiveBuilder(builder: (context, media) {
      return Material(
        child: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: CompanyDisplay(),
                    ),
                    Visibility(
                      visible: !media.isMobile,
                      child: SizedBox(
                        width: media.isMobile ? Get.width : 460,
                        child: CompanyCreate(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // Widget _create(SizingInformation media) {
  //   return SizedBox(
  //     width: media.isMobile ? Get.width : 360,
  //     child: Builder(
  //       builder: (context) {
  //         return Column(
  //           children: [
  //             Flexible(
  //               child: Card(
  //                 child: ListView(
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Text(
  //                         "Create Company",
  //                         style: TextStyle(
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: TextField(
  //                         controller: _conName,
  //                         decoration: InputDecoration(
  //                           prefixIcon: Icon(Icons.home_work_rounded),
  //                           hintText: 'Company Name',
  //                           border: OutlineInputBorder(
  //                             borderSide: BorderSide.none,
  //                           ),
  //                           filled: true,
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: MaterialButton(
  //                         color: Colors.cyan,
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(10.0),
  //                           child: Center(
  //                             child: Text(
  //                               "Create",
  //                               style: TextStyle(
  //                                 color: Colors.white,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         onPressed: () async {
  //                           final body = <String, String>{
  //                             'name': _conName.text,
  //                           };

  //                           if (body.values.contains("")) {
  //                             SmartDialog.showToast("Please fill all field");
  //                             return;
  //                           }

  //                           final kirim = await RouterApi.companyCreate().postData(body);
  //                           await _loadCompany();
  //                         },
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget _listDisplay(SizingInformation media) {
  //   return Scaffold(
  //     floatingActionButton: !media.isMobile
  //         ? null
  //         : FloatingActionButton(
  //             onPressed: () {
  //               Get.dialog(Dialog(
  //                 child: _create(media),
  //               ));
  //             },
  //             child: Icon(
  //               Icons.add,
  //               color: Colors.white,
  //             ),
  //           ),
  //     body: Card(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           AppBarImage(),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               'List Company',
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           Flexible(
  //             child: Obx(
  //               () => ListView(
  //                 children: [
  //                   ..._companyList.map(
  //                     (e) {
  //                       return ListTile(
  //                         leading: Checkbox(
  //                           value: false,
  //                           onChanged: (value) {},
  //                         ),
  //                         title: Text(e['name']),
  //                         trailing: PopupMenuButton(
  //                           onSelected: (value) {},
  //                           itemBuilder: (BuildContext context) => [
  //                             ..._popMenu.map(
  //                               (e) {
  //                                 return PopupMenuItem(
  //                                   value: e['title'],
  //                                   child: Text(e['title'].toString()),
  //                                 );
  //                               },
  //                             ).toList(),
  //                           ],
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

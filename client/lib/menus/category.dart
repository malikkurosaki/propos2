import 'dart:convert';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:propos/components/company_select.dart';
import 'package:propos/components/input.dart';
import 'package:propos/components/search_view_with_checkbox.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/category/category_create.dart';
import 'package:propos/src/category/category_display.dart';
import 'package:propos/utils/router_api.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => Column(
        children: [
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: CategoryDisplay(),
                ),
                Visibility(
                  visible: !media.isMobile,
                  child: SizedBox(
                    width: media.isMobile ? Get.width : 460,
                    child: CategoryCreate()
                    ,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class Category extends StatelessWidget {
//   Category({Key? key}) : super(key: key);
//   final _editId = "".obs;
//   final _conCompanyId = TextEditingController();
//   // final _conOutletId = TextEditingController();

//   final _propertiesComOut = [].obs;
//   final _listCompany = [].obs;

//   _loadProperty() async {
//     final data = await RouterApi.propertiesCompanyOutlet().getData();
//     if (data.statusCode == 200) _propertiesComOut.assignAll(jsonDecode(data.body));
//   }

//   _loadCategoryList() async {
//     final data = await RouterApi.categoryGetByCompany().getData();
//     if (data.statusCode == 200) _listCompany.assignAll(jsonDecode(data.body));
//   }

//   _loadData() async {
//     _loadProperty();
//     _loadCategoryList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _loadData();
//     debugPrint('Category build');
//     return ResponsiveBuilder(builder: (context, media) {
//       return SafeArea(
//         child: Column(
//           children: [
//             Flexible(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _listDisplay(media),
//                   ),
//                   Visibility(visible: !media.isMobile, child: _create(media))
//                 ],
//               ),
//             )
//           ],
//         ),
//       );
//     });
//   }

//   Widget _listDisplay(SizingInformation media) {
//     return Scaffold(
//       floatingActionButton: !media.isMobile
//           ? null
//           : FloatingActionButton(
//               child: Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 Get.dialog(
//                   SimpleDialog(
//                     children: [_create(media)],
//                   ),
//                 );
//               },
//             ),
//       body: Card(
//         child: Column(
//           children: [
//             Flexible(
//               child: Obx(
//                 () => _listCompany.isEmpty
//                     ? Text("empty...")
//                     : SizedBox(
//                         width: double.infinity,
//                         child: ContainedTabBarView(
//                           tabs: [
//                             ..._listCompany.map(
//                               (e) => ListTile(
//                                 title: Text(
//                                   e['name'].toString(),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             )
//                           ],
//                           views: [
//                             ..._listCompany.map(
//                               (e) => Builder(builder: (context) {
//                                 final selectAll = false.obs;
//                                 final lsCategory = (e['Category'] as List);
//                                 return Column(
//                                   children: [
//                                     SearchViewWithCheckbox(
//                                         onChanged: (value) {}, checkValue: selectAll, onCheckChanged: (value) {}),
//                                     Flexible(
//                                       child: ListView(
//                                         children: [
//                                           ...lsCategory.map(
//                                             (e) => ListTile(
//                                               leading: Checkbox(value: false, onChanged: (value) {}),
//                                               title: Text(e['name'].toString()),
//                                               trailing: PopupMenuButton(
//                                                 itemBuilder: (context) => [
//                                                   PopupMenuItem(
//                                                     child: Text("Edit"),
//                                                     value: () {},
//                                                   ),
//                                                   PopupMenuItem(
//                                                     child: Text("Delete"),
//                                                     value: () {},
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               }),
//                             )
//                           ],
//                         ),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _create(SizingInformation media) => Card(
//         child: SizedBox(
//           width: media.isMobile ? Get.width : 360,
//           height: media.isMobile ? 360 : Get.height * 0.92,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   "Create Category",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Flexible(
//                 child: Builder(
//                   builder: (context) {
//                     final conName = TextEditingController();
//                     return ListView(
//                       controller: ScrollController(),
//                       children: [
//                         CompanySelect(onSelectCompany: (companyId) {
//                           _conCompanyId.text = companyId;
//                         }),
//                         Input(
//                           controller: conName,
//                           label: "Category Name",
//                         ),
//                         // Padding(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: DropdownButtonFormField(
//                         //     isDense: true,
//                         //     decoration: InputDecoration(
//                         //       isDense: true,
//                         //       labelText: "Company",
//                         //       hintText: "Select Company",
//                         //       border: OutlineInputBorder(borderSide: BorderSide.none),
//                         //     ),
//                         //     items: [
//                         //       for (final itm in _propertiesComOut)
//                         //         DropdownMenuItem(
//                         //           value: itm,
//                         //           child: Text(itm['name']),
//                         //         )
//                         //     ],
//                         //     onChanged: (value) {
//                         //       final data = (value as Map);
//                         //       _conCompanyId.text = data['id'].toString();
//                         //     },
//                         //   ),
//                         // ),
//                         // Padding(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: TextFormField(
//                         //     controller: conName,
//                         //     decoration: InputDecoration(
//                         //       isDense: true,
//                         //       labelText: "Category Name",
//                         //       filled: true,
//                         //       border: OutlineInputBorder(
//                         //         borderSide: BorderSide.none,
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: MaterialButton(
//                             color: Colors.cyan,
//                             onPressed: () async {
//                               final body = {"name": conName.text, 'companyId': _conCompanyId.text};

//                               if (body.values.contains("")) {
//                                 SmartDialog.showToast("tidak bisa kosong");
//                                 return;
//                               }

//                               debugPrint(body.toString());

//                               final cat = await RouterApi.createCategory().postData(body);
//                               if (cat.statusCode == 201) {
//                                 SmartDialog.showToast("success");
//                                 await _loadCategoryList();
//                               }

//                               conName.clear();
//                               if (media.isMobile) Get.back();
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Center(
//                                 child: Text(
//                                   "Save",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                         // Builder(
//                         //   builder: (context) {
//                         //     final bisaDiclick = true.obs;
//                         //     return Obx(
//                         //       () => Padding(
//                         //         padding: const EdgeInsets.all(8.0),
//                         //         child: !bisaDiclick.value
//                         //             ? Text("loading ...")
//                         //             :
//                         //             ,
//                         //       ),
//                         //     );
//                         //   },
//                         // )
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
// }

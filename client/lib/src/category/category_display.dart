import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/category/category_create.dart';
import 'package:propos/src/category/category_edit.dart';
import 'package:propos/src/category/category_val.dart';
import 'package:get/get.dart';
import 'package:propos/src/developer/developer_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CategoryDisplay extends StatelessWidget {
  const CategoryDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return Scaffold(
        floatingActionButton: !media.isMobile
            ? null
            : FloatingActionButton(
                onPressed: () {
                  showBottomSheet(context: context, builder: (context) => CategoryCreate());
                },
                child: Icon(Icons.add),
              ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                SizedBox(
                  height: 4,
                  child: FutureBuilder<http.Response>(
                    future: Rot.globalListCompanyGet(),
                    builder: (context, snap) {
                      if (!snap.hasData) return LinearProgressIndicator();
                      () async {
                        if (snap.data!.statusCode == 200) {
                          await 0.1.delay();
                          CategoryVal.listCompanyDisplay.assignAll(jsonDecode(snap.data!.body));
                        }
                      }();
                      return Container();
                    },
                  ),
                ),
                Obx(
                  () => ListTile(
                    title: DropdownSearch<Map>(
                      itemAsString: (val) => val['name'].toString(),
                      items: [...CategoryVal.listCompanyDisplay],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          border: InputBorder.none,
                          hintText: 'Select Company',
                        ),
                      ),
                      onChanged: (val) async {
                        final res = await Rot.categoryListByCompanyIdGet(query: 'companyId=${val!["id"]}');
                        if (res.statusCode == 200) {
                          CategoryVal.listCategory.value.val = jsonDecode(res.body);
                          CategoryVal.listCategory.refresh();
                        } else {
                          SmartDialog.showToast(res.body);
                        }
                      },
                    ),
                  ),
                ),
                Obx(
                  () {
                    CategoryVal.reload.value;
                    return SizedBox(
                      height: 4,
                      child: FutureBuilder<http.Response>(
                        future: Rot.categoryListGet(),
                        builder: (con, snap) {
                          if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();

                          if (snap.data!.statusCode == 200) {
                            () async {
                              await 0.1.delay();
                              CategoryVal.listCategory.value.val = jsonDecode(snap.data!.body);
                              CategoryVal.listCategory.refresh();
                            }();
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    );
                  },
                ),
                Obx(
                  () => Column(
                    children: [
                      ...CategoryVal.listCategory.value.val.map(
                        (element) => ListTile(
                          onTap: () {
                            debugPrint(element.toString());
                            CategoryVal.mapData.assignAll(element);
                            showBottomSheet(context: context, builder: (context) => CategoryEdit());
                          },
                          leading: Text((CategoryVal.listCategory.value.val.indexOf(element) + 1).toString()),
                          title: Text(
                            element['name'].toString(),
                          ),
                          subtitle: !DeveloperVal.showId.value.val ? null : Text(element['id']),
                          trailing: Icon(
                            Icons.check_box,
                            color: element['isActive'] ? Colors.green : Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

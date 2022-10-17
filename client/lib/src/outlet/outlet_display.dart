import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/developer/developer_val.dart';
import 'package:propos/src/outlet/outlet_crete.dart';
import 'package:propos/src/outlet/outlet_edit.dart';
import 'package:propos/src/outlet/outlet_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OutletDisplay extends StatelessWidget {
  const OutletDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return Scaffold(
        floatingActionButton: !media.isMobile
            ? null
            : FloatingActionButton(
                onPressed: () {
                  showBottomSheet(context: context, builder: (context) => OutletCreate());
                },
                child: Icon(Icons.add),
              ),
        body: Builder(
          builder: (context) => Card(
            child: ListView(
              children: [
                SizedBox(
                  height: 4,
                  child: FutureBuilder<http.Response>(
                    future: Rot.globalListCompanyGet(),
                    builder: (con, snap) {
                      if (!snap.hasData) return LinearProgressIndicator();
                      () async {
                        if (snap.data!.statusCode == 200) {
                          () async {
                            if (snap.data!.statusCode == 200) {
                              await 0.1.delay();
                              OutletVal.listCompanyDisplay.assignAll(jsonDecode(snap.data!.body));
                            }
                          }();
                        }
                      }();
                      return Container();
                    },
                  ),
                ),
                Obx(
                  () => ListTile(
                    title: OutletVal.listCompanyDisplay.isEmpty
                        ? Text("Select Company")
                        : DropdownSearch<Map>(
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    filled: true, border: InputBorder.none, hintText: 'Select Company')),
                            items: [...OutletVal.listCompanyDisplay],
                            itemAsString: (val) => val['name'].toString(),
                            onChanged: (val) async {
                              final res = await Rot.outletListOutletByBompanyIdGet(query: 'companyId=${val!["id"]}');
                              if (res.statusCode == 200) {
                                // debugPrint(res.body);
                                OutletVal.listoutlet.value.val = jsonDecode(res.body);
                                OutletVal.listoutlet.refresh();
                              } else {
                                SmartDialog.showToast(res.body);
                              }
                            },
                          ),
                  ),
                ),
                Obx(() {
                  OutletVal.reload.value;
                  return SizedBox(
                    height: 4,
                    child: FutureBuilder<http.Response>(
                      future: Rot.outletListOutletGet(),
                      builder: (con, snap) {
                        if (!snap.hasData) return LinearProgressIndicator();
                        if (snap.data!.statusCode == 200) {
                          () async {
                            await 0.1.delay();
                            final ls = List<Map<String, dynamic>>.from(jsonDecode(snap.data!.body));
                            OutletVal.listoutlet.value.val = ls;
                            OutletVal.listoutlet.refresh();
                          }();
                        }
                        return Container();
                      },
                    ),
                  );
                }),
                Obx(
                  () => Column(
                    children: [
                      ...OutletVal.listoutlet.value.val.map(
                        (e) => ListTile(
                          leading: Text((OutletVal.listoutlet.value.val.indexOf(e) + 1).toString()),
                          title: Text(e['name'].toString()),
                          trailing: Icon(
                            Icons.check_box,
                            color: e['isActive'] ? Colors.green : Colors.grey,
                          ),
                          onTap: () {
                            // final mapData = Map.from(e);
                            OutletVal.mapData.assignAll(e);
                            showBottomSheet(context: context, builder: (context) => OutletEdit());
                          },
                          subtitle: !DeveloperVal.showId.value.val ? null : Text(e['id']),
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

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/discount/discount_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DiscountCreate extends StatelessWidget {
  const DiscountCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return ListView(
        controller: ScrollController(),
        children: [
          ListTile(
            leading: media.isMobile ? BackButton() : null,
            title: Text(
              "Create Discount",
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(
            height: 4,
            child: FutureBuilder<http.Response>(
              future: Rot.globalListCompanyGet(),
              builder: (con, snap) {
                if (!snap.hasData) return LinearProgressIndicator();
                () async {
                  await 0.1.delay();
                  DiscountVal.listCompanyCreate.assignAll(jsonDecode(snap.data!.body));
                }();
                return Container();
              },
            ),
          ),
          SizedBox(
            height: 4,
            child: FutureBuilder<http.Response>(
              future: Rot.discountModelGet(),
              builder: (con, snap) {
                if (!snap.hasData) return LinearProgressIndicator();
                () async {
                  if (snap.data!.statusCode == 200) {
                    await 0.1.delay();
                    DiscountVal.model.value.val = jsonDecode(snap.data!.body);
                    DiscountVal.model.refresh();
                  }
                }();
                return Container();
              },
            ),
          ),
          Obx(
            () => ListTile(
              title: DropdownSearch<Map>(
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      filled: true, border: InputBorder.none, hintText: 'Select Company', labelText: 'company'),
                ),
                items: [...DiscountVal.listCompanyCreate],
                itemAsString: (val) => val['name'],
                onChanged: (val) {
                  DiscountVal.model.value.val['companyId'] = val!['id'];
                },
              ),
            ),
          ),
          Obx(
            () => Column(
              children: [
                ...DiscountVal.model.value.val.keys.map(
                  (e) => !['name', 'des', 'isPercentage', 'percentage', 'value'].contains(e)
                      ? SizedBox.shrink()
                      : e == 'isPercentage'
                          ? ListTile(
                              title: CheckboxListTile(
                                title: Text("Is Percent?"),
                                value: DiscountVal.model.value.val['isPercentage'] ?? true,
                                onChanged: (val) {
                                  DiscountVal.model.value.val['isPercentage'] = val;
                                  DiscountVal.model.refresh();
                                },
                              ),
                            )
                          : e == 'value' && (DiscountVal.model.value.val['isPercentage'] ?? true)
                              ? Container()
                              : e == 'percentage' && !(DiscountVal.model.value.val['isPercentage'] ?? true)
                                  ? Container()
                                  : ListTile(
                                      title: TextFormField(
                                        onChanged: (val) => DiscountVal.model.value.val[e] = val,
                                        controller: TextEditingController(text: DiscountVal.model.value.val[e] ?? ""),
                                        decoration: InputDecoration(
                                            filled: true, border: InputBorder.none, labelText: e.toString()),
                                      ),
                                      trailing:
                                          e == 'percentage' && (DiscountVal.model.value.val['isPercentage'] ?? true)
                                              ? Icon(Icons.percent)
                                              : null,
                                      leading: e == 'value' && !(DiscountVal.model.value.val['isPercentage'] ?? true)
                                          ? Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Rp"),
                                            )
                                          : null,
                                    ),
                ),
                ListTile(
                  title: MaterialButton(
                    color: Colors.blue,
                    onPressed: () async {
                      final lsData = ['name', 'companyId'];

                      final lsKosong = [];
                      for (final itm in lsData) {
                        if (DiscountVal.model.value.val[itm] == null) {
                          lsKosong.add(itm);
                        }
                      }

                      if (lsKosong.isNotEmpty) {
                        SmartDialog.showToast("no empt allowed");
                        return;
                      }

                      final data = Map.from(DiscountVal.model.value.val);
                      data.removeWhere((k, v) => v == null);

                      if (data['isPercentage'] ?? true) {
                        data['isPercentage'] = true;
                        data['percentage'] = int.tryParse(data['percentage']) ?? 0;
                        if ((data['percentage'] as int).isGreaterThan(100)) {
                          SmartDialog.showToast("Max 100%");
                          return;
                        }
                      } else {
                        data['value'] = int.tryParse(data['value']) ?? 0;
                      }

                      // debugPrint(data.toString());

                      final res = await Rot.discountCreatePost(body: {"data": jsonEncode(data)});
                      if (res.statusCode == 201) {
                        DiscountVal.reload.toggle();
                        SmartDialog.showToast("success");
                        Get.back();
                      } else {
                        SmartDialog.showToast(res.body);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}

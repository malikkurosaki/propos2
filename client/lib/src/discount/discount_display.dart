import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/discount/discount_create.dart';
import 'package:propos/src/discount/discount_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DiscountDisplay extends StatelessWidget {
  const DiscountDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => Scaffold(
        floatingActionButton: !media.isMobile
            ? null
            : FloatingActionButton(
                onPressed: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) => DiscountCreate(),
                  );
                },
                child: Icon(Icons.add),
              ),
        body: Builder(builder: (context) {
          return ListView(
            controller: ScrollController(),
            children: [
              SizedBox(
                height: 4,
                child: FutureBuilder(
                    future: Rot.globalListCompanyGet(),
                    builder: (con, snap) {
                      if (!snap.hasData) return LinearProgressIndicator();
                      return Container();
                    }),
              ),
              SizedBox(
                height: 4,
                child: Obx(() {
                  DiscountVal.reload.value;
                  return FutureBuilder<http.Response>(
                    future: Rot.discountListGet(),
                    builder: (con, snap) {
                      if (!snap.hasData) return LinearProgressIndicator();
                      () async {
                        if (snap.data!.statusCode == 200) {
                          await 0.1.delay();
                          DiscountVal.listDiscount.value.val = jsonDecode(snap.data!.body);
                          DiscountVal.listDiscount.refresh();
                        }
                      }();
                      return Container();
                    },
                  );
                }),
              ),
              Obx(
                () => Column(
                  children: [
                    ...DiscountVal.listDiscount.value.val.map(
                      (e) => ListTile(
                        leading: Text((DiscountVal.listDiscount.value.val.indexOf(e) + 1).toString()),
                        subtitle: e['isPercentage']
                            ? Text(e['percentage'].toString() + "%")
                            : Text(NumberFormat.simpleCurrency(
                                decimalDigits: 0,
                                locale: "id_ID",
                              ).format(e['value'])),
                        trailing: Icon(
                          Icons.check_box,
                          color: e['isActive'] ? Colors.green : Colors.grey,
                        ),
                        title: Text(e['name'] ?? ""),
                        onTap: () {
                          DiscountVal.mapData.assignAll(e);
                          showBottomSheet(
                            context: context,
                            builder: (context) => Material(
                              child: ListView(
                                children: [
                                  Container(
                                    color: Colors.grey.shade100,
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      children: [BackButton(), Text("Edit Discount")],
                                    ),
                                  ),
                                  ...DiscountVal.mapData.keys.map(
                                    (el) => !['name', 'des', 'value', 'percentage', 'isActive'].contains(el)
                                        ? Container()
                                        : el == 'percentage' && !DiscountVal.mapData['isPercentage']
                                            ? Container()
                                            : el == 'value' && DiscountVal.mapData['isPercentage']
                                                ? Container()
                                                : el == 'isActive'
                                                    ? Obx(() => ListTile(
                                                          title: CheckboxListTile(
                                                              title: Text("Is Active"),
                                                              value: DiscountVal.mapData['isActive'],
                                                              onChanged: (val) =>
                                                                  DiscountVal.mapData['isActive'] = val),
                                                        ))
                                                    : ListTile(
                                                        title: TextFormField(
                                                          onChanged: (val) => DiscountVal.mapData[el] = val,
                                                          controller: TextEditingController(
                                                              text: int.tryParse(e[el].toString()) == null
                                                                  ? e[el]
                                                                  : e[el].toString()),
                                                          decoration: InputDecoration(
                                                              filled: true,
                                                              border: InputBorder.none,
                                                              labelText: el.toString()),
                                                        ),
                                                      ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: MaterialButton(
                                            color: Colors.pink,
                                            onPressed: () async {
                                              final res = await Rot.discountDelete(query: "id=${e['id']}");
                                              if (res.statusCode == 201) {
                                                DiscountVal.reload.refresh();
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
                                                  "Delete",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: MaterialButton(
                                            color: Colors.orange,
                                            onPressed: () async {
                                              final bd = <String, dynamic>{...DiscountVal.mapData};
                                              bd.removeWhere((key, value) => value == null);
                                              bd['value'] = int.parse(bd['value'].toString());

                                              final res = await Rot.discountUpdatePost(body: {"data": jsonEncode(bd)});
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
                                                  "Update",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

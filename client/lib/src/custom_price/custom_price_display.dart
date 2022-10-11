import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/custom_price/custom_price_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomPriceDisplay extends StatelessWidget {
  const CustomPriceDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => Scaffold(
        body: Builder(builder: (context) {
          return Card(
            child: Column(
              children: [
                Obx(
                  () => Column(
                    children: [
                      Visibility(
                        visible: false,
                        child: Text(
                          CustomPriceVal.reeload.value.toString(),
                        ),
                      ),
                      FutureBuilder<http.Response>(
                        future: Rot.customPriceListGet(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done) return LinearProgressIndicator();
                          final data = jsonDecode(snapshot.data!.body);
                          Future.delayed(
                              Duration(microseconds: 100), () => CustomPriceVal.lisCustomPrice.assignAll(data));
                          return SizedBox.shrink();
                        },
                      )
                    ],
                  ),
                ),
                Obx(
                  () => ListTile(
                    title: DropdownSearch<Map>(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration:
                              InputDecoration(filled: true, border: InputBorder.none, hintText: "select company")),
                      items: [...CustomPriceVal.listCompany],
                      itemAsString: (value) => value['name'].toString(),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Flexible(
                  child: Obx(
                    () => ListView(
                      children: [
                        ...CustomPriceVal.lisCustomPrice.map(
                          (element) => ListTile(
                            leading: Text((CustomPriceVal.lisCustomPrice.indexOf(element) + 1).toString()),
                            title: Text(element['name'].toString()),
                            trailing: Icon(
                              Icons.check_box,
                              color: element['isActive'] ? Colors.green : Colors.grey,
                            ),
                            onTap: () {
                              CustomPriceVal.mapData.assignAll(element);
                              showBottomSheet(
                                context: context,
                                builder: (context) => Material(
                                  child: ListView(
                                    children: [
                                      Container(
                                        color: Colors.grey.shade100,
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          children: [BackButton(), Text("Edit Custom Price")],
                                        ),
                                      ),
                                      ...CustomPriceVal.mapData.keys.map(
                                        (e) => !['name', 'des', 'isActive'].contains(e)
                                            ? SizedBox.shrink()
                                            : e == 'isActive'
                                                ? Obx(
                                                    () => ListTile(
                                                      title: CheckboxListTile(
                                                        value: CustomPriceVal.mapData['isActive'],
                                                        onChanged: (val) {
                                                          CustomPriceVal.mapData['isActive'] = val;
                                                        },
                                                        title: Text("Is Active"),
                                                      ),
                                                    ),
                                                  )
                                                : ListTile(
                                                    title: TextFormField(
                                                      onChanged: (val) => CustomPriceVal.mapData[e] = val,
                                                      controller: TextEditingController(text: element[e]),
                                                      decoration: InputDecoration(
                                                          filled: true,
                                                          border: InputBorder.none,
                                                          labelText: e.toString()),
                                                    ),
                                                  ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              title: MaterialButton(
                                                color: Colors.pink,
                                                onPressed: () {},
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Center(
                                                    child: Text(
                                                      'Delete',
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
                                                  final bd = Map.from(CustomPriceVal.mapData);
                                                  bd.removeWhere((key, value) => value == null);

                                                  final res =
                                                      await Rot.customPriceUpdatePost(body: {"data": jsonEncode(bd)});
                                                  if (res.statusCode == 201) {
                                                    CustomPriceVal.reeload.toggle();
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
                                                      'Update',
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
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

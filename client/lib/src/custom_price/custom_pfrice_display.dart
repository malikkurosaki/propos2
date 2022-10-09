import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:propos/menus/custom_price.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/custom_price/custom_price_val.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CustomPriceDisplay extends StatelessWidget {
  const CustomPriceDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                    Future.delayed(Duration(microseconds: 100), () => CustomPriceVal.lisCustomPrice.assignAll(data));
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
                            title: Text(element['name'].toString()),
                          )
                          // Column(
                          //   children: [
                          //     ListTile(
                          //       leading: Icon(Icons.money),
                          //       dense: true,
                          //       title: Text(
                          //         element['name'].toString(),
                          //       ),
                          //       trailing: PopupMenuButton(
                          //         itemBuilder: (context) => [
                          //           PopupMenuItem(
                          //             child: Text("Delete"),
                          //           ),
                          //           PopupMenuItem(
                          //             child: Text("Edit"),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //     DottedLine()
                          //   ],
                          // ),

                        )
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}

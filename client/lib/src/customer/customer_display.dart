import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:propos/menus/customer.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/customer/customer_val.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CustomerDisplay extends StatelessWidget {
  const CustomerDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Column(
            children: [
              Visibility(visible: false, child: Text(CustomerVal.reload.value.toString())),
              FutureBuilder<http.Response>(
                future: Rot.customerListCustomerGet(),
                builder: (context, snap) {
                  if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();

                  if (snap.data!.statusCode == 200) {
                    final lsDat = jsonDecode(snap.data!.body);
                    Future.delayed(Duration(microseconds: 100), () => CustomerVal.listCustomer.assignAll(lsDat));
                  }
                  return SizedBox.shrink();
                },
              ),
              FutureBuilder<http.Response>(
                future: Rot.customerListCompanyGet(),
                builder: (ctx, snap) {
                  if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();
                  if (snap.data!.statusCode == 200) {
                    final lsdata = jsonDecode(snap.data!.body);
                    Future.delayed(Duration(microseconds: 100), () => CustomerVal.listCompany.assign(lsdata));
                  }
                  return SizedBox.shrink();
                },
              )
            ],
          ),
        ),
        Obx(
          () => ListTile(
            title: DropdownSearch<Map>(
              items: [...CustomerVal.listCompany],
              itemAsString: (value) => value['name'].toString(),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    InputDecoration(filled: true, border: InputBorder.none, hintText: 'select company'),
              ),
              onChanged: (value) {},
            ),
          ),
        ),
        Flexible(
          child: Obx(
            () => ListView(
              children: [
                ...CustomerVal.listCustomer.map(
                  (element) => Column(
                    children: [
                      ListTile(
                        title: Text(element['name'].toString()),
                      ),
                      DottedLine()
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

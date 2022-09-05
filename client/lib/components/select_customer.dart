import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:propos/utils/router_api.dart';

class SelectCustomer extends StatelessWidget {
  SelectCustomer({Key? key,required this.onChanged}) : super(key: key);
  final _listCustomer = [].obs;
  final Function(String id) onChanged;

  @override
  Widget build(BuildContext context) {
    RouterApi.custoemerGetList().getData().then(
      (res) {
        if (res.statusCode == 200) _listCustomer.assignAll(jsonDecode(res.body));
      },
    );
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            label: Text("Select Customer"),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          items: _listCustomer
              .map(
                (element) => DropdownMenuItem(
                  value: element['id'],
                  child: Text(
                    element['name'].toString(),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            onChanged(value.toString());
          },
        ),
      ),
    );
  }
}

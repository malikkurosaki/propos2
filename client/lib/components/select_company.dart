import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:propos/utils/router_api.dart';

class SelectCompany extends StatelessWidget {
  SelectCompany({Key? key, required this.onSelectCompany}) : super(key: key);
  final _lsCompany = [].obs;
  final Function(String) onSelectCompany;

  _onLoad() async {
    RouterApi.listCompany()
        .getData()
        .then((value) => value.statusCode == 200 ? _lsCompany.value = jsonDecode(value.body) : debugPrint(value.body));
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            labelText: "Pilih Company",
            border: OutlineInputBorder(
              borderSide: BorderSide.none
            ),
            filled: true,
            isDense: true,
          ),
          items: [..._lsCompany]
              .map((e) => DropdownMenuItem(
                    child: Text(e['name']),
                    value: e['id'],
                  ))
              .toList(),
          onChanged: (value) {
            onSelectCompany(value!.toString());
          },
        ),
      ),
    );
  }
}

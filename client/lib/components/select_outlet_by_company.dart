import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:propos/utils/router_api.dart';

class SelectOoutletByCompany extends StatelessWidget {
  SelectOoutletByCompany({Key? key, required this.onSelectOutlet, required this.companyId}) : super(key: key);
  final _lsOutlet = [].obs;
  final Function(String) onSelectOutlet;
  final String companyId;

  Future<List> _getData(List ls) async => ls;

  @override
  Widget build(BuildContext context) {
    RouterApi.outletByCompanyId(query: "cusCompanyId=$companyId")
        .getData()
        .then((e) => e.statusCode == 200 ? _lsOutlet.assignAll(jsonDecode(e.body)) : debugPrint(e.body));
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: _lsOutlet.isEmpty || _lsOutlet.toString() == "null"
            ? Ink(
              color: Colors.grey.shade100,
              child: ListTile(
                  title: Text("Select Outlet"),
                  leading: Icon(Icons.dangerous,)
                ),
            )
            : DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "Pilih Outlet",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  filled: true,
                  isDense: true,
                ),
                items: [..._lsOutlet]
                    .map((e) => DropdownMenuItem(
                          child: Text(e['name']),
                          value: e['id'],
                        ))
                    .toList(),
                onChanged: (value) {
                  onSelectOutlet(value!.toString());
                },
              ),
      ),
    );
  }
}

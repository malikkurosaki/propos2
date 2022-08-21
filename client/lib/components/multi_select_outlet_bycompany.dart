import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:propos/utils/router_api.dart';

class MultiSelectOutletBycompany extends StatelessWidget {
  MultiSelectOutletBycompany({Key? key, required this.companyId, required this.onSelectOutlet}) : super(key: key);
  final _lsOutlet = [].obs;
  final _lsValue = [].obs;
  final Function(List) onSelectOutlet;
  final String companyId;

  _onLoad() {
    RouterApi.outletByCompanyId(query: "cusCompanyId=$companyId")
        .getData()
        .then((value) => value.statusCode == 200 ? _lsOutlet.value = jsonDecode(value.body) : debugPrint(value.body));
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Obx(
      () => Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Ink(
                color: Colors.grey.shade100,
                child: ListTile(
                  title: Text("Select Outlet"),
                  trailing: _lsOutlet.isEmpty? null: Checkbox(value: _lsValue.length.isEqual(_lsOutlet.length), onChanged: (value){
                    if(value!){
                      _lsValue.assignAll(_lsOutlet.map((e) => e['id']));
                    }else{
                      _lsValue.clear();
                    }
                  },),
                ),
              ),
              ..._lsOutlet.map(
                (e) => CheckboxListTile(
                  selected: _lsValue.contains(e['id']),
                  title: Text(e['name']),
                  value: _lsValue.contains(e['id']),
                  onChanged: (value) {
                    if (value!) {
                      _lsValue.add(e['id']);
                    } else {
                      _lsValue.remove(e['id']);
                    }
                    onSelectOutlet(_lsValue.toList());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

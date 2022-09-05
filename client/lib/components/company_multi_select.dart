import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:propos/utils/router_api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompanyMultiSelect extends StatelessWidget {
  CompanyMultiSelect({Key? key, required this.onSelectCompany}) : super(key: key);
  final _listCompany = [].val("MultiSelectCompany._listCompany").obs;
  final _listSelected = [].obs;
  final Function(List value) onSelectCompany;

  _onLoad() async {
    final data = await RouterApi.listCompany().getData();
    if (data.statusCode == 200) {
      final tmp = jsonDecode(data.body);
      _listCompany.value.val = tmp;
    }
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.grey.shade100,
            child: CheckboxListTile(
              title: Text("Select Company"),
              value: _listSelected.isNotEmpty && _listCompany.value.val.length.isEqual(_listSelected.length),
              onChanged: (value) {
                if (value!) {
                  _listSelected.assignAll([..._listCompany.value.val.map((data) => data['id']).toList()]);
                } else {
                  _listSelected.clear();
                }

                onSelectCompany(_listSelected);
              },
            ),
          ),
          ..._listCompany.value.val
              .map(
                (data) => CheckboxListTile(
                  title: Text(data['name'].toString()),
                  value: _listSelected.contains(data['id']),
                  onChanged: (value) {
                    value!
                        ? _listSelected.add(data['id'])
                        : _listSelected.removeWhere((element) => element == data['id']);
                    onSelectCompany(_listSelected);
                  },
                ),
              )
              .toList()
        ],
      ),
    );
  }
}

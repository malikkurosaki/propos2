import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/cashier/casier_val.dart';

class CashierSelectCutomer extends StatelessWidget {
  const CashierSelectCutomer({Key? key}) : super(key: key);

  Future<void> _onLoad() async {
    Rot.cashierListCustomerGet().then(
      (res) {
        debugPrint("ini di CashierSelectCustomer" + res.body);
        if (res.statusCode == 200) {
          CashierVal.listCustomer.assignAll(jsonDecode(res.body));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Obx(
      () => ListTile(
        leading: Icon(Icons.people),
        title: CashierVal.listCustomer.isEmpty
            ? Text("Select Customer")
            : DropdownSearch<Map>(
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    hintText: CashierVal.selectedCustomer.value.val.isEmpty
                        ? "Select Customer"
                        : CashierVal.selectedCustomer.value.val['name'].toString(),
                  ),
                ),
                items: [...CashierVal.listCustomer],
                itemAsString: (value) => value['name'],
                onChanged: (value) {
                  CashierVal.selectedCustomer.value.val.assignAll(value!);
                  CashierVal.selectedCustomer.refresh();
                },
              ),
        trailing: IconButton(
          onPressed: () {
            CashierVal.selectedCustomer.value.val.assignAll({});
            CashierVal.selectedCustomer.refresh();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}

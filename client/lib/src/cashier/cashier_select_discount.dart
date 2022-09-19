import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:propos/rot.dart';

class CashierSelectDiscount extends StatelessWidget {
  const CashierSelectDiscount({Key? key, this.selectedDiscount, required this.onChanged}) : super(key: key);
  static final listDiscount = [].obs;
  final Map? selectedDiscount;
  final Function(Map value) onChanged;

  _onLoad() {
    Rot.cashierListDiscountGet().then(
      (res) {
        debugPrint(res.body);
        if (res.statusCode == 200) {
          listDiscount.assignAll(jsonDecode(res.body));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Obx(
      () => ListTile(
        leading: Icon(Icons.money_rounded),
        title: listDiscount.isEmpty
            ? Text("Select Discount")
            : DropdownSearch<Map>(
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        hintText: selectedDiscount == null ? "Select Discount" : selectedDiscount!['name'].toString())),
                items: [...listDiscount],
                itemAsString: (value) => value['name'].toString(),
                onChanged: (value) {
                  if (selectedDiscount != null) selectedDiscount!.assignAll(value!);
                  onChanged(value!);
                },
              ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.delete,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}

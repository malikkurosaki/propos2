import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/cashier/cashier_select_discount.dart';
import 'package:propos/utils/val.dart';
import 'package:http/http.dart' as http;

class CashierTotalanAddNote extends StatelessWidget {
  const CashierTotalanAddNote({Key? key, required this.itm}) : super(key: key);
  final Rx<ReadWriteValue<Map<dynamic, dynamic>>> itm;
  // final _conName = TextEditingController();

  // _onLoad() {
  //   _conName.text = itm['note'].toString();
  // }

  @override
  Widget build(BuildContext context) {
    // _onLoad();
    return Material(
      color: Colors.grey.shade100,
      // title: Text("Note"),
      child: Column(
        children: [
          ListTile(
            leading: BackButton(),
            title: Text(
              itm.value.val['name'].toString(),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0, name: "").format(itm.value.val['price'])),
            trailing: MaterialButton(
              color: Colors.orange,
              onPressed: () {
                final data = List.from(Val.listorder.value.val);
                final idx = data.indexWhere((element) => element['id'] == itm.value.val['id']);
                data[idx]['note'] = itm.value.val['note'];
                data[idx]['isNote'] = itm.value.val['isNote'];
                data[idx]['isDiscount'] = itm.value.val['isDiscount'];
                data[idx]['isPercentage'] = itm.value.val['isPercentage'];
                data[idx]['percentage'] = itm.value.val['percentage'];
                data[idx]['value'] = itm.value.val['value'];
                data[idx]['discountId'] = itm.value.val['discountId'];
                data[idx]['discountName'] = itm.value.val['discountName'];
                data[idx]['discountMap'] = itm.value.val['discountMap'];
                Val.listorder.value.val = data;
                Val.listorder.refresh();
                SmartDialog.showToast("Saved");
                Get.back();
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Obx(() {
            itm.value;
            return ListTile(
              title: CheckboxListTile(
                title: Text(
                  "Add Note",
                  style: TextStyle(fontSize: 18),
                ),
                value: (itm.value.val['isNote'] ?? false),
                onChanged: (val) {
                  itm.value.val['isNote'] = val;
                  itm.refresh();
                },
              ),
            );
          }),
          Obx(() {
            final muncul = itm.value.val['isNote'] ?? false;
            return !muncul
                ? Container()
                : ListTile(
                    leading: Icon(Icons.edit),
                    title: TextField(
                      onChanged: (val) => itm.value.val['note'] = val,
                      controller: TextEditingController(text: itm.value.val['note']),
                      decoration: InputDecoration(
                        hintText: 'Note',
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        itm.value.val['note'] = "";
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.orange,
                      ),
                    ),
                  );
          }),
          Divider(),
          Obx(() {
            itm.value;
            return ListTile(
              title: CheckboxListTile(
                title: Text(
                  "Add Discount",
                  style: TextStyle(fontSize: 18),
                ),
                value: (itm.value.val['isDiscount'] ?? false),
                onChanged: (val) {
                  itm.value.val['isDiscount'] = val;
                  itm.refresh();
                },
              ),
            );
          }),
          Builder(
            builder: (context) {
              final ket = "".obs;

              return Obx(
                () {
                  final muncul = itm.value.val['isDiscount'] ?? false;

                  return !muncul
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: FutureBuilder<http.Response>(
                                future: Rot.cashierListDiscountGet(),
                                builder: (con, snap) {
                                  if (!snap.hasData) return LinearProgressIndicator();
                                  List lsdata = jsonDecode(snap.data!.body);

                                  return ListTile(
                                    // munculkan list discount
                                    title: DropdownSearch<Map>(
                                      selectedItem: itm.value.val['isDiscount'] ? itm.value.val['discountMap'] : {},
                                      dropdownDecoratorProps: DropDownDecoratorProps(
                                          dropdownSearchDecoration: InputDecoration(
                                              filled: true, border: InputBorder.none, hintText: "select discount")),
                                      items: [...lsdata],
                                      itemAsString: (val) => val['name'],
                                      onChanged: (value) {
                                        itm.value.val['discountId'] = value!['id'];
                                        itm.value.val['discountName'] = value['name'];
                                        itm.value.val['discountMap'] = value;
                                        if (value['isPercentage']) {
                                          final result =
                                              ((value['percentage'] / 100) * itm.value.val['total'] as double).round();
                                          final total = itm.value.val['total'];
                                          final maka = total - double.parse(result.toString()).round();

                                          ket.value = "${value['percentage']}% $total -  $result = $maka";
                                          debugPrint(double.parse(result.toString()).round().toString());
                                          itm.value.val['isPercentage'] = true;
                                          itm.value.val['percentage'] = value['percentage'];
                                        } else {
                                          ket.value = NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0)
                                              .format(value['value']);
                                          itm.value.val['isPercentage'] = false;
                                          itm.value.val['value'] = value['value'];
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            ket.isEmpty
                                ? Container()
                                : ListTile(
                                    leading: Icon(Icons.calculate),
                                    title: Text(ket.value),
                                  )
                          ],
                        );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

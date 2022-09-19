import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/intl.dart';
import 'package:propos/components/calculator_pad.dart';
import 'package:get/get.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/val.dart';
import 'package:short_uuids/short_uuids.dart';

class CashierManualOrder extends StatelessWidget {
  CashierManualOrder({Key? key}) : super(key: key);
  // final _conPrice = TextEditingController();
  final _conName = TextEditingController();
  final _price = "0".obs;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      onPressed: () {
        showBottomSheet(
          context: context,
          builder: (c) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              BackButton(
                                color: Colors.white,
                              ),
                              Text(
                                "Manual Order",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          ),
                          onPressed: () {
                            if (_conName.text.isEmpty || _price.value.isEmpty) {
                              SmartDialog.showToast("nama dan harga tidak boleh kosong");
                              return;
                            }

                            final adaData =
                                Val.listorder.value.val.map((element) => element['name']).contains(_conName.text);
                            if (adaData) {
                              SmartDialog.showToast("data has already");
                              return;
                            }

                            final productId = const ShortUuid().generate();

                            // final lsData = [...CashierVal.listManualProduct.value.val];
                            final data = [...Val.listorder.value.val];
                            final prod = {};
                            prod['id'] = productId;
                            prod['qty'] = 1;
                            prod['price'] = int.parse(_price.value);
                            prod['note'] = "";
                            prod['total'] = int.parse(_price.value);
                            prod['isManual'] = true;
                            prod['name'] = _conName.text;
                            data.add(prod);
                            SmartDialog.showToast("Added to cart", animationTime: Duration(milliseconds: 500));

                            Val.listorder.value.val = data;
                            Val.listorder.refresh();

                            // lsData.add({});

                            // CashierVal.listManualProduct.value.val = lsData;
                            // CashierVal.listManualProduct.refresh();
                            Get.back();
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _conName,
                      decoration: InputDecoration(
                          hintText: "Name / Description",
                          filled: true,
                          isDense: true,
                          border: OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0).format(int.parse(_price.value)),
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     controller: _conPrice,
                  //     decoration: InputDecoration(
                  //         hintText: "Price",
                  //         filled: true,
                  //         isDense: true,
                  //         border: OutlineInputBorder(borderSide: BorderSide.none)),
                  //   ),
                  // ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CalculatorPad(
                        color: Colors.blue,
                        onChanged: (value) {
                          _price.value = value;
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      child: Text(
        "Manual Order",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

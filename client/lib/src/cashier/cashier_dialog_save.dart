import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/val.dart';
import 'package:get/get.dart';

class CashierDialogSave {
  static void now(BuildContext context) {
    final conName = TextEditingController(
        text: CashierVal.restoreOrderName.value.val.isEmpty ? '' : CashierVal.restoreOrderName.value.val);
    if (Val.listorder.value.val.isEmpty) {
      SmartDialog.showToast("Cart is empty", animationTime: Duration(milliseconds: 500));
      return;
    }

    showBottomSheet(
      context: context,
      builder: (c) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ink(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    BackButton(
                      color: Colors.white,
                    ),
                    Text(
                      "Save Order",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                controller: conName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  for (final prod in Val.listSavedOrder.value.val)
                    TextButton(
                      onPressed: () {
                        conName.text = prod['name'];
                      },
                      child: Text(prod['name'].toString()),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  MaterialButton(
                    child: Text('Save'),
                    onPressed: () {
                      final data = List.from(Val.listSavedOrder.value.val);
                      final idx = data.indexWhere((element) => element['name'] == conName.text);
                      if (idx == -1) {
                        data.add({
                          'name': conName.text,
                          'order': Val.listorder.value.val,
                        });
                      } else {
                        data[idx]['order'] = Val.listorder.value.val;
                      }

                      if (conName.text != CashierVal.restoreOrderName.value.val) {
                        CashierVal.restoreOrderName.value.val = "";
                        CashierVal.restoreOrderName.refresh();
                      }

                      Val.listSavedOrder.value.val = data;
                      Val.listorder.value.val = [];
                      Val.listSavedOrder.refresh();
                      Val.listorder.refresh();

                      Get.back();
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Restore Order",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    for (final prod in Val.listSavedOrder.value.val)
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            Val.listorder.value.val = prod['order'];
                            Val.listorder.refresh();
                            CashierVal.restoreOrderName.value.val = prod['name'];
                            Get.back();
                          },
                          child: Chip(
                            backgroundColor: Colors.cyan,
                            label: Text(
                              prod['name'].toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onDeleted: () {
                              final data = List.from(Val.listSavedOrder.value.val);
                              final idx = data.indexWhere((element) => element['name'] == prod['name']);
                              if (idx != -1) {
                                data.removeAt(idx);
                              }
                              Val.listSavedOrder.value.val = data;
                              Val.listSavedOrder.refresh();
                            },
                            deleteIconColor: Colors.white,
                          ),
                        ),
                      )
                    // TextButton(
                    //   onPressed: () {
                    //     Val.listorder.value.val = prod['order'];
                    //     Val.listorder.refresh();
                    //     _restoreOrderName.value.val = prod['name'];
                    //     Get.back();
                    //   },
                    //   child: Text(prod['name'].toString()),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Get.dialog(
    //   SimpleDialog(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(
    //           "Save Order",
    //           style: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: TextFormField(
    //           decoration: InputDecoration(
    //             labelText: 'Name',
    //             filled: true,
    //             border: OutlineInputBorder(
    //               borderSide: BorderSide.none,
    //             ),
    //           ),
    //           controller: conName,
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Wrap(
    //           crossAxisAlignment: WrapCrossAlignment.start,
    //           children: [
    //             for (final prod in Val.listSavedOrder.value.val)
    //               TextButton(
    //                 onPressed: () {
    //                   conName.text = prod['name'];
    //                 },
    //                 child: Text(prod['name'].toString()),
    //               )
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: [
    //             MaterialButton(
    //               child: Text('Cancel'),
    //               onPressed: () {
    //                 Get.back();
    //               },
    //             ),
    //             MaterialButton(
    //               child: Text('Save'),
    //               onPressed: () {
    //                 final data = List.from(Val.listSavedOrder.value.val);
    //                 final idx = data.indexWhere((element) => element['name'] == conName.text);
    //                 if (idx == -1) {
    //                   data.add({
    //                     'name': conName.text,
    //                     'order': Val.listorder.value.val,
    //                   });
    //                 } else {
    //                   data[idx]['order'] = Val.listorder.value.val;
    //                 }

    //                 if (conName.text != _restoreOrderName.value.val) {
    //                   _restoreOrderName.value.val = "";
    //                   _restoreOrderName.refresh();
    //                 }

    //                 Val.listSavedOrder.value.val = data;
    //                 Val.listorder.value.val = [];
    //                 Val.listSavedOrder.refresh();

    //                 Get.back();
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //       Divider(),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(
    //           "Restore Order",
    //           style: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Obx(
    //           () => Wrap(
    //             crossAxisAlignment: WrapCrossAlignment.start,
    //             children: [
    //               for (final prod in Val.listSavedOrder.value.val)
    //                 Padding(
    //                   padding: const EdgeInsets.all(4.0),
    //                   child: InkWell(
    //                     onTap: () {
    //                       Val.listorder.value.val = prod['order'];
    //                       Val.listorder.refresh();
    //                       _restoreOrderName.value.val = prod['name'];
    //                       Get.back();
    //                     },
    //                     child: Chip(
    //                       backgroundColor: Colors.cyan,
    //                       label: Text(
    //                         prod['name'].toString(),
    //                         style: TextStyle(
    //                           color: Colors.white,
    //                         ),
    //                       ),
    //                       onDeleted: () {
    //                         final data = List.from(Val.listSavedOrder.value.val);
    //                         final idx = data.indexWhere((element) => element['name'] == prod['name']);
    //                         if (idx != -1) {
    //                           data.removeAt(idx);
    //                         }
    //                         Val.listSavedOrder.value.val = data;
    //                         Val.listSavedOrder.refresh();
    //                       },
    //                       deleteIconColor: Colors.white,
    //                     ),
    //                   ),
    //                 )
    //               // TextButton(
    //               //   onPressed: () {
    //               //     Val.listorder.value.val = prod['order'];
    //               //     Val.listorder.refresh();
    //               //     _restoreOrderName.value.val = prod['name'];
    //               //     Get.back();
    //               //   },
    //               //   child: Text(prod['name'].toString()),
    //               // )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

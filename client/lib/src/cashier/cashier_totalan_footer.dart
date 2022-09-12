import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:propos/pages.dart';
import 'package:propos/src/cashier/cashier_dialog_save.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/val.dart';
import 'package:get/get.dart';

class CashierTotalanFooter extends StatelessWidget {
  const CashierTotalanFooter({Key? key}) : super(key: key);

  Widget _saveOrderButton(BuildContext context) {
    return Visibility(
      visible: Val.listorder.value.val.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: MaterialButton(
          color: Colors.blue,
          onPressed: Val.listorder.value.val.isEmpty
              ? null
              : () {
                  // _savedOrderDialog(context);
                  CashierDialogSave.now(context);
                },
          // icon: Icon(
          //   Icons.save,
          //   color: Val.listorder.value.val.isEmpty ? Colors.grey : Colors.cyan,
          // ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Save",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          _saveOrderButton(context),
          // Tooltip(
          //   message: "menyimpan order",
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     child: CashierVal.restoreOrderName.value.val.isEmpty
          //         ? Badge(
          //             badgeColor: Colors.grey.shade100,
          //             badgeContent: Text(
          //               Val.listSavedOrder.value.val.length.toString(),
          //               style: TextStyle(color: Colors.black),
          //             ),
          //             child: MaterialButton(
          //               color: Colors.blue,
          //               onPressed: Val.listorder.value.val.isEmpty
          //                   ? null
          //                   : () {
          //                       // _savedOrderDialog(context);
          //                       CashierDialogSave.now(context);
          //                     },
          //               // icon: Icon(
          //               //   Icons.save,
          //               //   color: Val.listorder.value.val.isEmpty ? Colors.grey : Colors.cyan,
          //               // ),
          //               child: Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Text(
          //                   "Save",
          //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //           )
          //         : MaterialButton(
          //             color: Colors.orange,
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Text(
          //                 CashierVal.restoreOrderName.value.val.toString(),
          //                 style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //             onPressed: () {
          //               // _savedOrderDialog(context);
          //               CashierDialogSave.now(context);
          //             },
          //           ),
          //   ),
          // ),
          Expanded(
            child: MaterialButton(
              color: Colors.cyan,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Checkout",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                ),
              ),
              onPressed: () {
                if (Val.listorder.value.val.isNotEmpty) {
                  Get.toNamed(Pages.checkoutPage().route);
                } else {
                  Get.dialog(
                    AlertDialog(
                      title: Text("Warning"),
                      content: Text("Please add item to cart"),
                      actions: [
                        MaterialButton(
                          child: Text("Ok"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${NumberFormat.currency(
                locale: 'id_ID',
                symbol: 'Rp',
                decimalDigits: 0,
              ).format(
                Val.listorder.value.val
                    .fold(0, (prev, element) => int.parse(prev.toString()) + element['qty'] * element['price']),
              )}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

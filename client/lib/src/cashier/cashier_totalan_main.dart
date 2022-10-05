import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/intl.dart';
import 'package:propos/src/cashier/cashier_select_discount.dart';
import 'package:propos/src/cashier/cashier_totalan_add_note.dart';
import 'package:propos/src/cashier/cashier_totalan_detail.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:get/get.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/val.dart';

class CashierTotalanMain extends StatelessWidget {
  const CashierTotalanMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Val.listorder.value.val.isEmpty
          ? Center(
              child: ImgDef.cartEmpty(width: 200, fit: BoxFit.contain),
            )
          : ListView(
              controller: ScrollController(),
              children: [
                for (final itm in Val.listorder.value.val)
                  Column(
                    children: [
                      ListTile(
                        // leading: !isMultipleSelect.value
                        leading: CashierVal.lsTampungan.isEmpty
                            ? null
                            : Checkbox(
                                value: CashierVal.lsTampungan.contains(itm['id']),
                                onChanged: (value) {
                                  if (value!) {
                                    CashierVal.lsTampungan.add(itm['id']);
                                  } else {
                                    CashierVal.lsTampungan.remove(itm['id']);
                                  }
                                  // Get.back();
                                },
                              ),
                        title: ListTile(
                          onLongPress: () {
                            // CashierVal.isMultipleSelect.toggle();
                          },
                          onTap: () {
                            // dialog add note
                            showBottomSheet(
                              context: context,
                              builder: (context) => CashierTotalanAddNote(itm: itm),
                            );
                          },
                          leading: InkWell(
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.orange,
                              size: 36,
                            ),
                            onTap: () => CashierVal.orderSubstract(itm),
                            // onTap: () {
                            //   final data = List.from(Val.listorder.value.val);
                            //   final idx = data.indexWhere((element) => element['id'] == itm['id']);
                            //   if (idx != -1) {
                            //     if (data[idx]['qty'] > 1) {
                            //       data[idx]['qty']--;
                            //       data[idx]['total'] = data[idx]['qty'] * data[idx]['price'];
                            //     } else {
                            //       Get.dialog(
                            //         AlertDialog(
                            //           title: Text("Warning"),
                            //           content: Text("Are you sure want to delete this item?"),
                            //           actions: [
                            //             MaterialButton(
                            //               child: Text("Yes"),
                            //               onPressed: () {
                            //                 data.removeAt(idx);
                            //                 Val.listorder.value.val = data;
                            //                 Val.listorder.refresh();
                            //                 Get.back();
                            //               },
                            //             ),
                            //             MaterialButton(
                            //               child: Text("No"),
                            //               onPressed: () {
                            //                 Get.back();
                            //               },
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //     }
                            //   }
                            //   Val.listorder.value.val = data;
                            //   Val.listorder.refresh();
                            // },
                          ),
                          title: Text(
                            itm['name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          itm['qty'].toString(),
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                        ),
                                        Text(" x "),
                                        Text(NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
                                            .format(itm['price'])),
                                      ],
                                    ),
                                  ),
                                  Text(NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
                                      .format(itm['total'])),
                                ],
                              ),
                              itm['sisaStock'] == null
                                  ? SizedBox.shrink()
                                  : Row(
                                    children: [
                                      Text(
                                        "fnl stk ",
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                      Text(
                                        itm['sisaStock'].toString(),
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                    ],
                                  ),
                              itm['note'].toString().isEmpty
                                  ? SizedBox.shrink()
                                  : Ink(
                                      color: Colors.grey.shade100,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            size: 16,
                                            color: Colors.green,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(itm['note']),
                                          ),
                                        ],
                                      )),
                              !itm['isManual']
                                  ? SizedBox.shrink()
                                  : Text(
                                      "Manual",
                                      style: TextStyle(
                                        backgroundColor: Colors.grey.shade200,
                                        color: Colors.purple,
                                      ),
                                    )
                            ],
                          ),
                          trailing: InkWell(
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.green,
                              size: 36,
                            ),
                            onTap: () => CashierVal.orderAdd(itm),
                            // onTap: () {
                            //   final data = List.from(Val.listorder.value.val);
                            //   final idx = data.indexWhere((element) => element['id'] == itm['id']);
                            //   if (idx != -1) {
                            //     data[idx]['qty']++;
                            //     itm['total'] = itm['qty'] * itm['price'];
                            //   } else {
                            //     itm['qty'] = 1;
                            //     itm['note'] = '';
                            //     itm['total'] = itm['qty'] * itm['price'];
                            //     data.add(itm);
                            //   }
                            //   Val.listorder.value.val = data;
                            //   Val.listorder.refresh();
                            // },
                          ),
                        ),
                      ),
                      DottedLine(dashColor: Colors.grey.shade300)
                    ],
                  ),
                CashierTotalanDetail()
              ],
            ),
    );
  }
}

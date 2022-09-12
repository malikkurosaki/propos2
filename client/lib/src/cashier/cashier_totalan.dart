import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propos/pages.dart';
import 'package:propos/src/cashier/cashier_dialog_save.dart';
import 'package:propos/src/cashier/cashier_totalan_footer.dart';
import 'package:propos/src/cashier/cashier_totalan_header.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CashierTotalan extends StatelessWidget {
  const CashierTotalan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) {
        return Scaffold(
          body: Builder(
            builder: (context) {
              return Obx(() => SizedBox(
                    width: media.isMobile ? Get.width : 500,
                    child: Card(
                      child: Column(
                        children: [
                          CashierTotalanHeader(),
                          // _headerTotalan(media, CashierVal.lsTampungan),
                          // mulai list item
                          Flexible(
                            child: Val.listorder.value.val.isEmpty
                                ? Center(
                                    child: ImgDef.cartEmpty(width: 200, fit: BoxFit.contain),
                                  )
                                : ListView(
                                    controller: ScrollController(),
                                    children: [
                                      for (final itmManual in CashierVal.listManualProduct.value.val)
                                        ListTile(
                                          leading: InkWell(
                                            onTap: () {},
                                            child: Icon(
                                              Icons.remove_circle,
                                              color: Colors.pink,
                                              size: 36,
                                            ),
                                          ),
                                          trailing: InkWell(
                                            child: Icon(
                                              Icons.add_circle,
                                              color: Colors.cyan,
                                              size: 36,
                                            ),
                                          ),
                                          title: Text(itmManual['name'].toString()),
                                          onTap: () {},
                                          subtitle: Text("Manual"),
                                        ),
                                      for (final itm in Val.listorder.value.val)
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
                                                    Get.back();
                                                  },
                                                ),
                                          title: ListTile(
                                            onLongPress: () {
                                              CashierVal.isMultipleSelect.toggle();
                                            },
                                            onTap: () {
                                              final _conName = TextEditingController();
                                              // dialog add note
                                              showBottomSheet(
                                                context: context,
                                                builder: (context) => Material(
                                                  // title: Text("Note"),
                                                  child: Column(
                                                    children: [
                                                      TextField(
                                                        controller: _conName,
                                                        decoration: InputDecoration(
                                                          hintText: 'Note',
                                                          filled: true,
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          MaterialButton(
                                                            child: Text("Cancel"),
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                          ),
                                                          MaterialButton(
                                                            child: Text("Ok"),
                                                            onPressed: () {
                                                              final data = List.from(Val.listorder.value.val);
                                                              final idx = data
                                                                  .indexWhere((element) => element['id'] == itm['id']);
                                                              data[idx]['note'] = _conName.text;
                                                              Val.listorder.value.val = data;
                                                              Val.listorder.refresh();
                                                              Get.back();
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  // actions: [
                                                  //   MaterialButton(
                                                  //     child: Text("Cancel"),
                                                  //     onPressed: () {
                                                  //       Get.back();
                                                  //     },
                                                  //   ),
                                                  //   MaterialButton(
                                                  //     child: Text("Ok"),
                                                  //     onPressed: () {
                                                  //       final data = List.from(Val.listorder.value.val);
                                                  //       final idx = data
                                                  //           .indexWhere((element) => element['id'] == itm['id']);
                                                  //       data[idx]['note'] = _conName.text;
                                                  //       Val.listorder.value.val = data;
                                                  //       Val.listorder.refresh();
                                                  //       Get.back();
                                                  //     },
                                                  //   ),
                                                  // ],
                                                ),
                                              );
                                            },
                                            leading: InkWell(
                                              child: Icon(
                                                Icons.remove_circle,
                                                color: Colors.pink,
                                                size: 36,
                                              ),
                                              onTap: () {
                                                final data = List.from(Val.listorder.value.val);
                                                final idx = data.indexWhere((element) => element['id'] == itm['id']);
                                                if (idx != -1) {
                                                  if (data[idx]['qty'] > 1) {
                                                    data[idx]['qty']--;
                                                    data[idx]['total'] = data[idx]['qty'] * data[idx]['price'];
                                                  } else {
                                                    Get.dialog(
                                                      AlertDialog(
                                                        title: Text("Warning"),
                                                        content: Text("Are you sure want to delete this item?"),
                                                        actions: [
                                                          MaterialButton(
                                                            child: Text("Yes"),
                                                            onPressed: () {
                                                              data.removeAt(idx);
                                                              Val.listorder.value.val = data;
                                                              Val.listorder.refresh();
                                                              Get.back();
                                                            },
                                                          ),
                                                          MaterialButton(
                                                            child: Text("No"),
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                }
                                                Val.listorder.value.val = data;
                                                Val.listorder.refresh();
                                              },
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
                                                          Text(NumberFormat.currency(
                                                                  locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
                                                              .format(itm['price'])),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(NumberFormat.currency(
                                                            locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
                                                        .format(itm['total'])),
                                                  ],
                                                ),
                                                Text(itm['note']),
                                              ],
                                            ),
                                            trailing: InkWell(
                                                child: Icon(
                                                  Icons.add_circle,
                                                  color: Colors.cyan,
                                                  size: 36,
                                                ),
                                                onTap: () {
                                                  final data = List.from(Val.listorder.value.val);
                                                  final idx = data.indexWhere((element) => element['id'] == itm['id']);
                                                  if (idx != -1) {
                                                    data[idx]['qty']++;
                                                    itm['total'] = itm['qty'] * itm['price'];
                                                  } else {
                                                    itm['qty'] = 1;
                                                    itm['note'] = '';
                                                    itm['total'] = itm['qty'] * itm['price'];
                                                    data.add(itm);
                                                  }
                                                  Val.listorder.value.val = data;
                                                  Val.listorder.refresh();
                                                }),
                                          ),
                                        ),
                                    ],
                                  ),
                          ),
                          CashierTotalanFooter()
                          // save order
                          // Container(
                          //   color: Colors.grey.shade100,
                          //   padding: const EdgeInsets.all(16.0),
                          //   child: Row(
                          //     children: [
                          //       Tooltip(
                          //         message: "menyimpan order",
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(horizontal: 16),
                          //           child: CashierVal.restoreOrderName.value.val.isEmpty
                          //               ? Badge(
                          //                   badgeColor: Colors.grey.shade100,
                          //                   badgeContent: Text(
                          //                     Val.listSavedOrder.value.val.length.toString(),
                          //                     style: TextStyle(color: Colors.black),
                          //                   ),
                          //                   child: MaterialButton(
                          //                     color: Colors.blue,
                          //                     onPressed: Val.listorder.value.val.isEmpty
                          //                         ? null
                          //                         : () {
                          //                             // _savedOrderDialog(context);
                          //                             CashierDialogSave.now(context);
                          //                           },
                          //                     // icon: Icon(
                          //                     //   Icons.save,
                          //                     //   color: Val.listorder.value.val.isEmpty ? Colors.grey : Colors.cyan,
                          //                     // ),
                          //                     child: Padding(
                          //                       padding: const EdgeInsets.all(8.0),
                          //                       child: Text(
                          //                         "Save",
                          //                         style: TextStyle(
                          //                             fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 )
                          //               : MaterialButton(
                          //                   color: Colors.orange,
                          //                   child: Padding(
                          //                     padding: const EdgeInsets.all(8.0),
                          //                     child: Text(
                          //                       CashierVal.restoreOrderName.value.val.toString(),
                          //                       style: TextStyle(
                          //                           color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                          //                     ),
                          //                   ),
                          //                   onPressed: () {
                          //                     // _savedOrderDialog(context);
                          //                     CashierDialogSave.now(context);
                          //                   },
                          //                 ),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         child: MaterialButton(
                          //           color: Colors.cyan,
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: const Text(
                          //               "Checkout",
                          //               style:
                          //                   TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                          //             ),
                          //           ),
                          //           onPressed: () {
                          //             if (Val.listorder.value.val.isNotEmpty) {
                          //               Get.toNamed(Pages.checkoutPage().route);
                          //             } else {
                          //               Get.dialog(
                          //                 AlertDialog(
                          //                   title: Text("Warning"),
                          //                   content: Text("Please add item to cart"),
                          //                   actions: [
                          //                     MaterialButton(
                          //                       child: Text("Ok"),
                          //                       onPressed: () {
                          //                         Get.back();
                          //                       },
                          //                     ),
                          //                   ],
                          //                 ),
                          //               );
                          //             }
                          //           },
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Text(
                          //           "${NumberFormat.currency(
                          //             locale: 'id_ID',
                          //             symbol: 'Rp',
                          //             decimalDigits: 0,
                          //           ).format(
                          //             Val.listorder.value.val.fold(
                          //                 0,
                          //                 (prev, element) =>
                          //                     int.parse(prev.toString()) + element['qty'] * element['price']),
                          //           )}",
                          //           style: TextStyle(
                          //             fontSize: 20,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ));
            },
          ),
        );
      },
    );
  }
}

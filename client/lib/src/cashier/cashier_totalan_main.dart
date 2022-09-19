import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/intl.dart';
import 'package:propos/src/cashier/cashier_select_discount.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:get/get.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/val.dart';

class CashierTotalanMain extends StatelessWidget {
  const CashierTotalanMain({Key? key}) : super(key: key);

  _onLoad() {}

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Obx(
      () => Val.listorder.value.val.isEmpty
          ? Center(
              child: ImgDef.cartEmpty(width: 200, fit: BoxFit.contain),
            )
          : ListView(
              controller: ScrollController(),
              children: [
                // for (final itmManual in CashierVal.listManualProduct.value.val)
                //   ListTile(
                //     leading: InkWell(
                //       onTap: () {},
                //       child: Icon(
                //         Icons.remove_circle,
                //         color: Colors.deepOrange,
                //         size: 36,
                //       ),
                //     ),
                //     trailing: InkWell(
                //       child: Icon(
                //         Icons.add_circle,
                //         color: Colors.blue,
                //         size: 36,
                //       ),
                //     ),
                //     title: Text(itmManual['name'].toString()),
                //     onTap: () {},
                //     subtitle: Text("Manual"),
                //   ),
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
                            final _conName = TextEditingController(text: itm['note'].toString());
                            // dialog add note
                            showBottomSheet(
                              context: context,
                              builder: (context) => Material(
                                color: Colors.grey.shade100,
                                // title: Text("Note"),
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.orange,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          BackButton(
                                            color: Colors.white,
                                          ),
                                          Expanded(
                                            child: Text(
                                              itm['name'].toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                          MaterialButton(
                                            color: Colors.white,
                                            onPressed: () {
                                              if (_conName.text.isNotEmpty) {
                                                final data = List.from(Val.listorder.value.val);
                                                final idx = data.indexWhere((element) => element['id'] == itm['id']);
                                                data[idx]['note'] = _conName.text;
                                                Val.listorder.value.val = data;
                                                Val.listorder.refresh();
                                                SmartDialog.showToast("Note Saved");
                                                Get.back();
                                              } else {
                                                SmartDialog.showToast("Empty Note");
                                              }
                                            },
                                            child: Text(
                                              "Save",
                                              style: TextStyle(color: Colors.orange),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Add Note",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.edit),
                                      title: TextField(
                                        controller: _conName,
                                        decoration: InputDecoration(
                                          hintText: 'Note',
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ),
                                    // ListTile(
                                    //   title: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.end,
                                    //     children: [
                                    //       MaterialButton(
                                    //         child: Text("Cancel"),
                                    //         onPressed: () {
                                    //           Get.back();
                                    //         },
                                    //       ),
                                    //       MaterialButton(
                                    //         child: Text("Ok"),
                                    //         onPressed: () {

                                    //         },
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Divider(),
                                    ListTile(
                                      title: Text(
                                        "Add Discount",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    CashierSelectDiscount(
                                      onChanged: (value) {},
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          leading: InkWell(
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.deepOrange,
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
                                        Text(NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
                                            .format(itm['price'])),
                                      ],
                                    ),
                                  ),
                                  Text(NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
                                      .format(itm['total'])),
                                ],
                              ),
                              itm['note'].toString().isEmpty
                                  ? SizedBox.shrink()
                                  : ListTile(
                                      dense: true,
                                      leading: Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                      title: Text(itm['note']),
                                    ),
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
                              color: Colors.blue,
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
                            },
                          ),
                        ),
                      ),
                      DottedLine(dashColor: Colors.grey.shade300)
                    ],
                  ),
              ],
            ),
    );
  }
}

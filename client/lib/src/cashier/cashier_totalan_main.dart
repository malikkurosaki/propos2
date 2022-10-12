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
import 'package:get_storage/get_storage.dart';

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
                            final rxItm = Map.from(itm).val("CasierTotalan.rxItm").obs;
                            showBottomSheet(
                              context: context,
                              builder: (context) => CashierTotalanAddNote(itm: rxItm),
                            );
                          },
                          leading: InkWell(
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.orange,
                              size: 36,
                            ),
                            onTap: () => CashierVal.orderSubstract(itm),
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
                                  : ListTile(
                                      dense: true,
                                      leading: Icon(
                                        Icons.edit,
                                        // size: 16,
                                        color: Colors.green,
                                      ),
                                      title: Text(
                                        itm['note'],
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ),
                              // Row(
                              //     children: [
                              //       Icon(
                              //         Icons.edit,
                              //         // size: 16,
                              //         color: Colors.green,
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Text(
                              //           itm['note'],
                              //           style: TextStyle(color: Colors.green),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              !(itm['isDiscount'] ?? false)
                                  ? Container()
                                  : ListTile(
                                      dense: true,
                                      leading: Icon(
                                        Icons.discount,
                                        color: Colors.orange,
                                        // size: 1
                                      ),
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(itm['discountName'].toString()),
                                          Text(
                                            itm['isPercentage']
                                                ? "${itm['percentage']}%"
                                                : NumberFormat.simpleCurrency(
                                                        decimalDigits: 0, locale: 'id_ID', name: "")
                                                    .format(
                                                    itm['value'],
                                                  ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Builder(builder: (context) {
                                        int result = 0;
                                        if (itm['isPercentage']) {
                                          result = itm['total'] -
                                              ((itm['percentage'] / 100 * itm['total']) as double).round();
                                        } else {
                                          result = itm['total'] - itm['value'];
                                        }

                                        itm['totalDiscount'] = result;
                                        return Text(
                                            NumberFormat.simpleCurrency(decimalDigits: 0, locale: 'id_ID', name: "")
                                                .format(result));
                                      }),
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

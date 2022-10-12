import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/val.dart';

class CashierTotalanDetail extends StatelessWidget {
  const CashierTotalanDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Val.listorder.value.val.isEmpty
              ? SizedBox.shrink()
              : Builder(
                  builder: (context) {
                    final totalPrice = Val.listorder.value.val
                        .fold(0, (prev, element) => int.parse(prev.toString()) + element['qty'] * element['price']);

                    final totalQty =
                        Val.listorder.value.val.fold(0, (prev, element) => int.parse(prev.toString()) + element['qty']);

                    final int? totalDiscount = Val.listorder.value.val.fold(
                        0, (prev, element) => (int.parse(prev.toString()) + (element['totalDiscount'] ?? 0) as int));

                    Future.delayed(Duration(milliseconds: 10), () {
                      CashierVal.totalQty.value = (totalQty as int);
                      CashierVal.totalPrice.value.val = (totalPrice as int);
                      CashierVal.totalPrice.refresh();
                    });

                    final dataDetail = {};
                    dataDetail['totalQty'] = totalQty;
                    dataDetail['totalPrice'] = totalPrice;
                    dataDetail['totalDiscount'] = totalDiscount;
                    dataDetail['pax'] = CashierVal.pax.value.val;
                    dataDetail['customer'] = CashierVal.selectedCustomer.value.val;
                    CashierVal.orderDetail.value.val = dataDetail;
                    CashierVal.orderDetail.refresh();

                    return Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Text(
                                      "Pax",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DottedLine(dashColor: Colors.grey),
                                    ),
                                  ),
                                  Text(
                                    CashierVal.pax.value.val.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Text(
                                      "Cus",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DottedLine(dashColor: Colors.grey),
                                    ),
                                  ),
                                  Text(
                                    CashierVal.selectedCustomer.value.val.isEmpty
                                        ? "-"
                                        : CashierVal.selectedCustomer.value.val['name'].toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Text(
                                      "Qty",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DottedLine(dashColor: Colors.grey),
                                    ),
                                  ),
                                  Text(
                                    totalQty.toString(),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: DottedLine(
                            //     dashColor: Colors.grey,
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Text(
                                      "Ttl",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DottedLine(
                                        dashColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: '',
                                      decimalDigits: 0,
                                    ).format(totalPrice),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Text(
                                      "Dic",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DottedLine(
                                        dashColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Builder(builder: (context) {
                                    return Text(
                                      NumberFormat.currency(
                                        locale: 'id_ID',
                                        symbol: '',
                                        decimalDigits: 0,
                                      ).format(totalDiscount ?? 0),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ));
                  },
                )
        ],
      ),
    );
  }
}

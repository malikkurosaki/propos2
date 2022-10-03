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
      child: Obx(
        () => Column(
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
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: DottedLine(dashColor: Colors.grey),
            // ),
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
            //  Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: DottedLine(dashColor: Colors.grey),
            // ),
            Val.listorder.value.val.isEmpty
                ? SizedBox.shrink()
                : Builder(
                    builder: (context) {
                      final priceTotal = Val.listorder.value.val
                          .fold(0, (prev, element) => int.parse(prev.toString()) + element['qty'] * element['price']);

                      final qtyTotal = Val.listorder.value.val
                          .fold(0, (prev, element) => int.parse(prev.toString()) + element['qty']);

                      Future.delayed(Duration(milliseconds: 10), () {
                        CashierVal.totalQty.value = (qtyTotal as int);
                        CashierVal.totalPrice.value.val = (priceTotal as int);
                        CashierVal.totalPrice.refresh();
                      });

                      return Column(
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
                                  qtyTotal.toString(),
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
                                  ).format(priceTotal),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}

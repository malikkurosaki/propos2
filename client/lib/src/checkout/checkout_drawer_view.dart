import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/src/checkout/checkout_change.dart';
import 'package:propos/src/checkout/checkout_val.dart';
import 'package:propos/src/printers/printer_val.dart';
import 'package:propos/utils/struk_tiket.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CheckoutDrawerView extends StatelessWidget {
  const CheckoutDrawerView({Key? key, this.isPrintPreview}) : super(key: key);
  final bool? isPrintPreview;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => SizedBox(
        width: media.isMobile ? Get.width : 360,
        height: media.isMobile ? Get.height : Get.height * 0.92,
        child: Card(
          child: Column(
            children: [
              !(isPrintPreview ?? false) && media.isMobile
                  ? Row(
                      children: [BackButton(), Text("Bill")],
                    )
                  : SizedBox.shrink(),
              Flexible(
                child: ListView(
                  controller: ScrollController(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                         
                          FutureBuilder<http.Response>(
                            future: Rot.checkoutCodNameGet(),
                            builder: (con, snap) {
                              if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();
                              if (snap.data!.statusCode == 200) {
                                final mpData = jsonDecode(snap.data!.body);
                                Future.delayed(
                                    Duration(milliseconds: 100), () => CheckoutVal.codName.assignAll(mpData));
                              }
                              return SizedBox.shrink();
                            },
                          ),
                          Obx(
                            () => CheckoutVal.codName.isEmpty
                                ? SizedBox.shrink()
                                : Column(
                                    children: [
                                     
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Icon(Icons.store),
                                          Text(
                                            CheckoutVal.codName['Outlet']['name'].toString(),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Icon(Icons.devices),
                                          Text(
                                            CheckoutVal.codName['Device']['name'].toString(),
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.place),
                              Text(
                                "jl. hasanudin nomer 36 x denpasar bali",
                                style: TextStyle(),
                              ),
                            ],
                          ),
                          Text(
                            "bill",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [Text("Receipt: "), Text(CheckoutVal.billId.value.val.toString())],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [Text("Date: "), Text(DateFormat('dd/MM/yyyy').format(DateTime.now()))],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [Text("Cashier: "), Text("Owner")],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text("Cus: "),
                          Text(CashierVal.selectedCustomer.value.val['name'] ?? ""),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text("Pax: "),
                          Text(CashierVal.pax.value.val.toString()),
                        ],
                      ),
                    ),
                    DottedLine(),
                    Column(
                      children: [
                        for (final itm in Val.listorder.value.val)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itm['name'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text("${itm['qty']} x "),
                                          Text(NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: "")
                                              .format(int.parse(itm['price'].toString())))
                                        ],
                                      ),
                                    ),
                                    Text(NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
                                        .format(itm['total']))
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    DottedLine(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Bill: "),
                          Text(NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0)
                              .format(int.parse(CashierVal.totalPrice.value.val.toString()))),
                        ],
                      ),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Payment: "),
                            Text(
                              NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0).format(
                                int.parse(CheckoutVal.totalPayment.value.val),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Change: "),
                            Text(
                              CheckoutVal.change.value.val.contains("-")
                                  ? "0"
                                  : NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0).format(
                                      int.parse(CheckoutVal.change.value.val),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Payment Type: "),
                            CheckoutVal.listPaymentWidget.value.val.isEmpty
                                ? Text("Cash")
                                : Text(
                                    CheckoutVal.listPaymentWidget.value.val
                                        .map((element) => element['method'])
                                        .toList()
                                        .join(','),
                                  )
                          ],
                        ),
                      ),
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: DottedLine(),
                    ),
                    (isPrintPreview ?? false)
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Payment: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Text(
                                    //   "Rp. ",
                                    //   style: TextStyle(
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Change: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DottedLine(),
                            ],
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              (isPrintPreview ?? false)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.print,
                                  color: Colors.blue,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Print",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            if (PrinterVal.device.value.val.isEmpty) {
                              SmartDialog.showToast("select printer first");
                              return;
                            }
                            StrukTiket().toPrint();
                          },
                        ),
                        MaterialButton(
                            child: Text("Ok"),
                            onPressed: () {
                              Get.back();
                            })
                      ],
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/intl.dart';
import 'package:propos/src/checkout/checkout_change.dart';
import 'package:propos/src/checkout/checkout_val.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/struk_tiket.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/vl.dart';
import 'package:get/get.dart';
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
                          Builder(
                            builder: (context) {
                              final company = {}.obs;
                              RouterApi.companySingle().getData().then((value) {
                                if (value.statusCode == 200) company.assignAll(jsonDecode(value.body));
                              });
                              return Obx(
                                () => Text(
                                  company['name'].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                          Builder(
                            builder: (context) {
                              final outlet = {}.obs;
                              RouterApi.outletSingle().getData().then((value) {
                                if (value.statusCode == 200) outlet.assignAll(jsonDecode(value.body));
                              });
                              return Obx(
                                () => Text(
                                  outlet['name'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                          Text(
                            "jl. hasanudin nomer 36 x denpasar bali",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
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
                        children: [Text("Receipt: "), Text(Val.billId.value.val.toString())],
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
                        children: [Text("Pos: "), Text("Pos")],
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
                                        children: [Text("${itm['qty']} x "), Text("Rp. " + itm['price'].toString())],
                                      ),
                                    ),
                                    Text(NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
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
                              .format(int.parse(CheckoutVal.totalBill.toString()))),
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
                              CheckoutChange.change.value.contains("-")
                                  ? "0"
                                  : NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0).format(
                                      int.parse(CheckoutChange.change.value),
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
                            CheckoutVal.listPaymentWidget.isEmpty
                                ? Text("Cash")
                                : Text(
                                    CheckoutVal.listPaymentWidget
                                        .map((element) => element['method'])
                                        .toList()
                                        .join(','),
                                  )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal: "),
                          Text("Rp. "),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text("Discount: "),
                    //       Text("Rp. "),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text("Tax: "),
                    //       Text("Rp. "),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total: "),
                          Text(
                            NumberFormat.currency(
                              locale: 'id_ID',
                              symbol: 'Rp',
                              decimalDigits: 0,
                            ).format(
                              Val.listorder.value.val
                                  .fold(0, (prev, element) => int.parse(prev.toString()) + element['total']),
                            ),
                          ),
                        ],
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
                                    Text(
                                      "Rp. ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                                      "Rp. ",
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
                            if (Vl.selectedPrinter.val.isEmpty) {
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

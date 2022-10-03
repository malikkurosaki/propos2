import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/src/checkout/checkout_action.dart';
import 'package:propos/src/checkout/checkout_calculator_pad.dart';
import 'package:propos/src/checkout/checkout_change.dart';
import 'package:propos/src/checkout/checkout_hot_pad.dart';
import 'package:propos/src/checkout/checkout_payment_method.dart';
import 'package:propos/src/checkout/checkout_val.dart';
import 'package:propos/utils/router_api.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class CheckoutMainView extends StatelessWidget {
  CheckoutMainView({Key? key}) : super(key: key);
  final controller = WidgetsToImageController();

  _onLoad() {
    RouterApi.paymentMethodList().getData().then(
      (res) {
        if (res.statusCode == 200) {
          CheckoutVal.listPaymentMethod.assignAll(jsonDecode(res.body));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();

    return ResponsiveBuilder(
      builder: (context, media) => Card(
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total Bill: "),
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: '',
                          decimalDigits: 0,
                        ).format(CashierVal.totalPrice.value.val),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total Payment: "),
                      Obx(
                        () => Text(
                          NumberFormat.currency(
                            locale: 'id_ID',
                            symbol: '',
                            decimalDigits: 0,
                          ).format(int.parse(CheckoutVal.totalPayment.value.val)),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CheckoutChange()
              ],
            ),
            Flexible(
              child: ListView(
                controller: ScrollController(),
                children: [
                  // WidgetsToImage(child: Column(
                  //   children: [
                  //     Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSblhDvjUhKQcZ_nJQo3vWTcJwggZHggasUZQRA7e64jw&s')
                  //   ],
                  // ), controller: controller),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // bill id
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Bill ID: ",
                                  ),
                                  Text(
                                    CheckoutVal.billId.value.val.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text("Bill No"),
                                  FutureBuilder<http.Response>(
                                      future: Rot.billNumberGet(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState != ConnectionState.done) {
                                          return Text("...");
                                        }
                                        final nom = int.tryParse(snapshot.data!.body).toString() == "null";
                                        if (nom) return Text("Error");

                                        final angkanya = (int.parse(snapshot.data!.body) + 1);
                                        const panjangnya = 10;
                                        final rangka =
                                            List.generate(panjangnya - angkanya.toString().length, (index) => "0");

                                        CheckoutVal.billNumber.value = angkanya;
                                        return Text(
                                          "${rangka.join('')}$angkanya",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                        );
                                      })
                                  // const Text(
                                  //   "00001",
                                  //   style: TextStyle(
                                  //     fontSize: 20,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // DottedLine(dashColor: Colors.grey),
                        DottedLine(dashColor: Colors.grey),
                        CheckoutPaymentMethod(),
                        DottedLine(dashColor: Colors.grey)
                      ],
                    ),
                  ),
                  CheckoutHotPad(
                    onChanged: (value) {
                      if (CheckoutVal.listPaymentWidget.value.val.isNotEmpty) {
                        CheckoutVal.listPaymentWidget.value.val
                            .where(
                              (p0) => (p0['selected'] as bool),
                            )
                            .first['value'] = value;
                        final total = CheckoutVal.listPaymentWidget.value.val.fold<int>(
                            0,
                            (previousValue, element) =>
                                int.parse(previousValue.toString()) + int.parse(element['value']));

                        CheckoutVal.change.value.val = (total - CashierVal.totalPrice.value.val).toString();
                        CheckoutVal.change.refresh();
                        CheckoutVal.listPaymentWidget.refresh();

                        CheckoutVal.totalPayment.value.val = total.toString();
                        CheckoutVal.totalPayment.refresh();
                      } else {
                        CheckoutVal.totalPayment.value.val = value;
                        CheckoutVal.totalPayment.refresh();
                        CheckoutChange.calculateChange();
                      }
                    },
                  ),
                  Visibility(
                    visible: media.isMobile,
                    child: CheckoutCalculatorPad(
                      onChanged: (value) {
                        if (CheckoutVal.listPaymentWidget.value.val.isNotEmpty) {
                          CheckoutVal.listPaymentWidget.value.val
                              .where(
                                (p0) => (p0['selected'] as bool),
                              )
                              .first['value'] = value;
                          final total = CheckoutVal.listPaymentWidget.value.val.fold<int>(
                              0,
                              (previousValue, element) =>
                                  int.parse(previousValue.toString()) + int.parse(element['value']));

                          CheckoutVal.change.value.val = (total - CashierVal.totalPrice.value.val).toString();
                          CheckoutVal.change.refresh();
                          CheckoutVal.listPaymentWidget.refresh();

                          CheckoutVal.totalPayment.value.val = total.toString();
                          CheckoutVal.totalPayment.refresh();
                        } else {
                          CheckoutVal.totalPayment.value.val = value;
                          CheckoutVal.totalPayment.refresh();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                final loading = false.obs;
                return Obx(
                  () => Column(
                    children: [
                      // MaterialButton(
                      //   onPressed: () async {
                      //     final bytes = await controller.capture();
                      //     final bytesImg = await resizeImage(Uint8List.view(bytes!.buffer), width: 500);

                      //     PrinterPrintNow.printGambar(bytesImg!.buffer.asUint8List());
                      //   },
                      //   child: Text("Tekan"),
                      // ),
                      Visibility(
                        visible: int.parse(CheckoutVal.totalPayment.value.val) >= CashierVal.totalPrice.value.val,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: loading.value
                              ? const Text("loading ...")
                              : CheckoutAction.payLoading.value
                                  ? LinearProgressIndicator()
                                  : MaterialButton(
                                      color: Colors.orange,
                                      onPressed: CheckoutAction.pay,
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            "Pay",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

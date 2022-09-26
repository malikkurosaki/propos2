import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propos/components/struk.dart';
import 'package:propos/pages.dart';
import 'package:propos/src/checkout/checkout_calculator_pad.dart';
import 'package:propos/src/checkout/checkout_change.dart';
import 'package:propos/src/checkout/checkout_drawer_view.dart';
import 'package:propos/src/checkout/checkout_main_view.dart';
import 'package:propos/src/checkout/checkout_val.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CheckoutVal.onload();
    return ResponsiveBuilder(
      builder: (context, media) {
        return SafeArea(
          child: Material(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButton(
                        onPressed: () {
                          if (Vl.employeeId.val.isNotEmpty) {
                            Get.toNamed(Pages.empHomePage().route);
                          } else {
                            Get.toNamed(Pages.homePage().route);
                          }
                        },
                      ),
                      Visibility(
                        visible: media.isMobile,
                        child: IconButton(
                            onPressed: () {
                              Get.dialog(
                                SimpleDialog(
                                  children: [
                                    Struk(media: media),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.feed_outlined)),
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(visible: !media.isMobile, child: CheckoutDrawerView()),
                      Expanded(
                        child: CheckoutMainView(),
                      ),
                      Visibility(
                        visible: !media.isMobile,
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

                              CheckoutChange.change.value = (total - CheckoutVal.totalBill).toString();
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
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget _calculator(SizingInformation media) =>
  // SizedBox(
  //       width: media.isMobile ? Get.width : 360,
  //       height: media.isMobile ? 360 : Get.height * 0.5,
  //       child: Obx(() => Card(
  //             elevation: 0,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Visibility(
  //                   visible: false,
  //                   child: Text(
  //                     CheckoutVal.toPay.value.val.toString(),
  //                   ),
  //                 ),
  //                 Flexible(
  //                   child: GridButton(
  //                     borderColor: Colors.transparent,
  //                     onPressed: (data) {
  //                       if (data == "del") {
  //                         final ini = CheckoutVal.toPay.value.val.split("");
  //                         ini.removeLast();
  //                         CheckoutVal.toPay.value.val = ini.join();
  //                         if (CheckoutVal.toPay.value.val == "") {
  //                           CheckoutVal.toPay.value.val = "0";
  //                         }
  //                         CheckoutVal.toPay.refresh();
  //                       } else if (data == "c") {
  //                         CheckoutVal.toPay.value.val = "0";
  //                         CheckoutVal.toPay.refresh();
  //                       } else if (data == "") {
  //                       } else {
  //                         final ini = CheckoutVal.toPay.value.val.split("");
  //                         if (ini.first == "0") {
  //                           ini.removeAt(0);
  //                         }
  //                         String jadinya = ini.join();
  //                         jadinya += data;
  //                         CheckoutVal.toPay.value.val = jadinya;
  //                         CheckoutVal.toPay.refresh();
  //                       }
  //                     },
  //                     items: [
  //                       [
  //                         _pad(text: "7"),
  //                         _pad(text: "8"),
  //                         _pad(text: "9"),
  //                       ],
  //                       [
  //                         _pad(text: "4"),
  //                         _pad(text: "5"),
  //                         _pad(text: "6"),
  //                       ],
  //                       [
  //                         _pad(text: "1"),
  //                         _pad(text: "2"),
  //                         _pad(text: "3"),
  //                       ],
  //                       [
  //                         _pad(text: "0"),
  //                         _pad(
  //                           text: "del",
  //                           child: const Icon(
  //                             Icons.backspace,
  //                             color: Colors.white,
  //                             size: 30,
  //                           ),
  //                         ),
  //                         _pad(text: "c"),
  //                       ],
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )),
  //     );

  // GridButtonItem _pad({String? text, Widget? child}) => GridButtonItem(
  //     title: text,
  //     child: child,
  //     color: Colors.cyan,
  //     shape: const BorderSide(color: Colors.white, width: 2),
  //     textStyle: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold));
}

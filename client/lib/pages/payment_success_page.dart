import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:propos/components/struk.dart';
import 'package:propos/pages.dart';
import 'package:propos/src/checkout/checkout_val.dart';
import 'package:propos/src/printers/printer_print_now.dart';
import 'package:propos/utils/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) {
        return Material(
          color: Colors.white,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Visibility(
                //   visible: !media.isMobile,
                //   child: SizedBox(
                //     width: 360,
                //     child: ListView(
                //       children: [Struk(media: media)],
                //     ),
                //   ),
                // ),
                Center(
                  child: SizedBox(
                    width: media.isMobile ? Get.width : 360,
                    child: ListView(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: media.isMobile ? Get.width / 3 : 360 / 3,
                              ),
                              Text("Selamat !", style: TextStyle(fontSize: 24)),
                              Text("Pembayaran anda berhasil"),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 32),
                                child: Column(
                                  children: [
                                    Text("Change"),
                                    Text(
                                      CheckoutVal.change.value.val.isEmpty
                                          ? "0"
                                          : NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
                                              .format(int.parse(CheckoutVal.change.value.val)),
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Visibility(
                                visible: media.isMobile,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: InkWell(
                                    onTap: () {
                                      PrinterPrintNow.load();
                                    },
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.print_outlined,
                                          size: 42,
                                          color: Colors.blue,
                                        ),
                                        Text("Print"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.whatsapp,
                                        size: 42,
                                        color: Colors.green,
                                      ),
                                      Text("Whatsapp"),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.email,
                                        size: 42,
                                        color: Colors.orange,
                                      ),
                                      Text("Email"),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            color: Colors.blue,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Selesai",
                                style: TextStyle(fontSize: 24, color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              Val.listorder.value.val = [];
                              Get.offAllNamed(Pages.homePage().route);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

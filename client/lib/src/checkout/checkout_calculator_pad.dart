import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:propos/src/checkout/checkout_val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CheckoutCalculatorPad extends StatelessWidget {
  const CheckoutCalculatorPad({Key? key, required this.onChanged}) : super(key: key);

  final Function(String value) onChanged;
  static final valueNya = "0".val("CheckoutCalculatorPad._hasilNya").obs;

  GridButtonItem _pad({String? text, Widget? child}) => GridButtonItem(
    borderRadius: 8,
      title: text,
      child: child,
      color: Colors.blue,
      shape: const BorderSide(color: Colors.white, width: 2),
      textStyle: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => SizedBox(
        width: media.isMobile ? Get.width : 360,
        height: media.isMobile ? 360 : Get.height * 0.5,
        child: Obx(
          () => Card(
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: false,
                  child: Text(
                    CheckoutVal.totalPayment.value.val.toString(),
                  ),
                ),
                Flexible(
                  child: GridButton(
                    borderColor: Colors.transparent,
                    onPressed: (data) {
                      if (data == "del") {
                        final ini = valueNya.value.val.split("");
                        ini.removeLast();
                        valueNya.value.val = ini.join();
                        if (valueNya.value.val == "") {
                          valueNya.value.val = "0";
                        }
                        valueNya.refresh();
                      } else if (data == "c") {
                        valueNya.value.val = "0";
                        valueNya.refresh();
                      } else if (data == "") {
                      } else {
                        final ini = valueNya.value.val.split("");
                        if (ini.first == "0") {
                          ini.removeAt(0);
                        }
                        String jadinya = ini.join();
                        jadinya += data;
                        valueNya.value.val = jadinya;
                        valueNya.refresh();
                      }

                      onChanged(valueNya.value.val);

                      // if (data == "del") {
                      //   final ini = CheckoutVal.toPay.value.val.split("");
                      //   ini.removeLast();
                      //   CheckoutVal.toPay.value.val = ini.join();
                      //   if (CheckoutVal.toPay.value.val == "") {
                      //     CheckoutVal.toPay.value.val = "0";
                      //   }
                      //   CheckoutVal.toPay.refresh();
                      // } else if (data == "c") {
                      //   CheckoutVal.toPay.value.val = "0";
                      //   CheckoutVal.toPay.refresh();
                      // } else if (data == "") {
                      // } else {
                      //   final ini = CheckoutVal.toPay.value.val.split("");
                      //   if (ini.first == "0") {
                      //     ini.removeAt(0);
                      //   }

                      //   String jadinya = ini.join();
                      //   jadinya += data;

                      //   // CheckoutVal.toPay.value.val = jadinya;
                      //   // CheckoutVal.toPay.refresh();
                      // }
                    },
                    items: [
                      [
                        _pad(text: "7"),
                        _pad(text: "8"),
                        _pad(text: "9"),
                      ],
                      [
                        _pad(text: "4"),
                        _pad(text: "5"),
                        _pad(text: "6"),
                      ],
                      [
                        _pad(text: "1"),
                        _pad(text: "2"),
                        _pad(text: "3"),
                      ],
                      [
                        _pad(text: "0"),
                        _pad(
                          text: "del",
                          child: const Icon(
                            Icons.backspace,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        _pad(text: "c"),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

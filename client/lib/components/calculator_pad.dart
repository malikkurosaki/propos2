import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CalculatorPad extends StatelessWidget {
  CalculatorPad({Key? key, required this.onChanged, this.color}) : super(key: key);
  final valNya = "0".obs;
  final Function(String value) onChanged;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => SizedBox(
        width: media.isMobile ? Get.width : 360,
        height: media.isMobile ? 360 : Get.height * 0.5,
        child: Obx(() => Card(
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: false,
                    child: Text(valNya.value
                        // CheckoutVal.toPay.value.val.toString(),
                        ),
                  ),
                  Flexible(
                    child: GridButton(
                      borderColor: Colors.transparent,
                      onPressed: (data) {
                        if (data == "del") {
                          final ini = valNya.value.split("");
                          // final ini = CheckoutVal.toPay.value.val.split("");
                          ini.removeLast();
                          valNya.value = ini.join();
                          if (valNya.isEmpty) {
                            valNya.value = "0";
                          }
                          // CheckoutVal.toPay.value.val = ini.join();
                          // if (CheckoutVal.toPay.value.val == "") {
                          //   CheckoutVal.toPay.value.val = "0";
                          // }
                          // CheckoutVal.toPay.refresh();
                        } else if (data == "c") {
                          valNya.value = "0";
                          // CheckoutVal.toPay.value.val = "0";
                          // CheckoutVal.toPay.refresh();
                        } else if (data == "") {
                        } else {
                          final ini = valNya.value.split("");
                          // final ini = CheckoutVal.toPay.value.val.split("");
                          if (ini.first == "0") {
                            ini.removeAt(0);
                          }
                          String jadinya = ini.join();
                          jadinya += data;
                          valNya.value = jadinya;
                          // CheckoutVal.toPay.value.val = jadinya;
                          // CheckoutVal.toPay.refresh();
                        }

                        onChanged(valNya.value);
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
            )),
      ),
    );
  }

  GridButtonItem _pad({String? text, Widget? child}) => GridButtonItem(
      title: text,
      child: child,
      color: color ?? Colors.cyan,
      shape: const BorderSide(color: Colors.white, width: 2),
      textStyle: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold));
}

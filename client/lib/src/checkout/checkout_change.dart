import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propos/src/checkout/checkout_payment_method.dart';
import 'package:propos/src/checkout/checkout_val.dart';

class CheckoutChange extends StatelessWidget {
  const CheckoutChange({Key? key}) : super(key: key);

  static final change = "0".obs;

  static calculateChange() {
    final nilai = (int.parse(CheckoutVal.totalPayment.value.val.toString()) - CheckoutVal.totalBill);
    CheckoutChange.change.value = nilai.isNegative ? "0" : nilai.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text("Change"),
          Obx(
            () => Text(
              NumberFormat.currency(
                locale: 'id_ID',
                symbol: 'Rp. ',
                decimalDigits: 0,
              ).format(int.parse(change.value)).contains("-")
                  ? "0"
                  : NumberFormat.currency(
                      locale: 'id_ID',
                      symbol: 'Rp. ',
                      decimalDigits: 0,
                    ).format(int.parse(change.value)),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

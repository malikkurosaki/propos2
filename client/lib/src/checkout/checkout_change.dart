import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/src/checkout/checkout_payment_method.dart';
import 'package:propos/src/checkout/checkout_val.dart';

class CheckoutChange extends StatelessWidget {
  const CheckoutChange({Key? key}) : super(key: key);

  // static final change = "0".obs;

  static calculateChange() {
    final nilai = (int.parse(CheckoutVal.totalPayment.value.val.toString()) - CashierVal.totalPrice.value.val);
    CheckoutVal.change.value.val = nilai.isNegative ? "0" : nilai.toString();
    CheckoutVal.change.refresh();
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
            () => Column(
              children: [
                Visibility(visible: false, child: Text(CashierVal.totalPrice.value.val.toString())),
                Text(
                  NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: '',
                    decimalDigits: 0,
                  ).format(int.parse(CheckoutVal.change.value.val)).contains("-")
                      ? "0"
                      : NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: '',
                          decimalDigits: 0,
                        ).format(int.parse(CheckoutVal.change.value.val)),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/src/checkout/checkout_val.dart';

class CheckoutHotPad extends StatelessWidget {
  CheckoutHotPad({Key? key, required this.onChanged}) : super(key: key);
  final Function(String value) onChanged;
  final listHotKey = ["1000", "5000", "10000", "20000", "50000", "100000", "uang pas"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          for (final itm in listHotKey)
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: MaterialButton(
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(8)
                // ),
                color: Colors.green,
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      itm == "uang pas"
                          ? "Uang Pas"
                          : NumberFormat.currency(
                              locale: 'id_ID',
                              symbol: '',
                              decimalDigits: 0,
                            ).format(int.parse(itm)),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  if (itm == "uang pas") {
                    // CheckoutVal.toPay.value.val = CheckoutVal.totalPrice.toString();
                    // CheckoutVal.toPay.refresh();
                    onChanged(CashierVal.totalPrice.value.val.toString());
                  } else {
                    onChanged(itm);
                    // CheckoutVal.toPay.value.val = itm;
                    // CheckoutVal.toPay.refresh();
                  }
                },
              ),
            )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DiscountSelect extends StatelessWidget {
  DiscountSelect({Key? key, required this.onChanged}) : super(key: key);
  final _listDiscount = [].obs;
  final Function(String discountId) onChanged;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(items: [
        ..._listDiscount.map(
          (element) => DropdownMenuItem(
            value: element['id'],
            child: Text(
              element['name'],
            ),
          ),
        )
      ], onChanged: (value) {}),
    );
  }
}

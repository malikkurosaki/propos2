import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:propos/src/product/product_val.dart';


// class _ProductStock {
//   final isInclude = false.obs;
//   TextEditingController stock = TextEditingController(text: "1");
//   TextEditingController minStock = TextEditingController(text: "0");
// }

class ProductCreateWithStock extends StatelessWidget {
  const ProductCreateWithStock({Key? key}) : super(key: key);
  // final dataStock = _ProductStock();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          CheckboxListTile(
            title: const Text("Include Stock"),
            value: ProductVal.dataStock.isInclude.value,
            onChanged: (value) {
              ProductVal.dataStock.isInclude.value = value!;
            },
          ),
          Visibility(
            visible: ProductVal.dataStock.isInclude.value,
            child: Column(
              children: [
                ListTile(
                  title: const Text("Initial Stock"),
                  subtitle: TextField(
                    controller: ProductVal.dataStock.stock,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text("Minimum Stock"),
                  subtitle: TextField(
                    controller: ProductVal.dataStock.minStock,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
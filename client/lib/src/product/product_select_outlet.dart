import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:propos/src/product/product_val.dart';

class ProductSelectOutlet extends StatelessWidget {
  const ProductSelectOutlet({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ProductVal.listoutlet.isEmpty
          ? Center(child: Text("Outlet Is Empty"))
          : DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: "Select Outlet",
              isDense: true,
              filled: true,
              border: OutlineInputBorder(borderSide: BorderSide.none)
            ),
              value: ProductVal.listoutlet.contains(ProductVal.selectedOutlet)
                  ? ProductVal.selectedOutlet
                  : ProductVal.listoutlet[0],
              items: [
                ...ProductVal.listoutlet.map(
                  (element) => DropdownMenuItem(
                    value: element,
                    child: Text(
                      element['name'].toString(),
                    ),
                  ),
                )
              ],
              onChanged: (value) {
                debugPrint(value.toString());
              },
            ),
    );
  }
}

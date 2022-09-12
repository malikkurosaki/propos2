import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:propos/utils/vl.dart';

class ProductSelectCompany extends StatelessWidget {
  const ProductSelectCompany({Key? key, required this.onChanged}) : super(key: key);
  final Function(Map value) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        labelText: "Select Company",
      ),
      value: ProductVal.selectedCompany.value.val,
      items: [
        ...ProductVal.listCompany.value.val.map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e['name'].toString(),
            ),
          ),
        )
      ],
      onChanged: (value) async {
        ProductVal.selectedCompany.value.val = (value as Map);
        ProductVal.selectedCompany.refresh();
        // await ProductVal.loadProductByCompanyId();
      },
    );
  }
}

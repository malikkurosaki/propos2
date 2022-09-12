import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:propos/src/product/product_select_company.dart';

class ProductListVie extends StatelessWidget {
  const ProductListVie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ProductSelectCompany(onChanged: ((value) {}))],
    );
  }
}

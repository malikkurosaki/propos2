import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:propos/src/product/product_create_with_custom_price.dart';
import 'package:propos/src/product/product_create_with_detail.dart';
import 'package:propos/src/product/product_val.dart';

class ProductCreatePrimary extends StatelessWidget {
  const ProductCreatePrimary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: ScrollController(),
      children: [
        Form(
          key: ProductVal.keyForm,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) => value!.isEmpty || value.length < 3
                      ? "Name is required and should be at least 3 characters long"
                      : null,
                  textInputAction: TextInputAction.next,
                  controller: ProductVal.primary.conName,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    labelStyle: TextStyle(backgroundColor: Colors.white),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              // _primaryPrice()
              const ProductCreateWithCustomPrice()
            ],
          ),
        ),
        const Divider(),
        // _primaryDetail()
        ProductCreateWithDetail()
      ],
    );
  }
}
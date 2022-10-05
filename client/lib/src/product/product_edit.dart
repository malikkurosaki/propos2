import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductEdit extends StatelessWidget {
  const ProductEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Ink(
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  BackButton(),
                  Text("Edit Product"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

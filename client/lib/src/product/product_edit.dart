import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/product/product_edit_outlet.dart';
import 'package:propos/src/product/product_edit_stock.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductEdit extends StatelessWidget {
  const ProductEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        addAutomaticKeepAlives: true,
        controller: ScrollController(),
        children: [
          Container(
            color: Colors.grey.shade100,
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                BackButton(),
                Text("Edit Product"),
              ],
            ),
          ),
          ...ProductVal.mapData.value.val.keys.map(
            (el) => !['name', 'price'].contains(el)
                ? Container()
                : ListTile(
                    title: TextFormField(
                      onChanged: (val) => ProductVal.mapData.value.val[el] = val,
                      controller: TextEditingController(text: ProductVal.mapData.value.val[el].toString()),
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        labelText: el.toString(),
                      ),
                    ),
                  ),
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: MaterialButton(
                    color: Colors.pink,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: MaterialButton(
                    color: Colors.orange,
                    onPressed: () async {
                      debugPrint(ProductVal.mapData.value.val.toString());

                      final res = await Rot.productUpdateDefaultPost(
                        body: {
                          "data": jsonEncode(
                            {
                              "id": ProductVal.mapData.value.val['id'],
                              "name": ProductVal.mapData.value.val['name'],
                              "price": int.parse(ProductVal.mapData.value.val['price'].toString())
                            },
                          )
                        },
                      );

                      if (res.statusCode == 201) {
                        SmartDialog.showToast("success");
                        ProductVal.reloadProduct.toggle();
                      } else {
                        SmartDialog.showToast(res.body);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          ProductEditOutlet(),
          ProductEditStock()
        ],
      ),
    );
  }
}

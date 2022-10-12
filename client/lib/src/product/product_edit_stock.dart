import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/product/product_val.dart';

class ProductEditStock extends StatelessWidget {
  const ProductEditStock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "Stock",
            style: TextStyle(fontSize: 24),
          ),
        ),
        Text(ProductVal.mapData.value.val.toString()),
        FutureBuilder<http.Response>(
          future: Rot.productListStockByProductIdByOutletIdGet(
              query: "productId=${ProductVal.mapData.value.val['productId']}&outletId=${ProductVal.mapData.value.val['outletId']}"),
          builder: (con, snap) {
            if (!snap.hasData) return LinearProgressIndicator();
            debugPrint(snap.data!.body);
            return Container();
          },
        )
      ],
    );
  }
}

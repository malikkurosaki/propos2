import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/router_api.dart';
import 'package:http/http.dart' as http;

class CashierCategoryView extends StatelessWidget {
  const CashierCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 4,
          child: FutureBuilder<http.Response>(
            future: Rot.cashierListCategoryGet(),
            builder: (con, snap) {
              if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();
              if (snap.data!.statusCode == 200) {
                (() async {
                  await 0.1.delay();
                  CashierVal.listCategory.assignAll(jsonDecode(snap.data!.body));
                })();
              }
              return SizedBox.shrink();
            },
          ),
        ),
        Obx(
          () => SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MaterialButton(
                    // color: Colors.cyan,
                    onPressed: () async {
                      // CashierVal.listProduct.value.val = CashierVal.tmpListProduct.value.val;
                      // CashierVal.listProduct.refresh();
                      final list = await Rot.cashierListProductGet();
                      if (list.statusCode == 200) {
                        CashierVal.listProduct.value.val = jsonDecode(list.body);
                        CashierVal.listProduct.refresh();
                      }
                    },
                    child: Text(
                      "All",
                      style: TextStyle(
                        color: Colors.cyan,
                      ),
                    ),
                  ),
                ),
                for (final cat in CashierVal.listCategory)
                  MaterialButton(
                    // color: Colors.cyan,
                    onPressed: () async {
                      final data = await RouterApi.productGetByCategory(query: "categoryId=${cat['id']}").getData();
                      if (data.statusCode == 200) {
                        final lsData = jsonDecode(data.body);

                        CashierVal.listProduct.value.val = lsData;
                        CashierVal.listProduct.refresh();
                      }
                    },
                    child: Text(
                      cat['name'].toString(),
                      style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

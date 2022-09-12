import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/vl.dart';

class CashierCategoryView extends StatelessWidget {
  const CashierCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final listCat = [].obs;
        RouterApi.categoryByCompanyId(query: "cusCompanyId=${Vl.companyId.val}").getData().then(
          (data) {
            if (data.statusCode == 200) {
              listCat.assignAll(jsonDecode(data.body));
            }
          },
        );
        return Obx(
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
                      CashierVal.listProduct.value.val = CashierVal.tmpListProduct.value.val;
                      CashierVal.listProduct.refresh();
                      // final list = await RouterApi.productList().getData();
                      // if (list.statusCode == 200) {
                      //   final lsData = jsonDecode(list.body);
                      //   _listProduct.value.val = lsData;
                      //   _listProduct.refresh();
                      // }
                    },
                    child: Text(
                      "All",
                      style: TextStyle(
                        color: Colors.cyan,
                      ),
                    ),
                  ),
                ),
                for (final cat in listCat)
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
        );
      },
    );
  }
}

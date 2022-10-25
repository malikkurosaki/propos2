import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
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
      () {
        List lsOutlet = [];
        List lsSelectedOutlet = [];
        List lsItem = [];

        try {
          lsOutlet.assignAll(List.from(ProductVal.mapCompanyOutletCategory['Outlet'] ?? []));
          lsSelectedOutlet.assignAll(
              List.from(ProductVal.mapBodyCreate.value.val['ProductOutlet']['createMany']['data'] ?? [])
                  .map((e) => e['outletId'] ?? []));
          lsItem.assignAll(lsOutlet.where((e) => lsSelectedOutlet.contains(e['id'])).toList());
        } catch (e) {
          debugPrint(e.toString());
        }
        return Column(
          children: [
            ListTile(
              title: CheckboxListTile(
                title: const Text(
                  "Include Stock",
                  textAlign: TextAlign.end,
                ),
                value: ProductVal.mapBodyCreate.value.val['isStock'] ?? false,
                onChanged: (value) {
                  final data = ProductVal.mapBodyCreate.value.val;
                  data['isStock'] = value;

                  final lsData = [];
                  if (value!) {
                    for (final itm in lsSelectedOutlet) {
                      final bd = {
                        "outletId": itm,
                        "isActive": true,
                        "minStock": 0,
                        "stock": 0,
                      };
                      lsData.add(bd);
                    }

                    data['ProductStock'] = {
                      "createMany": {"data": lsData}
                    };

                    // ['createMany']['data'] = lsData;
                  } else {
                    data.removeWhere((key, value) => key == 'ProductStock');
                  }

                  ProductVal.mapBodyCreate.value.val = data;
                  ProductVal.mapBodyCreate.refresh();

                  // ProductVal.dataStock.isInclude.value = value!;
                },
              ),
            ),
            Visibility(
              visible: ProductVal.mapBodyCreate.value.val['isStock'] ?? false,
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: ContainedTabBarView(
                      tabs: [
                        ...lsItem.map((e) => SizedBox(
                              width: 300,
                              child: ListTile(
                                title: Text(e['name'].toString()),
                              ),
                            ))
                      ],
                      views: [
                        ...lsItem.map(
                          (e) => SizedBox(
                            width: 300,
                            child: ListTile(
                              title: Text(e['name'].toString()),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // ListTile(
                  //   title: const Text("Initial Stock"),
                  //   subtitle: TextField(
                  //     controller: ProductVal.dataStock.stock,
                  //     decoration: const InputDecoration(
                  //       border: InputBorder.none,
                  //       filled: true,
                  //     ),
                  //   ),
                  // ),
                  // ListTile(
                  //   title: const Text("Minimum Stock"),
                  //   subtitle: TextField(
                  //     controller: ProductVal.dataStock.minStock,
                  //     decoration: const InputDecoration(
                  //       border: InputBorder.none,
                  //       filled: true,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

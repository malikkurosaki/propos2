import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propos/menus.dart';
import 'package:propos/src/cashier/cashier_category_view.dart';
import 'package:propos/src/cashier/cashier_search_box.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/config.dart';
import 'package:propos/utils/val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CashierMenuItem extends StatelessWidget {
  const CashierMenuItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // kerjakan disini
    return ResponsiveBuilder(
      builder: ((context, media) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _searchBox(),
            CashierSearchBox(),
            CashierCategoryView(),
            // _categoryView(),
            Flexible(
              child: Obx(
                () => CashierVal.listProduct.value.val.isEmpty
                    ? Center(
                        child: MaterialButton(
                          color: Colors.blue,
                          child: Text(
                            "Create Product",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Menus.visible.value.val = "Product";
                            Menus.visible.refresh();
                          },
                        ),
                      )
                    : GridView.extent(
                        maxCrossAxisExtent: media.isMobile ? Get.width / 2 : 200,
                        childAspectRatio: media.isMobile ? 0.8 : 0.8,
                        children: [
                          for (final prod in CashierVal.listProduct.value.val)
                            InkWell(
                              onTap: () {
                                // Val.listorder.value.val = [];
                                final data = List.from(Val.listorder.value.val);
                                final idx = data.indexWhere((element) => element['id'] == prod['id']);

                                if (idx == -1) {
                                  prod['qty'] = 1;
                                  prod['note'] = '';
                                  prod['total'] = prod['qty'] * prod['price'];
                                  data.add(prod);
                                  SmartDialog.showToast("Added to cart", animationTime: Duration(milliseconds: 500));
                                } else {
                                  data[idx]['qty']++;
                                }

                                Val.listorder.value.val = data;
                                Val.listorder.refresh();
                              },
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              "${Config.host}/product-image/${(prod["ProductImage"]?['name'] ?? "null").toString()}",
                                          fit: BoxFit.contain,
                                          width: media.isMobile ? Get.width / 2 : 200),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        prod['name'].toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                                              .format(prod['price'])),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ),
            Obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ...Val.listSavedOrder.value.val
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: MaterialButton(
                                color: Colors.cyan,
                                child: Container(
                                  width: 100,
                                  child: Text(
                                    e['name'].toString(),
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                      content: Text("Restore Order ${e['name']} ?"),
                                      actions: [
                                        MaterialButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                        MaterialButton(
                                          child: Text("Yes"),
                                          onPressed: () {
                                            Val.listorder.value.val = e['order'];
                                            Val.listorder.refresh();
                                            CashierVal.restoreOrderName.value.val = e['name'];
                                            Get.back();
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                          .toList()
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propos/menus.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/cashier/cashier_category_view.dart';
import 'package:propos/src/cashier/cashier_search_box.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/config.dart';
import 'package:propos/utils/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:short_uuids/short_uuids.dart';
import 'package:http/http.dart' as http;

/// # Cashier Menu Item
/// tampilah menu kotak kotak untuk milih menu
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
            SizedBox(
              height: 4,
              child: FutureBuilder<http.Response>(
                future: Rot.cashierListProductGet(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Center(
                      child: LinearProgressIndicator(),
                    );
                  final List lsData = jsonDecode(snapshot.data!.body);
                  Future.delayed(Duration(milliseconds: 100), () {
                    CashierVal.listProduct.value.val = lsData;
                    CashierVal.listProduct.refresh();
                  });

                  return lsData.isNotEmpty
                      ? SizedBox.shrink()
                      : MaterialButton(
                          onPressed: () {},
                          child: Text("Cleate product"),
                        );
                }),
              ),
            ),
            Flexible(
              child: Obx(
                () => GridView.extent(
                  maxCrossAxisExtent: media.isMobile ? Get.width / 2 : 150,
                  childAspectRatio: media.isMobile ? 0.8 : 0.8,
                  children: [
                    for (final prod in CashierVal.listProduct.value.val)
                      InkWell(
                        onTap: () => CashierVal.orderAdd(prod),
                       
                        child: Card(
                          borderOnForeground: true,
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${Config.host}/product-image/${(prod["ProductImage"]?['name'] ?? "null").toString()}",
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                      // width: media.isMobile ? Get.width / 2 : 200,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          prod['name'].toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                                              .format(
                                            prod['price'],
                                          ),
                                        ),
                                        () {
                                          try {
                                            return Ink(
                                              color:  prod['ProductStock'][0]['stock'] == 0
                                                  ? Colors.pink
                                                  : prod['ProductStock'][0]['stock'] <=
                                                      prod['ProductStock'][0]['minStock']
                                                  ? Colors.orange
                                                  : Colors.green,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "stk ",
                                                          style: TextStyle(color: Colors.white, fontSize: 12),
                                                        ),
                                                        Text(
                                                          prod['ProductStock'][0]['stock'].toString(),
                                                          style: TextStyle(fontSize: 12, color: Colors.white),
                                                        ),
                                                        Text("/", style: TextStyle(color: Colors.white, fontSize: 12),),
                                                        Text(
                                                          prod['ProductStock'][0]['minStock'].toString(),
                                                          style: TextStyle(fontSize: 12, color: Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                 
                                                ],
                                              ),
                                            );
                                          } catch (e) {
                                            return SizedBox.shrink();
                                          }
                                        }()
                                      ],
                                    ),
                                  ),
                                ],
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
                                color: Colors.orange,
                                child: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Icon(Icons.save, size: 16, color: Colors.white,),
                                      Text(
                                        e['name'].toString(),
                                        style: TextStyle(color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
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

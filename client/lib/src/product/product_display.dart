import 'package:cached_network_image/cached_network_image.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propos/src/product/product_create.dart';
import 'package:propos/src/product/product_search_box.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:propos/utils/conf.dart';
import 'package:propos/utils/img_def.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductDisplay extends StatelessWidget {
  const ProductDisplay({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: ((context, media) {
        return Scaffold(
          floatingActionButton: !media.isMobile
              ? null
              : FloatingActionButton(
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.dialog(
                      Dialog(
                        insetPadding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [const BackButton()],
                              ),
                            ),
                            Flexible(
                                child: ProductCreate()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          body: Card(
            child: Obx(
              () => ProductVal.listCompanyProduct.isEmpty
                  ? ImgDef.empty()
                  : ContainedTabBarView(
                      tabs: [
                        ...ProductVal.listCompanyProduct.map(
                          (e) => ListTile(
                            leading: Icon(Icons.business),
                            title: Text(
                              e['name'].toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                      views: [
                        ...ProductVal.listCompanyProduct.map(
                          (company) => (company['Product'] as List).isEmpty
                              ? Center(
                                  child: ImgDef.empty(width: 100, height: 100, fit: BoxFit.contain),
                                )
                              : Builder(
                                  builder: (context) {
                                    final lsProduct = company['Product'] as List;
                                    final isCheckAll = false.obs;
                                    return Column(
                                      children: [
                                        ProductSearchBox(),
                                        // searchBox(context, listSelected, isCheckAll, lsProduct, company, isShowChecked),
                                        Flexible(
                                          child: Obx(
                                            () => Column(
                                              children: [
                                                Flexible(
                                                  child: ListView(
                                                    controller: ScrollController(),
                                                    children: [
                                                      ...lsProduct.map(
                                                        (e) => ListTile(
                                                          onLongPress: () {
                                                            ProductVal.isShowChecked.toggle();
                                                          },
                                                          leading: !ProductVal.isShowChecked.value
                                                              ? null
                                                              : Checkbox(
                                                                  value: ProductVal.listSelected.contains(e['id']),
                                                                  onChanged: (value) {
                                                                    if (value!) {
                                                                      ProductVal.listSelected.add(e['id']);
                                                                    } else {
                                                                      ProductVal.listSelected.remove(e['id']);
                                                                    }

                                                                    isCheckAll.value =
                                                                        ProductVal.listSelected.length.isEqual(lsProduct.length);
                                                                  },
                                                                ),
                                                          title: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                      width: media.isMobile ? 50 : 70,
                                                                      child: Column(
                                                                        children: [
                                                                          CachedNetworkImage(
                                                                            imageUrl:
                                                                                "${Conf.host}/product-image/${(e['ProductImage']?['name'] ?? "null").toString()}",
                                                                            fit: BoxFit.cover,
                                                                          )
                                                                        ],
                                                                      )),
                                                                  Expanded(
                                                                    child: ListTile(
                                                                      trailing: PopupMenuButton(
                                                                        onSelected: (value) {
                                                                          switch (value) {
                                                                            case 'delete':
                                                                              Get.dialog(
                                                                                AlertDialog(
                                                                                  title: const Text(
                                                                                      "Are you sure you want to delete this item?"),
                                                                                  actions: [
                                                                                    MaterialButton(
                                                                                        child: const Text("Yes"),
                                                                                        onPressed: () {}),
                                                                                    MaterialButton(
                                                                                        child: const Text("No"),
                                                                                        onPressed: () {})
                                                                                  ],
                                                                                ),
                                                                              );
                                                                              break;
                                                                            default:
                                                                              debugPrint("deleteData");
                                                                          }
                                                                        },
                                                                        itemBuilder: (context) {
                                                                          return [
                                                                            const PopupMenuItem(
                                                                              value: "outlet",
                                                                              child: Text("Outlet"),
                                                                            ),
                                                                            const PopupMenuItem(
                                                                              value: "edit",
                                                                              child: Text("Edit"),
                                                                            ),
                                                                            const PopupMenuItem(
                                                                              value: "available",
                                                                              child: Text("available"),
                                                                            ),
                                                                            const PopupMenuItem(
                                                                              value: "delete",
                                                                              child: Text("Delete"),
                                                                            ),
                                                                          ];
                                                                        },
                                                                      ),
                                                                      title: Text(e['name'].toString()),

                                                                      //  Row(
                                                                      //   children: [
                                                                      //     Visibility(
                                                                      //         visible: !media.isMobile,
                                                                      //         child: const SizedBox(
                                                                      //             width: 100, child:
                                                                      //             Text("Name"))),
                                                                      //     Expanded(child: Text(e['name'].toString())),
                                                                      //   ],
                                                                      // ),
                                                                      subtitle: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(NumberFormat.currency(
                                                                                  locale: 'id_ID',
                                                                                  symbol: 'Rp',
                                                                                  decimalDigits: 0)
                                                                              .format(e['price'])),
                                                                          Text(e['description'] ?? ""),
                                                                          Ink(
                                                                            child: Text((() {
                                                                              try {
                                                                                return e['Category']['name'];
                                                                              } catch (e) {
                                                                                return "";
                                                                              }
                                                                            })()),
                                                                          ),
                                                                          
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Wrap(
                                                                  alignment: WrapAlignment.start,
                                                                  crossAxisAlignment: WrapCrossAlignment.start,
                                                                  children: [
                                                                    for (final itm in e['ProductOutlet'])
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(4.0),
                                                                        child: Chip(
                                                                            backgroundColor: Colors.cyan,
                                                                            label: Text(
                                                                              itm['Outlet']['name'].toString(),
                                                                              style: const TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                            )),
                                                                      )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      }),
    );
  }
}

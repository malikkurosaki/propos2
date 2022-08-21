import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:propos/pages.dart';
import 'package:propos/utils/conf.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Cashier extends StatelessWidget {
  Cashier({Key? key}) : super(key: key);
  final _conSearch = TextEditingController();
  final _restoreOrderName = "".val('Cashier.restoreOrderName').obs;
  // final _listProduct = List.from(ValDef.productList.value.val).val('Cashier.listProduct').obs;
  final _listCategory = [].obs;
  final _listProduct = [].obs;

  // _loadCategory() async {
  //   final list = await RouterApi.listCategory().getData();
  //   if (list.statusCode == 200) _listCategory.assignAll(jsonDecode(list.body));
  // }

  _loadProduct() async {
    final list = await RouterApi.listProduct().getData();
    if (list.statusCode == 200) _listProduct.assignAll(jsonDecode(list.body));
  }

  _onLoad() async {
    // _loadCategory();
    _loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ResponsiveBuilder(
      builder: (context, media) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Visibility(
                      visible: !media.isMobile,
                      child: _menu(media),
                    ),
                  ),
                  _totalan(media)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _headerTotalan(SizingInformation media, RxList lsTampungan) => Ink(
        color: Colors.grey.shade200,
        child: ListTile(
          leading: Tooltip(
            message: "Select Sekaligus",
            child: Checkbox(
              value: lsTampungan.isNotEmpty && lsTampungan.length.isEqual(Val.listorder.value.val.length),
              onChanged: lsTampungan.isEmpty? null: (value) {
                if (value!) {
                  lsTampungan.assignAll(Val.listorder.value.val.map((e) => e['id']));
                } else {
                  lsTampungan.clear();
                }
                Get.back();
              },
            ),
          ),
          title: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Tooltip(
                message: "menyimpan order",
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _restoreOrderName.value.val.isEmpty
                      ? Badge(
                          badgeColor: Colors.grey.shade100,
                          badgeContent: Text(
                            Val.listSavedOrder.value.val.length.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          child: IconButton(
                              onPressed: Val.listorder.value.val.isEmpty? null: () {
                                _savedOrderDialog();
                              },
                              icon: Icon(
                                Icons.save,
                                color: Val.listorder.value.val.isEmpty? Colors.grey: Colors.cyan,
                              )),
                        )
                      : MaterialButton(
                          child: Text(
                            _restoreOrderName.value.val.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _savedOrderDialog();
                          },
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  tooltip: "menghapus multiple",
                  onPressed: lsTampungan.isEmpty? null: () {
                    Get.dialog(AlertDialog(
                      title: Text("Clean Order"),
                      content: Text("Are you sure to delete order?"),
                      actions: [
                        MaterialButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        MaterialButton(
                          child: Text("Delete"),
                          onPressed: () {
                            Val.listorder.value.val.removeWhere((element) => lsTampungan.contains(element['id']));
                            Val.listorder.refresh();
                            Get.back();
                          },
                        ),
                      ],
                    ));
                  },
                  icon: Icon(
                    Icons.delete_sweep_sharp,
                    color: lsTampungan.isEmpty? Colors.grey: Colors.pink,
                  ),
                ),
              ),
              Visibility(
                visible: media.isMobile,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Get.dialog(Material(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              BackButton(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Select Item"),
                              )
                            ]),
                            Flexible(child: _menu(media)),
                          ],
                        ),
                      ));
                    },
                    icon: Icon(
                      Icons.add_circle_outlined,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget _totalan(SizingInformation media) => Builder(builder: (context) {
        final lsTampungan = [].obs;
        return Obx(
          () => SizedBox(
            width: media.isMobile ? Get.width : 500,
            child: Card(
              child: Column(
                children: [
                  _headerTotalan(media, lsTampungan),
                  // mulai list item
                  Flexible(
                    child: ListView(
                      controller: ScrollController(),
                      children: [
                        for (final itm in Val.listorder.value.val)
                          ListTile(
                            leading: Checkbox(
                              value: lsTampungan.contains(itm['id']),
                              onChanged: (value) {
                                if (value!) {
                                  lsTampungan.add(itm['id']);
                                } else {
                                  lsTampungan.remove(itm['id']);
                                }
                                Get.back();
                              },
                            ),
                            title: ListTile(
                              onLongPress: () {
                                Get.dialog(
                                  AlertDialog(
                                    title: Text('Delete'),
                                    content: Text('Are you sure?'),
                                    actions: [
                                      MaterialButton(
                                        child: Text('Cancel'),
                                        onPressed: () => Get.back(),
                                      ),
                                      MaterialButton(
                                        child: Text('Delete'),
                                        onPressed: () {
                                          final data = List.from(Val.listorder.value.val);
                                          final idx = data.indexWhere((element) => element['id'] == itm['id']);
                                          data.removeAt(idx);
                                          Val.listorder.value.val = data;
                                          Val.listorder.refresh();
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              onTap: () {
                                final _conName = TextEditingController();
                                // dialog add note
                                Get.dialog(
                                  AlertDialog(
                                    title: Text("Note"),
                                    content: TextField(
                                      controller: _conName,
                                      decoration: InputDecoration(
                                        hintText: 'Note',
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      MaterialButton(
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                      MaterialButton(
                                        child: Text("Ok"),
                                        onPressed: () {
                                          final data = List.from(Val.listorder.value.val);
                                          final idx = data.indexWhere((element) => element['id'] == itm['id']);
                                          data[idx]['note'] = _conName.text;
                                          Val.listorder.value.val = data;
                                          Val.listorder.refresh();
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              leading: InkWell(
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.pink,
                                  size: 36,
                                ),
                                onTap: () {
                                  final data = List.from(Val.listorder.value.val);
                                  final idx = data.indexWhere((element) => element['id'] == itm['id']);
                                  if (idx != -1) {
                                    if (data[idx]['qty'] > 1) {
                                      data[idx]['qty']--;
                                      data[idx]['total'] = data[idx]['qty'] * data[idx]['price'];
                                    } else {
                                      Get.dialog(
                                        AlertDialog(
                                          title: Text("Warning"),
                                          content: Text("Are you sure want to delete this item?"),
                                          actions: [
                                            MaterialButton(
                                              child: Text("Yes"),
                                              onPressed: () {
                                                data.removeAt(idx);
                                                Val.listorder.value.val = data;
                                                Val.listorder.refresh();
                                                Get.back();
                                              },
                                            ),
                                            MaterialButton(
                                              child: Text("No"),
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }
                                  Val.listorder.value.val = data;
                                  Val.listorder.refresh();
                                },
                              ),
                              title: Text(itm['name']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(itm['qty'].toString()),
                                            Text("x"),
                                            Text(NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
                                                .format(itm['price'])),
                                          ],
                                        ),
                                      ),
                                      Text(NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
                                          .format(itm['total'])),
                                    ],
                                  ),
                                  Text(itm['note']),
                                ],
                              ),
                              trailing: InkWell(
                                  child: Icon(
                                    Icons.add_circle,
                                    color: Colors.cyan,
                                    size: 36,
                                  ),
                                  onTap: () {
                                    final data = List.from(Val.listorder.value.val);
                                    final idx = data.indexWhere((element) => element['id'] == itm['id']);
                                    if (idx != -1) {
                                      data[idx]['qty']++;
                                      itm['total'] = itm['qty'] * itm['price'];
                                    } else {
                                      itm['qty'] = 1;
                                      itm['note'] = '';
                                      itm['total'] = itm['qty'] * itm['price'];
                                      data.add(itm);
                                    }
                                    Val.listorder.value.val = data;
                                    Val.listorder.refresh();
                                  }),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade100,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Total: ${NumberFormat.currency(
                              locale: 'id_ID',
                              symbol: 'Rp',
                              decimalDigits: 0,
                            ).format(
                              Val.listorder.value.val.fold(
                                  0, (prev, element) => int.parse(prev.toString()) + element['qty'] * element['price']),
                            )}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MaterialButton(
                          color: Colors.cyan,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              "Checkout",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            if (Val.listorder.value.val.isNotEmpty) {
                              Get.toNamed(Pages.checkoutPage().route);
                            } else {
                              Get.dialog(
                                AlertDialog(
                                  title: Text("Warning"),
                                  content: Text("Please add item to cart"),
                                  actions: [
                                    MaterialButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });

  Widget _menu(SizingInformation media) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  onChanged: (value) async {
                    final data = await RouterApi.productSearch(query: "search=$value").getData();
                    if (data.statusCode == 200) _listProduct.assignAll(jsonDecode(data.body));
                  },
                  controller: _conSearch,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(builder: (context) {
                final listCat = [].obs;
                RouterApi.categoryByCompanyId(query: "cusCompanyId=${Vl.companyId.val}").getData().then((data) {
                  if (data.statusCode == 200) {
                    listCat.assignAll(jsonDecode(data.body));
                  }
                });
                return Obx(() => SingleChildScrollView(
                      controller: ScrollController(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: MaterialButton(
                              color: Colors.green,
                              onPressed: () async {
                                final list = await RouterApi.productList().getData();
                                if (list.statusCode == 200) _listProduct.assignAll(jsonDecode(list.body));
                              },
                              child: Text(
                                "All",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          for (final cat in listCat)
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: MaterialButton(
                                color: Colors.green,
                                onPressed: () async {
                                  final data =
                                      await RouterApi.productGetByCategory(query: "categoryId=${cat['id']}").getData();
                                  if (data.statusCode == 200) _listProduct.assignAll(jsonDecode(data.body));
                                },
                                child: Text(
                                  cat['name'].toString(),
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ));
              }),
            ),
            Flexible(
              child: Obx(
                () => GridView.extent(
                  maxCrossAxisExtent: media.isMobile ? Get.width / 2 : 200,
                  childAspectRatio: media.isMobile ? 1 : 0.8,
                  children: [
                    for (final prod in _listProduct)
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
                          } else {
                            data[idx]['qty']++;
                          }

                          Val.listorder.value.val = data;
                          Val.listorder.refresh();

                          SmartDialog.showToast("Added to cart", animationTime: Duration(milliseconds: 500));

                          // if (media.isMobile) Get.back();
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                    imageUrl:
                                        "${Conf.host}/product-image/${(prod["ProductImage"]?['name'] ?? "null").toString()}",
                                    fit: BoxFit.cover,
                                    width: media.isMobile ? Get.width / 2 : 200),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  prod['name'].toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
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
          ],
        ),
      );

  void _savedOrderDialog() {
    final conName = TextEditingController(text: _restoreOrderName.value.val.isEmpty ? '' : _restoreOrderName.value.val);
    if (Val.listorder.value.val.isEmpty) {
      SmartDialog.showToast("Cart is empty", animationTime: Duration(milliseconds: 500));
      return;
    }
    Get.dialog(
      SimpleDialog(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Save Order",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              controller: conName,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                for (final prod in Val.listSavedOrder.value.val)
                  TextButton(
                    onPressed: () {
                      conName.text = prod['name'];
                    },
                    child: Text(prod['name'].toString()),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Get.back();
                  },
                ),
                MaterialButton(
                  child: Text('Save'),
                  onPressed: () {
                    final data = List.from(Val.listSavedOrder.value.val);
                    final idx = data.indexWhere((element) => element['name'] == conName.text);
                    if (idx == -1) {
                      data.add({
                        'name': conName.text,
                        'order': Val.listorder.value.val,
                      });
                    } else {
                      data[idx]['order'] = Val.listorder.value.val;
                    }

                    if (conName.text != _restoreOrderName.value.val) {
                      _restoreOrderName.value.val = "";
                      _restoreOrderName.refresh();
                    }

                    Val.listSavedOrder.value.val = data;
                    Val.listSavedOrder.refresh();

                    Get.back();
                  },
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Restore Order",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  for (final prod in Val.listSavedOrder.value.val)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          Val.listorder.value.val = prod['order'];
                          Val.listorder.refresh();
                          _restoreOrderName.value.val = prod['name'];
                          Get.back();
                        },
                        child: Chip(
                          backgroundColor: Colors.cyan,
                          label: Text(
                            prod['name'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onDeleted: () {
                            final data = List.from(Val.listSavedOrder.value.val);
                            final idx = data.indexWhere((element) => element['name'] == prod['name']);
                            if (idx != -1) {
                              data.removeAt(idx);
                            }
                            Val.listSavedOrder.value.val = data;
                            Val.listSavedOrder.refresh();
                          },
                          deleteIconColor: Colors.white,
                        ),
                      ),
                    )
                  // TextButton(
                  //   onPressed: () {
                  //     Val.listorder.value.val = prod['order'];
                  //     Val.listorder.refresh();
                  //     _restoreOrderName.value.val = prod['name'];
                  //     Get.back();
                  //   },
                  //   child: Text(prod['name'].toString()),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

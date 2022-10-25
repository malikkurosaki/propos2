import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/product/product_val.dart';

// class _ProductPrimary {
//   final conName = TextEditingController();
//   final conPrice = TextEditingController();
// }

class ProductCreateWithCustomPrice extends StatelessWidget {
  const ProductCreateWithCustomPrice({Key? key}) : super(key: key);

  // ProdustCreateWithCustomPrice({Key? key,
  //   required this.isCustomPrice,
  //   required this.dataCustomPrice,
  //   required this.listCustomPriwce
  // }) : super(key: key);
  // final RxBool isCustomPrice;

  // final primary = _ProductPrimary();
  // final RxList<dynamic>  listCustomPriwce;
  // final Map dataCustomPrice ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(ProductVal.isCustomPrice.value ? 16 : 0),
      padding: EdgeInsets.all(ProductVal.isCustomPrice.value ? 8 : 0),
      // decoration: BoxDecoration(border: !ProductVal.isCustomPrice.value ? null : Border.all()),
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextFormField(
          //     textInputAction: TextInputAction.next,
          //     keyboardType: TextInputType.number,
          //     controller: ProductVal.primary.conPrice,
          //     validator: (value) {
          //       return value!.isEmpty || int.tryParse(value) == null ? "price is required ar number only" : null;
          //     },
          //     onChanged: (value) {
          //       if (int.tryParse(value).toString() == "null") {
          //         ProductVal.primary.conPrice.clear();
          //       }
          //     },
          //     decoration: const InputDecoration(
          //       labelText: "Product Price",
          //       // labelStyle: TextStyle(backgroundColor: Colors.white),
          //       filled: true,
          //       border: InputBorder.none,
          //     ),
          //   ),
          // ),
          ListTile(
            title: Obx(
              () => TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: (ProductVal.mapBodyCreate.value.val['price'] ?? "").toString()),
                // controller: ProductVal.primary.conPrice,
                // validator: (value) {
                //   return value!.isEmpty || int.tryParse(value) == null ? "price is required ar number only" : null;
                // },
                onChanged: (value) {
                  if (int.tryParse(value).toString() == "null") {
                    final data = {...ProductVal.mapBodyCreate.value.val};
                    data['price'] = 0;
                    ProductVal.mapBodyCreate.value.val = data;
                    ProductVal.mapBodyCreate.refresh();
                    SmartDialog.showToast("Number Only Please");
                    return;
                  } else {
                    final data = {...ProductVal.mapBodyCreate.value.val};
                    data['price'] = int.parse(value);
                    ProductVal.mapBodyCreate.value.val = data;
                  }
                },
                decoration: const InputDecoration(
                  labelText: "Product Price",
                  // labelStyle: TextStyle(backgroundColor: Colors.white),
                  filled: true,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Obx(
            () {
              return ListTile(
                title: CheckboxListTile(
                  // value: ProductVal.isCustomPrice.value,
                  value: ProductVal.mapBodyCreate.value.val['isCustomPrice'] ?? false,
                  title: Text(
                    "Use Custom Price",
                    textAlign: TextAlign.end,
                  ),
                  onChanged: (value) {
                    final data = {...ProductVal.mapBodyCreate.value.val};

                    data['isCustomPrice'] = value;

                    if (value!) {
                      for (final itm in (data["ProductCustomPrice"]['createMany']['data'] as List)) {
                        itm['isActive'] = true;
                      }
                    } else {
                      for (final itm in (data["ProductCustomPrice"]['createMany']['data'] as List)) {
                        itm['isActive'] = false;
                      }
                    }

                    ProductVal.mapBodyCreate.value.val = data;
                    ProductVal.mapBodyCreate.refresh();

                    debugPrint(ProductVal.mapBodyCreate.value.val.toString());
                  },
                  subtitle: Text(
                    "Memungkinkan Anda Menggunakan Harga Berbeda Seperti Untuk Gojek , Grab Atau Lainnya",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 4,
            child: FutureBuilder<http.Response>(
              future: Rot.customPriceListGet(),
              builder: (context, snap) {
                if (!snap.hasData) return LinearProgressIndicator();
                if (snap.data!.statusCode == 200) {
                  () async {
                    await 0.1.delay();
                    final List result = jsonDecode(snap.data!.body);

                    if (ProductVal.mapBodyCreate.value.val["ProductCustomPrice"] == null) {
                      final data = ProductVal.mapBodyCreate.value.val;
                      data["ProductCustomPrice"] = {
                        "createMany": {
                          "data": [
                            ...result.map(
                              (e) => {
                                "price": 0,
                                "customPriceId": e['id'],
                              },
                            )
                          ]
                        }
                      };
                    }
                    ProductVal.listCustomPriwce.assignAll(result);
                    // ProductVal.listCustomPriwce.refresh();
                  }();
                }
                return Container();
              },
            ),
          ),
          Obx(() {
            return Visibility(
              // visible: ProductVal.isCustomPrice.value,
              visible: ProductVal.mapBodyCreate.value.val['isCustomPrice'] ?? false,
              child: Column(
                children: [
                  ...ProductVal.listCustomPriwce.map(
                    (e) => ListTile(
                      title: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (int.tryParse(value) == null) {
                            final data = ProductVal.mapBodyCreate.value.val;
                            final List listPrice = data["ProductCustomPrice"]['createMany']['data'];
                            for (final itm in listPrice) {
                              if (itm['customPriceId'] == e['id']) {
                                itm['price'] = 0;
                              }
                            }

                            data["ProductCustomPrice"]['createMany']['data'] = listPrice;
                            ProductVal.mapBodyCreate.value.val = data;
                            ProductVal.mapBodyCreate.refresh();

                            SmartDialog.showToast("Number Only Please");
                            return;
                          }
                          final data = ProductVal.mapBodyCreate.value.val;
                          final List listPrice = data["ProductCustomPrice"]['createMany']['data'];
                          for (final itm in listPrice) {
                            if (itm['customPriceId'] == e['id']) {
                              itm['price'] = int.parse(value);
                            }
                          }

                          data["ProductCustomPrice"]['createMany']['data'] = listPrice;
                          ProductVal.mapBodyCreate.value.val = data;

                          // final data = ProductVal.mapBodyCreate.value.val;
                          // data["ProductCustomPrice"] = {
                          //   "createMany": {
                          //     "data": [
                          //       {
                          //         "price": int.parse(value),
                          //         "customPriceId": e['id'],
                          //       }
                          //     ]
                          //   }
                          // };
                          // ProductVal.mapBodyCreate.value.val = data;

                          // if (int.tryParse(value) == null) {
                          //   (ProductVal.dataCustomPrice[e['id']]['con'] as TextEditingController).clear();
                          // }
                        },

                        // menditeksi jika nilai sudah ada , jika enggak akan dikebalikan ke 0
                        controller: TextEditingController(
                            text: ((ProductVal.mapBodyCreate.value.val["ProductCustomPrice"]['createMany']['data']
                                            as List)
                                        .where((element) => element['customPriceId'] == e['id'])
                                        .toList()[0]['price'] ??
                                    0)
                                .toString()),
                        decoration: InputDecoration(
                          filled: true,
                          border: InputBorder.none,
                          prefixText: "Rp ",
                          labelText: e['name'].toString(),
                        ),
                      ),
                      // subtitle: TextField(
                      //   keyboardType: TextInputType.number,
                      //   onChanged: (value) {
                      //     if (int.tryParse(value) == null) {
                      //       (ProductVal.dataCustomPrice[e['id']]['con'] as TextEditingController).clear();
                      //     }
                      //   },
                      //   controller: (ProductVal.dataCustomPrice[e['id']]['con'] as TextEditingController),
                      //   decoration:
                      //       const InputDecoration(filled: true, border: InputBorder.none, prefixText: "Rp "),
                      // ),
                    ),
                  )
                ],
              ),
            );
          }),

          // Visibility(
          //   visible: _isCustomPrice.value,
          //   child: FutureBuilder<http.Response>(
          //     future: RouterApi.customPriceGetDataSelect().getData(),
          //     builder: (c, s) {
          //       if (s.connectionState != ConnectionState.done) {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //       final List listData = jsonDecode(s.data!.body);
          //       return Column(
          //         children: [
          //           ...listData.map(
          //             (e) => Builder(
          //               builder: (context) {

          //                 return ListTile(
          //                   title: Text(e['name'].toString()),
          //                   subtitle: const TextField(
          //                     decoration: InputDecoration(filled: true, border: InputBorder.none, prefixText: "Rp "),
          //                   ),
          //                 );
          //               }
          //             ),
          //           )
          //         ],
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:propos/utils/notif.dart';
import 'package:propos/utils/router_api.dart';

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
    return Obx(
      () => Container(
        margin: EdgeInsets.all(ProductVal.isCustomPrice.value ? 16 : 0),
        padding: EdgeInsets.all(ProductVal.isCustomPrice.value ? 8 : 0),
        decoration: BoxDecoration(border: !ProductVal.isCustomPrice.value ? null : Border.all()),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: ProductVal.primary.conPrice,
                validator: (value) {
                  return value!.isEmpty || int.tryParse(value) == null ? "price is required ar number only" : null;
                },
                onChanged: (value) {
                  if (int.tryParse(value).toString() == "null") {
                    ProductVal.primary.conPrice.clear();
                  }
                },
                decoration: const InputDecoration(
                  labelText: "Product Price",
                  labelStyle: TextStyle(backgroundColor: Colors.white),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Use Custom Price"),
                    ),
                    Checkbox(
                      value: ProductVal.isCustomPrice.value,
                      onChanged: (value) {
                        if (ProductVal.primary.conPrice.text.isEmpty) {
                          Notif.error(message: "isi harga terlebih dahulu");
                          return;
                        }

                        ProductVal.isCustomPrice.toggle();
                      },
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Memungkinkan Anda Menggunakan Harga Berbeda Seperti Untuk Gojek , Grab Atau Lainnya",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
            Builder(
              builder: (c) {
                RouterApi.customPriceGetDataSelect().getData().then(
                  (res) {
                    if (res.statusCode == 200) {
                      ProductVal.listCustomPriwce.assignAll(jsonDecode(res.body));
                      ProductVal.listCustomPriwce.refresh();
                    }
                  },
                );
                return Visibility(
                  visible: ProductVal.isCustomPrice.value,
                  child: Column(
                    children: [
                      ...ProductVal.listCustomPriwce.map(
                        (e) => Builder(
                          builder: (context) {
                            ProductVal.dataCustomPrice[e['id']] = {
                              "id": e['id'],
                              "name": e['name'].toString(),
                              "con": TextEditingController()
                            };
                            return ListTile(
                              title: Text(e['name'].toString()),
                              subtitle: TextField(
                                onChanged: (value) {
                                  if (int.tryParse(value) == null) {
                                    (ProductVal.dataCustomPrice[e['id']]['con'] as TextEditingController).clear();
                                  }
                                },
                                controller: (ProductVal.dataCustomPrice[e['id']]['con'] as TextEditingController),
                                decoration: const InputDecoration(filled: true, border: InputBorder.none, prefixText: "Rp "),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            )
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
      ),
    );
  }
}
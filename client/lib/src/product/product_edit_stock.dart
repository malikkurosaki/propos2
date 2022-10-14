import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:propos/utils/vl.dart';

class ProductEditStock extends StatelessWidget {
  ProductEditStock({Key? key}) : super(key: key);
  final productStock = {}.obs;
  final listOutlet = [].obs;
  final reload = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "Stock By Outlet",
            style: TextStyle(fontSize: 24),
          ),
        ),
        SizedBox(
          height: 4,
          child: Obx(() {
            reload.value;
            return FutureBuilder<http.Response>(
              future:
                  Rot.globalOutletListByCompanyIdGet(query: "companyId=${ProductVal.mapData.value.val['companyId']}"),
              builder: (con, snap) {
                if (!snap.hasData) return LinearProgressIndicator();
                if (snap.data!.statusCode == 200) {
                  () async {
                    await 0.1.delay();
                    listOutlet.assignAll(jsonDecode(snap.data!.body));
                  }();
                }
                return Container();
              },
            );
          }),
        ),
        SizedBox(
          height: 4,
          child: Obx(
            () {
              reload.value;
              return FutureBuilder<http.Response>(
                future: Rot.productListStockByProductIdByOutletIdGet(
                    query: "productId=${ProductVal.mapData.value.val['id']}"),
                builder: (con, snap) {
                  debugPrint("inta data");

                  if (!snap.hasData) return LinearProgressIndicator();
                  () async {
                    if (snap.data!.statusCode == 200) {
                      await 0.1.delay();
                      productStock.assignAll(jsonDecode(snap.data!.body));
                    }
                  }();
                  return Container();
                },
              );
            },
          ),
        ),
        Obx(
          () => productStock['ProductStock'] == null
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(productStock['ProductStock'].toString()),
                    ...listOutlet.map(
                      (element) => Builder(
                        builder: (context) {
                          final ada =
                              (productStock['ProductStock'] as List).map((e) => e['outletId']).contains(element['id']);
                          final index =
                              (productStock['ProductStock'] as List).indexWhere((e) => e['outletId'] == element['id']);

                          return Obx(
                            () {
                              productStock.value;
                              return Column(
                                children: [
                                  ListTile(
                                    title: CheckboxListTile(
                                      title: Text(element['name'].toString()),
                                      value: ada,
                                      onChanged: (val) async {
                                         SmartDialog.showLoading();
                                        Future.delayed(Duration(seconds: 1), () => SmartDialog.dismiss());
                                        if (ada) {
                                          final body = productStock['ProductStock'][index];
                                          body['isActive'] = val;
                                          debugPrint(body.toString());
                                          final res = await Rot.productUpdateAvailableStockPost(
                                              body: {"data": jsonEncode(body)});
                                          if (res.statusCode == 201) {
                                            SmartDialog.showToast("success");
                                            reload.toggle();
                                          } else {
                                            SmartDialog.showToast(res.body);
                                          }
                                        } else {
                                          final body = {
                                            "stock": 0,
                                            "isActive": true,
                                            "minStock": 0,
                                            "outletId": element['id'],
                                            "productId": ProductVal.mapData.value.val['id']
                                          };

                                          final res = await Rot.productUpdateAvailableStockPost(
                                              body: {"data": jsonEncode(body)});
                                          if (res.statusCode == 201) {
                                            SmartDialog.showToast("success");
                                            reload.toggle();
                                          } else {
                                            SmartDialog.showToast(res.body);
                                          }
                                        }
                                      },
                                    ),
                                    subtitle: index == -1
                                        ? Container()
                                        : Builder(
                                            builder: (context) {
                                              final stock = productStock['ProductStock'][index];
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  ListTile(
                                                    title: TextFormField(
                                                      onChanged: (val) => stock['stock'] = val,
                                                      controller:
                                                          TextEditingController(text: stock['stock'].toString()),
                                                      decoration: InputDecoration(
                                                          filled: true,
                                                          border: InputBorder.none,
                                                          labelText: 'curent stock'),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: TextFormField(
                                                      onChanged: (val) => stock['minStock'] = val,
                                                      controller:
                                                          TextEditingController(text: stock['minStock'].toString()),
                                                      decoration: InputDecoration(
                                                          filled: true,
                                                          border: InputBorder.none,
                                                          labelText: 'min stock'),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: MaterialButton(
                                                      color: Colors.orange,
                                                      onPressed: () async {
                                                        SmartDialog.showLoading();
                                                        Future.delayed(
                                                            Duration(seconds: 1), () => SmartDialog.dismiss());

                                                        stock['stock'] = int.parse(stock['stock'].toString());
                                                        stock['minStock'] = int.parse(stock['minStock'].toString());

                                                        if (stock['minStock'] > stock['stock']) {
                                                          SmartDialog.showToast(
                                                              "mimimal stok harus lebih kecil dari stock");
                                                          return;
                                                        }

                                                        final res = await Rot.productUpdateAvailableStockPost(
                                                            body: {"data": jsonEncode(stock)});
                                                        if (res.statusCode == 201) {
                                                          SmartDialog.showToast("success");
                                                          ProductVal.reloadProduct.toggle();
                                                        } else {
                                                          SmartDialog.showToast(res.body);
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: Center(
                                                          child: Text(
                                                            "Update",
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                  ),
                                  DottedLine(
                                    dashColor: Colors.grey,
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
        )
      ],
    );
  }
}
